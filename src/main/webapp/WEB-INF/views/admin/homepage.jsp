<%--
  Created by IntelliJ IDEA.
  User: sakura
  Date: 2025/6/24
  Time: 09:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理员界面</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#3b82f6',
                        secondary: '#64748b',
                        accent: '#0ea5e9',
                        neutral: '#f1f5f9',
                        success: '#10b981',
                        warning: '#f59e0b',
                        danger: '#ef4444',
                        info: '#6366f1',
                        light: '#f8fafc',
                        dark: '#1e293b',
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
                @apply shadow-lg hover:shadow-xl transition-shadow duration-300;
            }
            .nav-link {
                @apply flex items-center px-4 py-3 text-gray-700 hover:bg-primary/5 hover:text-primary transition-colors duration-200;
            }
            .nav-link.active {
                @apply bg-primary/10 text-primary border-l-4 border-primary;
            }
            .btn {
                @apply inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm transition-all duration-150 ease-in-out;
            }
            .btn-primary {
                @apply btn text-white bg-primary hover:bg-primary/90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary;
            }
            .btn-danger {
                @apply btn text-white bg-danger hover:bg-danger/90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-danger;
            }
        }
    </style>
</head>
<body class="bg-gray-50 font-inter min-h-screen flex flex-col">
<!-- 顶部导航栏 -->
<nav class="bg-white shadow-sm sticky top-0 z-50">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-16">
            <div class="flex items-center">
                <a href="#" class="flex-shrink-0 flex items-center">
                    <i class="fa fa-shield text-primary text-2xl mr-2"></i>
                    <span class="font-semibold text-xl text-gray-800">管理员中心</span>
                </a>
            </div>
            <div class="flex items-center">
                <div class="flex items-center mr-4">
                    <span class="text-sm text-gray-600">欢迎<strong>${user.nickname}</strong>管理员</span>
                </div>
                <a href="${pageContext.request.contextPath}/logout" class="btn-danger flex items-center">
                    <i class="fa fa-sign-out mr-2"></i>退出登录
                </a>
            </div>
        </div>
    </div>
</nav>

<!-- 主内容区 -->
<main class="flex-grow flex flex-col md:flex-row">
    <!-- 侧边导航 -->
    <aside class="bg-white shadow-md w-full md:w-64 flex-shrink-0">
        <div class="py-4">
            <div class="px-4 mb-6">
                <h2 class="text-lg font-semibold text-gray-900">管理菜单</h2>
            </div>
            <nav class="space-y-1">
                <a href="${pageContext.request.contextPath}/admin/getAllUser" class="nav-link active">
                    <i class="fa fa-users w-5 h-5 mr-3"></i>
                    <span>用户管理</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/getAllAlbum" class="nav-link">
                    <i class="fa fa-picture-o w-5 h-5 mr-3"></i>
                    <span>相册管理</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/dashboard"  class="nav-link">
                </a>
            </nav>
        </div>
    </aside>

    <!-- 内容区域 -->
    <div class="flex-grow p-6">
        <div class="max-w-7xl mx-auto">
            <!-- 欢迎信息 -->
            <div class="mb-8">
                <h1 class="text-3xl font-bold text-gray-900">管理员控制台</h1>
                <p class="mt-1 text-sm text-gray-500">欢迎使用系统管理功能</p>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                <div class="stat-card">
                    <div class="flex items-center mb-4">
                        <div class="bg-primary/10 p-3 rounded-full mr-4">
                            <i class="fa fa-users text-primary text-xl"></i>
                        </div>
                        <div>
                            <p class="text-sm text-gray-500">注册用户总数</p>
                            <h2 class="stat-number">${totalUsers}</h2>
                        </div>
                    </div>

                </div>

                <div class="stat-card">
                    <div class="flex items-center mb-4">
                        <div class="bg-success/10 p-3 rounded-full mr-4">
                            <i class="fa fa-user-circle-o text-success text-xl"></i>
                        </div>
                        <div>
                            <p class="text-sm text-gray-500">活跃用户数</p>
                            <h2 class="stat-number">${activeUsers}</h2>
                        </div>
                    </div>

                </div>

                <div class="stat-card">
                    <div class="flex items-center mb-4">
                        <div class="bg-warning/10 p-3 rounded-full mr-4">
                            <i class="fa fa-shield text-warning text-xl"></i>
                        </div>
                        <div>
                            <p class="text-sm text-gray-500">管理员数量</p>
                            <h2 class="stat-number">${adminUsers}</h2>
                        </div>
                    </div>

                </div>

                <div class="stat-card">
                    <div class="flex items-center mb-4">
                        <div class="bg-info/10 p-3 rounded-full mr-4">
                            <i class="fa fa-picture-o text-info text-xl"></i>
                        </div>
                        <div>
                            <p class="text-sm text-gray-500">相册总数</p>
                            <h2 class="stat-number">${totalAlbums}</h2>
                        </div>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="flex items-center mb-4">
                        <div class="bg-accent/10 p-3 rounded-full mr-4">
                            <i class="fa fa-unlock-alt text-accent text-xl"></i>
                        </div>
                        <div>
                            <p class="text-sm text-gray-500">公开相册数</p>
                            <h2 class="stat-number">${publicAlbums}</h2>
                        </div>
                    </div>

                </div>

                <div class="stat-card">
                    <div class="flex items-center mb-4">
                        <div class="bg-secondary/10 p-3 rounded-full mr-4">
                            <i class="fa fa-images text-secondary text-xl"></i>
                        </div>
                        <div>
                            <p class="text-sm text-gray-500">照片总数</p>
                            <h2 class="stat-number">${totalPhotos}</h2>
                        </div>
                    </div>

                </div>

                <div class="stat-card">
                    <div class="flex items-center mb-4">
                        <div class="bg-success/10 p-3 rounded-full mr-4">
                            <i class="fa fa-thumbs-up text-success text-xl"></i>
                        </div>
                        <div>
                            <p class="text-sm text-gray-500">点赞总数</p>
                            <h2 class="stat-number">${totalLikes}</h2>
                        </div>
                    </div>

                </div>

                <div class="stat-card">
                    <div class="mb-4">
                        <h3 class="text-lg font-semibold text-gray-800">最受欢迎相册</h3>
                    </div>
                    <div class="text-center">
                        <h4 class="font-medium text-gray-900 mb-1">${mostLikedAlbum.title}</h4>
                        <p class="text-primary font-semibold">
                            <i class="fa fa-thumbs-up mr-1"></i> ${mostLikedAlbum.like_count} 点赞
                        </p>
                    </div>
                </div>
            </div>
        </div>

            <!-- 快速操作 -->
            <div class="bg-white rounded-lg shadow-md p-6 mb-8">
                <h2 class="text-xl font-bold text-gray-900 mb-4">快速操作</h2>
                <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-4">
                    <a href="${pageContext.request.contextPath}/admin/getAllUser" class="flex flex-col items-center justify-center p-4 border border-gray-200 rounded-lg hover:bg-gray-50 transition-colors duration-200">
                        <div class="text-primary text-2xl mb-2">
                            <i class="fa fa-users"></i>
                        </div>
                        <p class="text-sm font-medium text-gray-700">管理用户</p>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/getAllAlbum" class="flex flex-col items-center justify-center p-4 border border-gray-200 rounded-lg hover:bg-gray-50 transition-colors duration-200">
                        <div class="text-info text-2xl mb-2">
                            <i class="fa fa-picture-o"></i>
                        </div>
                        <p class="text-sm font-medium text-gray-700">管理相册</p>
                    </a>
                    <a href="${pageContext.request.contextPath}/toUpload" class="flex flex-col items-center justify-center p-4 border border-gray-200 rounded-lg hover:bg-gray-50 transition-colors duration-200">
                        <div class="text-success text-2xl mb-2">
                            <i class="fa fa-plus-circle"></i>
                        </div>
                        <p class="text-sm font-medium text-gray-700">添加内容</p>
                    </a>

                </div>
            </div>
        </div>
    </div>
</main>

<!-- 页脚 -->
<footer class="bg-white border-t border-gray-200">
    <div class="max-w-7xl mx-auto py-4 px-4 sm:px-6 lg:px-8">
        <p class="text-center text-sm text-gray-500">
            &copy; 2025 图册管理系统 版权所有
        </p>
    </div>
</footer>
</body>
<script>
    window.addEventListener('DOMContentLoaded', function () {
        const dashboardLink = document.querySelector('a[href$="/admin/dashboard"]');
        if (dashboardLink) {
            dashboardLink.click();
        }
    });
</script>

</html>