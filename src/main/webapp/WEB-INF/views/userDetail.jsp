<%--
  Created by IntelliJ IDEA.
  User: sakura
  Date: 2025/6/24
  Time: 16:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户信息编辑</title>
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
            .avatar-preview {
                @apply w-20 h-20 rounded-full object-cover border-2 border-gray-200 transition-all duration-300;
            }
            .avatar-container {
                @apply relative flex items-center justify-center w-20 h-20 rounded-full bg-gray-100 overflow-hidden border-2 border-dashed border-gray-300 transition-all duration-300;
            }
            .avatar-placeholder {
                @apply text-gray-400 text-3xl;
            }
        }
    </style>
</head>
<body class="bg-gradient-to-br from-gray-50 to-gray-100 min-h-screen font-inter text-gray-800">
<!-- 页面容器 -->
<div class="container mx-auto px-4 py-8 max-w-5xl">

    <!-- 页面标题 -->
    <div class="text-center mb-8">
        <h1 class="text-[clamp(1.75rem,3vw,2.25rem)] font-bold text-gray-800 mb-2">用户信息编辑</h1>
        <p class="text-gray-500">完善个人资料，展示更真实的自己</p>
    </div>

    <!-- 表单卡片 -->
    <div class="bg-white rounded-2xl card-shadow overflow-hidden">
        <!-- 表单头部 -->
        <div class="bg-gradient-to-r from-primary to-secondary p-6 text-white">
            <h2 class="text-xl font-semibold flex items-center">
                <i class="fa fa-user-circle mr-3"></i>
                个人信息
            </h2>
        </div>

        <!-- 表单内容 -->
        <form method="post" action="${pageContext.request.contextPath}/updateProfile" class="p-6 space-y-6">
            <!-- 基础信息 -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="space-y-2">
                    <label for="id" class="block text-sm font-medium text-gray-700">ID</label>
                    <div class="relative">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-500">
                                <i class="fa fa-id-card"></i>
                            </span>
                        <input type="text" id="id" name="id" value="${user.id}" readonly
                               class="pl-10 block w-full rounded-lg border-gray-300 bg-gray-50 py-2.5 text-gray-500 shadow-sm input-focus">
                    </div>
                </div>

                <div class="space-y-2">
                    <label for="email" class="block text-sm font-medium text-gray-700">邮箱</label>
                    <div class="relative">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-500">
                                <i class="fa fa-envelope"></i>
                            </span>
                        <input type="email" id="email" name="email" value="${user.email}" required
                               class="pl-10 block w-full rounded-lg border border-gray-300 py-2.5 shadow-sm input-focus">
                    </div>
                </div>

                <div class="space-y-2">
                    <label for="nickname" class="block text-sm font-medium text-gray-700">昵称</label>
                    <div class="relative">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-500">
                                <i class="fa fa-user"></i>
                            </span>
                        <input type="text" id="nickname" name="nickname" value="${user.nickname}"
                               class="pl-10 block w-full rounded-lg border border-gray-300 py-2.5 shadow-sm input-focus">
                    </div>
                </div>

                <div class="space-y-2">
                    <label for="address" class="block text-sm font-medium text-gray-700">地址</label>
                    <div class="relative">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-500">
                                <i class="fa fa-map-marker"></i>
                            </span>
                        <input type="text" id="address" name="address" value="${user.address}"
                               class="pl-10 block w-full rounded-lg border border-gray-300 py-2.5 shadow-sm input-focus">
                    </div>
                </div>

                <div class="space-y-2">
                    <label for="bio" class="block text-sm font-medium text-gray-700">个性签名</label>
                    <div class="relative">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-500">
                                <i class="fa fa-pencil"></i>
                            </span>
                        <textarea id="bio" name="bio" rows="2" class="pl-10 block w-full rounded-lg border border-gray-300 py-2.5 shadow-sm input-focus">${user.bio}</textarea>
                    </div>
                </div>

                <div class="space-y-2">
                    <label for="intro" class="block text-sm font-medium text-gray-700">简介</label>
                    <div class="relative">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-500">
                                <i class="fa fa-file-text-o"></i>
                            </span>
                        <textarea id="intro" name="intro" rows="2" class="pl-10 block w-full rounded-lg border border-gray-300 py-2.5 shadow-sm input-focus">${user.intro}</textarea>
                    </div>
                </div>

                <div class="space-y-2">
                    <label for="gender" class="block text-sm font-medium text-gray-700">性别</label>
                    <div class="relative">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-500">
                                <i class="fa fa-venus-mars"></i>
                            </span>
                        <select id="gender" name="gender" class="pl-10 block w-full rounded-lg border border-gray-300 py-2.5 shadow-sm input-focus appearance-none bg-white">
                            <option value="男" ${user.gender == '男' ? 'selected' : ''}>男</option>
                            <option value="女" ${user.gender == '女' ? 'selected' : ''}>女</option>
                            <option value="保密" ${user.gender == '保密' ? 'selected' : ''}>保密</option>
                        </select>
                        <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-3 text-gray-500">
                            <i class="fa fa-chevron-down text-xs"></i>
                        </div>
                    </div>
                </div>

                <div class="space-y-2">
                    <label for="avatar" class="block text-sm font-medium text-gray-700">头像链接</label>
                    <div class="flex flex-col gap-3">
                        <div class="relative">
                                <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-500">
                                    <i class="fa fa-image"></i>
                                </span>
                            <input type="text" id="avatar" name="avatar" value="${user.avatar}"
                                   class="pl-10 block w-full rounded-lg border border-gray-300 py-2.5 shadow-sm input-focus"
                                   oninput="updateAvatarPreview()">
                        </div>
                        <div id="avatarPreviewContainer" class="avatar-container">
                            <i class="fa fa-user avatar-placeholder"></i>
                            <img id="avatarPreview" src="${user.avatar}" alt="头像预览" class="avatar-preview hidden">
                        </div>
                    </div>
                </div>

                <div class="space-y-2">
                    <label for="role" class="block text-sm font-medium text-gray-700">角色</label>
                    <div class="relative">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-500">
                                <i class="fa fa-briefcase"></i>
                            </span>
                        <input type="text" id="role" name="role" value="${user.role}" readonly
                               class="pl-10 block w-full rounded-lg border border-gray-300 py-2.5 shadow-sm input-focus">
                    </div>
                </div>

                <div class="space-y-2">
                    <label for="age" class="block text-sm font-medium text-gray-700">年龄</label>
                    <div class="relative">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-500">
                                <i class="fa fa-calendar"></i>
                            </span>
                        <input type="number" id="age" name="age" value="${user.age}"
                               class="pl-10 block w-full rounded-lg border border-gray-300 py-2.5 shadow-sm input-focus">
                    </div>
                </div>

                <div class="space-y-2 md:col-span-2">
                    <label for="answer" class="block text-sm font-medium text-gray-700">密保答案</label>
                    <div class="relative">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-500">
                                <i class="fa fa-shield"></i>
                            </span>
                        <input type="text" id="answer" name="answer" value="${user.answer}"
                               class="pl-10 block w-full rounded-lg border border-gray-300 py-2.5 shadow-sm input-focus">
                    </div>
                </div>
            </div>

            <!-- 表单按钮 -->
            <div class="flex flex-col sm:flex-row sm:justify-between sm:items-center gap-4 pt-4 border-t border-gray-100">
                <div class="text-sm text-gray-500">
                    <i class="fa fa-info-circle mr-1"></i>
                    <span>修改个人信息后，部分设置可能需要重新登录才能生效</span>
                </div>

                <div class="flex space-x-3">
                    <button type="button" onclick="history.back()" class="btn-hover inline-flex items-center justify-center px-5 py-2.5 bg-gray-100 text-gray-700 rounded-lg transition-all duration-200 hover:bg-gray-200">
                        <i class="fa fa-arrow-left mr-2"></i>
                        返回
                    </button>

                    <button type="submit" class="btn-hover inline-flex items-center justify-center px-5 py-2.5 bg-primary text-white rounded-lg transition-all duration-200 hover:bg-primary/90">
                        <i class="fa fa-check mr-2"></i>
                        提交修改
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- 表单验证脚本 -->
<script>
    // 添加表单提交前的验证
    document.querySelector('form').addEventListener('submit', function(event) {
        const emailInput = document.getElementById('email');
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        if (!emailRegex.test(emailInput.value)) {
            event.preventDefault();
            alert('请输入有效的邮箱地址');
            emailInput.focus();
        }
    });

    // 头像预览功能
    function updateAvatarPreview() {
        const avatarInput = document.getElementById('avatar');
        const avatarPreview = document.getElementById('avatarPreview');
        const avatarContainer = document.getElementById('avatarPreviewContainer');
        const avatarPlaceholder = avatarContainer.querySelector('.avatar-placeholder');

        // 显示预览容器
        avatarContainer.classList.remove('border-dashed');

        if (avatarInput.value.trim() === '') {
            // 无输入时显示占位符
            avatarPreview.classList.add('hidden');
            avatarPlaceholder.classList.remove('hidden');
            avatarContainer.classList.add('border-dashed');
        } else {
            // 有输入时尝试加载图片
            avatarPreview.src = avatarInput.value;
            avatarPreview.classList.remove('hidden');
            avatarPlaceholder.classList.add('hidden');

            // 图片加载失败时的处理
            avatarPreview.onerror = function() {
                avatarPreview.classList.add('hidden');
                avatarPlaceholder.classList.remove('hidden');
                avatarContainer.classList.add('border-dashed');
            };
        }
    }

    // 页面加载时初始化头像预览
    document.addEventListener('DOMContentLoaded', function() {
        updateAvatarPreview();
    });
</script>
</body>
</html>
