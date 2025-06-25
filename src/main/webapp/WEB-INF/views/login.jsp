<%--
  Created by IntelliJ IDEA.
  User: sakura
  Date: 2025/6/24
  Time: 09:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8" />
    <title>用户登录</title>
    <style>
        body {
            font-family: "Segoe UI", sans-serif;

            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-size: cover;
        }
        .login-box {
            background-color: white;
            padding: 40px 30px;
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
            width: 360px;
        }
        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #ff69b4;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        .email-group {
            display: flex;
            margin-bottom: 20px;
        }
        #emailName {
            flex: 1;
            padding: 10px;
            border: 2px solid #ddd;
            border-radius: 8px 0 0 8px;
            font-size: 14px;
            transition: border-color 0.3s;
            box-sizing: border-box;
        }
        #emailDomain {
            padding: 10px;
            border: 2px solid #ddd;
            border-left: none;
            border-radius: 0 8px 8px 0;
            font-size: 14px;
            background: white;
            cursor: pointer;
        }
        #emailName:focus, #emailDomain:focus {
            border-color: #ff69b4;
            outline: none;
        }
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s;
            box-sizing: border-box;
        }
        input[type="password"]:focus {
            border-color: #ff69b4;
            outline: none;
        }
        input[type="submit"] {
            background-color: #ff69b4;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #ff1493;
        }
        .links {
            display: flex;
            justify-content: space-between;
            margin-top: 15px;
            font-size: 14px;
        }
        .links a {
            color: #ff69b4;
            text-decoration: none;
        }
        .links a:hover {
            text-decoration: underline;
        }
        .error-message {
            color: #d8000c;
            font-size: 14px;
            margin-bottom: 15px;
            text-align: center;
            min-height: 20px;
        }
    </style>
</head>
<body>

<div class="login-box">
    <h2>🎀 用户登录</h2>
    <form id="loginForm" action="${pageContext.request.contextPath}/login" method="post" onsubmit="return validateLogin()">
        <div class="email-group">
            <input
                    type="text"
                    id="emailName"
                    name="emailName"
                    placeholder="请输入邮箱用户名"
                    autocomplete="username"
                    required
                    maxlength="64"
            />
            <select id="emailDomain" name="emailDomain" required>
                <option value="@qq.com">@qq.com</option>
                <option value="@163.com">@163.com</option>
                <option value="@gmail.com">@gmail.com</option>
                <option value="@outlook.com">@outlook.com</option>
                <option value="@icloud.com">@icloud.com</option>
            </select>
        </div>

        <input
                type="password"
                name="password"
                id="password"
                placeholder="请输入密码"
                required
                autocomplete="current-password"
        />

        <input type="hidden" name="email" id="emailFull" />

        <div class="error-message" id="errorMsg">
            <c:if test="${not empty error}">
                ${error}
            </c:if>
        </div>

        <input type="submit" value="登录" />
    </form>

    <div class="links">
        <a href="${pageContext.request.contextPath}/register">去注册</a>
        <a href="${pageContext.request.contextPath}/forgetPassword">忘记密码？</a>
    </div>
</div>

<script>
    function validateLogin() {
        const emailName = document.getElementById('emailName').value.trim();
        const emailDomain = document.getElementById('emailDomain').value;
        const password = document.getElementById('password').value.trim();
        const errorMsg = document.getElementById('errorMsg');
        const emailFull = document.getElementById('emailFull');

        errorMsg.textContent = '';

        if (!emailName) {
            errorMsg.textContent = '邮箱用户名不能为空！';
            return false;
        }

        if (/\s/.test(emailName)) {
            errorMsg.textContent = '邮箱用户名不能包含空格！';
            return false;
        }

        // 拼接完整邮箱
        const fullEmail = emailName + emailDomain;

        // 简单邮箱正则验证
        const emailPattern = /^[\w.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        if (!emailPattern.test(fullEmail)) {
            errorMsg.textContent = '邮箱格式不正确！';
            return false;
        }

        if (!password) {
            errorMsg.textContent = '密码不能为空！';
            return false;
        }

        if (/\s/.test(password)) {
            errorMsg.textContent = '密码不能包含空格！';
            return false;
        }

        // 提交时把完整邮箱赋值给隐藏字段
        emailFull.value = fullEmail;

        return true;
    }
</script>

</body>
</html>

