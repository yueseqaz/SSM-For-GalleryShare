<%--
  Created by IntelliJ IDEA.
  User: sakura
  Date: 2025/6/24
  Time: 15:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>添加用户</title>
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
      .form-input-focus {
        @apply focus:ring-2 focus:ring-primary/50 focus:border-primary focus:outline-none;
      }
      .card-shadow {
        @apply shadow-lg hover:shadow-xl transition-shadow duration-300;
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
          <i class="fa fa-user-circle text-primary text-2xl mr-2"></i>
          <span class="font-semibold text-xl text-gray-800">用户管理系统</span>
        </a>
        <div class="hidden sm:ml-6 sm:flex sm:space-x-8">
          <a href="${pageContext.request.contextPath}/admin/getAllUser" class="border-primary text-gray-900 border-b-2 px-1 pt-1 inline-flex items-center text-sm font-medium">
            <i class="fa fa-arrow-left mr-1"></i>
            <span>返回用户列表</span>
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
<main class="flex-grow">
  <div class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
    <div class="bg-white rounded-lg shadow-xl overflow-hidden">
      <div class="bg-primary text-white px-6 py-4">
        <h1 class="text-xl font-bold flex items-center">
          <i class="fa fa-user-plus mr-2"></i>添加用户
        </h1>
      </div>

      <div class="p-6">
        <form action="${pageContext.request.contextPath}/admin/addUser" method="post" class="space-y-6">
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div class="space-y-2">
              <label for="email" class="block text-sm font-medium text-gray-700">
                <i class="fa fa-envelope-o mr-1"></i>邮箱
              </label>
              <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                  <i class="fa fa-envelope-o text-gray-400"></i>
                </div>
                <input type="email" name="email" id="email" class="pl-10 block w-full rounded-md border-gray-300 shadow-sm form-input-focus" placeholder="user@example.com">
              </div>
            </div>

            <div class="space-y-2">
              <label for="password" class="block text-sm font-medium text-gray-700">
                <i class="fa fa-lock mr-1"></i>密码
              </label>
              <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                  <i class="fa fa-lock text-gray-400"></i>
                </div>
                <input type="password" name="password" id="password" class="pl-10 block w-full rounded-md border-gray-300 shadow-sm form-input-focus" placeholder="请输入密码">
              </div>
            </div>

            <div class="space-y-2">
              <label for="nickname" class="block text-sm font-medium text-gray-700">
                <i class="fa fa-user mr-1"></i>昵称
              </label>
              <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                  <i class="fa fa-user text-gray-400"></i>
                </div>
                <input type="text" name="nickname" id="nickname" class="pl-10 block w-full rounded-md border-gray-300 shadow-sm form-input-focus" placeholder="请输入昵称">
              </div>
            </div>

            <div class="space-y-2">
              <label for="address" class="block text-sm font-medium text-gray-700">
                <i class="fa fa-map-marker mr-1"></i>地址
              </label>
              <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                  <i class="fa fa-map-marker text-gray-400"></i>
                </div>
                <input type="text" name="address" id="address" class="pl-10 block w-full rounded-md border-gray-300 shadow-sm form-input-focus" placeholder="请输入地址">
              </div>
            </div>

            <div class="space-y-2">
              <label for="gender" class="block text-sm font-medium text-gray-700">
                <i class="fa fa-venus-mars mr-1"></i>性别
              </label>
              <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                  <i class="fa fa-venus-mars text-gray-400"></i>
                </div>
                <select name="gender" id="gender" class="pl-10 block w-full rounded-md border-gray-300 shadow-sm form-input-focus">
                  <option value="">请选择性别</option>
                  <option value="男">男</option>
                  <option value="女">女</option>
                  <option value="其他">其他</option>
                </select>
              </div>
            </div>

            <div class="space-y-2">
              <label for="avatar" class="block text-sm font-medium text-gray-700">
                <i class="fa fa-image mr-1"></i>头像URL
              </label>
              <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                  <i class="fa fa-image text-gray-400"></i>
                </div>
                <input type="text" name="avatar" id="avatar" class="pl-10 block w-full rounded-md border-gray-300 shadow-sm form-input-focus" placeholder="请输入头像URL">
              </div>
            </div>

            <div class="space-y-2">
              <label for="role" class="block text-sm font-medium text-gray-700">
                <i class="fa fa-user-circle-o mr-1"></i>角色
              </label>
              <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                  <i class="fa fa-user-circle-o text-gray-400"></i>
                </div>
                <select name="role" id="role" class="pl-10 block w-full rounded-md border-gray-300 shadow-sm form-input-focus">
                  <option value="">请选择角色</option>
                  <option value="普通用户">普通用户</option>
                  <option value="管理员">管理员</option>
                  <option value="VIP用户">VIP用户</option>
                </select>
              </div>
            </div>

            <div class="space-y-2">
              <label for="age" class="block text-sm font-medium text-gray-700">
                <i class="fa fa-calendar mr-1"></i>年龄
              </label>
              <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                  <i class="fa fa-calendar text-gray-400"></i>
                </div>
                <input type="number" name="age" id="age" class="pl-10 block w-full rounded-md border-gray-300 shadow-sm form-input-focus" placeholder="请输入年龄">
              </div>
            </div>
          </div>

          <div class="space-y-2">
            <label for="bio" class="block text-sm font-medium text-gray-700">
              <i class="fa fa-pencil mr-1"></i>签名
            </label>
            <div class="relative">
              <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                <i class="fa fa-pencil text-gray-400"></i>
              </div>
              <input type="text" name="bio" id="bio" class="pl-10 block w-full rounded-md border-gray-300 shadow-sm form-input-focus" placeholder="请输入个性签名">
            </div>
          </div>

          <div class="space-y-2">
            <label for="intro" class="block text-sm font-medium text-gray-700">
              <i class="fa fa-file-text-o mr-1"></i>简介
            </label>
            <div class="relative">
              <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                <i class="fa fa-file-text-o text-gray-400"></i>
              </div>
              <textarea name="intro" id="intro" rows="3" class="pl-10 block w-full rounded-md border-gray-300 shadow-sm form-input-focus" placeholder="请输入用户简介"></textarea>
            </div>
          </div>

          <div class="space-y-2">
            <label for="answer" class="block text-sm font-medium text-gray-700">
              <i class="fa fa-question-circle mr-1"></i>忘记密码助记词
            </label>
            <div class="relative">
              <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                <i class="fa fa-question-circle text-gray-400"></i>
              </div>
              <input type="text" name="answer" id="answer" class="pl-10 block w-full rounded-md border-gray-300 shadow-sm form-input-focus" placeholder="请输入忘记密码助记词">
            </div>
          </div>

          <div class="flex justify-end space-x-4 pt-4 border-t border-gray-200">
            <a href="${pageContext.request.contextPath}/admin/getAllUser" class="inline-flex items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary transition duration-150 ease-in-out">
              <i class="fa fa-arrow-left mr-2"></i>返回
            </a>
            <button type="submit" class="inline-flex items-center px-6 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-primary hover:bg-primary/90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary transition duration-150 ease-in-out">
              <i class="fa fa-save mr-2"></i>提交
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</main>

<!-- 页脚 -->
<footer class="bg-white border-t border-gray-200">
  <div class="max-w-7xl mx-auto py-4 px-4 sm:px-6 lg:px-8">
    <p class="text-center text-sm text-gray-500">
      &copy; 2025 用户管理系统 版权所有
    </p>
  </div>
</footer>
</body>
</html>
