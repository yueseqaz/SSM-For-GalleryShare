<%--
  Created by IntelliJ IDEA.
  User: sakura
  Date: 2025/6/26
  Time: 10:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1>上传图片</h1>
<form action="/addPhotoToAlbum" method="post" enctype="multipart/form-data">
  <input type="file" name="photos" multiple="multiple" >
  <input type="hidden" name="albumId" value="${albumId}">
  <input type="submit" value="上传">
  <a href="${pageContext.request.contextPath}/myalbum">返回</a>
</form>


</body>
</html>
