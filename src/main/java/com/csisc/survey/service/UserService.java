package com.csisc.survey.service;

import com.csisc.survey.dao.UserDao;
import com.csisc.survey.model.User;
import com.csisc.survey.util.HibernateUtil;
import org.hibernate.HibernateException;
import org.hibernate.Session;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by KingLf on 2016/5/18.
 */
public class UserService implements UserDao {
    public List<User> findAllUsers() {
        Session session = null;
        List<User> users=new ArrayList<User>();
        try{
            session= HibernateUtil.getSession();//得到session
            session.beginTransaction();//开启事务
            //添加事务
            users=session.createQuery("from User").list();
            session.getTransaction().commit();//执行事务
        }catch(HibernateException e){

            if(session!=null)
                session.getTransaction().rollback();
        }finally{
            if(session!=null)
                session.close();
        }
        return users;

    }

    public User findUserById(int id) {
        User user=null;
        Session session = null;
        try{
            session=HibernateUtil.getSession();//得到session
            session.beginTransaction();//开启事务
            //添加事务
            user=(User) session.get(User.class, id);
            session.getTransaction().commit();//执行事务
        }catch(HibernateException e){
            if(session!=null)
                session.getTransaction().rollback();
        }finally{
            if(session!=null)
                session.close();
        }
        return user;

    }

    public User findUserByName(String username) {
//		return (User) this.getSession().createQuery("from user where username=?").setParameter(0, username).uniqueResult();
        User user=null;
        Session session = null;
        try{
            session=HibernateUtil.getSession();//得到session
            session.beginTransaction();
            user=(User) session.createQuery("from User where username=?").setParameter(0, username).uniqueResult();
            session.getTransaction().commit();
        }catch(HibernateException e){
            e.printStackTrace();
            if(session!=null)
                session.getTransaction().rollback();
        }finally{
            if(session!=null)
                session.close();
        }
        return user;

    }

    public int add(User user) {
        Session session = null;
        try{
            session=HibernateUtil.getSession();//得到session
            session.beginTransaction();//开启事务
            //添加事务
            session.save(user);
            session.getTransaction().commit();//执行事务
            return 1;
        }catch(HibernateException e){
            e.printStackTrace();
            if(session!=null)
                session.getTransaction().rollback();
            return 0;
        }finally{
            if(session!=null)
                session.close();
        }
    }

    public int modify(User user) {
        Session session = null;
        try{
            session=HibernateUtil.getSession();//得到session
            session.update(user);
            return 1;
        }catch(HibernateException e){
            if(session!=null)
                session.getTransaction().rollback();
            return 0;
        }finally{
            if(session!=null)
                session.close();
        }

    }

    public int delete(User user) {
        Session session = null;
        try{
            session=HibernateUtil.getSession();//得到session
            session.delete(user);
            return 1;
        }catch(HibernateException e){
            if(session!=null)
                session.getTransaction().rollback();
            return 0;
        }finally{
            if(session!=null)
                session.close();
        }

    }
    public User login(String username,String password){
        User u=null;
        u=findUserByName(username);
        if(u!=null){
            if(u.getPassword().equals(password)){
                return u;
            }else{
                return null;
            }}else{
            return null;
        }
    }
}
