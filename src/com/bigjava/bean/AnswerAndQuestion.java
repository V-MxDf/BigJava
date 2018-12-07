package com.bigjava.bean;

import java.util.List;

public class AnswerAndQuestion<E>{
    private List<Answer> answerList;
    private List<Question> questionList;
    private int id = 1;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public List<Answer> getAnswerList() {
        return answerList;
    }

    public void setAnswerList(List<Answer> answerList) {
        this.answerList = answerList;
    }

    public List<Question> getQuestionList() {
        return questionList;
    }

    public void setQuestionList(List<Question> questionList) {
        this.questionList = questionList;
    }

    @Override
    public String toString() {
        return "AnswerAndQuestion{" +
                "answerList=" + answerList +
                ", questionList=" + questionList +
                '}';
    }
}
