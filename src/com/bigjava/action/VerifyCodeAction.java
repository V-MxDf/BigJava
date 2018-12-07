package com.bigjava.action;

import com.bigjava.util.VerifyCode;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;

public class VerifyCodeAction extends ActionSupport {
    private HttpServletRequest request = ServletActionContext.getRequest();
    private HttpServletResponse response = ServletActionContext.getResponse();

    public String verifyCode() throws Exception {
        VerifyCode verifyCode = new VerifyCode();   //创建对象
        BufferedImage image = verifyCode.getImage();    //获取图片
        String text = verifyCode.getText();     //获取文本

        request.getSession().setAttribute("imageText",text);    //将系统生成的文本保存在session中
        verifyCode.output(image,response.getOutputStream());
        return null;
    }
}
