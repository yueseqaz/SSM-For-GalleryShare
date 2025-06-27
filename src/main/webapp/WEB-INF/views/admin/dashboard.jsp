<%--
  Created by IntelliJ IDEA.
  User: sakura
  Date: 2025/6/27
  Time: 14:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理后台 - 数据看板</title>
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
            .stat-card {
                @apply bg-white rounded-xl p-6 card-shadow flex flex-col items-center justify-center;
            }
            .stat-number {
                @apply text-4xl font-bold text-primary mb-2;
            }
            .stat-label {
                @apply text-gray-600 font-medium;
            }
            .trend-up {
                @apply text-green-500 flex items-center text-sm;
            }
            .trend-down {
                @apply text-red-500 flex items-center text-sm;
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
                <a href="${pageContext.request.contextPath}/admin/homepage" class="flex-shrink-0 flex items-center">
                    <i class="fa fa-tachometer text-primary text-2xl mr-2"></i>
                    <span class="font-semibold text-xl text-gray-800">管理后台</span>
                </a>
                <div class="hidden sm:ml-6 sm:flex sm:space-x-8">
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="border-primary text-gray-900 border-b-2 px-1 pt-1 inline-flex items-center text-sm font-medium">
                        <i class="fa fa-dashboard mr-1"></i>
                        <span>数据看板</span>
                    </a>
                </div>
            </div>
            <div class="flex items-center">
                <button type="button" class="p-2 rounded-full text-gray-400 hover:text-gray-500 focus:outline-none">
                    <i class="fa fa-bell"></i>
                </button>
                <div class="ml-3 relative">
                    <div>
                        <button type="button" class="flex text-sm rounded-full focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary">
                            <img class="h-8 w-8 rounded-full" src="https://picsum.photos/200/200?random=1" alt="管理员头像">
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</nav>

<!-- 主内容区 -->
<main class="flex-grow p-6">
    <div class="max-w-7xl mx-auto">
        <!-- 页面标题 -->
        <div class="mb-8">
            <h1 class="text-3xl font-bold text-gray-900">数据看板</h1>
            <p class="mt-1 text-sm text-gray-500">系统关键指标概览</p>
        </div>

        <!-- 统计卡片 -->
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
                    <div class="rounded-lg overflow-hidden mb-3">
                        <img src="${mostLikedAlbum.coverUrl}" alt="${mostLikedAlbum.title}" class="w-full h-40 object-cover">
                    </div>
                    <h4 class="font-medium text-gray-900 mb-1">${mostLikedAlbum.title}</h4>
                    <p class="text-primary font-semibold">
                        <i class="fa fa-thumbs-up mr-1"></i> ${mostLikedAlbum.like_count} 点赞
                    </p>
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
</html>
