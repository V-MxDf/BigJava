package com.bigjava.action;

import com.bigjava.bean.User;
import com.opensymphony.xwork2.ActionSupport;
import net.sf.json.JSONObject;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

public class Test extends ActionSupport {

    private File uploadImage;//得到上传的文件
    private String uploadImageContentType;//得到文件的类型
    private String uploadImageFileName;//得到文件的名称
    //用来返回json字符串的
    private String res;

    public File getUploadImage() {
        return uploadImage;
    }

    public void setUploadImage(File uploadImage) {
        this.uploadImage = uploadImage;
    }

    public String getUploadImageContentType() {
        return uploadImageContentType;
    }

    public void setUploadImageContentType(String uploadImageContentType) {
        this.uploadImageContentType = uploadImageContentType;
    }

    public String getUploadImageFileName() {
        return uploadImageFileName;
    }

    public void setUploadImageFileName(String uploadImageFileName) {
        this.uploadImageFileName = uploadImageFileName;
    }

    public String getRes() {
        return res;
    }

    public void setRes(String res) {
        this.res = res;
    }

    public String postPhoto() throws Exception {
//        UserBizImpl userBiz = new UserBizImpl（）;
        User user = new User();
        Map<String, String> photoData = new HashMap<String, String>();
        /*
         * ServletActionContext.getServletContext().getRealPath("/")
         * 是当前【程序】在磁盘中的位置，
         * 如：D:\apache-tomcat-7.0.6\webapps\SchoolWeb
         */
        //把文件保存到服务器的路径
        String realpath = ServletActionContext.getServletContext().getRealPath("/test");
        File file = new File(realpath);

        // 没有此文件夹就创建
        if (!file.exists()) file.mkdirs();
        try {
            FileUtils.copyFile(uploadImage, new File(file, uploadImageFileName));
            photoData.put("name", uploadImageFileName);
            photoData.put("path", "test" + "/" + uploadImageFileName);
//            user.setImage(uploadImageFileName);
//            userBiz.modifyInfo(user);
            // 将要返回的map对象进行json处理
            JSONObject jo = JSONObject.fromObject(photoData);

            // 调用json对象的toString方法转换为字符串然后赋值给result
            this.res = jo.toString();

            //返回字符串
            HttpServletResponse response = ServletActionContext.getResponse();
            response.setContentType("text/html;charset=utf-8");
            PrintWriter pw = response.getWriter();
            pw.write(this.res);
            pw.flush();
            pw.close();
        } catch (IOException e) {

            e.printStackTrace();
        }

        //记得这里返回null，留意下面Struts.xml文件的怎么配置
        return null;
    }

}
