package com.bigjava.util;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateUtil {
    private static Configuration configuration ;
    private static SessionFactory sessionFactory;
    static {
        try {
            configuration = new Configuration().configure();
            sessionFactory = configuration.buildSessionFactory();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Hibernate  失败");
        }

    }
    private SessionFactory getSessionFactory(){
        return sessionFactory;
    }

    public Session getSession (){
        return getSessionFactory().openSession();
    }
}
