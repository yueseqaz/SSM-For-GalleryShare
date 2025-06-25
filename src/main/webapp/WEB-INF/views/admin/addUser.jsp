<%--
  Created by IntelliJ IDEA.
  User: sakura
  Date: 2025/6/24
  Time: 15:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1>添加用户</h1>
<form action="${pageContext.request.contextPath}/admin/addUser" method="post">
  邮箱：<input type="text" name="email">
  密码：<input type="text" name="password">
  昵称：<input type="text" name="nickname">
  地址：<input type="text" name="address">
  性别：<input type="text" name="gender">
  头像：<input type="text" name="avatar">
  角色：<input type="text" name="role">
  年龄<input type="text" name="age">
  签名：<input type="text" name="bio">
  简介：<input type="text" name="intro">
  忘记密码助记词：<input type="text" name="answer">
  <input type="submit" value="提交">
</form>
<a href="${pageContext.request.contextPath}/admin/getAllUser">返回用户管理</a>
</body>
</html>
