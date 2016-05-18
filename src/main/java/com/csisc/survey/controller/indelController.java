package com.csisc.survey.controller;

import com.csisc.survey.document.ListContent;
import com.csisc.survey.model.User;
import com.csisc.survey.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by KingLf on 2016/5/18.
 */

@Controller
@SessionAttributes(value={"loginUser","list"})
public class indelController {
    @RequestMapping(value="login")
    public @ResponseBody Map<String,Object> loginAJAX(String username,String password,Model model){
        UserService us=new UserService();
        Map<String,Object> map=new HashMap<String, Object>();
        User u=null;
        u=us.login(username, password);
        if(u!=null){
            model.addAttribute("loginUser",u);
            model.addAttribute("list", ListContent.getList(u.getLevel()));
            map.put("msg", "success");
        }else{
            map.put("msg", "用户名或者密码错误");
        }
        return map;
    }
    @RequestMapping(value="/home")
    public String home(){
        return "/home";
    }
}
