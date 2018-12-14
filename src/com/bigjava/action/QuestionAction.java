package com.bigjava.action;

import com.bigjava.bean.Answer;
import com.bigjava.bean.Question;
import com.bigjava.bean.Topic;
import com.bigjava.bean.User;
import com.bigjava.biz.UserBizImpl.QuestionBizImpl;
import com.bigjava.biz.UserBizImpl.UserBizImpl;
import com.bigjava.util.UserException;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class QuestionAction extends ActionSupport  {
    private HttpServletRequest request = ServletActionContext.getRequest();
    private QuestionBizImpl questionBiz;
    private Question question = new Question();
    private Topic topic;
    private User user = (User) request.getSession().getAttribute("loginSuccess");
    private UserBizImpl userBiz;
    private List<Question> questionList = new ArrayList();
    private List list = new ArrayList();
    private String result;
    private String questionTitle;

    public String getQuestionTitle() {
        return questionTitle;
    }

    public void setQuestionTitle(String questionTitle) {
        this.questionTitle = questionTitle;
    }

    public List getList() {
        return list;
    }

    public void setList(List list) {
        this.list = list;
    }

    public List<Question> getQuestionList() {
        return questionList;
    }

    public void setQuestionList(List<Question> questionList) {
        this.questionList = questionList;
    }

    public void setTopic(Topic topic) {
        this.topic = topic;
    }

    public Topic getTopic() {
        return topic;
    }

    public void setQuestionBiz(QuestionBizImpl questionBiz) {
        this.questionBiz = questionBiz;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public void setQuestion(Question question) {
        this.question = question;
    }

    public Question getQuestion() {
        return question;
    }

    //添加问题
    public String askQuestion() throws UserException, IOException {
//        User user1 = (User)request.getSession().getAttribute("loginSuccess");
        if (question.getQuestionTitle().trim().isEmpty()) {
            result = "请填写问题";
        }
        if (topic.getTopicTitle().trim().isEmpty()) {
            result = "请填写话题";
        }
        question.setAskQuestion_user_id(user.getId());
        questionBiz.askQuestion(question,topic);
        return "ask";
    }
    //show Info topic
    public String showAllTopic(){
        list = questionBiz.allTopic();
        return "allTopic";
    }

    //联想话题
    public String searchTopic() throws UserException {
        list = questionBiz.searchTopic(result);
        System.out.println("话题"+list);
        return SUCCESS;
    }
    //联想问题
    public String searchQuestion() {
        list = questionBiz.searchQuestion(questionTitle);
        return SUCCESS;
    }
    //根据话题显示问题和一个答案
    public String showById() throws UserException {
        List<Answer> list4 = new ArrayList<>();
        questionList = questionBiz.showByQuestionID(topic.getId());
        for (Object object: questionList) {
            Question question = (Question) object;
            list4 =  questionBiz.showAnswerByQuestionID(question.getId());
            integerAnswerMap.put(question,list4);
            for (Answer answer : list4 ) {
                list.add(userBiz.showInfoById(answer.getAnswer_user_id()));
                System.out.println(list);
            }
        }
        return "showQuestion";
    }

    //主页显示答案和问题
    public String showQuestionAndAnswer() throws UserException {
            questionList = questionBiz.showQuestion();
            for(Object o : questionList) {
                Question question = (Question) o;
                // Value is answerList
                integerAnswerMap.put(question,questionBiz.showAnswerByQuestionID(question.getId()));
            }
        return "showQuestionAndAnswer";
    }
    //根据问题显示答案
    public String showAnswer() throws UserException {
        for (Object object: questionBiz.showAnswerByQuestionID(question.getId()) ) {
            Answer answer = (Answer) object;
           answer.setUserList(userBiz.showInfoById(answer.getAnswer_user_id()));
           list.add(answer);
        }
        questionTitle = question.getQuestionTitle();
        return "showAnswer";
    }
    //添加答案
    public String addAnswer(){

        return null;
    }
    //spring DI
    public void setUserBiz(UserBizImpl userBiz) {
        this.userBiz = userBiz;
    }

    private  Map<Question,List<Answer>> integerAnswerMap = new HashMap<>();

    public Map<Question, List<Answer>> getIntegerAnswerMap() {
        return integerAnswerMap;
    }

    public void setIntegerAnswerMap(Map<Question, List<Answer>> integerAnswerMap) {
        this.integerAnswerMap = integerAnswerMap;
    }
}
