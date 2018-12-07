package com.bigjava.biz.UserBizImpl;

import com.bigjava.bean.Answer;
import com.bigjava.bean.Pager;
import com.bigjava.bean.Question;
import com.bigjava.bean.Topic;
import com.bigjava.biz.QuestionBiz;
import com.bigjava.dao.UserDaoImpl.QuestionDaoImpl;
import com.bigjava.util.UserException;

import java.util.List;

public class QuestionBizImpl implements QuestionBiz {
    private QuestionDaoImpl questionDao;

    public void setQuestionDao(QuestionDaoImpl questionDao) {
        this.questionDao = questionDao;
    }

    @Override
    public void askQuestion(Question question, Topic topic) throws UserException {
        if (question.getQuestionTitle().equals("") || topic.getTopicTitle().equals(""))
            throw new UserException("请输入问题");
        questionDao.addQuestion(question,topic);
    }

    //根据话题id显示所有问题
    @Override
    public List<Question> showByQuestionID(int id) throws UserException {
        List<Question> questionList = questionDao.findByQuestionId(id);
        return questionList;
    }

    //显示所有问题，用于主页显示

    @Override
    public List<Question> showQuestion() {
        return questionDao.findQuestion();
    }

    //根据问题id显示相应答案
    @Override
    public List<Answer> showAnswerByQuestionID(int id) throws UserException {
        return  questionDao.findByQuestionTitleId(id);
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
}