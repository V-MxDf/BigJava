package com.bigjava.biz.UserBizImpl;

import com.bigjava.bean.Answer;
import com.bigjava.bean.User;
import com.bigjava.biz.UserBiz;
import com.bigjava.dao.UserDaoImpl.UserDaoImpl;
import com.bigjava.util.CodeUtil;
import com.bigjava.util.MailUtil;
import com.bigjava.util.UserException;

import java.util.List;

public class UserBizImpl implements UserBiz {
    private UserDaoImpl userDao;
    private QuestionBizImpl questionBiz;
    private Answer answer;

    public UserBizImpl(UserDaoImpl userDao) {
        this.userDao = userDao;
    }

    public UserBizImpl() {
    }

    /**
     * 分页
     *
     * @param indexPage
     * @param pageSize
     * @return
     */
    public List<User> findAll(int indexPage, int pageSize) {
        return userDao.findAll(indexPage, pageSize);
    }

    //登陆
    public User login(String username, String password) throws UserException {
        return userDao.findByNameAndPassword(username, password);
    }

    //效验邮箱并生成激活码 这个参数是为了比较和数据库值是否相同
    public boolean verifyEmail(User user, String email) throws UserException {
        if (user.getEmail().matches("^\\w+@(\\w+\\.)+\\w+$") && !user.getEmail().equals(email)) {
            //生成激活码
            String code = CodeUtil.generateUniqueCode();
            user.setCode(code);
            new Thread(new MailUtil(user.getEmail(), user.getCode())).start();
            return true;
        }
        return false;
    }

    //注册
    public boolean register(User user) throws UserException {
        if (user != null) {
            if (user.getEmail().matches("^\\w+@(\\w+\\.)+\\w+$")) {
                //生成激活码
                String code = CodeUtil.generateUniqueCode();
                user.setCode(code);
                userDao.addUser(user);
                new Thread(new MailUtil(user.getEmail(), user.getCode())).start();
                return true;
            }
        }
        return false;
    }

    //改变状态
    public void modifyState(String code) {
        userDao.modifyState(code);
    }

    //根据id显示用户信息
    @Override
    public List<User> showInfoById(int id) {
        return userDao.findByUserId(id);
    }

    //修改资料 顺带检查邮箱
    @Override
    public void modifyInfo(User user,String email) throws UserException {
        verifyEmail(user,email);
        userDao.modifyInfo(user);
    }

    //修改头像
    @Override
    public void updateImg(String fileName, int id) {
        userDao.modifyFileName(fileName,id );
    }

    public void setQuestionBiz(QuestionBizImpl questionBiz) {
        this.questionBiz = questionBiz;
    }

    public void setAnswer(Answer answer) {
        this.answer = answer;
    }
}
