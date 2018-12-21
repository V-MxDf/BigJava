package com.bigjava.biz.UserBizImpl;

import com.bigjava.bean.Comment;
import com.bigjava.biz.CommentBiz;
import com.bigjava.dao.UserDaoImpl.CommentDaoImpl;
import com.bigjava.util.UserException;

public class CommentBizImpl implements CommentBiz {
    private CommentDaoImpl commentDao;
    /**
     * 评论
     * @param comment
     */
    @Override
    public void addComment(Comment comment) throws UserException {
        if (comment.getCommentContent().trim().isEmpty() || comment.getCommentContent() == null)
            throw new UserException("ok 评论为空");
        commentDao.addComment(comment);
    }

//    DI
    public void setCommentDao(CommentDaoImpl commentDao) {
        this.commentDao = commentDao;
    }
}
