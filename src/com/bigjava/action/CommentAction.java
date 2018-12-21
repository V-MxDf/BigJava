package com.bigjava.action;

import com.bigjava.bean.Comment;
import com.bigjava.bean.User;
import com.bigjava.biz.UserBizImpl.CommentBizImpl;
import com.bigjava.biz.UserBizImpl.UserBizImpl;
import com.bigjava.util.UserException;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;

public class CommentAction  extends ActionSupport {
    private HttpServletRequest request = ServletActionContext.getRequest();
    private UserBizImpl userBiz;
    private CommentBizImpl commentBiz;
    private Comment comment = new Comment();

    public Comment getComment() {
        return comment;
    }

    public void setComment(Comment comment) {
        this.comment = comment;
    }

    public UserBizImpl getUserBiz() {
        return userBiz;
    }

    public void setUserBiz(UserBizImpl userBiz) {
        this.userBiz = userBiz;
    }

    public CommentBizImpl getCommentBiz() {
        return commentBiz;
    }

    public void setCommentBiz(CommentBizImpl commentBiz) {
        this.commentBiz = commentBiz;
    }

    /**
     * 评论
     * @return
     */
    public String addComment() throws UserException {
        User user = (User) request.getSession().getAttribute("loginSuccess");
        comment.setUserId(user.getId());
        System.out.println("添加评论"+comment);
        commentBiz.addComment(comment);
        return "addComment";
    }
}
