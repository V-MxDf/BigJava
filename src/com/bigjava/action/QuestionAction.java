package com.bigjava.action;

import com.bigjava.bean.*;
import com.bigjava.biz.UserBizImpl.QuestionBizImpl;
import com.bigjava.biz.UserBizImpl.UserBizImpl;
import com.bigjava.util.UserException;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.*;

public class QuestionAction extends ActionSupport {
    private HttpServletRequest request = ServletActionContext.getRequest();
    private QuestionBizImpl questionBiz;
    private Question question = new Question();
    private Topic topic;
    private User user = (User) request.getSession().getAttribute("loginSuccess");
    private UserBizImpl userBiz;
    private List questionList = new ArrayList();
    private List list = new ArrayList();
    private String result;
    private String questionTitle;
    private Answer answer = new Answer();
    private Follow follow = new Follow();

    public Follow getFollow() {
        return follow;
    }

    public void setFollow(Follow follow) {
        this.follow = follow;
    }

    public Answer getAnswer() {
        return answer;
    }

    public void setAnswer(Answer answer) {
        this.answer = answer;
    }

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

    public List getQuestionList() {
        return questionList;
    }

    public void setQuestionList(List questionList) {
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
        questionBiz.askQuestion(question, topic);
        return "ask";
    }

    //show Info topic
    public String showAllTopic() {
        list = questionBiz.allTopic();
        return "allTopic";
    }

    //联想话题
    public String searchTopic() throws UserException {
        list = questionBiz.searchTopic(result);
        System.out.println("话题" + list);
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
        List<User> userList = new ArrayList<>();
        Set set = new HashSet();

        //根据话题id拿到所有问题
        questionList = questionBiz.showByQuestionID(topic.getId());
        //遍历这个List 拿到问题的id,
        for (Object object : questionList) {
            Question question = (Question) object;
//            通过问题的id拿到一个答案
            list4 = questionBiz.showAnswerByQuestionID(question.getId());
            if (list4.size() != 0) {
                integerAnswerMap.put(question, Collections.singletonList(list4.get(0)));
            } else {
                integerAnswerMap.put(question,list4 );
            }
            for (Answer answer : list4) {
//                通过答案的id拿到用户的信息
                userList = userBiz.showInfoById(answer.getAnswer_user_id());
                list.addAll(userList);
            }

        }
//        剔除重复数据
       list = questionBiz.removeDupliById(list);
        answer.setUserList(list);
        return "showQuestion";
    }

        //主页显示答案和问题
    public String showQuestionAndAnswer() throws UserException {
        questionList = questionBiz.showQuestion();
        for (Object o : questionList) {
            Question question = (Question) o;
            // Value is answerList
            integerAnswerMap.put(question, questionBiz.showAnswerByQuestionID(question.getId()));
        }
        return "showQuestionAndAnswer";
    }

    //根据问题显示答案
    public String showAnswer() throws UserException {
//        根据问题id获取所有答案
        List<Answer> answerList = questionBiz.showAnswerByQuestionID(question.getId());
        for (Object object : answerList) {
            Answer answer = (Answer) object;
//            根据回答id获取用户信息
            answer.setUserList(userBiz.showInfoById(answer.getAnswer_user_id()));
//           循环添加答案，用于前台显示
            list.add(answer);
        }
//        为了前台显示问题标题
        questionList = questionBiz.byIdShowQuestion(question.getId());
//        查询关注状态
        follow = questionBiz.findFollowState(user.getId(), question.getId());
        if (follow == null) {
            System.out.println("未关注");
        }
        request.getSession().setAttribute("questionId", question);
        return "showAnswer";
    }

    //添加答案
    public String addAnswer() {
//        问题id
        Question question = (Question) request.getSession().getAttribute("questionId");
//        回答需要用户id
        User user1 = (User) request.getSession().getAttribute("loginSuccess");
        questionList = questionBiz.byIdShowQuestion(question.getId());
//        根据问题id拿到话题id
        for (Object object : questionList) {
            Question question1 = (Question) object;
            answer.setTopic_id_fk(question1.getTopic_id_fk());
        }
//        疯狂set Answer
        answer.setAnswer_question_id(question.getId());
        answer.setAnswer_user_id(user1.getId());
//       执行添加答案方法
        questionBiz.addAnswer(answer);
        return "addAnswer";
    }

    //    关注以及取关  逻辑判断在biz
    public String followQuestion() {
        User user1 = (User) request.getSession().getAttribute("loginSuccess");
//        用户id
        follow.setFollowUserId(user1.getId());
        questionBiz.followQuestion(follow);
        return "follow";
    }

    //赞同
    public String liked(){
        answer.setLiked((answer.getLiked())+1);
        questionBiz.liked(answer);
        answer = questionBiz.likedNum(answer);
        return "liked";
    }
    //spring DI
    public void setUserBiz(UserBizImpl userBiz) {
        this.userBiz = userBiz;
    }

    private Map<Question, List<Answer>> integerAnswerMap = new HashMap<>();

    public Map<Question, List<Answer>> getIntegerAnswerMap() {
        return integerAnswerMap;
    }

    public void setIntegerAnswerMap(Map<Question, List<Answer>> integerAnswerMap) {
        this.integerAnswerMap = integerAnswerMap;
    }
}
