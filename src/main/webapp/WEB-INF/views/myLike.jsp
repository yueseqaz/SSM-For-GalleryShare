<%--
  Created by IntelliJ IDEA.
  User: sakura
  Date: 2025/6/27
  Time: 01:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>我喜欢的相册</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Microsoft YaHei', 'PingFang SC', sans-serif;
      background: linear-gradient(135deg, #efe8e8 0%, #e0dde4 100%);
      min-height: 100vh;
      padding: 20px;
    }

    .container {
      max-width: 1200px;
      margin: 0 auto;
    }

    .header {
      text-align: center;
      margin-bottom: 40px;
      color: white;
    }

    .header h1 {
      font-size: 2.5rem;
      margin-bottom: 20px;
      text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
    }

    .back-btn {
      display: inline-block;
      padding: 12px 24px;
      background: rgba(255,255,255,0.2);
      color: white;
      text-decoration: none;
      border-radius: 25px;
      backdrop-filter: blur(10px);
      border: 1px solid rgba(255,255,255,0.3);
      transition: all 0.3s ease;
      font-weight: 500;
    }

    .back-btn:hover {
      background: rgba(255,255,255,0.3);
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(0,0,0,0.2);
    }

    .albums-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
      gap: 30px;
      margin-top: 30px;
    }

    .album-card {
      background: rgba(255,255,255,0.95);
      border-radius: 20px;
      padding: 25px;
      box-shadow: 0 10px 30px rgba(0,0,0,0.1);
      transition: all 0.3s ease;
      backdrop-filter: blur(10px);
      border: 1px solid rgba(255,255,255,0.2);
    }

    .album-card:hover {
      transform: translateY(-10px);
      box-shadow: 0 20px 40px rgba(0,0,0,0.2);
    }

    .album-title {
      font-size: 1.4rem;
      color: #333;
      margin-bottom: 15px;
      font-weight: 600;
    }

    .album-description {
      color: #666;
      margin-bottom: 20px;
      line-height: 1.6;
    }

    .album-cover {
      width: 100%;
      height: 200px;
      object-fit: cover;
      border-radius: 15px;
      margin-bottom: 20px;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
      transition: transform 0.3s ease;
    }

    .album-cover:hover {
      transform: scale(1.05);
    }

    .album-author {
      color: #888;
      margin-bottom: 20px;
      font-size: 0.9rem;
    }

    .album-author::before {
      content: "👤 ";
    }

    .album-actions {
      display: flex;
      gap: 15px;
      flex-wrap: wrap;
    }

    .btn {
      padding: 10px 20px;
      border: none;
      border-radius: 25px;
      text-decoration: none;
      font-weight: 500;
      transition: all 0.3s ease;
      cursor: pointer;
      font-size: 0.9rem;
      display: inline-flex;
      align-items: center;
      gap: 8px;
    }

    .btn-primary {
      background: linear-gradient(45deg, #b9bcc3, #cfcad8);
      color: white;
    }

    .btn-primary:hover {
      background: linear-gradient(45deg, #dddcdc, #dfdce4);
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
    }

    .btn-danger {
      background: linear-gradient(45deg, #ff6b6b, #ee5a52);
      color: white;
    }

    .btn-danger:hover {
      background: linear-gradient(45deg, #ff5252, #d32f2f);
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(255, 107, 107, 0.4);
    }

    .empty-state {
      text-align: center;
      color: rgba(255,255,255,0.8);
      margin-top: 100px;
    }

    .empty-state .icon {
      font-size: 4rem;
      margin-bottom: 20px;
    }

    .empty-state h3 {
      font-size: 1.5rem;
      margin-bottom: 10px;
    }

    @media (max-width: 768px) {
      .albums-grid {
        grid-template-columns: 1fr;
        gap: 20px;
      }

      .header h1 {
        font-size: 2rem;
      }

      .album-actions {
        flex-direction: column;
      }

      .btn {
        justify-content: center;
      }
    }
  </style>
</head>
<body>
<div class="container">
  <div class="header">
    <h1>💖 我喜欢的相册</h1>
    <a href="${pageContext.request.contextPath}/getAllAlbum" class="back-btn">
      🏠 返回首页
    </a>
  </div>

  <c:choose>
    <c:when test="${not empty likedAlbums}">
      <div class="albums-grid">
        <c:forEach items="${likedAlbums}" var="album">
          <div class="album-card">
            <h3 class="album-title">${album.title}</h3>
            <p class="album-description">${album.description}</p>
            <img src="${pageContext.request.contextPath}${album.coverUrl}"
                 alt="${album.title}"
                 class="album-cover"
                 loading="lazy" />
            <p class="album-author">作者：${album.user.nickname}</p>
            <div class="album-actions">
              <a href="${pageContext.request.contextPath}/publicAlbumByPhoto?albumId=${album.id}"
                 class="btn btn-primary">
                👁️ 查看详情
              </a>
              <a href="${pageContext.request.contextPath}/myLikeCancelLike?albumId=${album.id}&userId=${album.user.id}"
                 class="btn btn-danger"
                 onclick="return confirm('确定要取消喜欢这个相册吗？')">
                💔 取消喜欢
              </a>
            </div>
          </div>
        </c:forEach>
      </div>
    </c:when>
    <c:otherwise>
      <div class="empty-state">
        <div class="icon">📷</div>
        <h3>还没有喜欢的相册</h3>
        <p>去发现一些精彩的相册吧！</p>
      </div>
    </c:otherwise>
  </c:choose>
</div>

<script>
  // 图片加载失败时的处理
  document.querySelectorAll('.album-cover').forEach(img => {
    img.onerror = function() {
      this.src = 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgdmlld0JveD0iMCAwIDIwMCAyMDAiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxyZWN0IHdpZHRoPSIyMDAiIGhlaWdodD0iMjAwIiBmaWxsPSIjRjNGNEY2Ii8+CjxwYXRoIGQ9Ik0xMDAgMTAwTTEwMCAxMDBMMTAwIDEwME0xMDAgMTAwTDEwMCAxMDBNMTAwIDEwMEwxMDAgMTAwTTEwMCAxMDBMMTAwIDEwMCIgc3Ryb2tlPSIjQ0NEMUQ5IiBzdHJva2Utd2lkdGg9IjIiLz4KPHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCA0MCA0MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4PSI4MCIgeT0iODAiPgo8cGF0aCBkPSJNMzUgMTJIMzJMMjguNSA3SDE1TDExLjUgMTJIOEMxMC4yIDEyIDEyIDEzLjggMTIgMTZWMzJDMTIgMzQuMiAxMy44IDM2IDE2IDM2SDMyQzM0LjIgMzYgMzYgMzQuMiAzNiAzMlYxNkMzNiAxMy44IDM0LjIgMTIgMzIgMTJaIiBzdHJva2U9IiNDQ0QxRDkiIHN0cm9rZS13aWR0aD0iMiIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIi8+CjxjaXJjbGUgY3g9IjI0IiBjeT0iMjQiIHI9IjciIHN0cm9rZT0iI0NDRDFEOSIgc3Ryb2tlLXdpZHRoPSIyIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiLz4KPC9zdmc+Cjwvc3ZnPgo=';
      this.alt = '图片加载失败';
    };
  });

  // 添加页面加载动画
  window.addEventListener('load', function() {
    const cards = document.querySelectorAll('.album-card');
    cards.forEach((card, index) => {
      card.style.opacity = '0';
      card.style.transform = 'translateY(30px)';
      setTimeout(() => {
        card.style.transition = 'all 0.6s ease';
        card.style.opacity = '1';
        card.style.transform = 'translateY(0)';
      }, index * 100);
    });
  });
</script>
</body>
</html>
