package top.x2h.Mapper;

import top.x2h.entity.User;

import java.util.List;

public interface UserMapper {
    List<User> selectAllUsers();
    void insertUser(User user);
    void deleteUser(Integer id);
    User selectUserByEmail(String  email);
    void adminUpdateUser(User user);
    User selectUserById(Integer id);
    void userUpdateUser(User user);
    void updatePassword(User  user);
    void resetPassword(User user);
    int getUserCount();
    void adminEditStatus(User user);
}
