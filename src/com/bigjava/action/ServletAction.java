package com.bigjava.action;

import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.interceptor.ServletRequestAware;

import javax.servlet.http.HttpServletRequest;

public class ServletAction extends ActionSupport implements ServletRequestAware {
    private HttpServletRequest servletRequest;
    @Override
    public void setServletRequest(HttpServletRequest servletRequest) {
        this.servletRequest = servletRequest;
    }
    public String test () {
        servletRequest.setAttribute("test","request.val" );
        servletRequest.getSession().setAttribute("ses","ses_val" );
        servletRequest.getSession().getServletContext().setAttribute("app","app_val" );
        return SUCCESS;
    }
}
