package com.bigjava.dao.UserDaoImpl;

import com.bigjava.bean.Answer;
import com.bigjava.bean.Pager;
import com.bigjava.bean.Question;
import com.bigjava.bean.Topic;
import com.bigjava.dao.QuestionDao;
import org.hibernate.query.Query;
import org.springframework.orm.hibernate5.support.HibernateDaoSupport;

import java.util.List;

public class QuestionDaoImpl extends HibernateDaoSupport implements QuestionDao {

    @Override
    //添加问题，以及话题，并查询是否有该话题
    public void addQuestion(Question question, Topic topic) {
        Query query = this.getHibernateTemplate().getSessionFactory().getCurrentSession()
                .createQuery("From Topic where topicTitle =: topic");
        query.setParameter("topic" ,topic.getTopicTitle());
        Topic topic1= (Topic) query.uniqueResult();
        //如果没有这个话题则保存
        if (topic1 == null) {
            this.getHibernateTemplate().save(topic);
            System.out.println("没有保存" + topic);
        } else {
            question.setTopic_id_fk(topic1.getId());
            System.out.println("有保存id" + topic1.getId());
            this.getHibernateTemplate().save(question);
        }
    }

    //查询话题
    public List<Topic> findAll() {
        return this.getHibernateTemplate().getSessionFactory().getCurrentSession()
                .createQuery("FROM Topic ").list();
    }

    //联想话题
    public List<Topic> findByText(String text) {
        return this.getHibernateTemplate().getSessionFactory().getCurrentSession()
                .createQuery("select DISTINCT t.topicTitle from Topic t where t.topicTitle like :text")
                .setParameter("text", text + "%").list();
    }

    //根据话题显示所有问题
    @Override
    public List<Question> findByQuestionId(int id) {
        return this.getHibernateTemplate().getSessionFactory().getCurrentSession()
                .createQuery("FROM Question q  where q.topic_id_fk=: id")
                .setParameter("id", id).list();
    }

    //显示所有问题
    @Override
    public List<Question> findQuestion() {
        return this.getHibernateTemplate().getSessionFactory().getCurrentSession()
                .createQuery("FROM Question").list();
    }

    //根据问题显示相应的答案
    @Override
    public List<Answer> findByQuestionTitleId(int id) {
        List<Answer> list = this.getHibernateTemplate().getSessionFactory().getCurrentSession()
                .createQuery("FROM Answer a WHERE a.answer_question_id =: topicId")
                .setParameter("topicId", id).list();
        return list;
    }

    //所有问题 分页
    @Override
    public List<Question> findQuestion(Pager<Question> pager) {
        return this.getHibernateTemplate().getSessionFactory()
                .getCurrentSession().createQuery("FROM Question")
                .setFirstResult((pager.getIndexPage()- 1) * pager.getPageSize()).setMaxResults(pager.getPageSize()).list();
    }

    //查询总问题数量
    @Override
    public int findQuestionCount() {
        return this.getHibernateTemplate().getSessionFactory()
                .getCurrentSession().createQuery("FROM Question").list().size();
    }

    //联想问题
    @Override
    public List<Question> findByQuestionTitle(String text) {
        return this.getHibernateTemplate().getSessionFactory().getCurrentSession()
                .createQuery("from Question q where q.questionTitle like: questionTitle")
                .setParameter("questionTitle","%"+text+"%").list();
    }
}
