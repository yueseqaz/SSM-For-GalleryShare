<%--
  Created by IntelliJ IDEA.
  User: sakura
  Date: 2025/6/25
  Time: 09:02
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<c:url var="baseUrl" value="${pageUrl}" />

<tr>
  <td colspan="12" style="text-align:center; padding: 10px 0;">
    <a href="${baseUrl}?page=1">首页</a>

    <c:choose>
      <c:when test="${currentPage > 1}">
        <a href="${baseUrl}?page=${currentPage - 1}">上一页</a>
      </c:when>
      <c:otherwise>
        <span style="color:gray;">上一页</span>
      </c:otherwise>
    </c:choose>

    <c:choose>
      <c:when test="${currentPage < totalPages}">
        <a href="${baseUrl}?page=${currentPage + 1}">下一页</a>
      </c:when>
      <c:otherwise>
        <span style="color:gray;">下一页</span>
      </c:otherwise>
    </c:choose>

    <a href="${baseUrl}?page=${totalPages}">尾页</a>

    第 ${currentPage} 页 / 共 ${totalPages} 页
  </td>
</tr>


