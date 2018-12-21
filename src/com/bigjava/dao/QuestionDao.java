package com.bigjava.dao;

import com.bigjava.bean.*;
import com.bigjava.util.UserException;

import java.util.List;

public interface QuestionDao {
    //添加问题以及话题
    void addQuestion(Question question, Topic topic);

    //查询话题
    List<Topic> findAll();

    //Ajax联想查询话题
    List<Topic> findByText(String text) throws UserException;

    //根据话题id查询所有问题
    List<Question> findByQuestionId(int id);

    //查询所有话题 重载 为了主页显示
    List<Question> findQuestion();

    //根据问题id查询所有答案
    List<Answer> findByQuestionTitleId(int id);

    //查询问题分页
    List<Question> findQuestion(Pager<Question> pager);

    //查询总问题数量
    int findQuestionCount();

    //联想问题
    List<Question> findByQuestionTitle(String text);

    //添加答案
    void addAnswer(Answer answer);

    //根据id查询问题
    List<Question> findAllQuestion(int id);

    //  添加关注状态
    void addFollow(Follow follow);

    //    修改关注状态
    void modifyFollowState(Follow follow);

    //    赞同
    void modifyLike(Answer answer);
    //返回点赞数
    Answer findLikeNum(Answer answer);

    //    查询关注状态
    Follow findFollowState(int userId, int questionId);

}
