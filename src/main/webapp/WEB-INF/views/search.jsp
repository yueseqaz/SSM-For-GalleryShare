<%--
  Created by IntelliJ IDEA.
  User: sakura
  Date: 2025/6/26
  Time: 21:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>图册搜索</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #eeeef1 0%, #d9d5df 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }

        .header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
        }

        .nav-links {
            padding: 20px 30px;
            border-bottom: 1px solid #eee;
        }

        .nav-links a {
            color: #4facfe;
            text-decoration: none;
            font-weight: bold;
            transition: color 0.3s ease;
        }

        .nav-links a:hover {
            color: #667eea;
        }

        .search-section {
            padding: 30px;
        }

        .search-form {
            display: flex;
            gap: 15px;
            align-items: center;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }

        .search-form label {
            font-weight: bold;
            color: #333;
            white-space: nowrap;
        }

        .search-form input {
            flex: 1;
            min-width: 200px;
            padding: 12px 15px;
            border: 2px solid #e1e8ed;
            border-radius: 10px;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .search-form input:focus {
            outline: none;
            border-color: #4facfe;
            box-shadow: 0 0 0 3px rgba(79, 172, 254, 0.1);
        }

        .search-btn {
            padding: 12px 25px;
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            white-space: nowrap;
        }

        .search-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(79, 172, 254, 0.4);
        }

        .results-section {
            margin-top: 20px;
        }

        .results-header {
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f0f0;
        }

        .results-count {
            color: #4facfe;
            font-weight: bold;
            font-size: 18px;
        }

        .album-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            margin-top: 20px;
        }

        .album-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: all 0.3s ease;
            border: 1px solid #f0f0f0;
        }

        .album-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
        }

        .album-cover {
            width: 100%;
            height: 200px;
            object-fit: cover;
            display: block;
        }

        .album-info {
            padding: 20px;
        }

        .album-title {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            margin-bottom: 8px;
        }

        .album-description {
            color: #666;
            font-size: 14px;
            line-height: 1.4;
            margin-bottom: 12px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .album-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 6px;
            margin-bottom: 12px;
        }

        .tag {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            padding: 4px 10px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: bold;
        }

        .album-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 13px;
            color: #999;
        }

        .no-results {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }

        .no-results h3 {
            font-size: 24px;
            margin-bottom: 10px;
            color: #999;
        }

        .search-tips {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-top: 20px;
            border-left: 4px solid #4facfe;
        }

        .search-tips h4 {
            color: #4facfe;
            margin-bottom: 10px;
        }

        .search-tips p {
            color: #666;
            line-height: 1.5;
        }

        @media (max-width: 768px) {
            .search-form {
                flex-direction: column;
                align-items: stretch;
            }

            .search-form input {
                min-width: auto;
            }

            .album-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>图册搜索</h1>
        <p>找到你想要的精彩内容</p>
    </div>

    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/getAllAlbum">← 回到gallery</a>
    </div>

    <div class="search-section">
        <form action="${pageContext.request.contextPath}/album/searchByTag" method="get" class="search-form">
            <label for="keyword">搜索标签：</label>
            <input type="text" id="keyword" name="keyword" placeholder="请输入标签关键词" value="${param.keyword}">
            <button type="submit" class="search-btn">搜索</button>
        </form>

        <!-- 搜索结果显示区域 -->
        <c:if test="${not empty param.keyword}">
            <div class="results-section">
                <div class="results-header">
                    <c:choose>
                        <c:when test="${not empty albums}">
                            <div class="results-count">找到 ${albums.size()} 个包含 "${param.keyword}" 标签的图册</div>
                        </c:when>
                        <c:otherwise>
                            <div class="results-count">没有找到包含 "${param.keyword}" 标签的图册</div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <c:choose>
                    <c:when test="${not empty albums}">
                        <div class="album-grid">
                            <c:forEach var="album" items="${albums}">
                                <div class="album-card">
                                    <img src="${pageContext.request.contextPath}${album.coverUrl}"
                                         alt="${album.title}"
                                         class="album-cover">
                                            <div class="album-info">
                                        <div class="album-title">${album.title}</div>
                                        <div class="album-description">${album.description}</div>
                                        <div class="album-tags">
                                            <c:forEach var="tag" items="${album.tags}">
                                                <span class="tag">${tag.name}</span>
                                            </c:forEach>
                                        </div>
                                        <div class="album-meta">
                                            <span>创建时间: ${album.createTime}</span>
                                        </div>
                                    </div>
                                </div>
                                <a href="${pageContext.request.contextPath}/albumByPhoto?albumId=${album.id}">去查看</a>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="no-results">
                            <h3>暂无结果</h3>
                            <p>尝试使用其他关键词搜索</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <!-- 搜索提示 -->
        <c:if test="${empty param.keyword}">
            <div class="search-tips">
                <h4>搜索提示</h4>
                <p>您可以通过标签关键词搜索相关图册，例如：风景、旅行、美食、日常等。</p>
            </div>
        </c:if>
    </div>
</div>
</body>
</html>
