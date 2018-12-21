package com.bigjava.dao;


import com.bigjava.bean.User;

import java.util.List;

public interface UserDao {
    //添加
    public void addUser(User user);
    //根据用户和密码查询
    public User findByNameAndPassword(String username,String password);
    //改变激活状态
    public void modifyState(String code);
    //查询全部
    public List findAll(int indexPage, int pageSize);
    //根据id显示所有信息
    public List<User> findByUserId(int id);
    //修改信息
    public void modifyInfo(User user);
   // 修改图片名称
    public void modifyFileName(String fileName,int id);

}
