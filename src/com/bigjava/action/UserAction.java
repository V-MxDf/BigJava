package com.bigjava.action;

import com.bigjava.bean.Question;
import com.bigjava.bean.User;
import com.bigjava.biz.UserBizImpl.QuestionBizImpl;
import com.bigjava.biz.UserBizImpl.UserBizImpl;
import com.bigjava.util.UserException;
import com.opensymphony.xwork2.ActionSupport;
import net.sf.json.JSONObject;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;


public class UserAction extends ActionSupport {
    // 上传文件存放路径
    private final static String uploadAdders = "/photo";
    private HttpServletRequest request = ServletActionContext.getRequest();
    private HttpServletResponse response = ServletActionContext.getResponse();
    private User user;
    private UserBizImpl userBiz;
    private QuestionBizImpl questionBiz;
    private Map errorMap = new HashMap<>();
    private Set set = new HashSet();
    private File upload;
    private String uploadContentType;
    private String uploadFileName;
    private String path;
    private String res;
    private String userRes;

    public String getUserRes() {
        return userRes;
    }

    public void setUserRes(String userRes) {
        this.userRes = userRes;
    }

    public String getRes() {
        return res;
    }

    public void setRes(String res) {
        this.res = res;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    private List list = new ArrayList();


    public File getUpload() {
        return upload;
    }

    public void setUpload(File upload) {
        this.upload = upload;
    }

    public String getUploadContentType() {
        return uploadContentType;
    }

    public void setUploadContentType(String uploadContentType) {
        this.uploadContentType = uploadContentType;
    }

    public String getUploadFileName() {
        return uploadFileName;
    }

    public void setUploadFileName(String uploadFileName) {
        this.uploadFileName = uploadFileName;
    }

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

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public void setUserBiz(UserBizImpl userBiz) {
        this.userBiz = userBiz;
    }

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
                for (Object o : list) {
                    Question question = (Question) o;
                    // Value is answerList
                    List list1 = questionBiz.showAnswerByQuestionID(question.getId());
                    set.add(list1);
                    errorMap.put(question, set);
                }
                return "index";
            }
        } catch (UserException e) {
            System.out.println(e.getMessage());
        }
        return "login";
    }

    //注册
    public String register() throws UserException {
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

    //预览
    public String preViewImg() throws IOException {
        response.setContentType("text/html;charset=utf-8");
        Map<String, String> map = new HashMap();
        User user1 = (User) request.getSession().getAttribute("loginSuccess");
        path = ServletActionContext.getServletContext().getRealPath(uploadAdders);
        //在服务器路径下判断是否有photo这个文件夹，没有就创建一个
        //但是这个文件夹是临时的，如果项目重新部署的话会被删除
        File file = new File(path);
        if (!file.exists()) {
            file.mkdir();
        }
        //为了避免文件名重复，这里选择用uuid重命名（肯定不会重复）
        uploadFileName = UUID.randomUUID().toString() + "用户" + user1.getUsername() + uploadFileName;
        request.getSession().setAttribute("uploadFileName", uploadFileName);
        //将文件拷贝到服务器路径下
        FileUtils.copyFile(upload, new File(file, uploadFileName));
        map.put("path", "photo" + "/" + uploadFileName);
        // 调用json对象的toString方法转换为字符串然后赋值给result
        JSONObject jo = JSONObject.fromObject(map);
        this.res = jo.toString();
        //返回字符串
        PrintWriter pw = response.getWriter();
        pw.write(this.res);
        pw.flush();
        pw.close();
        return null;
    }

    //修改图片
    public String updateImg() throws IOException, UserException {
        response.setContentType("text/html;charset=utf-8");
        Map<String, Object> map = new HashMap<>();
        String uploadFileName = (String) request.getSession().getAttribute("uploadFileName");
        User user1 = (User) request.getSession().getAttribute("loginSuccess");
//        user1.setImage(uploadFileName);
        userBiz.updateImg(uploadFileName, user1.getId());
        map.put("userPath", "photo" + "/" + uploadFileName);
        JSONObject jsonObject = JSONObject.fromObject(map);
        this.res = jsonObject.toString();
        //返回字符串
        PrintWriter pw = response.getWriter();
        pw.write(this.res);
        pw.flush();
        pw.close();
        return null;
    }

    //修改资料
    public String updateInfo() throws IOException, UserException {
        response.setContentType("text/html;charset=utf-8");
        Map<String, String> map = new HashMap<>();
        User user1 = (User) request.getSession().getAttribute("loginSuccess");
        String email = user1.getEmail();
        //        获取当前年
        Calendar calendar = Calendar.getInstance();
        int year = calendar.get(Calendar.YEAR);
        //默认数据库的年龄
        int y = user1.getAge();
        if (user.getYear() != null && !user.getYear().equals("year")) {
            y = Integer.parseInt(user.getYear());
            int cunrrnt = year - y;
            //当年龄为负数，设置为默认年龄
            if (cunrrnt < 0) user1.setAge(y);
            user1.setAge(cunrrnt);
        } else {
            user1.setAge(y);
        }
        //Sex为空则不做修改
        if (user.getSex() == null) {
            user1.setSex(user1.getSex());
        } else {
            user1.setSex(user.getSex());
        }
        //Address为空则不做修改
        if (user.getAddress().equals("") || user.getAddress() == null) {
            user1.setAddress(user1.getAddress());
        } else {
            user1.setAddress(user.getAddress());
        }
        //Email为空则不做任何修改
        if (user.getEmail().trim().isEmpty()) {
            user1.setEmail(email);
        } else {
            user1.setEmail(user.getEmail());
        }
        user1.setYear(user.getYear());
        user1.setMonth(user.getMonth());
        user1.setDay(user.getDay());
        userBiz.modifyInfo(user1, email);

        map.put("name", user1.getUsername());
        map.put("sex", user1.getSex());
        map.put("address", user1.getAddress());
        map.put("age", String.valueOf(user1.getAge()));
        map.put("year", user1.getYear());
        map.put("month", user1.getMonth());
        map.put("day", user1.getDay());
        map.put("email", user1.getEmail());

        JSONObject jsonObject = JSONObject.fromObject(map);
        this.userRes = jsonObject.toString();
        //返回字符串
        PrintWriter pw = response.getWriter();
        pw.write(this.userRes);
        pw.flush();
        pw.close();
        System.out.println(userRes);
        return null;
    }


    //个人信息
    public String userInfo() {
        User user1 = (User) request.getSession().getAttribute("loginSuccess");
        list = userBiz.showInfoById(user1.getId());
        return "userInfo";
    }

    public String language() {
        return INPUT;
    }


    //spring di
    public void setQuestionBiz(QuestionBizImpl questionBiz) {
        this.questionBiz = questionBiz;
    }
}
