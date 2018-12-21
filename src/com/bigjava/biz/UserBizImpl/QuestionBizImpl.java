package com.bigjava.biz.UserBizImpl;

import com.bigjava.bean.*;
import com.bigjava.biz.QuestionBiz;
import com.bigjava.dao.UserDaoImpl.QuestionDaoImpl;
import com.bigjava.util.UserException;

import java.util.*;

public class QuestionBizImpl implements QuestionBiz {
    private QuestionDaoImpl questionDao;

    //     剔除根据list对象id属性相同
    public List<User> removeDupliById(List<User> persons) {
        Set<User> personSet = new TreeSet<>(Comparator.comparing(User::getId));
        personSet.addAll(persons);
        return new ArrayList<>(personSet);
    }

    public void setQuestionDao(QuestionDaoImpl questionDao) {
        this.questionDao = questionDao;
    }

    @Override
    public void askQuestion(Question question, Topic topic) throws UserException {
        if (question.getQuestionTitle().equals("") || topic.getTopicTitle().equals(""))
            throw new UserException("请输入问题");
        questionDao.addQuestion(question, topic);
    }

    //根据话题id显示所有问题
    @Override
    public List<Question> showByQuestionID(int id) throws UserException {
        return questionDao.findByQuestionId(id);
    }

    //显示所有问题，用于主页显示

    @Override
    public List<Question> showQuestion() {
        return questionDao.findQuestion();
    }

    //根据问题id显示相应答案
    @Override
    public List<Answer> showAnswerByQuestionID(int id) throws UserException {
        return questionDao.findByQuestionTitleId(id);
    }

    //联想话题
    @Override
    public List<Topic> searchTopic(String text) throws UserException {
        if (text.trim().isEmpty() && text.equals(" ")) throw new UserException("输入的为空");
        return questionDao.findByText(text);
    }

    public List<Topic> allTopic() {
        return questionDao.findAll();
    }

    @Override
    public List<Question> allQuestion(Pager<Question> pager) {
        if (pager.getIndexPage() < 1) pager.setIndexPage(1);
        pager.setTotalRecord(countQuestion());
        pager.setPageSize(3);
        if (pager.getIndexPage() > pager.getTotalPage()) pager.setIndexPage(pager.getTotalPage());
        return questionDao.findQuestion(pager);
    }

    //总记录
    @Override
    public int countQuestion() {
        return questionDao.findQuestionCount();
    }

    //联想问题
    @Override
    public List<Question> searchQuestion(String text) {
        return questionDao.findByQuestionTitle(text);
    }

    //根据id查询所有问题
    @Override
    public List<Question> byIdShowQuestion(int id) {
        return questionDao.findAllQuestion(id);
    }

    //添加答案
    @Override
    public void addAnswer(Answer answer) {
        questionDao.addAnswer(answer);
    }

    //    关注问题
    @Override
    public void followQuestion(Follow follow) {
        Follow follow1 = questionDao.findFollowState(follow.getFollowUserId(), follow.getQuestionId());
        System.out.println(follow + "follow<<");
        System.out.println(follow1 + "biz");
        // 没有查到就代表数据库没有,没有就添加一个关注状态
        if (follow1 == null) {
//            第一次关注添加,后面if判断 关注之后取关又关注
            follow.setState(1);
            questionDao.addFollow(follow);
        } else if (follow1.getState() == 0) {
            //如果查到,判断状态是否处于未关注状态,处于则设置为关注状态
            follow.setState(1);
            System.out.println("关注" + follow);
            questionDao.modifyFollowState(follow);
        } else {
            // 否则取关
            follow.setState(0);
            System.out.println("取关" + follow);
            questionDao.modifyFollowState(follow);
        }

    }

//    点赞
    @Override
    public void liked(Answer answer) {
        questionDao.modifyLike(answer);
    }
//点赞数
    @Override
    public Answer likedNum(Answer answer) {
        return questionDao.findLikeNum(answer);
    }

    // 取消关注
    @Override
    public void unFollow(Follow follow) {
        questionDao.modifyFollowState(follow);
    }

    //  查询关注状态
    @Override
    public Follow findFollowState(int userId, int questionId) {
        return questionDao.findFollowState(userId, questionId);
    }
}