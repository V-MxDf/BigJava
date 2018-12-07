package com.bigjava.action;

import com.bigjava.bean.Pager;
import com.bigjava.bean.Question;
import com.bigjava.biz.UserBizImpl.QuestionBizImpl;
import com.opensymphony.xwork2.ActionSupport;

import java.util.ArrayList;
import java.util.List;

public class PaginationAction extends ActionSupport {
    private Pager<Question> pager = new Pager<>();
    private Pager<Question> questionPager = new Pager<Question>();
    private List<Question> list = new ArrayList<>();
    private QuestionBizImpl questionBiz;
    private int indexPage;
//
    public List<Question> getList() {
        return list;
    }

    public void setList(List<Question> list) {
        this.list = list;
    }

    public int getIndexPage() {
        return indexPage;
    }

    public void setIndexPage(int indexPage) {
        this.indexPage = indexPage;
    }

    public Pager<Question> getQuestionPager() {
        return questionPager;
    }

    public void setQuestionPager(Pager<Question> questionPager) {
        this.questionPager = questionPager;
    }

    public Pager<Question> getPager() {
        return pager;
    }

    public void setPager(Pager<Question> pager) {
        this.pager = pager;
    }

    public String pagination() {
        list = questionBiz.allQuestion(pager);
        return "pagination";
    }

    public void setQuestionBiz(QuestionBizImpl questionBiz) {
        this.questionBiz = questionBiz;
    }
}
