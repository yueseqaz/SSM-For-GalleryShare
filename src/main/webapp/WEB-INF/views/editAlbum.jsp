<%--
  Created by IntelliJ IDEA.
  User: sakura
  Date: 2025/6/27
  Time: 01:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>编辑相册</title>
    <style>
        body {
            background: linear-gradient(to right, #fceabb, #f8b500);
            font-family: "Segoe UI", "Microsoft YaHei", sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .form-container {
            background-color: #ffffffdd;
            padding: 30px 40px;
            border-radius: 16px;
            box-shadow: 0 12px 24px rgba(0,0,0,0.2);
            max-width: 500px;
            width: 100%;
        }

        h2 {
            text-align: center;
            color: #444;
            margin-bottom: 24px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
            color: #555;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 10px 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 14px;
        }

        textarea {
            resize: vertical;
            min-height: 80px;
        }

        input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #ff9800;
            border: none;
            color: white;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #fb8c00;
        }

        @media (max-width: 600px) {
            .form-container {
                padding: 20px;
                margin: 10px;
            }
        }
    </style>
</head>
<body>
<div class="form-container">
    <h2>编辑相册信息</h2>
    <form action="${pageContext.request.contextPath}/editAlbum" method="post">
        <input type="hidden" name="id" value="${album.id}">

        <label for="title">标题</label>
        <input type="text" id="title" name="title" value="${album.title}" required>

        <label for="description">描述</label>
        <textarea id="description" name="description">${album.description}</textarea>

        <label for="coverUrl">封面 URL</label>
        <input type="text" id="coverUrl" name="coverUrl" value="${album.coverUrl}">

        <input type="submit" value="提交修改">
    </form>
</div>
</body>
</html>
