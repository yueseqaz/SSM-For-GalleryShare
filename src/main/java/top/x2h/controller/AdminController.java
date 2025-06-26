package top.x2h.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import top.x2h.entity.User;
import top.x2h.method.Sakura;
import top.x2h.service.UserService;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@CrossOrigin(origins = "*")
@RequestMapping("/admin")
public class AdminController {
@Autowired
    private UserService userService;



//获取所有用户 ----------已经测试通过
@GetMapping("/getAllUser")
public String getAllUser(HttpSession session,
                         Model model,
                         @RequestParam(defaultValue = "1") Integer page,
                         @RequestParam(defaultValue = "2") Integer size) {
    User user = Sakura.checkAdmin(session);
    List<User> allUser = userService.displayAllUser();
    int totalCount = userService.getUserCount();
    List<User> pagedUsers = Sakura.page(allUser, page, size, model, "allUser");
    model.addAttribute("totalCount", totalCount);
    return "/admin/usermanage";
}



//添加用户  ---------已经测试通过
    @PostMapping("/addUser")
    public String addUser(@RequestParam String email, @RequestParam String password,@RequestParam String answer,@RequestParam String nickname,@RequestParam String address,
    @RequestParam String gender,@RequestParam String status,@RequestParam String avatar,@RequestParam String role,@RequestParam Integer age,@RequestParam String bio,@RequestParam String intro, HttpSession session) {
        User currentUser = Sakura.checkAdmin(session);
        if (currentUser == null) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "你没有权限访问这个接口！");
        }
        User user = new User();
        user.setEmail(email);
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        String hashedPassword = encoder.encode(password);
        user.setPassword(hashedPassword);
        user.setNickname(nickname);
        user.setAddress(address);
        user.setGender(gender);
        user.setAvatar(avatar);
        user.setRole(role);
        user.setAge(age);
        user.setBio(bio);
        user.setIntro(intro);
        user.setAnswer(answer);
        user.setStatus("active");
        userService.addUser(user);
        return "redirect:/admin/getAllUser";
    }

//删除用户 -------------已经测试通过
@GetMapping("/deleteUser")
public String deleteUser(@RequestParam Integer id,HttpSession session){
   User currentUser = Sakura.checkAdmin(session);
    if (currentUser== null){
        throw new ResponseStatusException(HttpStatus.FORBIDDEN, "你没有权限访问这个接口！");
    }
    userService.deleteUser(id);
    return "redirect:/admin/getAllUser";
}

//查询单个用户的信息  ---------已经测试通过
    @GetMapping("/toUpdateUser")
    public String toUpdateUser(@RequestParam Integer id, Model model,HttpSession session) {
        User currentUser = Sakura.checkAdmin(session);
        if (currentUser == null) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "你没有权限访问这个接口！");
        }
        User user = userService.getUserById(id);
        user.setPassword("为保护客户隐私，无法进行该操作");
        model.addAttribute("user", user);
        return "/admin/userDetail";
    }

//修改用户  -------------已经测试通过
@PostMapping("/updateUser")
    public String updateUser(@RequestParam Integer id,@RequestParam String email, @RequestParam String nickname,@RequestParam String address,
                             @RequestParam String bio, @RequestParam String intro,@RequestParam String gender,
                             @RequestParam String avatar, @RequestParam String role,@RequestParam Integer age,@RequestParam String answer
                                     ,@RequestParam String status, HttpSession session) {
    User currentUser = Sakura.checkAdmin(session);
    if (currentUser == null) {
        throw new ResponseStatusException(HttpStatus.FORBIDDEN, "你没有权限访问这个接口！");
    }
    User user = new User();
    user.setId(id);
    user.setEmail(email);
    user.setNickname(nickname);
    user.setAddress(address);
    user.setBio(bio);
    user.setIntro(intro);
    user.setGender(gender);
    user.setAvatar(avatar);
    user.setRole(role);
    user.setAge(age);
    userService.adminUpdateUser(user);
    return "redirect:/admin/getAllUser";
}

//封禁用户   ----------已经测试通过
@GetMapping("/banUser")
    public String banUser(@RequestParam Integer id,HttpSession session)
    {
    User currentUser = Sakura.checkAdmin(session);
    if (currentUser == null) {
        throw new ResponseStatusException(HttpStatus.FORBIDDEN, "你没有权限访问这个接口！");
    }
    User user = userService.getUserById(id);
    user.setStatus("blocked");
    userService.adminEditStatus(user);
    return "redirect:/admin/getAllUser";
    }


    //解封用户   ----------已经测试通过
    @GetMapping("/unbanUser")
    public String unbanUser(@RequestParam Integer id,HttpSession session)
        {
        User currentUser = Sakura.checkAdmin(session);
        if (currentUser == null) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "你没有权限访问这个接口！");
        }
        User user = userService.getUserById(id);
        user.setStatus("active");
        userService.adminEditStatus(user);
        return "redirect:/admin/getAllUser";
        }

}
