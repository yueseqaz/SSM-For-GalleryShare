package top.x2h.service;

import org.springframework.stereotype.Service;
import top.x2h.entity.User;
import java.util.List;

@Service
public interface UserService {
    List<User> displayAllUser();
    void addUser(User user);
    void deleteUser(Integer id);
    User getUserByEmail(String  email);
    void adminUpdateUser(User user);
    User getUserById(Integer id);
    void userUpdateUser(User user);
    void updatePassword(User  user);
    void resetPassword(User user);
    int getUserCount();
    void adminEditStatus(User  user);
}