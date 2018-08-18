package com.boot.controller;

import com.boot.entity.User;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@Controller
public class MainController {
    @GetMapping("/undefined")
    public String getError(Model model){
        return "login";
    }
    @GetMapping("/")
    public String getMain(@AuthenticationPrincipal User user,@RequestParam(name = "name",required = false,defaultValue = "User") String name,
                          Map<String,Object> model){
            model.put("user",user);
        return "greeting";
    }
}
