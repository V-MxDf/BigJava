package com.bigjava.biz;

import com.bigjava.bean.*;
import com.bigjava.util.UserException;

import java.util.List;

public interface QuestionBiz {
    //提问
    public void askQuestion(Question question, Topic topic) throws UserException;

    //话题展示
    public List<Topic> allTopic();

    //联想话题
    public List<Topic> searchTopic(String text) throws UserException;

    //根据话题显示所有问题
    public List<Question> showByQuestionID(int id) throws UserException;

    //重载显示所有话题
    public List<Question> showQuestion();

    //根据问题显示所有答案
    public List<Answer> showAnswerByQuestionID(int id) throws UserException;

    //所有问题
    public List<Question> allQuestion(Pager<Question> pager);

    //问题总数据
    public int countQuestion();

    //联想问题
    public List<Question> searchQuestion(String text);

    //根据id查询所有问题
    public List<Question> byIdShowQuestion(int id);

    //添加答案
    public void addAnswer(Answer answer);

    //    关注问题
    public void followQuestion(Follow follow);
    //取消关注
    public void unFollow(Follow follow);
//    点赞
    void liked(Answer answer);
//    点赞数
    Answer likedNum(Answer answer);
    //  查询关注状态
    public Follow findFollowState(int userId,int questionId);
}
