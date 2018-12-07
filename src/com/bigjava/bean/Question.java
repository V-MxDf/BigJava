package com.bigjava.bean;

import javax.persistence.Entity;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Question {
    private Integer id;
    private Integer askQuestion_user_id;
    private String questionTitle;
    //所属分类
    private Integer topic_id_fk;
    private List<Answer> answerList;

    public List<Answer> getList() {
        return answerList;
    }

    public void setList(List<Answer> list) {
        this.answerList = list;
    }

    public Integer getTopic_id_fk() {
        return topic_id_fk;
    }

    public void setTopic_id_fk(Integer topic_id_fk) {
        this.topic_id_fk = topic_id_fk;
    }

    public Integer getAskQuestion_user_id() {
        return askQuestion_user_id;
    }

    public void setAskQuestion_user_id(Integer askQuestion_user_id) {
        this.askQuestion_user_id = askQuestion_user_id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getQuestionTitle() {
        return questionTitle;
    }

    public void setQuestionTitle(String questionTitle) {
        this.questionTitle = questionTitle;
    }

    @Override
    public String toString() {
        return "Question{" +
                "id=" + id +
                ", askQuestion_user_id=" + askQuestion_user_id +
                ", questionTitle='" + questionTitle + '\'' +
                ", topic_id_fk='" + topic_id_fk + '\'' +
                '}';
    }
}
