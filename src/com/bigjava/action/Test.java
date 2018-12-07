package com.bigjava.action;

import com.bigjava.bean.User;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class Test extends ActionSupport implements ModelDriven<User> {
    private String result;
    private User user = new User();

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }
    public String test() {
        System.out.println(user.getUsername());
        System.out.println(user.getPassword());
        if(!user.getUsername().equals("admin") && !user.getPassword().equals("admin")) {
            result = "用户密码错误";
        }else{
            result = "登录成功";
        }
        return SUCCESS;
    }

    @Override
    public User getModel() {
        return user;
    }
}
