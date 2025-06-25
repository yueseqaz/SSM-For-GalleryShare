package top.x2h.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import top.x2h.entity.User;
import top.x2h.service.UserService;

import javax.servlet.http.HttpSession;

@Controller
@CrossOrigin(origins = "*")
@RequestMapping("/")

public class AuthController {

    @Autowired
    private UserService userService;


    // 注册 -------------------已测试通过
    @PostMapping("/register")
    public String register(@RequestParam String email, @RequestParam String password,Model  model){
        User user = new User();
        user.setEmail(email);
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        String hashedPassword = encoder.encode(password);
        user.setPassword(hashedPassword);
        user.setRole("user");
        user.setAge(18);
        user.setAvatar("https://img.loliapi.com/i/pp/img93.webp");
        user.setAddress("中国");
        user.setGender("男");
        user.setBio("无");
        user.setIntro("无");
        user.setNickname("用户");
        user.setAnswer("无");
        user.setStatus("active");
        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            model.addAttribute("error", "邮箱和密码不能为空！");
            return "register";
        }
        if (!email.contains("@")) {
            model.addAttribute("error", "请输入有效的邮箱！");
            return "register";
        }
        if (userService.getUserByEmail(email) != null) {
            model.addAttribute("error", "邮箱已存在！");
            return "register";
        }
        userService.addUser(user);
        return "redirect:/login";
    }


    // 登录  ---------------------已测试通过
    @PostMapping("/login")
    public String login(@RequestParam String email, @RequestParam String password, HttpSession session, Model model){
        User user = userService.getUserByEmail(email);
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        if (user != null && encoder.matches(password, user.getPassword())) {
            if (user.getRole().equals("admin")){
                session.setAttribute("user", user);
                return "redirect:/admin/homepage";
            }
            if (user.getStatus().equals("blocked")){
                model.addAttribute("error", "用户被封禁！");
                return "login";
            }
            session.setAttribute("user", user);
            model.addAttribute("user",user);
            return "redirect:/homepage";
        } else {
            model.addAttribute("error", "账号不存在或密码错误！");
            return "login";
        }

    }


    //退出登陆  ---------------------已测试通过
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("user");
        return "redirect:/login";
    }


    //修改密码     ---------------------已测试通过
    @PostMapping("/updatePassword")
    public String updatePassword(@RequestParam String email,
                                 @RequestParam Integer id,
                                 @RequestParam String oldPassword,
                                 @RequestParam String newPassword,
                                 HttpSession session) {
        User currentUser = (User) session.getAttribute("user");
        currentUser.setId( id);
        if (currentUser == null) {
            return "redirect:/login";
        }
        if (!currentUser.getEmail().equals(email)) {

            return "redirect:/updatePassword";
        }

        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        if (!encoder.matches(oldPassword, currentUser.getPassword())) {

            return "redirect:/updatePassword";
        }
        currentUser.setPassword(encoder.encode(newPassword));
        userService.updatePassword(currentUser);
        session.setAttribute("user", currentUser);

        return "redirect:/homepage";
    }



    //忘记密码   ---------------------已测试通过
    @PostMapping("/forgetPassword")
    public String forgetPassword(@RequestParam String email,
                                 @RequestParam String newPassword,
                                 @RequestParam String answer) {
        User user = userService.getUserByEmail(email);
        if (user != null) {
            if (user.getAnswer() != null && user.getAnswer().equalsIgnoreCase(answer.trim())) {
                BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
                user.setPassword(encoder.encode(newPassword));
                userService.resetPassword(user);
                return "redirect:/login";
            }
        }

        return "redirect:/forgetPassword";
    }

}
