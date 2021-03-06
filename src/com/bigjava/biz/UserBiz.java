package com.bigjava.biz;

import com.bigjava.bean.User;
import com.bigjava.util.UserException;

import java.util.List;

public interface UserBiz {
    //登录
    public User login(String username, String password) throws UserException;
    //注册
    public boolean register(User user) throws UserException;
    //分页
    public List<User> findAll(int indexPage,int pageSize);
    //改变状态
    public void modifyState(String code);
    //根据id显示所有信息
    public List<User> showInfoById(int id);
    //修改资料 顺带检查邮箱
    public void modifyInfo(User user,String email) throws UserException;

    //修改头像
    public void updateImg(String fileName,int id);
}
