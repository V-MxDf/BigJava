package com.bigjava.dao.UserDaoImpl;

import com.bigjava.bean.*;
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
        query.setParameter("topic", topic.getTopicTitle());
        Topic topic1 = (Topic) query.uniqueResult();
        //如果没有这个话题则保存
        if (topic1 == null) {
            this.getHibernateTemplate().save(topic);
            System.out.println("没有保存" + topic);
        } else {
            question.setTopic_id_fk(topic1.getId());
            System.out.println("有保存id" + topic1.getId());
//            保存问题
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
    @Override//
    public List<Answer> findByQuestionTitleId(int id) {
        List<Answer> list = this.getHibernateTemplate().getSessionFactory().getCurrentSession()
                .createQuery("FROM Answer a WHERE 1=1 and a.answer_question_id =: questionId ")
                .setParameter("questionId", id)
                .list();
        return list;
    }

    //所有问题 分页
    @Override
    public List<Question> findQuestion(Pager<Question> pager) {
        return this.getHibernateTemplate().getSessionFactory()
                .getCurrentSession().createQuery("FROM Question")
                .setFirstResult((pager.getIndexPage() - 1) * pager.getPageSize()).setMaxResults(pager.getPageSize()).list();
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
                .setParameter("questionTitle", "%" + text + "%").list();
    }

    //添加答案
    @Override
    public void addAnswer(Answer answer) {
        QuestionAndAnswer questionAndAnswer = new QuestionAndAnswer();
        questionAndAnswer.setAnswerId(answer.getId());
        questionAndAnswer.setQuestionId(answer.getAnswer_question_id());
        this.getHibernateTemplate().save(answer);
        this.getHibernateTemplate().save(questionAndAnswer);
    }

    //根据id查询所有问题
    @Override
    public List<Question> findAllQuestion(int id) {
        return this.getHibernateTemplate().getSessionFactory().getCurrentSession()
                .createQuery("FROM Question q where q.id =: id")
                .setParameter("id", id).list();
    }


    //    添加关注状态
    @Override
    public void addFollow(Follow follow) {
        this.getHibernateTemplate().save(follow);
    }

    //修改关注状态
    @Override
    public void modifyFollowState(Follow follow) {
        this.getHibernateTemplate().getSessionFactory().getCurrentSession()
                .createQuery("UPDATE Follow f set f.state = : state " +
                        "where f.followUserId =: userId and f.questionId =: questionId")
                .setParameter("state", follow.getState())
                .setParameter("userId", follow.getFollowUserId())
                .setParameter("questionId", follow.getQuestionId()).executeUpdate();
    }

    //赞同
    @Override
    public void modifyLike(Answer answer) {
        this.getHibernateTemplate().getSessionFactory().getCurrentSession()
                .createQuery("update Answer a set a.liked =: liked where a.id=: id")
                .setParameter("liked", answer.getLiked())
                .setParameter("id", answer.getId()).executeUpdate();
    }

    //    点赞数
    @Override
    public Answer findLikeNum(Answer answer) {
        /*return (Answer) this.getHibernateTemplate().getSessionFactory().getCurrentSession()
                .createQuery("select a.liked from Answer a where a.id =: id")
                .setParameter("id", answer.getId());*/
        System.out.println(answer.getId());
        return this.getHibernateTemplate().get(Answer.class,answer.getId());
    }

    //    查询关注状态
    @Override
    public Follow findFollowState(int userId, int questionId) {
        Query query = this.getHibernateTemplate().getSessionFactory().getCurrentSession()
                .createQuery("FROM Follow f where f.followUserId =: followUserId and f.questionId =: questionId");
        query.setParameter("followUserId", userId);
        query.setParameter("questionId", questionId);
        return (Follow) query.uniqueResult();
    }


}
