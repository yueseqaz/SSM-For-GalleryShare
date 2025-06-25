<%--
  Created by IntelliJ IDEA.
  User: sakura
  Date: 2025/6/24
  Time: 09:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8" />
    <title>用户注册</title>
    <style>
        body {
            font-family: "Segoe UI", sans-serif;
            background: linear-gradient(to right, #fdfbfb, #ebedee);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .register-box {
            background-color: white;
            padding: 40px 30px;
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
            width: 360px;
            position: relative;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #ff69b4;
        }

        .form-group {
            margin-bottom: 20px;
            position: relative;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s;
            box-sizing: border-box;
        }

        input[type="text"]:focus, input[type="password"]:focus {
            border-color: #ff69b4;
            outline: none;
        }

        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #ff69b4;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #ff1493;
        }

        .link {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #555;
            text-decoration: none;
        }

        .link:hover {
            text-decoration: underline;
        }

        .error-message {
            color: #d8000c;
            font-size: 14px;
            margin-top: 10px;
            text-align: center;
            min-height: 20px;
        }

        /* 邮箱补全列表 */
        .email-suggestions {
            position: absolute;
            top: 42px;
            left: 0;
            right: 0;
            background: white;
            border: 1px solid #ddd;
            border-top: none;
            border-radius: 0 0 8px 8px;
            max-height: 140px;
            overflow-y: auto;
            box-shadow: 0 4px 10px rgba(255, 105, 180, 0.2);
            z-index: 1000;
            display: none;
        }

        .email-suggestions div {
            padding: 8px 12px;
            cursor: pointer;
            font-size: 14px;
            color: #ff69b4;
        }

        .email-suggestions div:hover {
            background-color: #ffe6f1;
        }
    </style>
</head>
<body>

<div class="register-box">
    <h2>🎀 用户注册</h2>
    <form id="registerForm" action="${pageContext.request.contextPath}/register" method="post" onsubmit="return validateForm()">
        <div class="form-group">
            <input
                    type="text"
                    name="email"
                    id="email"
                    placeholder="请输入邮箱"
                    autocomplete="off"
                    spellcheck="false"
                    required
            />
            <div id="emailSuggestions" class="email-suggestions"></div>
        </div>
        <div class="form-group">
            <input type="password" name="password" id="password" placeholder="请输入密码" required />
        </div>
        <div class="error-message" id="errorMsg">
            <c:if test="${not empty error}">
                ${error}
            </c:if>
        </div>
        <input type="submit" value="注册" />
    </form>

    <a class="link" href="${pageContext.request.contextPath}/login">已有账号？去登录</a>
</div>

<script>
    const emailInput = document.getElementById('email');
    const suggestionsBox = document.getElementById('emailSuggestions');
    const suffixes = ['@qq.com', '@163.com', '@gmail.com', '@outlook.com', '@icloud.com'];
    const errorMsg = document.getElementById('errorMsg');

    emailInput.addEventListener('input', () => {
        const val = emailInput.value.trim();
        const atIndex = val.indexOf('@');

        // 如果没输入 @ 并且有内容，显示补全
        if (val && atIndex === -1) {
            suggestionsBox.innerHTML = '';
            suffixes.forEach(suffix => {
                const div = document.createElement('div');
                div.textContent = val + suffix;
                div.onclick = () => {
                    emailInput.value = div.textContent;
                    suggestionsBox.style.display = 'none';
                };
                suggestionsBox.appendChild(div);
            });
            suggestionsBox.style.display = 'block';
        } else {
            suggestionsBox.style.display = 'none';
        }
    });

    // 点击外部隐藏建议列表
    document.addEventListener('click', (e) => {
        if (e.target !== emailInput) {
            suggestionsBox.style.display = 'none';
        }
    });

    function validateEmail(email) {
        // 简单邮箱正则
        const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return re.test(email);
    }

    function validateForm() {
        errorMsg.textContent = '';
        const email = emailInput.value.trim();
        const password = document.getElementById('password').value.trim();

        if (!email) {
            errorMsg.textContent = '邮箱不能为空！';
            return false;
        }
        if (!validateEmail(email)) {
            errorMsg.textContent = '请输入有效的邮箱地址！';
            return false;
        }
        if (!password) {
            errorMsg.textContent = '密码不能为空！';
            return false;
        }
        if (/\s/.test(email) || /\s/.test(password)) {
            errorMsg.textContent = '邮箱和密码中不能包含空格！';
            return false;
        }

        return true;
    }
</script>

</body>
</html>
