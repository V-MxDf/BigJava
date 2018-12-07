package com.bigjava.dao.UserDaoImpl;


import com.bigjava.bean.Log;
import com.bigjava.bean.User;
import com.bigjava.biz.UserBizImpl.LogBizImpl;
import com.bigjava.dao.UserDao;
import org.hibernate.query.Query;
import org.springframework.orm.hibernate5.support.HibernateDaoSupport;

import java.util.Date;
import java.util.List;

public class UserDaoImpl  extends HibernateDaoSupport implements UserDao {

    private LogBizImpl logBiz;
    private Log log;
    public void setLogBiz(LogBizImpl logBiz) {
        this.logBiz = logBiz;
    }

    public void setLog(Log log) {
        this.log = log;
    }

    @Override
    //根据用户和密码查询
    public User findByNameAndPassword(String username, String password) {
            Query query = this.getHibernateTemplate().getSessionFactory().getCurrentSession().createQuery("FROM User WHERE username =: username AND password =: password");
            query.setParameter("username", username);
            query.setParameter("password", password);
            return (User) query.uniqueResult();
    }

    @Override
    /**
     * 添加
     *
     * @param user
     */
    public void addUser(User user) {
          this.getHibernateTemplate().save(user);
            log.setType("注册日志");
            log.setTime(new Date());
            log.setDetail(user.getUsername() + "已添加");
            logBiz.addLog(log);
    }

    @Override
    /**
     * 改变激活状态
     * @param code
     */
    public void modifyState(String code) {
        Query query = getHibernateTemplate().getSessionFactory().getCurrentSession().createQuery("UPDATE User u set u.state= 1 where u.code=: code");
        query.setParameter("code", code);
        query.executeUpdate();
    }

    @Override
    /**
     * 查询全部
     *
     * @param indexPage
     * @param pageSize
     * @return
     */
    public List<User> findAll(int indexPage, int pageSize) {
        return this.getHibernateTemplate().getSessionFactory()
                .getCurrentSession().createQuery("FROM User")
                .setFirstResult((indexPage - 1) * pageSize)
                .setMaxResults(pageSize).list();
    }

    //根据id显示所有信息
    @Override
    public List<User> findByUserId(int id) {
        return this.getHibernateTemplate().getSessionFactory().getCurrentSession().createQuery("FROM User u where u.id =: id")
                .setParameter("id",id  ).list();
    }

    //修改资料
    @Override
    public void modifyInfo(User user) {
//        String hql = "UPDATE User u set u";
//        this.getHibernateTemplate().getSessionFactory().getCurrentSession().createQuery(hql);
        this.getHibernateTemplate().getSessionFactory().getCurrentSession().update(user);
    }
}
