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
    <title>用户登录 - PicShare</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#165DFF',
                        secondary: '#FF7D00',
                        dark: '#1D2939',
                        light: '#F9FAFB'
                    },
                    fontFamily: {
                        inter: ['Inter', 'system-ui', 'sans-serif'],
                    },
                }
            }
        }
    </script>
    <style type="text/tailwindcss">
        @layer utilities {
            .content-auto {
                content-visibility: auto;
            }
            .text-shadow {
                text-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            .transition-custom {
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            }
            .hover-scale {
                @apply hover:scale-105 transition-all duration-300;
            }
            .card-shadow {
                box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            }
            .form-input-focus {
                @apply focus:border-primary focus:ring-2 focus:ring-primary/20 focus:outline-none;
            }
        }
    </style>
</head>
<body class="font-inter bg-gradient-to-br from-primary/5 to-light min-h-screen flex items-center justify-center p-4">
<!-- 背景装饰 -->
<div class="absolute inset-0 overflow-hidden pointer-events-none">
    <div class="absolute top-0 right-0 w-96 h-96 bg-primary/10 rounded-full blur-3xl transform translate-x-1/2 -translate-y-1/2"></div>
    <div class="absolute bottom-0 left-0 w-96 h-96 bg-secondary/10 rounded-full blur-3xl transform -translate-x-1/2 translate-y-1/2"></div>
</div>

<div class="relative z-10 w-full max-w-md">
    <!-- 回到首页链接 -->
    <div class="text-center mb-8">
        <a href="${pageContext.request.contextPath}/" class="inline-flex items-center space-x-2 text-primary hover:text-primary/80 transition-colors">
            <i class="fa fa-arrow-left"></i>
            <span>回到首页</span>
        </a>
    </div>

    <!-- 登录卡片 -->
    <div class="bg-white rounded-2xl shadow-xl overflow-hidden card-shadow hover-scale">
        <!-- 卡片头部 -->
        <div class="bg-primary text-white p-6 text-center">
            <div class="flex items-center justify-center space-x-2 mb-2">
                <i class="fa fa-camera-retro text-2xl"></i>
                <h2 class="text-xl font-bold">PicShare</h2>
            </div>
            <p class="text-white/80">登录您的账户</p>
        </div>

        <!-- 登录表单 -->
        <div class="p-8">
            <form id="loginForm" action="${pageContext.request.contextPath}/login" method="post" onsubmit="return validateLogin()">
                <!-- 邮箱输入 -->
                <div class="mb-6">
                    <label for="emailName" class="block text-sm font-medium text-dark/70 mb-2">邮箱</label>
                    <div class="flex">
                        <input
                                type="text"
                                id="emailName"
                                name="emailName"
                                placeholder="请输入邮箱用户名"
                                autocomplete="username"
                                required
                                maxlength="64"
                                class="flex-grow px-4 py-3 rounded-l-lg border border-gray-300 form-input-focus transition-custom"
                        />
                        <select id="emailDomain" name="emailDomain" required class="px-4 py-3 rounded-r-lg border border-l-0 border-gray-300 bg-white form-input-focus transition-custom">
                            <option value="@qq.com">@qq.com</option>
                            <option value="@163.com">@163.com</option>
                            <option value="@gmail.com">@gmail.com</option>
                            <option value="@outlook.com">@outlook.com</option>
                            <option value="@icloud.com">@icloud.com</option>
                        </select>
                    </div>
                </div>

                <!-- 密码输入 -->
                <div class="mb-6">
                    <label for="password" class="block text-sm font-medium text-dark/70 mb-2">密码</label>
                    <input
                            type="password"
                            name="password"
                            id="password"
                            placeholder="请输入密码"
                            required
                            autocomplete="current-password"
                            class="w-full px-4 py-3 rounded-lg border border-gray-300 form-input-focus transition-custom"
                    />
                </div>

                <!-- 错误消息 -->
                <div class="mb-6">
                    <div class="text-red-500 text-sm text-center" id="errorMsg">
                        <c:if test="${not empty error}">
                            ${error}
                        </c:if>
                    </div>
                </div>

                <input type="hidden" name="email" id="emailFull" />

                <!-- 登录按钮 -->
                <button type="submit" class="w-full bg-primary hover:bg-primary/90 text-white py-3 rounded-lg font-medium transition-custom shadow-md hover:shadow-lg">
                    登录
                </button>
            </form>

            <!-- 链接 -->
            <div class="flex justify-between items-center mt-6">
                <a href="${pageContext.request.contextPath}/register" class="text-primary hover:text-primary/80 text-sm transition-colors">
                    去注册
                </a>
                <a href="${pageContext.request.contextPath}/forgetPassword" class="text-primary hover:text-primary/80 text-sm transition-colors">
                    忘记密码？
                </a>
            </div>
        </div>
    </div>

    <!-- 页脚 -->
    <div class="text-center text-dark/60 text-sm mt-8">
        <p>© 2025 PicShare. 保留所有权利。</p>
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
