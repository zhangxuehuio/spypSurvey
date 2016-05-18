package com.csisc.survey.controller;

import com.csisc.survey.model.Result;
import com.csisc.survey.model.User;
import com.csisc.survey.service.ResultService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by KingLf on 2016/5/18.
 */
@Controller
@RequestMapping("/home")
@SessionAttributes("json")
public class homeController {

    @RequestMapping("/postAnswer")
    public @ResponseBody String postAnswer(HttpServletResponse resp, HttpServletRequest hsq, Model model, String postAnswer, int page){
        User u=(User) hsq.getSession().getAttribute("loginUser");
        if(u==null){
            return "ERROR";
        }
        ResultService rs=new ResultService();
        rs.modifyResult(page, postAnswer, u);
        return "OK";
    }

    @RequestMapping("/getAnswer")
    public @ResponseBody String getAnswer(HttpServletRequest hsq, int page, Model model){
        User u=(User) hsq.getSession().getAttribute("loginUser");
        if(u==null){
            return "error";
        }else{
            ResultService rs=new ResultService();
            Result result=null;
            result=rs.getResult(u, page);
            if(result==null){
                return "null";
            }else{
                return result.getResult();
            }
        }
    }

}
