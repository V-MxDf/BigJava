package com.bigjava.dao.UserDaoImpl;

import com.bigjava.bean.Comment;
import com.bigjava.dao.CommentDao;
import org.springframework.orm.hibernate5.support.HibernateDaoSupport;

public class CommentDaoImpl extends HibernateDaoSupport implements CommentDao {
    /**
     * 添加评论
     * @param comment
     */
    @Override
    public void addComment(Comment comment) {
        this.getHibernateTemplate().save(comment);
    }

}
