
<%--
  Created by IntelliJ IDEA.
  User: sakura
  Date: 2025/6/25
  Time: 23:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Cos Gallery</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: "Comic Sans MS", "Microsoft YaHei", sans-serif;
            background: #fefefe;
        }

        .gallery-container {
            column-count: 4;
            column-gap: 1em;
            padding: 1em;
        }

        .photo-box {
            background: #fff;
            margin-bottom: 1em;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            break-inside: avoid;
            transition: transform 0.3s ease;
        }

        .photo-box:hover {
            transform: scale(1.02);
        }

        .photo-box img {
            width: 100%;
            height: auto;
            display: block;
        }

        @media screen and (max-width: 1200px) {
            .gallery-container {
                column-count: 3;
            }
        }

        @media screen and (max-width: 768px) {
            .gallery-container {
                column-count: 2;
            }
        }

        @media screen and (max-width: 480px) {
            .gallery-container {
                column-count: 1;
            }
        }
    </style>
</head>
<body>
<a href="${pageContext.request.contextPath}/addPhotoToAlbum?albumId=${albumId}">添加图片</a>
<a href="${pageContext.request.contextPath}/myalbum">返回</a>
<div class="gallery-container">
    <c:forEach items="${photos}" var="photo">
        <div class="photo-box">
            <img src="${pageContext.request.contextPath}${photo.url}"
                 crossorigin="use-credentials"
                 onerror="this.onerror=null;this.src='images/default-cover.jpg'" />
            <div class="photo-info">
                <a href="${pageContext.request.contextPath}/deletePhoto?id=${photo.id}&albumId=${albumId}">删除</a>
            </div>
        </div>
    </c:forEach>
</div>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<c:url var="baseUrl" value="${pageUrl}" />

<tr>
    <td colspan="12" style="text-align:center; padding: 10px 0;">
        <c:url var="firstPageUrl" value="${baseUrl}">
            <c:param name="page" value="1"/>
            <c:if test="${not empty albumId}">
                <c:param name="albumId" value="${albumId}"/>
            </c:if>
        </c:url>
        <a href="${firstPageUrl}">首页</a>

        <c:choose>
            <c:when test="${currentPage > 1}">
                <c:url var="prevPageUrl" value="${baseUrl}">
                    <c:param name="page" value="${currentPage - 1}"/>
                    <c:if test="${not empty albumId}">
                        <c:param name="albumId" value="${albumId}"/>
                    </c:if>
                </c:url>
                <a href="${prevPageUrl}">上一页</a>
            </c:when>
            <c:otherwise>
                <span style="color:gray;">上一页</span>
            </c:otherwise>
        </c:choose>

        <c:choose>
            <c:when test="${currentPage < totalPages}">
                <c:url var="nextPageUrl" value="${baseUrl}">
                    <c:param name="page" value="${currentPage + 1}"/>
                    <c:if test="${not empty albumId}">
                        <c:param name="albumId" value="${albumId}"/>
                    </c:if>
                </c:url>
                <a href="${nextPageUrl}">下一页</a>
            </c:when>
            <c:otherwise>
                <span style="color:gray;">下一页</span>
            </c:otherwise>
        </c:choose>

        <c:url var="lastPageUrl" value="${baseUrl}">
            <c:param name="page" value="${totalPages}"/>
            <c:if test="${not empty albumId}">
                <c:param name="albumId" value="${albumId}"/>
            </c:if>
        </c:url>
        <a href="${lastPageUrl}">尾页</a>

        第 ${currentPage} 页 / 共 ${totalPages} 页
    </td>
</tr>


</body>
</html>
