package com.bigjava.dao;

import com.bigjava.bean.Answer;
import com.bigjava.bean.Pager;
import com.bigjava.bean.Question;
import com.bigjava.bean.Topic;
import com.bigjava.util.UserException;

import java.util.List;

public interface QuestionDao {
    //添加问题以及话题
    public void  addQuestion (Question question, Topic topic);
    //查询话题
    public List<Topic> findAll();
    //Ajax联想查询话题
    public List<Topic> findByText(String text) throws UserException;
    //根据话题id查询所有问题
    public List<Question> findByQuestionId(int id);
    //查询所有话题 重载 为了主页显示
    public List<Question> findQuestion();
    //根据问题id查询所有答案
    public List<Answer> findByQuestionTitleId(int id);
    //查询问题分页
    public List<Question> findQuestion(Pager<Question> pager);
    //查询总问题数量
    public int findQuestionCount();
    //联想问题
    public List<Question> findByQuestionTitle(String text);
    //添加答案
    public void addAnswer(Answer answer);
}
