package com.bigjava.biz.UserBizImpl;

import com.bigjava.bean.Log;
import com.bigjava.biz.LogBiz;
import org.springframework.orm.hibernate5.support.HibernateDaoSupport;

public class LogBizImpl  extends HibernateDaoSupport implements LogBiz {
    @Override
    public void addLog(Log log) {
       getHibernateTemplate().save(log);
}
}
