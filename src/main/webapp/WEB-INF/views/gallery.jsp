<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: sakura
  Date: 2025/6/26
  Time: 00:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<table>
    <tr>
        <th>ID</th>
        <th>标题</th>
        <th>描述</th>
        <th>封面</th>
    </tr>
    <c:forEach items="${album}" var="album">
        <tr>
            <td>${album.id}</td>
            <td>${album.title}</td>
            <td>${album.description}</td>
            <td>
                <c:choose>
                    <c:when test="${not empty album.coverUrl}">
                        <img src="${pageContext.request.contextPath}${album.coverUrl}" width="100" height="100" crossorigin="use-credentials"
                             onerror="this.onerror=null;this.src='images/default-cover.jpg'"/>
                        <br>
                        <small>路径: ${pageContext.request.contextPath}${album.coverUrl}</small>
                      </c:when>
                    <c:otherwise>
                        <img src="images/default-cover.jpg" width="100" height="100"/>
                        <br>
                        <small>封面未设置</small>
                    </c:otherwise>
                  </c:choose>
            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
