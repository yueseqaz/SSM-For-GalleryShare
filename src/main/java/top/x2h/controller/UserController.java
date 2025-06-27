package top.x2h.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import top.x2h.entity.User;
import top.x2h.method.Sakura;
import top.x2h.service.UserService;

import javax.servlet.http.HttpSession;

@Controller
@CrossOrigin(origins = "*")
@RequestMapping("/")
public class UserController {
    @Autowired
    private UserService userService;

    // 查看个人资料  ------------已通过测试
    @GetMapping("/myProfile")
    public String myProfile(HttpSession  session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        user.setEmail(user.getEmail());
        user.setNickname(user.getNickname());
        user.setAddress(user.getAddress());
        user.setBio(user.getBio());
        user.setIntro(user.getIntro());
        user.setAge(user.getAge());
        user.setGender(user.getGender());
        user.setAvatar(user.getAvatar());
        user.setRole(user.getRole());
        user.setAnswer(user.getAnswer());
        user.setStatus(user.getStatus());

        model.addAttribute("user", user);
        return "myProfile";
    }

    // 修改个人资料     ------------已通过测试
   @PostMapping("/updateProfile")
   public String updateProfile(@RequestParam String email,
                               @RequestParam String nickname,
                               @RequestParam String address,
                               @RequestParam String bio,
                               @RequestParam String intro,
                               @RequestParam String gender,
                               @RequestParam String avatar,
                               @RequestParam Integer age,
                               @RequestParam String answer,
                               HttpSession session) {
       User user = (User) session.getAttribute("user");
       if (user == null) {
           return "redirect:/login";
       }
       user.setEmail(email);
       user.setNickname(nickname);
       user.setAddress(address);
       user.setBio(bio);
       user.setIntro(intro);
       user.setGender(gender);
       user.setAvatar(avatar);
       user.setAge(age);
       user.setAnswer(answer);
       userService.userUpdateUser(user);
       return "redirect:/myProfile";
   }

    // 用户详情  --------------已通过测试
    @GetMapping("/toUpdateUser")
    public String toUpdateUser(@RequestParam Integer id, Model model) {
        User user = userService.getUserById(id);
        model.addAttribute("user", user);
        return "userDetail";
    }
    


    // 删除用户  -----------------已通过测试
    @GetMapping("/deleteUser")
    public String deleteUser(@RequestParam Integer id, HttpSession session) {
        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "请先登录！");
        }
        if (!sessionUser.getId().equals(id)) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "你只能删除自己的账户！");
        }
        userService.deleteUser(id);
        session.invalidate();
        return "redirect:/login";
    }

}