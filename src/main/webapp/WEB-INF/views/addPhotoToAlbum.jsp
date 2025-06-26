<%--
  Created by IntelliJ IDEA.
  User: sakura
  Date: 2025/6/26
  Time: 10:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>上传图片</title>
    <style>
        /* 基础样式重置 */
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: "Microsoft YaHei", sans-serif; }
        body { background-color: #f5f7fa; color: #333; min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px; }

        /* 卡片容器 */
        .upload-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            padding: 30px;
            max-width: 450px;
            width: 100%;
            transition: all 0.3s ease;
        }
        .upload-container:hover { box-shadow: 0 15px 35px rgba(0,0,0,0.12); }

        /* 标题样式 */
        .upload-title {
            text-align: center;
            margin-bottom: 30px;
        }
        .upload-title h1 {
            font-size: 28px;
            color: #2c3e50;
            margin-bottom: 8px;
        }

        /* 上传区域 */
        .upload-area {
            border: 2px dashed #ddd;
            border-radius: 8px;
            padding: 30px;
            text-align: center;
            margin-bottom: 25px;
            transition: all 0.2s ease;
        }
        .upload-area:hover {
            border-color: #4a90e2;
            background-color: #f8fbff;
        }
        .upload-area input[type="file"] {
            display: none;
        }
        .upload-area label {
            display: inline-block;
            padding: 10px 20px;
            background-color: #4a90e2;
            color: white;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        .upload-area label:hover {
            background-color: #357abd;
        }
        .upload-area p {
            margin-top: 15px;
            color: #7f8c8d;
            font-size: 14px;
        }

        /* 操作按钮 */
        .action-buttons {
            display: flex;
            gap: 15px;
        }
        .action-buttons input,
        .action-buttons a {
            flex: 1;
            padding: 12px 0;
            text-align: center;
            border-radius: 6px;
            font-size: 16px;
            text-decoration: none;
            transition: all 0.2s ease;
        }
        .action-buttons input {
            background-color: #4a90e2;
            color: white;
            border: none;
            cursor: pointer;
        }
        .action-buttons input:hover {
            background-color: #357abd;
        }
        .action-buttons a {
            background-color: #ecf0f1;
            color: #7f8c8d;
        }
        .action-buttons a:hover {
            background-color: #dde4e6;
        }
    </style>
</head>
<body>
<div class="upload-container">
    <div class="upload-title">
        <h1>上传图片</h1>
    </div>
    <form action="/addPhotoToAlbum" method="post" enctype="multipart/form-data">
        <div class="upload-area">
            <label for="photos">选择图片文件</label>
            <input type="file" name="photos" multiple="multiple" id="photos">
            <p>支持多文件上传，点击或拖拽文件到此处</p>
        </div>
        <input type="hidden" name="albumId" value="${albumId}">
        <div class="action-buttons">
            <input type="submit" value="上传">
            <a href="${pageContext.request.contextPath}/myalbum">返回</a>
        </div>
    </form>
</div>
</body>
</html>
