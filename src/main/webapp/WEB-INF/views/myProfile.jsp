<%--
  Created by IntelliJ IDEA.
  User: sakura
  Date: 2025/6/24
  Time: 09:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>个人中心</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Helvetica Neue', sans-serif;
            background: linear-gradient(to bottom right, #fdfbfb, #ebedee);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        h1 {
            margin-top: 40px;
            color: #444;
            font-size: 32px;
        }

        .avatar {
            margin: 20px 0;
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #d1c4e9;
        }

        .info {
            font-size: 18px;
            color: #555;
            line-height: 1.8;
            text-align: left;
            max-width: 480px;
            width: 90%;
            margin-bottom: 30px;
        }

        .info p {
            margin: 6px 0;
        }

        .buttons {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 12px;
            margin-bottom: 40px;
        }

        .buttons a {
            padding: 10px 20px;
            background-color: #a5b4fc;
            color: #fff;
            border-radius: 20px;
            text-decoration: none;
            font-size: 14px;
            transition: background 0.3s ease;
        }

        .buttons a:hover {
            background-color: #6366f1;
        }

        @media (max-width: 480px) {
            h1 {
                font-size: 24px;
            }

            .info {
                font-size: 16px;
            }

            .buttons a {
                font-size: 13px;
                padding: 8px 16px;
            }
        }
    </style>
</head>
<body>
<h1>个人中心</h1>
<img class="avatar" src="${user.avatar}" alt="用户头像">
<div class="info">
    <p><strong>昵称：</strong>${user.nickname}</p>
    <p><strong>个性签名：</strong>${user.bio}</p>
    <p><strong>性别：</strong>${user.gender}</p>
    <p><strong>年龄：</strong>${user.age}</p>
    <p><strong>邮箱：</strong>${user.email}</p>
    <p><strong>地址：</strong>${user.address}</p>
    <p><strong>个人简介：</strong>${user.intro}</p>
    <p><strong>找回密码助记词：</strong>${user.answer}</p>
    <p><strong>角色：</strong>${user.role}</p>

</div>
<div class="buttons">
    <a href="${pageContext.request.contextPath}/toUpdatePassword">修改密码</a>
    <a href="${pageContext.request.contextPath}/toUpdateUser?id=${user.id}">修改信息</a>
    <a class="btn btn-danger" href="${pageContext.request.contextPath}/deleteUser?id=${user.id}" onclick="return sakura()">删除该账户</a>
    <a href="${pageContext.request.contextPath}/logout">退出登录</a>
    <a href="${pageContext.request.contextPath}/homepage">返回主页</a>

    <script>
        function sakura() {
            return confirm("确定要删除该账户吗？");
        }
    </script>

</html>

