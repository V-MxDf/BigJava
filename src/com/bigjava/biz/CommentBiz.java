package com.bigjava.biz;

import com.bigjava.bean.Comment;
import com.bigjava.util.UserException;

public interface CommentBiz {
    void addComment (Comment comment) throws UserException;
}
