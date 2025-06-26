
<%--
  Created by IntelliJ IDEA.
  User: sakura
  Date: 2025/6/25
  Time: 21:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PicShare - 我的相册</title>
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
                        light: '#F9FAFB',
                        success: '#10B981',
                        danger: '#EF4444',
                        warning: '#F59E0B',
                        info: '#3B82F6',
                        lightgray: '#F3F4F6'
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
            .status-badge {
                @apply px-2 py-1 rounded-full text-xs font-medium;
            }
        }
    </style>
</head>
<body class="font-inter bg-gray-50 text-dark antialiased">
<!-- 导航栏 -->
<header class="fixed top-0 left-0 right-0 bg-white shadow-sm z-50 transition-all duration-300">
    <div class="container mx-auto px-4 py-3 flex items-center justify-between">
        <div class="flex items-center space-x-2">
            <i class="fa fa-camera-retro text-primary text-2xl"></i>
            <span class="text-xl font-bold text-primary">PicShare</span>
        </div>

        <nav class="hidden md:flex items-center space-x-6">
            <a href="${pageContext.request.contextPath}/myalbum" class="text-primary font-medium">我的相册</a>
            <a href="${pageContext.request.contextPath}/tosearch" class="text-dark/70 hover:text-primary transition-colors">搜索</a>
        </nav>

        <div class="flex items-center space-x-4">
            <div class="relative">
                <button class="flex items-center space-x-2 focus:outline-none" id="userMenuBtn">
                    <div class="w-8 h-8 rounded-full bg-primary/10 flex items-center justify-center text-primary">
                        <i class="fa fa-user"></i>
                    </div>
                    <span class="hidden md:inline text-dark font-medium">我的账户</span>
                    <i class="fa fa-angle-down text-dark/60"></i>
                </button>

                <div class="absolute right-0 mt-2 w-48 bg-white rounded-lg shadow-lg py-2 hidden" id="userMenu">
                    <a href="${pageContext.request.contextPath}/myProfile" class="block px-4 py-2 text-dark/80 hover:bg-gray-50 hover:text-primary transition-colors">
                        <i class="fa fa-user-circle mr-2"></i> 我的资料
                    </a>
                    <a href="${pageContext.request.contextPath}/toUpload" class="block px-4 py-2 text-dark/80 hover:bg-gray-50 hover:text-primary transition-colors">
                        <i class="fa fa-upload mr-2"></i> 上传图片
                    </a>
                    <a href="${pageContext.request.contextPath}/createAlbum" class="block px-4 py-2 text-dark/80 hover:bg-gray-50 hover:text-primary transition-colors">
                        <i class="fa fa-folder mr-2"></i> 创建相册
                    </a>
                    <div class="border-t border-gray-100 my-1"></div>
                    <a href="${pageContext.request.contextPath}/logout" class="block px-4 py-2 text-red-500 hover:bg-gray-50 transition-colors">
                        <i class="fa fa-sign-out mr-2"></i> 退出登录
                    </a>
                </div>
            </div>

            <button class="md:hidden text-dark" id="mobileMenuBtn">
                <i class="fa fa-bars text-xl"></i>
            </button>
        </div>
    </div>

    <!-- 移动端菜单 -->
    <div class="md:hidden bg-white shadow-md absolute w-full hidden" id="mobileMenu">
        <div class="container mx-auto px-4 py-3 flex flex-col space-y-3">
            <a href="${pageContext.request.contextPath}/myalbum" class="text-primary font-medium py-2">我的相册</a>
            <a href="${pageContext.request.contextPath}/tosearch" class="text-dark/70 hover:text-primary transition-colors py-2">搜索</a>
            <div class="border-t border-gray-100 my-1"></div>
            <a href="${pageContext.request.contextPath}/myProfile" class="text-dark/80 hover:text-primary transition-colors py-2">
                <i class="fa fa-user-circle mr-2"></i> 我的资料
            </a>
            <a href="${pageContext.request.contextPath}/toUpload" class="text-dark/80 hover:text-primary transition-colors py-2">
                <i class="fa fa-upload mr-2"></i> 上传图片
            </a>
            <a href="${pageContext.request.contextPath}/toUpload" class="text-dark/80 hover:text-primary transition-colors py-2">
                <i class="fa fa-folder mr-2"></i> 创建相册
            </a>
            <a href="${pageContext.request.contextPath}/logout" class="text-red-500 hover:bg-gray-50 transition-colors py-2">
                <i class="fa fa-sign-out mr-2"></i> 退出登录
            </a>
        </div>
    </div>
</header>

<!-- 主内容区 -->
<main class="container mx-auto px-4 pt-24 pb-16">
    <!-- 返回链接 -->
    <div class="mb-6">
        <a href="${pageContext.request.contextPath}/getAllAlbum" class="inline-flex items-center space-x-2 text-primary hover:text-primary/80 transition-colors">
            <i class="fa fa-arrow-left"></i>
            <span>回到首页</span>
        </a>
    </div>

    <!-- 成功/错误消息 -->
    <c:if test="${not empty success}">
        <div class="bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded-lg mb-6 flex items-center">
            <i class="fa fa-check-circle mr-2"></i>
            <span>${success}</span>
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg mb-6 flex items-center">
            <i class="fa fa-exclamation-circle mr-2"></i>
            <span>${error}</span>
        </div>
    </c:if>

    <!-- 页面标题 -->
    <div class="mb-8">
        <div class="flex flex-col md:flex-row md:items-center md:justify-between">
            <div>
                <h1 class="text-2xl md:text-3xl font-bold text-dark">我的相册</h1>
                <p class="text-dark/60 mt-2">管理和查看你的相册</p>
            </div>
            <a href="${pageContext.request.contextPath}/toUpload" class="mt-4 md:mt-0 inline-flex items-center bg-primary hover:bg-primary/90 text-white px-4 py-2 rounded-lg transition-custom shadow-md hover:shadow-lg">
                <i class="fa fa-plus mr-2"></i>
                <span>创建相册</span>
            </a>
        </div>
    </div>

    <!-- 相册列表 -->
    <div class="bg-white rounded-xl shadow-md overflow-hidden">
        <div class="overflow-x-auto">
            <table class="w-full">
                <thead>
                <tr class="bg-gray-50 text-left">
                    <th class="px-6 py-4 text-sm font-medium text-dark/70">ID</th>
                    <th class="px-6 py-4 text-sm font-medium text-dark/70">标题</th>
                    <th class="px-6 py-4 text-sm font-medium text-dark/70">描述</th>
                    <th class="px-6 py-4 text-sm font-medium text-dark/70">状态</th>
                    <th class="px-6 py-4 text-sm font-medium text-dark/70">封面</th>
                    <th class="px-6 py-4 text-sm font-medium text-dark/70">创建时间</th>
                    <th class="px-6 py-4 text-sm font-medium text-dark/70 text-right">操作</th>
                </tr>
                </thead>
                <tbody class="divide-y divide-gray-100">
                <c:forEach items="${albums}" var="album">
                    <tr class="hover:bg-gray-50 transition-colors">
                        <td class="px-6 py-4 text-sm text-dark/70">${album.id}</td>
                        <td class="px-6 py-4">
                            <div class="font-medium text-dark">${album.title}</div>
                        </td>
                        <td class="px-6 py-4 text-sm text-dark/70 line-clamp-1">${album.description}</td>
                        <td class="px-6 py-4">
                            <c:choose>
                                <c:when test="${album.status eq 'public'}">
                                    <span class="status-badge bg-green-100 text-green-800">公开</span>
                                </c:when>
                                <c:when test="${album.status eq 'private'}">
                                    <span class="status-badge bg-gray-100 text-gray-800">私密</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge bg-yellow-100 text-yellow-800">审核中</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="px-6 py-4">
                            <div class="w-12 h-12 rounded-lg overflow-hidden bg-gray-100">
                                <c:choose>
                                    <c:when test="${not empty album.coverUrl}">
                                        <img src="${pageContext.request.contextPath}${album.coverUrl}" alt="${album.title}" class="w-full h-full object-cover" crossorigin="use-credentials" onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/default-cover.jpg'"/>
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/images/default-cover.jpg" alt="默认封面" class="w-full h-full object-cover"/>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </td>
                        <td class="px-6 py-4 text-sm text-dark/70">${album.createTime}</td>
                        <td class="px-6 py-4 text-right">
                            <div class="flex justify-end space-x-2">
                                <a href="${pageContext.request.contextPath}/albumByPhoto?albumId=${album.id}" class="text-primary hover:text-primary/80 transition-colors">
                                    <i class="fa fa-eye"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/editAlbum?albumId=${album.id}" class="text-info hover:text-info/80 transition-colors">
                                    <i class="fa fa-pencil"></i>
                                </a>
                                <c:choose>
                                    <c:when test="${album.status eq 'public'}">
                                        <a href="${pageContext.request.contextPath}/changeAlbumStatus?albumId=${album.id}&status=private" class="text-warning hover:text-warning/80 transition-colors">
                                            <i class="fa fa-lock"></i>
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/changeAlbumStatus?albumId=${album.id}&status=public" class="text-success hover:text-success/80 transition-colors">
                                            <i class="fa fa-unlock"></i>
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                                <a href="${pageContext.request.contextPath}/deleteAlbum?id=${album.id}" class="text-danger hover:text-danger/80 transition-colors" onclick="return confirm('确定要删除这个相册吗？')">
                                    <i class="fa fa-trash"></i>
                                </a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- 空状态 -->
        <c:if test="${empty albums}">
            <div class="py-12 text-center">
                <div class="w-16 h-16 mx-auto mb-4 bg-gray-100 rounded-full flex items-center justify-center">
                    <i class="fa fa-folder-open-o text-2xl text-gray-400"></i>
                </div>
                <h3 class="text-lg font-medium text-dark mb-2">你还没有创建任何相册</h3>
                <p class="text-dark/60 mb-6">点击下方按钮创建你的第一个相册</p>
                <a href="${pageContext.request.contextPath}/createAlbum" class="inline-flex items-center bg-primary hover:bg-primary/90 text-white px-4 py-2 rounded-lg transition-custom shadow-md hover:shadow-lg">
                    <i class="fa fa-plus mr-2"></i>
                    <span>创建相册</span>
                </a>
            </div>
        </c:if>
    </div>
</main>

<!-- 页脚 -->
<footer class="bg-white border-t border-gray-200 py-8">
    <div class="container mx-auto px-4">
        <div class="flex flex-col md:flex-row justify-between items-center">
            <div class="mb-4 md:mb-0">
                <div class="flex items-center space-x-2">
                    <i class="fa fa-camera-retro text-primary text-xl"></i>
                    <span class="text-lg font-bold text-primary">PicShare</span>
                </div>
                <p class="text-dark/60 text-sm mt-2">分享你的精彩瞬间</p>
            </div>

            <div class="flex space-x-6">
                <a href="#" class="text-dark/60 hover:text-primary transition-colors">
                    <i class="fa fa-facebook"></i>
                </a>
                <a href="#" class="text-dark/60 hover:text-primary transition-colors">
                    <i class="fa fa-twitter"></i>
                </a>
                <a href="#" class="text-dark/60 hover:text-primary transition-colors">
                    <i class="fa fa-instagram"></i>
                </a>
                <a href="#" class="text-dark/60 hover:text-primary transition-colors">
                    <i class="fa fa-pinterest"></i>
                </a>
            </div>
        </div>

        <div class="border-t border-gray-100 mt-6 pt-6 text-center text-dark/60 text-sm">
            <p>© 2025 PicShare. 保留所有权利。</p>
        </div>
    </div>
</footer>

<script>
    // 用户菜单切换
    const userMenuBtn = document.getElementById('userMenuBtn');
    const userMenu = document.getElementById('userMenu');

    userMenuBtn.addEventListener('click', () => {
        userMenu.classList.toggle('hidden');
    });

    // 移动端菜单切换
    const mobileMenuBtn = document.getElementById('mobileMenuBtn');
    const mobileMenu = document.getElementById('mobileMenu');

    mobileMenuBtn.addEventListener('click', () => {
        mobileMenu.classList.toggle('hidden');
    });

    // 点击外部关闭菜单
    document.addEventListener('click', (e) => {
        if (!userMenuBtn.contains(e.target) && !userMenu.contains(e.target)) {
            userMenu.classList.add('hidden');
        }

        if (!mobileMenuBtn.contains(e.target) && !mobileMenu.contains(e.target)) {
            mobileMenu.classList.add('hidden');
        }
    });

    // 导航栏滚动效果
    window.addEventListener('scroll', () => {
        const navbar = document.querySelector('header');
        if (window.scrollY > 10) {
            navbar.classList.add('py-2', 'shadow-md');
            navbar.classList.remove('py-3', 'shadow-sm');
        } else {
            navbar.classList.add('py-3', 'shadow-sm');
            navbar.classList.remove('py-2', 'shadow-md');
        }
    });
</script>
</body>
</html>
