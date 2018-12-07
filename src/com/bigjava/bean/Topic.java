package com.bigjava.bean;

public class Topic {
    private Integer id;
    private String topicTitle;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTopicTitle() {
        return topicTitle;
    }

    public void setTopicTitle(String topicTitle) {
        this.topicTitle = topicTitle;
    }

    @Override
    public String toString() {
        return "Topic{" +
                "id=" + id +
                ", topicTitle='" + topicTitle + '\'' +
                '}';
    }
}
