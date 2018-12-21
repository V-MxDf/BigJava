package com.bigjava.bean;

public class QuestionAndAnswer {
    private Integer id;
    private Integer questionId;
    private Integer answerId;

    @Override
    public String toString() {
        return "QuestionAndAnswer{" +
                "id=" + id +
                ", questionId=" + questionId +
                ", answerId=" + answerId +
                '}';
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getQuestionId() {
        return questionId;
    }

    public void setQuestionId(Integer questionId) {
        this.questionId = questionId;
    }

    public Integer getAnswerId() {
        return answerId;
    }

    public void setAnswerId(Integer answerId) {
        this.answerId = answerId;
    }
}
