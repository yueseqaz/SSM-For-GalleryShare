<%--
  Created by IntelliJ IDEA.
  User: sakura
  Date: 2025/6/26
  Time: 22:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<c:forEach items="${photos}" var="photo">
  <div style="border: 1px solid #ddd; padding: 10px;">
    <img src="${pageContext.request.contextPath}${photo.url}" width="150" height="150" onerror="this.src='images/default-image.jpg'"/>
    <br>
    相册ID: ${photo.albumId}
  </div>
</c:forEach>

</body>
</html>
