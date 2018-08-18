package com.boot.controller;

import com.boot.entity.Role;
import com.boot.entity.User;
import com.boot.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Collections;
import java.util.Map;
import java.util.UUID;

@Controller
public class RegistrationController {
    @Value("${upload.path}")
    private String uploadPath;
    @Autowired
    private UserRepository userRepository;
    @GetMapping("/registration")
    public String registration(){
        return "registration";
    }
    @PostMapping("/registration")
    public String addUser(User user, @RequestParam("file") MultipartFile file,Map<String, Object> model){

        User userFromDB = userRepository.findByUsername(user.getUsername());
        if(userFromDB!=null){
            model.put("message","User exists");
            return registration();
        }
        else{
            user.setRoles(Collections.singleton(Role.USER));
            userRepository.save(user);
        }
        if(file!=null){
            uploadPath+="/"+user.getId();
            File uploadDir = new File(uploadPath);
            if(!uploadDir.exists()){
                uploadDir.mkdir();

            }
            try {
                File file1 = new File("../../../../../../../../../../"+ uploadPath + "/" + "logo.jpg");
                file.transferTo(file1);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return "redirect:/login";
    }
}
