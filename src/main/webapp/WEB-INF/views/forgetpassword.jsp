<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>忘记密码</title>
    <style>
        /* 基础样式重置 */
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: "Microsoft YaHei", sans-serif; }
        body { background-color: #f5f7fa; color: #333; min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px; }

        /* 卡片容器 */
        .form-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            padding: 30px;
            max-width: 400px;
            width: 100%;
            transition: all 0.3s ease;
        }
        .form-container:hover { box-shadow: 0 15px 35px rgba(0,0,0,0.12); }

        /* 标题样式 */
        .form-title {
            text-align: center;
            margin-bottom: 30px;
        }
        .form-title h1 {
            font-size: 28px;
            color: #2c3e50;
            margin-bottom: 8px;
        }
        .form-title p {
            color: #7f8c8d;
            font-size: 14px;
        }

        /* 表单元素 */
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
            font-size: 14px;
        }
        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            transition: all 0.2s ease;
        }
        .form-control:focus {
            border-color: #4a90e2;
            outline: none;
            box-shadow: 0 0 0 2px rgba(74, 144, 226, 0.2);
        }
        .form-control::placeholder { color: #95a5a6; }

        /* 提交按钮 */
        .btn-submit {
            width: 100%;
            padding: 12px 0;
            background-color: #4a90e2;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        .btn-submit:hover { background-color: #357abd; }
        .btn-submit:active { transform: scale(0.98); }

        /* 辅助文字 */
        .form-footer {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
        }
        .form-footer a {
            color: #4a90e2;
            text-decoration: none;
        }
        .form-footer a:hover { text-decoration: underline; }
    </style>
</head>
<body>
<div class="form-container">
    <div class="form-title">
        <h1>忘记密码</h1>
        <p>请输入以下信息重置您的密码</p>
    </div>
    <form action="${pageContext.request.contextPath}/forgetPassword" method="post">
        <div class="form-group">
            <label for="email">邮箱</label>
            <input type="email" id="email" name="email" class="form-control" placeholder="请输入注册邮箱" required>
        </div>
        <div class="form-group">
            <label for="answer">忘记密码助记词</label>
            <input type="text" id="answer" name="answer" class="form-control" placeholder="请输入设置的安全答案" required>
        </div>
        <div class="form-group">
            <label for="newPassword">新密码</label>
            <input type="password" id="newPassword" name="newPassword" class="form-control" placeholder="设置新密码" required>
        </div>
        <button type="submit" class="btn-submit">提交</button>
    </form>
    <div class="form-footer">
        <a href="${pageContext.request.contextPath}/login">
            <i class="fa fa-arrow-left" style="margin-right: 5px;"></i>返回登录页面
        </a>
    </div>
</div>
</body>
</html>