<%--
  Created by IntelliJ IDEA.
  User: sakura
  Date: 2025/6/24
  Time: 09:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>忘记密码</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#6366f1',
                        secondary: '#a5b4fc',
                        danger: '#ef4444',
                        neutral: '#9ca3af',
                        light: '#f9fafb',
                        dark: '#4b5563'
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
            .card-shadow {
                box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05), 0 8px 10px -6px rgba(0, 0, 0, 0.02);
            }
            .input-focus {
                @apply focus:ring-2 focus:ring-primary/30 focus:border-primary transition-all duration-200;
            }
            .btn-hover {
                @apply hover:shadow-lg transform hover:-translate-y-0.5 transition-all duration-200;
            }
            .error-message {
                @apply text-danger text-sm mt-1 hidden;
            }
        }
    </style>
</head>
<body class="bg-gradient-to-br from-gray-50 to-gray-100 min-h-screen font-inter text-gray-800">
<!-- 页面容器 -->
<div class="container mx-auto px-4 py-8 max-w-2xl">

    <!-- 页面标题 -->
    <div class="text-center mb-8">
        <h1 class="text-[clamp(1.75rem,3vw,2.25rem)] font-bold text-gray-800 mb-2">忘记密码</h1>
        <p class="text-gray-500">重置您的密码以恢复账户访问权限</p>
    </div>

    <!-- 表单卡片 -->
    <div class="bg-white rounded-2xl card-shadow overflow-hidden">
        <!-- 表单头部 -->
        <div class="bg-gradient-to-r from-primary to-secondary p-6 text-white">
            <h2 class="text-xl font-semibold flex items-center">
                <i class="fa fa-unlock-alt mr-3"></i>
                重置密码
            </h2>
        </div>

        <!-- 表单内容 -->
        <form id="forgotPasswordForm" method="post" action="${pageContext.request.contextPath}/forgetPassword" class="p-6 space-y-6">
            <div class="space-y-4">
                <div class="space-y-2">
                    <label for="email" class="block text-sm font-medium text-gray-700">邮箱</label>
                    <div class="relative">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-500">
                                <i class="fa fa-envelope"></i>
                            </span>
                        <input type="email" id="email" name="email"
                               class="pl-10 block w-full rounded-lg border border-gray-300 py-2.5 shadow-sm input-focus"
                               placeholder="请输入注册时使用的邮箱">
                        <p id="emailError" class="error-message">
                            <i class="fa fa-exclamation-circle mr-1"></i>
                            <span>请输入有效的邮箱地址</span>
                        </p>
                    </div>
                </div>

                <div class="space-y-2">
                    <label for="newPassword" class="block text-sm font-medium text-gray-700">新密码</label>
                    <div class="relative">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-500">
                                <i class="fa fa-key"></i>
                            </span>
                        <input type="password" id="newPassword" name="newPassword"
                               class="pl-10 block w-full rounded-lg border border-gray-300 py-2.5 shadow-sm input-focus"
                               placeholder="请设置新密码">
                        <button type="button" id="toggleNewPassword" class="absolute inset-y-0 right-0 flex items-center pr-3 text-gray-500">
                            <i class="fa fa-eye-slash"></i>
                        </button>
                        <p id="newPasswordError" class="error-message">
                            <i class="fa fa-exclamation-circle mr-1"></i>
                            <span>密码长度至少为8位，包含字母和数字</span>
                        </p>
                    </div>
                </div>

                <div class="space-y-2">
                    <label for="answer" class="block text-sm font-medium text-gray-700">找回密码助记词</label>
                    <div class="relative">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-500">
                                <i class="fa fa-shield"></i>
                            </span>
                        <input type="text" id="answer" name="answer"
                               class="pl-10 block w-full rounded-lg border border-gray-300 py-2.5 shadow-sm input-focus"
                               placeholder="请输入您的找回密码助记词">
                        <p id="answerError" class="error-message">
                            <i class="fa fa-exclamation-circle mr-1"></i>
                            <span>请输入正确的助记词</span>
                        </p>
                    </div>
                </div>
            </div>

            <!-- 提示信息 -->
            <div class="bg-blue-50 border border-blue-100 rounded-lg p-4 text-sm">
                <div class="flex items-start">
                    <div class="flex-shrink-0 pt-0.5">
                        <i class="fa fa-info-circle text-blue-500"></i>
                    </div>
                    <div class="ml-3">
                        <p class="text-blue-700">
                            <strong>提示：</strong>
                            请输入您注册时使用的邮箱地址和设置的密保答案，系统将验证您的身份后重置密码。
                        </p>
                    </div>
                </div>
            </div>

            <!-- 表单按钮 -->
            <div class="pt-4 border-t border-gray-100">
                <button type="submit" id="submitBtn" class="btn-hover w-full inline-flex items-center justify-center px-5 py-3 bg-primary text-white rounded-lg transition-all duration-200 hover:bg-primary/90">
                    <i class="fa fa-check-circle mr-2"></i>
                    <span>提交重置请求</span>
                </button>
            </div>
        </form>
    </div>

    <!-- 页脚 -->
    <footer class="mt-12 text-center text-gray-500 text-sm">
        <p>© 2025 用户管理系统. 保留所有权利.</p>
    </footer>
</div>

<!-- 表单验证脚本 -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const forgotPasswordForm = document.getElementById('forgotPasswordForm');
        const emailInput = document.getElementById('email');
        const newPasswordInput = document.getElementById('newPassword');
        const answerInput = document.getElementById('answer');
        const emailError = document.getElementById('emailError');
        const newPasswordError = document.getElementById('newPasswordError');
        const answerError = document.getElementById('answerError');
        const toggleNewPasswordBtn = document.getElementById('toggleNewPassword');

        // 密码可见性切换
        toggleNewPasswordBtn.addEventListener('click', function() {
            togglePasswordVisibility(newPasswordInput, this);
        });

        // 表单提交验证
        forgotPasswordForm.addEventListener('submit', function(event) {
            event.preventDefault();
            let isValid = true;

            // 验证邮箱
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(emailInput.value)) {
                showError(emailInput, emailError);
                isValid = false;
            } else {
                hideError(emailInput, emailError);
            }

            // 验证新密码
            const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
            if (!passwordRegex.test(newPasswordInput.value)) {
                showError(newPasswordInput, newPasswordError);
                isValid = false;
            } else {
                hideError(newPasswordInput, newPasswordError);
            }

            // 验证密保答案
            if (answerInput.value.trim() === '') {
                showError(answerInput, answerError);
                isValid = false;
            } else {
                hideError(answerInput, answerError);
            }

            // 如果验证通过，提交表单
            if (isValid) {
                // 这里可以添加提交前的加载状态
                forgotPasswordForm.submit();
            }
        });

        // 实时验证
        emailInput.addEventListener('input', function() {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(this.value)) {
                showError(this, emailError);
            } else {
                hideError(this, emailError);
            }
        });

        newPasswordInput.addEventListener('input', function() {
            const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
            if (!passwordRegex.test(this.value)) {
                showError(this, newPasswordError);
            } else {
                hideError(this, newPasswordError);
            }
        });

        answerInput.addEventListener('input', function() {
            if (this.value.trim() === '') {
                showError(this, answerError);
            } else {
                hideError(this, answerError);
            }
        });

        // 辅助函数
        function togglePasswordVisibility(input, button) {
            const type = input.getAttribute('type') === 'password' ? 'text' : 'password';
            input.setAttribute('type', type);

            // 切换图标
            if (type === 'text') {
                button.innerHTML = '<i class="fa fa-eye"></i>';
            } else {
                button.innerHTML = '<i class="fa fa-eye-slash"></i>';
            }
        }

        function showError(input, errorElement) {
            input.classList.add('border-danger');
            input.classList.remove('border-gray-300');
            errorElement.classList.remove('hidden');
        }

        function hideError(input, errorElement) {
            input.classList.remove('border-danger');
            input.classList.add('border-gray-300');
            errorElement.classList.add('hidden');
        }
    });
</script>
</body>
</html>

