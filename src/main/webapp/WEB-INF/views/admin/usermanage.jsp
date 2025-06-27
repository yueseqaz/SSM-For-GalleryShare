
<%--
  Created by IntelliJ IDEA.
  User: sakura
  Date: 2025/6/24
  Time: 14:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户管理</title>
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
            .btn-hover {
                @apply hover:shadow-lg transform hover:-translate-y-0.5 transition-all duration-200;
            }
            .table-row-animate {
                @apply transition-all duration-200 hover:bg-gray-50;
            }
            .avatar-sm {
                @apply w-8 h-8 rounded-full object-cover;
            }
        }
    </style>
</head>
<body class="bg-gradient-to-br from-gray-50 to-gray-100 min-h-screen font-inter text-gray-800">
<!-- 页面容器 -->
<div class="container mx-auto px-4 py-8 max-w-7xl">
    <!-- 返回按钮 -->
    <div class="mb-6">
        <a href="${pageContext.request.contextPath}/admin/homepage" class="inline-flex items-center text-neutral hover:text-primary transition-colors duration-200">
            <i class="fa fa-arrow-left mr-2"></i>
            <span>返回主页</span>
        </a>
    </div>

    <!-- 页面标题 -->
    <div class="flex flex-col md:flex-row md:items-center md:justify-between mb-8">
        <div>
            <h1 class="text-[clamp(1.75rem,3vw,2.25rem)] font-bold text-gray-800 mb-2">用户管理</h1>
            <p class="text-gray-500">管理系统中的所有用户账户</p>
        </div>

        <div class="mt-4 md:mt-0">
            <a href="${pageContext.request.contextPath}/admin/addUser" class="btn-hover inline-flex items-center px-5 py-2.5 bg-primary text-white rounded-lg transition-all duration-200 hover:bg-primary/90">
                <i class="fa fa-plus-circle mr-2"></i>
                <span>添加用户</span>
            </a>
        </div>
    </div>
    <!-- 用户列表 -->
    <div class="bg-white rounded-xl card-shadow overflow-hidden">
        <!-- 表格头部 -->
        <div class="bg-gray-50 border-b border-gray-200 px-6 py-4">
            <div class="flex items-center justify-between">
                <h2 class="text-lg font-semibold text-gray-800">用户列表</h2>
                <div class="text-sm text-gray-500">
                    共 <span class="font-medium">${totalCount}</span> 个用户
                </div>
            </div>
        </div>

        <!-- 表格内容 -->
        <div class="overflow-x-auto">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                <tr>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">邮箱</th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">昵称</th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">角色</th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">状态</th>





                    <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">操作</th>
                </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                <c:forEach items="${allUser}" var="user">
                    <tr class="table-row-animate">
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                ${user.id}
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                                ${user.email}
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <div class="flex items-center">
                                <div class="flex-shrink-0 h-8 w-8">
                                    <img class="avatar-sm" src="${user.avatar}" alt="${user.nickname}头像">
                                </div>
                                <div class="ml-3">
                                    <div class="text-sm font-medium text-gray-900">${user.nickname}</div>
                                    <div class="text-xs text-gray-500">${user.gender}</div>
                                </div>
                            </div>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full ${user.role == 'admin' ? 'bg-red-100 text-red-800' : (user.role == 'user' ? 'bg-green-100 text-green-800' : 'bg-gray-100 text-gray-800')}">
                                            ${user.role}
                                    </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium">
        <span class="h-2 w-2 rounded-full mr-2 ${user.status == 'active' ? 'bg-green-500' : 'bg-red-500'}"></span>
        ${user.status == 'active' ? '活跃' : '已封禁'}
    </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                            <a href="${pageContext.request.contextPath}/admin/toUpdateUser?id=${user.id}" class="text-primary hover:text-primary/80 mr-4">
                                <i class="fa fa-edit mr-1"></i>编辑与查看
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/deleteUser?id=${user.id}" class="text-danger hover:text-danger/80" onclick="return confirm('确定要删除用户 ${user.nickname} 吗？')">
                                <i class="fa fa-trash mr-1"></i>删除
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/banUser?id=${user.id}" class="text-danger hover:text-danger/80">
                                <i class="fa fa-ban mr-1"></i>封禁
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/unbanUser?id=${user.id}" class="text-danger hover:text-danger/80">
                                <i class="fa fa-unlock mr-1"></i>解封
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- 分页 -->
        <div class="bg-white px-6 py-4 border-t border-gray-200">
            <jsp:include page="/WEB-INF/views/page.jsp">
                <jsp:param name="pageUrl" value="${pageContext.request.contextPath}/admin/getAllUser" />
            </jsp:include>
        </div>
    </div>
</div>
</body>
</html>

