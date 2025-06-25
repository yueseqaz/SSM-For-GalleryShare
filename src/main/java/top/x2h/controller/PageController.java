package top.x2h.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@CrossOrigin(origins = "*")
@RequestMapping("/")

public class PageController {
    @GetMapping("/")
    public String index() {
        return "index";
    }//首页
    @GetMapping("/login")
    public String login() {
        return "login";
    }//登录页面
    @GetMapping("/register")
    public String register() {
        return "register";
    }//注册页面
    @GetMapping("/forgetPassword")
    public String forgetPassword() {
        return "forgetpassword";
    }//忘记密码页面
    @GetMapping("/admin/homepage")
    public String adminHomepage() {
        return "admin/homepage";
    }//管理员首页
    @GetMapping("/homepage")
    public String userHomepage() {
        return "homepage";
    }//用户首页

    @GetMapping("/admin/addUser")
    public String addUser() {
        return "admin/addUser";
    }//添加用户页面

    @GetMapping("/toUpdatePassword")
    public String updatePassword() {
        return "updatePassword";
    }//修改密码页面

    @GetMapping("/toUpload")
    public String toUpload() {
        return "upload";
    }//上传图片页面

}
