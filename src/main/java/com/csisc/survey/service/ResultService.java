package com.csisc.survey.service;

import com.csisc.survey.dao.ResultDao;
import com.csisc.survey.model.Result;
import com.csisc.survey.model.User;
import com.csisc.survey.util.HibernateUtil;
import org.hibernate.HibernateException;
import org.hibernate.Session;

/**
 * Created by KingLf on 2016/5/18.
 */
public class ResultService implements ResultDao {

    public int addResult(Result result) {
        Session session = null;
        try{
            session=HibernateUtil.getSession();//得到session
            session.beginTransaction();//开启事务
            //添加事务
            session.save(result);
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

    public Result getResult(User user, int page) {
        Session session = null;
        Result result=null;
        try{
            session=HibernateUtil.getSession();//得到session
            session.beginTransaction();//开启事务
            //添加事务
            result=(Result) session.createQuery("from Result where pageId=? and user=?").setParameter(0, page).setParameter(1, user).uniqueResult();
            session.getTransaction().commit();//执行事务
        }catch(HibernateException e){
            if(session!=null)
                session.getTransaction().rollback();
        }finally{
            if(session!=null)
                session.close();
        }
        return result;
    }

    public int modifyResult(Result result) {
        Session session = null;
        try{
            session=HibernateUtil.getSession();//得到session
            session.update(result);
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

    public int addResult(int pageId, String result, User user) {
        Result res=new Result();
        res.setPageId(pageId);
        res.setResult(result);
        res.setUser(user);
        return addResult(res);
    }

    public int modifyResult(int pageId, String res, User user) {
        Session session = null;
        Result result=null;
        try{
            session=HibernateUtil.getSession();//得到session
            session.beginTransaction();//开启事务
            //添加事务
            result=(Result) session.createQuery("from Result where pageId=? and user=?").setParameter(0, pageId).setParameter(1, user).uniqueResult();
            if(result==null){
                result=new Result();
                result.setPageId(pageId);
                result.setUser(user);
                result.setResult(res);
                session.save(result);
            }else{
                result.setResult(res);
                session.update(result);
            }
            session.getTransaction().commit();//执行事务
        }catch(HibernateException e){
            if(session!=null)
                session.getTransaction().rollback();
        }finally{
            if(session!=null)
                session.close();
        }
        return 1;
    }
}
