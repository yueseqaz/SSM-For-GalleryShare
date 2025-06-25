package top.x2h.service.serviceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.x2h.Mapper.UserMapper;
import top.x2h.entity.User;
import top.x2h.service.UserService;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
 @Autowired
 private UserMapper UserMapper;
 @Override
 public List<User> displayAllUser(){
  return UserMapper.selectAllUsers();
 }
@Override
 public void addUser(User user){
  UserMapper.insertUser(user);
 }
 @Override
 public void deleteUser(Integer id){
  UserMapper.deleteUser(id);
 }
 @Override
 public User getUserByEmail(String  email){
  return UserMapper.selectUserByEmail(email);
 }
 @Override
 public void adminUpdateUser(User user){
  UserMapper.adminUpdateUser(user);
 }
 @Override
 public User getUserById(Integer id){
  return UserMapper.selectUserById(id);
 }
 @Override
 public  void userUpdateUser(User user){
  UserMapper.userUpdateUser(user);
 }
 @Override
 public void updatePassword(User  user){
  UserMapper.updatePassword(user);
 }
 @Override
 public void resetPassword(User user){
  UserMapper.resetPassword(user);
 }
 @Override
 public int getUserCount(){
  return UserMapper.getUserCount();
 }
 @Override
 public void adminEditStatus(User user){
  UserMapper.adminEditStatus(user);
 }
}
