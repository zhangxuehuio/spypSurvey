package com.csisc.survey.dao;

import com.csisc.survey.model.Result;
import com.csisc.survey.model.User;

/**
 * Created by KingLf on 2016/5/18.
 */
public interface ResultDao {
    public int addResult(Result result);
    public int addResult(int pageId,String result,User user);
    public Result getResult(User user,int page);
    public int modifyResult(Result result);
    public int modifyResult(int pageId,String result,User user);
}
