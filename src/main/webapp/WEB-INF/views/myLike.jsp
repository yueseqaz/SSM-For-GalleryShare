<%--
  Created by IntelliJ IDEA.
  User: sakura
  Date: 2025/6/27
  Time: 01:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>我喜欢的相册</title>
</head>
<body>
<h2>我喜欢的相册</h2>
<a href="${pageContext.request.contextPath}/getAllAlbum">返回首页</a>
<div>
  <c:forEach items="${likedAlbums}" var="album">
    <div style="border: 1px solid #ddd; margin: 10px; padding: 10px;">
      <h3>${album.title}</h3>
      <p>${album.description}</p>
      <img src="${pageContext.request.contextPath}${album.coverUrl}" width="150" height="150" />
      <p>作者：${album.user.nickname}</p>
      <a href="${pageContext.request.contextPath}/albumByPhoto?albumId=${album.id}">查看详情</a>
    </div>
  </c:forEach>
</div>
</body>
</html>
