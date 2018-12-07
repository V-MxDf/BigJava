package com.bigjava.action;

import com.bigjava.bean.Question;
import com.bigjava.bean.User;
import com.bigjava.biz.UserBizImpl.QuestionBizImpl;
import com.bigjava.biz.UserBizImpl.UserBizImpl;
import com.bigjava.util.UserException;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.*;


public class UserAction extends ActionSupport {
    private HttpServletRequest request = ServletActionContext.getRequest();

    private User user;
    private UserBizImpl userBiz;
    private QuestionBizImpl questionBiz;
    private Map errorMap = new HashMap<>();
    private Set set = new HashSet();
    // 封装上传文件域的属性
    private File image;
    // 封装上传文件类型的属性
    private String imageContentType;
    // 封装上传文件名的属性
    private String imageFileName;
    // 接受依赖注入的属性
    private String savePath;
    private List list = new ArrayList();

    public Set getSet() {
        return set;
    }

    public void setSet(Set set) {
        this.set = set;
    }

    public Map getErrorMap() {
        return errorMap;
    }

    public void setErrorMap(Map errorMap) {
        this.errorMap = errorMap;
    }

    public List getList() {
        return list;
    }

    public void setList(List list) {
        this.list = list;
    }

    public File getImage() {
        return image;
    }

    public void setImage(File image) {
        this.image = image;
    }

    public String getImageContentType() {
        return imageContentType;
    }

    public void setImageContentType(String imageContentType) {
        this.imageContentType = imageContentType;
    }

    public String getImageFileName() {
        return imageFileName;
    }

    public void setImageFileName(String imageFileName) {
        this.imageFileName = imageFileName;
    }

    public String getSavePath() {
        return ServletActionContext.getServletContext().getRealPath(savePath);
    }

    public void setSavePath(String savePath) {
        this.savePath = savePath;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public void setUserBiz(UserBizImpl userBiz) {
        this.userBiz = userBiz;
    }
    /*
    @Override
    public String execute() throws Exception {
        if (userType == 1) {
            dr = "/findAll.jsp";
        } else if (userType == 0) {
            dr = "userModule/index.jsp";
        }
        return SUCCESS;
    }*/

    /**
     * 转跳错误信息
     */
 /*   @Override
    public void validate() {
        if (user.getUsername() == null || user.getUsername().trim().isEmpty()) {
            this.addFieldError("username", "用户名不能为空");
        }
    }*/
    public String findAll() {
        String value = request.getParameter("indexPage");
        int indexPage = 1;
        if (value != null) {
            indexPage = Integer.parseInt(value);
        }
        if (indexPage < 1) indexPage = 1;
        if (indexPage > 3) indexPage = 3;
        List<User> list = userBiz.findAll(indexPage, 3);
        request.getSession().setAttribute("indexPage", indexPage);
        request.getSession().setAttribute("list", list);
        System.out.println(list.size());
        return "findAll";
    }

    /**
     * 登录
     *
     * @return
     */
    public String login() {
        String text = request.getParameter("imageText");
        String imageText = (String) request.getSession().getAttribute("imageText");
        try {
            user = userBiz.login(user.getUsername(), user.getPassword());
            if (user == null || user.getUsername().trim().isEmpty() || user.getPassword().trim().isEmpty()) {
                errorMap.put("loginError", "请输入验证码");
            }
            if (text.trim().isEmpty() || text.equals("")) {
                errorMap.put("imageError", "请输入验证码");
            }

            if (!text.equalsIgnoreCase(imageText)) {
                errorMap.put("imageError", "验证码不正确");
            }
            if (errorMap.size() > 0) {
                request.setAttribute("error", errorMap);
                return "login";
            } else {
                request.getSession().setAttribute("loginSuccess", user);
                list = questionBiz.showQuestion();
                for(Object o : list) {
                    Question question = (Question) o;
                    // Value is answerList
                    List list1 = questionBiz.showAnswerByQuestionID(question.getId());
                    set.add(list1);
                    errorMap.put(question,set);
                }
                return "index";
            }
        } catch (UserException e) {
            System.out.println(e.getMessage());
        }
        return "login";
    }

    //注册
    public String register() {
        String rePassword = request.getParameter("RePassword");

        if (user.getUsername() == null || user.getUsername().trim().isEmpty()) {
            errorMap.put("registerName", "用户名不能为空");
        }
        if (user.getEmail() == null || user.getEmail().trim().isEmpty()) {
            errorMap.put("registerEmail", "邮箱不能为空");
        }
        if (!user.getPassword().equals(rePassword)) {
            errorMap.put("registerPas", "密码不一致");
        }
        if (user.getPassword() == null || user.getPassword().trim().isEmpty()) errorMap.put("registerPas", "请输入密码");

        if (errorMap.size() > 0) {
            request.setAttribute("error", errorMap);
            return "register";
        }
        if (userBiz.register(user)) {
            return "registerSUCCESS";
        }
        return "register";
    }

    //激活
    public String verifyCode() {
        userBiz.modifyState(user.getCode());
        return "verifyCode";
    }

    //更换头像
    public String updateImg() {
        FileOutputStream fos = null;
        FileInputStream fis = null;
        try {
            // 建立文件输出流
            System.out.println(getSavePath());
            fos = new FileOutputStream(getSavePath() + "\\" + getImageFileName());
            // 建立文件上传流
            fis = new FileInputStream(getImage());
            byte[] buffer = new byte[1024];
            int len = 0;
            while ((len = fis.read(buffer)) > 0) {
                fos.write(buffer, 0, len);
            }
        } catch (Exception e) {
            System.out.println("文件上传失败");
            e.printStackTrace();
        } finally {
            if (fos != null) {
                try {
                    fos.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
                if (fis != null) {
                    try {
                        fis.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        return "updateImg";
    }

    //个人信息
    public String userInfo(){
        User user1 = (User) request.getSession().getAttribute("loginSuccess");
        list = userBiz.showInfoById(user1.getId());
        return "userInfo";
    }
    //修改资料
    public String modifyInfo(){
        userBiz.modifyInfo(user);
        return "modifyInfo";
    }
    public String language() {
        return INPUT;
    }


    //spring di
    public void setQuestionBiz(QuestionBizImpl questionBiz) {
        this.questionBiz  = questionBiz;
    }
}
