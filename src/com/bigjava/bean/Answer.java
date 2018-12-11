package com.bigjava.bean;

import java.util.List;

public class Answer {
    private Integer id;
    private Integer answer_user_id;
    private Integer answer_question_id;
    private String answer_content;
    //分类
    private Integer topic_id_fk;
    //回答答案用户
    private List<User> userList;

    public List<User> getUserList() {
        return userList;
    }

    public void setUserList(List<User> userList) {
        this.userList = userList;
    }

    public Integer getTopic_id_fk() {
        return topic_id_fk;
    }

    public void setTopic_id_fk(Integer topic_id_fk) {
        this.topic_id_fk = topic_id_fk;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getAnswer_user_id() {
        return answer_user_id;
    }

    public void setAnswer_user_id(Integer answer_user_id) {
        this.answer_user_id = answer_user_id;
    }

    public Integer getAnswer_question_id() {
        return answer_question_id;
    }

    public void setAnswer_question_id(Integer answer_question_id) {
        this.answer_question_id = answer_question_id;
    }

    public String getAnswer_content() {
        return answer_content;
    }

    public void setAnswer_content(String answer_content) {
        this.answer_content = answer_content;
    }

    @Override
    public String toString() {
        return "Answer{" +
                "id=" + id +
                ", answer_user_id=" + answer_user_id +
                ", answer_question_id=" + answer_question_id +
                ", answer_content='" + answer_content + '\'' +
                ", topic_id_fk=" + topic_id_fk +
                '}';
    }
}
