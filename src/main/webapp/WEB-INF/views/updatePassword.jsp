<%--
  Created by IntelliJ IDEA.
  User: sakura
  Date: 2025/6/24
  Time: 16:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>修改密码</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen font-sans">
<div class="bg-white shadow-md rounded-lg p-8 w-full max-w-md">
    <h2 class="text-2xl font-bold text-center text-blue-600 mb-6">修改密码</h2>
    <form action="${pageContext.request.contextPath}/updatePassword" method="post" class="space-y-4">
        <div>
            <label class="block text-gray-700 font-medium mb-1">用户名</label>
            <input type="text" name="email" required
                   class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400"/>
        </div>

        <div>
            <label class="block text-gray-700 font-medium mb-1">旧密码</label>
            <input type="password" name="oldPassword" required
                   class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400"/>
        </div>

        <div>
            <label class="block text-gray-700 font-medium mb-1">新密码</label>
            <input type="password" name="newPassword" required
                   class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400"/>
        </div>

        <div class="text-center">
            <input type="submit" value="修改"
                   class="bg-blue-500 hover:bg-blue-600 text-white font-semibold py-2 px-6 rounded-lg transition duration-200 cursor-pointer"/>
        </div>
    </form>
    <div class="text-center mt-4">
        <a href="${pageContext.request.contextPath}/getAllAlbum" class="text-blue-500 hover:underline">返回首页</a>
    </div>
</div>
</body>
</html>


