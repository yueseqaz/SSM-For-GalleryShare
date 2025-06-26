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
    <title>Title</title>
</head>
<body>
<form action="/editAlbum" method="post">
    <input type="hidden" name="id" value="${album.id}">
    <label for="title">标题</label>
    <input type="text" id="title" name="title" value="${album.title}">
    <label for="description">描述</label>
    <textarea id="description" name="description">${album.description}</textarea>
    <label for="coverUrl">封面</label>
    <input type="text" id="coverUrl" name="coverUrl" value="${album.coverUrl}">

    <input type="submit" value="提交">
</form>


</body>
</html>
