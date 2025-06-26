<%--
  Created by IntelliJ IDEA.
  User: sakura
  Date: 2025/6/26
  Time: 08:56
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>图册展示</title>
</head>
<body>
<a href="${pageContext.request.contextPath}/admin/homepage">回到首页</a>
<table border="1" cellpadding="10" cellspacing="0">
    <tr>
        <th>ID</th>
        <th>标题</th>
        <th>描述</th>
        <th>状态</th>
        <th>封面</th>
        <th>作者</th>
        <th>标签</th>
        <th>操作</th>
    </tr>

    <c:forEach items="${album}" var="album">
        <tr>
            <td>${album.id}</td>
            <td>${album.title}</td>
            <td>${album.description}</td>
            <td>${album.status}</td>
            <td>
                <c:choose>
                    <c:when test="${not empty album.coverUrl}">
                        <img src="${pageContext.request.contextPath}${album.coverUrl}" width="100" height="100" crossorigin="use-credentials"
                             onerror="this.onerror=null;this.src='images/default-cover.jpg'"/>
                    </c:when>
                    <c:otherwise>
                        <img src="images/default-cover.jpg" width="100" height="100"/>
                        <br><small>封面未设置</small>
                    </c:otherwise>
                </c:choose>
            </td>
            <td>
                <img src="${album.user.avatar}" width="40" height="40" style="border-radius: 50%">
                    ${album.user.nickname}
            </td>
            <td>
                <!-- 遍历显示标签 -->
                <c:forEach items="${album.tags}" var="tag">
                    <span style="display:inline-block; background:#4facfe; color:#fff; padding:2px 6px; margin:2px; border-radius:8px; font-size:12px;">
                            ${tag.name}
                    </span>
                </c:forEach>
            </td>
            <td>
                <a href="${pageContext.request.contextPath}/admin/AlbumByPhoto?albumId=${album.id}">查看</a>

                    &nbsp;|&nbsp;
                    <a href="${pageContext.request.contextPath}/admin/deleteAlbum?id=${album.id}">删除</a>
                &nbsp;|&nbsp;
                <a href="${pageContext.request.contextPath}/admin/changeAlbumStatus?albumId=${album.id}&status=private">设为私密</a>
                &nbsp;|&nbsp;
                <a href="${pageContext.request.contextPath}/admin/changeAlbumStatus?albumId=${album.id}&status=public">设为公开</a>
            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>

