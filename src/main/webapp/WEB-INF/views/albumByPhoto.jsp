<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: sakura
  Date: 2025/6/25
  Time: 23:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>cos</title>
</head>
<body>
<c:forEach items="${photos}" var="photo">
    <img src="${pageContext.request.contextPath}${photo.url}" width="100" height="100" crossorigin="use-credentials"
         onerror="this.onerror=null;this.src='images/default-cover.jpg'"/>
</c:forEach>
</body>
</html>
