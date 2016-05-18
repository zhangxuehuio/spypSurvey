package com.csisc.survey.dao;

import com.csisc.survey.model.User;

import java.util.List;

/**
 * Created by KingLf on 2016/5/18.
 */
public interface UserDao {
    public List<User> findAllUsers();
    public User findUserById(int id);
    public User findUserByName(String username);

    public int add(User user);
    public int modify(User user);
    public int delete(User user);
}
