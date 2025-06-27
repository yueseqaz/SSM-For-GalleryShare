<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PicShare - 相册列表</title>
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
            .tag {
                @apply bg-primary/10 text-primary px-2 py-1 rounded-full text-xs font-medium;
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
            <a href="${pageContext.request.contextPath}/myalbum" class="text-dark/70 hover:text-primary transition-colors">我的相册</a>
            <a href="${pageContext.request.contextPath}/myLike" class="text-dark/70 hover:text-primary transition-colors py-2">我的喜欢</a>
            <a href="${pageContext.request.contextPath}/tosearch" class="text-dark/70 hover:text-primary transition-colors">搜索</a>
        </nav>

        <div class="flex items-center space-x-4">
            <div class="relative">
                <button class="flex items-center space-x-2 focus:outline-none" id="userMenuBtn">
                    <div class="w-8 h-8 rounded-full bg-primary/10 flex items-center justify-center text-primary">
                        <i class="fa fa-user"></i>
                    </div>
                    <span class="hidden md:inline text-dark font-medium"><strong>${user.nickname}</strong></span>
                    <i class="fa fa-angle-down text-dark/60"></i>
                </button>

                <div class="absolute right-0 mt-2 w-48 bg-white rounded-lg shadow-lg py-2 hidden" id="userMenu">
                    <a href="${pageContext.request.contextPath}/myProfile" class="block px-4 py-2 text-dark/80 hover:bg-gray-50 hover:text-primary transition-colors">
                        <i class="fa fa-user-circle mr-2"></i> 我的资料
                    </a>
                    <a href="${pageContext.request.contextPath}/myLike" class="block px-4 py-2 text-dark/80 hover:bg-gray-50 hover:text-primary transition-colors">
                        <i class="fa fa-heart mr-2"></i> 我的喜欢
                    </a>
<%--                    更改密码--%>
                    <a href="${pageContext.request.contextPath}/toUpdateUser?id=${user.id}" class="block px-4 py-2 text-dark/80 hover:bg-gray-50 hover:text-primary transition-colors">
                        <i class="fa fa-cog mr-2"></i> 更改个人信息
                    </a>
                    <a href="${pageContext.request.contextPath}/toUpload" class="block px-4 py-2 text-dark/80 hover:bg-gray-50 hover:text-primary transition-colors">
                        <i class="fa fa-upload mr-2"></i> 上传图片
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

            <a href="${pageContext.request.contextPath}/myalbum" class="text-dark/70 hover:text-primary transition-colors py-2">我的相册</a>
            <a href="${pageContext.request.contextPath}/myLike" class="text-dark/70 hover:text-primary transition-colors py-2">我的喜欢</a>
            <a href="${pageContext.request.contextPath}/getAllAlbum" class="text-primary font-medium py-2">发现</a>
            <a href="${pageContext.request.contextPath}/tosearch" class="text-dark/70 hover:text-primary transition-colors py-2">搜索</a>
            <div class="border-t border-gray-100 my-1"></div>
            <a href="${pageContext.request.contextPath}/myProfile" class="text-dark/80 hover:text-primary transition-colors py-2">
                <i class="fa fa-user-circle mr-2"></i> 我的资料
            </a>
            <a href="${pageContext.request.contextPath}/toUpload" class="text-dark/80 hover:text-primary transition-colors py-2">
                <i class="fa fa-upload mr-2"></i> 上传图片
            </a>
            <a href="${pageContext.request.contextPath}/logout" class="text-red-500 hover:bg-gray-50 transition-colors py-2">
                <i class="fa fa-sign-out mr-2"></i> 退出登录
            </a>
        </div>
    </div>
</header>

<!-- 主内容区 -->
<main class="container mx-auto px-4 pt-24 pb-16">


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

    <!-- 相册列表标题 -->
    <div class="mb-8">
        <h1 class="text-2xl md:text-3xl font-bold text-dark">相册列表</h1>
        <p class="text-dark/60 mt-2">浏览和发现精彩的相册</p>
    </div>

    <!-- 相册网格 -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <c:forEach items="${album}" var="album">
            <div class="bg-white rounded-xl overflow-hidden shadow-md hover:shadow-xl transition-custom hover-scale">
                <div class="h-48 bg-gray-200 relative overflow-hidden">
                    <c:choose>
                        <c:when test="${not empty album.coverUrl}">
                            <img src="${pageContext.request.contextPath}${album.coverUrl}" alt="${album.title}" class="w-full h-full object-cover" crossorigin="use-credentials" onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/default-cover.jpg'"/>
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/images/default-cover.jpg" alt="默认封面" class="w-full h-full object-cover"/>
                        </c:otherwise>
                    </c:choose>
                    <div class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent"></div>
                    <div class="absolute bottom-0 left-0 p-4 text-white">
                        <h3 class="font-bold text-lg">${album.title}</h3>
                        <p class="text-white/80 text-sm">作者: ${album.user.nickname}</p>
                    </div>
                </div>
                <div class="p-4">
                    <p class="text-dark/70 text-sm mb-4 line-clamp-2">${album.description}</p>

                    <div class="flex flex-wrap gap-2 mb-4">
                        <c:forEach var="tag" items="${album.tags}">
                            <span class="tag">${tag.name}</span>
                        </c:forEach>
                    </div>

                    <div class="flex justify-between items-center">
                        <div class="flex items-center text-dark/60">
                            <i class="fa fa-heart text-red-500 mr-1"></i>
                            <span>${likeCountMap[album.id]}</span>
                        </div>
                        <div class="flex space-x-2">
                            <a href="${pageContext.request.contextPath}/publicAlbumByPhoto?albumId=${album.id}" class="text-primary hover:text-primary/80 transition-colors">
                                <i class="fa fa-eye"></i> 查看
                            </a>
                            <a href="${pageContext.request.contextPath}/like?albumId=${album.id}&userId=${album.user.id}" class="text-primary hover:text-primary/80 transition-colors">
                                <i class="fa fa-heart"></i> 点赞
                            </a>
                            <a href="${pageContext.request.contextPath}/cancelLike?albumId=${album.id}&userId=${album.user.id}" class="text-primary hover:text-primary/80 transition-colors">
                                <i class="fa fa-heart-o"></i> 取消点赞
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
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
