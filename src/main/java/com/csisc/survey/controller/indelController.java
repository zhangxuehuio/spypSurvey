package com.csisc.survey.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by KingLf on 2016/5/18.
 */

@Controller
@RequestMapping(value = "haha")
public class indelController {

    public static void main(String[] args) {
        System.out.printf("asdasd");
    }

    @RequestMapping(value="login")
    public @ResponseBody String login(Model model){
        System.out.println("恒公进入");
        return "success";
    }
}
