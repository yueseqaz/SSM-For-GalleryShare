<%--
  Created by IntelliJ IDEA.
  User: sakura
  Date: 2025/6/24
  Time: 09:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1>用户首页</h1>
${album}

<a href="${pageContext.request.contextPath}/myProfile">我的资料</a>
<a href="${pageContext.request.contextPath}/myalbum">我的相册</a>
<a href="${pageContext.request.contextPath}/logout">退出登陆</a>
<a href="${pageContext.request.contextPath}/getAllAlbum">相册</a>
<a href="${pageContext.request.contextPath}/toUpload">上传相册</a>




</body>
</html>
