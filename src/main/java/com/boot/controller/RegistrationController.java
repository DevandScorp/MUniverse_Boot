package com.boot.controller;

import com.boot.entity.Role;
import com.boot.entity.User;
import com.boot.repository.UserRepository;
import com.boot.service.MailSender;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
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
    @Autowired
    private MailSender mailSender;
    @GetMapping("/registration")
    public String registration(){
        return "registration";
    }
    public boolean activateUser(String code) {
        User user = userRepository.findByActivationCode(code);
        if(user==null){
            return false;
        }
        user.setActivationCode(null);
        /**
         * ТОлько после того,как была получена обратная связь от ссылки,мы сохраняем пользователя.
         */
        userRepository.save(user);
        return true;
    }
    @GetMapping("/activate/{code}")
    public String activate(Model model, @PathVariable String code){
        boolean isActivated = activateUser(code);
        if(isActivated)model.addAttribute("message","User was successfully activated");
        else model.addAttribute("message","Activation code not found");
        return "login";
    }

    @PostMapping("/registration")
    public String addUser(@RequestParam("file") MultipartFile file,
                          @Valid User user,
                          BindingResult bindingResult,
                          Model model){
        if(bindingResult.hasErrors()){
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);
            return "registration";
        }
        User userFromDB = userRepository.findByUsername(user.getUsername());
        if(userFromDB!=null){
            model.addAttribute("message","User exists");
            return registration();
        }
        else{
            user.setActivationCode(UUID.randomUUID().toString());
            user.setRoles(Collections.singleton(Role.USER));
            if(!StringUtils.isEmpty(user.getEmail())){
                String message = String.format("Hello,%s!\n" +
                                " Please,visit next Link to verify your email: http://localhost:8080/activate/%s",
                        user.getUsername(),user.getActivationCode());
                mailSender.send(user.getEmail(),"Activation code",message);
            }
            userRepository.save(user);
        }
        if(file!=null){
            System.out.println(user.getId());
            String uPath = uploadPath+"/"+user.getId();
            File uploadDir = new File(uPath);
            if(!uploadDir.exists()){
                uploadDir.mkdir();

            }
            try {
                File file1 = new File("../../../../../../../../../../"+ uPath + "/" + "logo.jpg");
                file.transferTo(file1);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return "redirect:/login";
    }
}
