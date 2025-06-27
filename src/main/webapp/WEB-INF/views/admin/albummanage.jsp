<%--
  Created by IntelliJ IDEA.
  User: sakura
  Date: 2025/6/26
  Time: 08:56
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>图册展示</title>
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
            .table-shadow {
                @apply shadow-md hover:shadow-lg transition-shadow duration-300;
            }
            .tag-style {
                @apply inline-block bg-primary/10 text-primary px-2 py-1 rounded-full text-xs font-medium mr-1 mb-1;
            }
            .status-pill {
                @apply inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium;
            }
            .btn-action {
                @apply inline-flex items-center px-3 py-1.5 border border-transparent text-sm font-medium rounded-md shadow-sm transition-all duration-150 ease-in-out;
            }
            .btn-primary {
                @apply btn-action text-white bg-primary hover:bg-primary/90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary;
            }
            .btn-secondary {
                @apply btn-action text-gray-700 bg-white border border-gray-300 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary;
            }
            .btn-danger {
                @apply btn-action text-white bg-danger hover:bg-danger/90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-danger;
            }
            .btn-info {
                @apply btn-action text-white bg-info hover:bg-info/90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-info;
            }
            .img-hover-zoom {
                @apply overflow-hidden;
            }
            .img-hover-zoom img {
                @apply transition-transform duration-500 ease-in-out;
            }
            .img-hover-zoom:hover img {
                @apply transform scale-110;
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
                    <i class="fa fa-picture-o text-primary text-2xl mr-2"></i>
                    <span class="font-semibold text-xl text-gray-800">图册管理系统</span>
                </a>
                <div class="hidden sm:ml-6 sm:flex sm:space-x-8">
                    <a href="${pageContext.request.contextPath}/admin/homepage" class="border-primary text-gray-900 border-b-2 px-1 pt-1 inline-flex items-center text-sm font-medium">
                        <i class="fa fa-home mr-1"></i>
                        <span>回到首页</span>
                    </a>
                </div>
            </div>
            <div class="flex items-center">
                <button type="button" class="p-2 rounded-full text-gray-400 hover:text-gray-500 focus:outline-none">
                    <i class="fa fa-bell"></i>
                </button>
            </div>
        </div>
    </div>
</nav>

<!-- 主内容区 -->
<main class="flex-grow">
    <div class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
        <!-- 页面标题和操作区 -->
        <div class="flex flex-col md:flex-row md:items-center md:justify-between mb-6">
            <div>
                <h1 class="text-2xl font-bold text-gray-900">图册管理</h1>
                <p class="mt-1 text-sm text-gray-500">查看和管理所有图册</p>
            </div>
            <div class="mt-4 flex md:mt-0 md:ml-4">
                <a href="${pageContext.request.contextPath}/toUpload" class="btn-primary">
                    <i class="fa fa-plus mr-2"></i>新增图册
                </a>
            </div>
        </div>


        <!-- 图册列表 -->
        <div class="bg-white rounded-lg shadow-md overflow-hidden">
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                    <tr>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">标题</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">描述</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">状态</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">封面</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">作者</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">标签</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">操作</th>
                    </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                    <c:forEach items="${album}" var="album">
                        <tr class="hover:bg-gray-50 transition-colors duration-150">
                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${album.id}</td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm font-medium text-gray-900">${album.title}</div>
                            </td>
                            <td class="px-6 py-4">
                                <div class="text-sm text-gray-500 line-clamp-2">${album.description}</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <c:choose>
                                    <c:when test="${album.status == 'public'}">
                                                <span class="status-pill bg-green-100 text-green-800">
                                                    <i class="fa fa-globe mr-1"></i>公开
                                                </span>
                                    </c:when>
                                    <c:when test="${album.status == 'private'}">
                                                <span class="status-pill bg-red-100 text-red-800">
                                                    <i class="fa fa-lock mr-1"></i>私密
                                                </span>
                                    </c:when>
                                    <c:otherwise>
                                                <span class="status-pill bg-gray-100 text-gray-800">
                                                        ${album.status}
                                                </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <c:choose>
                                    <c:when test="${not empty album.coverUrl}">
                                        <div class="img-hover-zoom rounded-md overflow-hidden w-16 h-16">
                                            <img src="${pageContext.request.contextPath}${album.coverUrl}" alt="${album.title}封面" class="w-full h-full object-cover">
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="img-hover-zoom rounded-md overflow-hidden w-16 h-16 bg-gray-100 flex items-center justify-center">
                                            <i class="fa fa-picture-o text-gray-300 text-2xl"></i>
                                        </div>
                                        <span class="text-xs text-gray-500">封面未设置</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="flex items-center">
                                    <div class="flex-shrink-0 h-8 w-8">
                                        <img class="h-8 w-8 rounded-full object-cover" src="${album.user.avatar}" alt="${album.user.nickname}头像">
                                    </div>
                                    <div class="ml-3">
                                        <div class="text-sm font-medium text-gray-900">${album.user.nickname}</div>
                                    </div>
                                </div>
                            </td>
                            <td class="px-6 py-4">
                                <!-- 遍历显示标签 -->
                                <c:forEach items="${album.tags}" var="tag">
                                            <span class="tag-style">
                                                    ${tag.name}
                                            </span>
                                </c:forEach>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                <div class="flex space-x-2">
                                    <a href="${pageContext.request.contextPath}/admin/AlbumByPhoto?albumId=${album.id}" class="btn-secondary text-xs px-2 py-1">
                                        <i class="fa fa-eye mr-1"></i>查看
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/editAlbum?albumId=${album.id}" class="btn-info text-xs px-2 py-1">
                                        <i class="fa fa-pencil mr-1"></i>编辑
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/deleteAlbum?id=${album.id}" class="btn-danger text-xs px-2 py-1" onclick="return confirm('确定要删除这个图册吗？')">
                                        <i class="fa fa-trash mr-1"></i>删除
                                    </a>
                                    <c:choose>
                                        <c:when test="${album.status == 'public'}">
                                            <a href="${pageContext.request.contextPath}/admin/changeAlbumStatus?albumId=${album.id}&status=private" class="btn-secondary text-xs px-2 py-1">
                                                <i class="fa fa-lock mr-1"></i>设为私密
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/admin/changeAlbumStatus?albumId=${album.id}&status=public" class="btn-secondary text-xs px-2 py-1">
                                                <i class="fa fa-globe mr-1"></i>设为公开
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- 分页控件 -->
            <div class="bg-white px-4 py-3 flex items-center justify-between border-t border-gray-200 sm:px-6">
                <div class="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between">
                    <div>
                        <nav class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px" aria-label="Pagination">
                            <c:url var="firstPageUrl" value="${baseUrl}">
                                <c:param name="page" value="1"/>
                                <c:if test="${not empty albumId}">
                                    <c:param name="albumId" value="${albumId}"/>
                                </c:if>
                            </c:url>
                            <a href="${firstPageUrl}" class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                <span class="sr-only">第一页</span>
                                <i class="fa fa-angle-double-left"></i>
                            </a>

                            <c:choose>
                                <c:when test="${currentPage > 1}">
                                    <c:url var="prevPageUrl" value="${baseUrl}">
                                        <c:param name="page" value="${currentPage - 1}"/>
                                        <c:if test="${not empty albumId}">
                                            <c:param name="albumId" value="${albumId}"/>
                                        </c:if>
                                    </c:url>
                                    <a href="${prevPageUrl}" class="relative inline-flex items-center px-2 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                        <span class="sr-only">上一页</span>
                                        <i class="fa fa-angle-left"></i>
                                    </a>
                                </c:when>
                                <c:otherwise>
                                        <span class="relative inline-flex items-center px-2 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-400 cursor-not-allowed">
                                            <span class="sr-only">上一页</span>
                                            <i class="fa fa-angle-left"></i>
                                        </span>
                                </c:otherwise>
                            </c:choose>

                            <!-- 显示当前页面前后各两页的页码 -->
                            <c:set var="startLoop" value="${currentPage - 2 < 1 ? 1 : currentPage - 2}" />
                            <c:set var="endLoop" value="${startLoop + 4 > totalPages ? totalPages : startLoop + 4}" />
                            <c:set var="startLoop" value="${endLoop - 4 < 1 ? 1 : endLoop - 4}" />

                            <c:forEach var="i" begin="${startLoop}" end="${endLoop}">
                                <c:url var="pageUrl" value="${baseUrl}">
                                    <c:param name="page" value="${i}"/>
                                    <c:if test="${not empty albumId}">
                                        <c:param name="albumId" value="${albumId}"/>
                                    </c:if>
                                </c:url>
                                <c:choose>
                                    <c:when test="${i == currentPage}">
                                            <span aria-current="page" class="relative inline-flex items-center px-4 py-2 border border-primary bg-primary/10 text-sm font-medium text-primary">
                                                    ${i}
                                            </span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageUrl}" class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50">
                                                ${i}
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <c:choose>
                                <c:when test="${currentPage < totalPages}">
                                    <c:url var="nextPageUrl" value="${baseUrl}">
                                        <c:param name="page" value="${currentPage + 1}"/>
                                        <c:if test="${not empty albumId}">
                                            <c:param name="albumId" value="${albumId}"/>
                                        </c:if>
                                    </c:url>
                                    <a href="${nextPageUrl}" class="relative inline-flex items-center px-2 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                        <span class="sr-only">下一页</span>
                                        <i class="fa fa-angle-right"></i>
                                    </a>
                                </c:when>
                                <c:otherwise>
                                        <span class="relative inline-flex items-center px-2 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-400 cursor-not-allowed">
                                            <span class="sr-only">下一页</span>
                                            <i class="fa fa-angle-right"></i>
                                        </span>
                                </c:otherwise>
                            </c:choose>

                            <c:url var="lastPageUrl" value="${baseUrl}">
                                <c:param name="page" value="${totalPages}"/>
                                <c:if test="${not empty albumId}">
                                    <c:param name="albumId" value="${albumId}"/>
                                </c:if>
                            </c:url>
                            <a href="${lastPageUrl}" class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                <span class="sr-only">最后一页</span>
                                <i class="fa fa-angle-double-right"></i>
                            </a>
                        </nav>
                    </div>
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

