<%--
  Created by IntelliJ IDEA.
  User: sakura
  Date: 2025/6/24
  Time: 14:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户详情</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 30px;
            text-align: center;
            position: relative;
        }

        .header h2 {
            font-size: 2.2em;
            font-weight: 300;
            margin-bottom: 10px;
        }

        .mode-indicator {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 20px;
            background: rgba(255, 255, 255, 0.2);
            font-size: 0.9em;
            margin-top: 10px;
            transition: all 0.3s ease;
        }

        .content {
            padding: 40px;
        }

        .user-card {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
            margin-bottom: 30px;
        }

        .field-group {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 20px;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }

        .field-group:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }

        .field-group.full-width {
            grid-column: 1 / -1;
        }

        .field-label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 8px;
            font-size: 0.9em;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .field-value {
            font-size: 1.1em;
            color: #212529;
            line-height: 1.5;
            min-height: 24px;
        }

        .field-value.empty {
            color: #6c757d;
            font-style: italic;
        }

        /* 编辑模式样式 */
        .edit-mode .field-group {
            border-color: #e3f2fd;
            background: #ffffff;
        }

        input, textarea, select {
            width: 100%;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            padding: 12px;
            font-size: 1em;
            transition: all 0.3s ease;
            background: #fff;
        }

        input:focus, textarea:focus, select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        textarea {
            resize: vertical;
            min-height: 80px;
        }

        select {
            cursor: pointer;
        }

        /* 按钮样式 */
        .button-group {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 30px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 25px;
            font-size: 1em;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            min-width: 120px;
            justify-content: center;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
        }

        .btn-success {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
        }

        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(40, 167, 69, 0.3);
        }

        .btn-danger {
            background: linear-gradient(135deg, #dc3545, #fd7e14);
            color: white;
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(220, 53, 69, 0.3);
        }

        .btn-secondary {
            background: linear-gradient(135deg, #6c757d, #adb5bd);
            color: white;
        }

        .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(108, 117, 125, 0.3);
        }

        .btn-outline {
            background: transparent;
            border: 2px solid #667eea;
            color: #667eea;
        }

        .btn-outline:hover {
            background: #667eea;
            color: white;
        }

        /* 头像预览 */
        .avatar-preview {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #667eea;
            margin-top: 10px;
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .user-card {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .content {
                padding: 20px;
            }

            .header {
                padding: 20px;
            }

            .button-group {
                flex-direction: column;
                align-items: center;
            }

            .btn {
                width: 100%;
                max-width: 300px;
            }
        }

        /* 动画效果 */
        .fade-in {
            animation: fadeIn 0.5s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* 隐藏查看模式下的输入框 */
        .view-mode input,
        .view-mode textarea,
        .view-mode select {
            display: none;
        }

        .edit-mode .field-value {
            display: none;
        }

        /* 只读字段样式 */
        input[readonly] {
            background-color: #f8f9fa;
            color: #6c757d;
            cursor: not-allowed;
        }
    </style>
</head>
<body>
<div class="container fade-in">
    <div class="header">
        <h2>用户详情管理</h2>
        <div class="mode-indicator" id="modeIndicator">查看模式</div>
    </div>

    <div class="content" id="contentArea">
        <form method="post" action="${pageContext.request.contextPath}/admin/updateUser" id="userForm">
            <div class="user-card">
                <!-- ID字段 -->
                <div class="field-group">
                    <div class="field-label">用户ID</div>
                    <div class="field-value" id="id-display">${empty user.id ? 'U001' : user.id}</div>
                    <input type="text" name="id" value="${empty user.id ? 'U001' : user.id}" readonly id="id-input">
                </div>

                <!-- 邮箱字段 -->
                <div class="field-group">
                    <div class="field-label">邮箱地址</div>
                    <div class="field-value" id="email-display">${empty user.email ? 'user@example.com' : user.email}</div>
                    <input type="email" name="email" value="${empty user.email ? 'user@example.com' : user.email}" required id="email-input">
                </div>

                <!-- 昵称字段 -->
                <div class="field-group">
                    <div class="field-label">用户昵称</div>
                    <div class="field-value" id="nickname-display">${empty user.nickname ? '张三' : user.nickname}</div>
                    <input type="text" name="nickname" value="${empty user.nickname ? '张三' : user.nickname}" id="nickname-input">
                </div>

                <!-- 角色字段 -->
                <div class="field-group">
                    <div class="field-label">用户角色</div>
                    <div class="field-value" id="role-display">${empty user.role ? '普通用户' : user.role}</div>
                    <input type="text" name="role" value="${empty user.role ? '普通用户' : user.role}" id="role-input">
                </div>

                <!-- 性别字段 -->
                <div class="field-group">
                    <div class="field-label">性别</div>
                    <div class="field-value" id="gender-display">${empty user.gender ? '保密' : user.gender}</div>
                    <select name="gender" id="gender-input">
                        <option value="男" ${user.gender == '男' ? 'selected' : ''}>男</option>
                        <option value="女" ${user.gender == '女' ? 'selected' : ''}>女</option>
                        <option value="保密" ${user.gender == '保密' || empty user.gender ? 'selected' : ''}>保密</option>
                    </select>
                </div>

                <!-- 年龄字段 -->
                <div class="field-group">
                    <div class="field-label">年龄</div>
                    <div class="field-value" id="age-display">${empty user.age ? '25' : user.age}</div>
                    <input type="number" name="age" value="${empty user.age ? '25' : user.age}" min="1" max="150" id="age-input">
                </div>

                <!-- 地址字段 -->
                <div class="field-group full-width">
                    <div class="field-label">联系地址</div>
                    <div class="field-value" id="address-display">${empty user.address ? '北京市朝阳区' : user.address}</div>
                    <input type="text" name="address" value="${empty user.address ? '北京市朝阳区' : user.address}" id="address-input">
                </div>

                <!-- 头像字段 -->
                <div class="field-group full-width">
                    <div class="field-label">头像链接</div>
                    <div class="field-value" id="avatar-display">
                        ${empty user.avatar ? 'https://via.placeholder.com/60' : user.avatar}
                        <img src="${empty user.avatar ? 'https://via.placeholder.com/60' : user.avatar}" alt="头像预览" class="avatar-preview" id="avatarPreview">
                    </div>
                    <input type="url" name="avatar" value="${empty user.avatar ? 'https://via.placeholder.com/60' : user.avatar}" id="avatar-input" oninput="updateAvatarPreview()">
                </div>

                <!-- 个性签名字段 -->
                <div class="field-group full-width">
                    <div class="field-label">个性签名</div>
                    <div class="field-value" id="bio-display">${empty user.bio ? '这个人很懒，什么都没有留下' : user.bio}</div>
                    <textarea name="bio" id="bio-input" placeholder="输入个性签名...">${empty user.bio ? '这个人很懒，什么都没有留下' : user.bio}</textarea>
                </div>

                <!-- 个人简介字段 -->
                <div class="field-group full-width">
                    <div class="field-label">个人简介</div>
                    <div class="field-value" id="intro-display">${empty user.intro ? '暂无个人简介' : user.intro}</div>
                    <textarea name="intro" id="intro-input" placeholder="输入个人简介..." rows="4">${empty user.intro ? '暂无个人简介' : user.intro}</textarea>
                </div>

            </div>

            <div class="button-group">
                <!-- 查看模式按钮 -->
                <div id="viewModeButtons">
                    <button type="button" class="btn btn-primary" onclick="toggleEditMode()">
                        ✏️ 切换编辑模式
                    </button>
                    <a class="btn btn-secondary" href="${pageContext.request.contextPath}/admin/getAllUser">
                        🏠 返回主页
                    </a>
                </div>

                <!-- 编辑模式按钮 -->
                <div id="editModeButtons" style="display: none;">
                    <button type="submit" class="btn btn-success">
                        💾 保存修改
                    </button>
                    <button type="button" class="btn btn-outline" onclick="toggleEditMode()">
                        👁️ 切换查看模式
                    </button>
                    <button type="button" class="btn btn-danger" onclick="confirmDelete()">
                        🗑️ 删除用户
                    </button>
                    <a class="btn btn-secondary" href="${pageContext.request.contextPath}/admin/getAllUser">
                        🏠 返回主页
                    </a>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
    let isEditMode = false;

    function toggleEditMode() {
        isEditMode = !isEditMode;
        const contentArea = document.getElementById('contentArea');
        const modeIndicator = document.getElementById('modeIndicator');
        const viewModeButtons = document.getElementById('viewModeButtons');
        const editModeButtons = document.getElementById('editModeButtons');

        if (isEditMode) {
            contentArea.classList.remove('view-mode');
            contentArea.classList.add('edit-mode');
            modeIndicator.textContent = '编辑模式';
            modeIndicator.style.background = 'rgba(40, 167, 69, 0.8)';
            viewModeButtons.style.display = 'none';
            editModeButtons.style.display = 'flex';
        } else {
            contentArea.classList.remove('edit-mode');
            contentArea.classList.add('view-mode');
            modeIndicator.textContent = '查看模式';
            modeIndicator.style.background = 'rgba(255, 255, 255, 0.2)';
            viewModeButtons.style.display = 'flex';
            editModeButtons.style.display = 'none';
        }
    }

    function updateAvatarPreview() {
        const avatarInput = document.getElementById('avatar-input');
        const avatarPreview = document.getElementById('avatarPreview');
        const newUrl = avatarInput.value;

        if (newUrl) {
            avatarPreview.src = newUrl;
            avatarPreview.onerror = function() {
                this.src = 'https://via.placeholder.com/60';
            };
        }
    }

    function confirmDelete() {
        if (confirm('确定要删除这个用户吗？此操作不可撤销！')) {
            const userId = document.querySelector('input[name="id"]').value;
            window.location.href = `\${pageContext.request.contextPath}/admin/deleteUser?id=\${userId}`;
        }
    }

    // 初始化为查看模式
    document.addEventListener('DOMContentLoaded', function() {
        toggleEditMode(); // 先进入编辑模式
        toggleEditMode(); // 再切换回查看模式，确保正确初始化
    });

    // 表单提交前确认
    document.getElementById('userForm').addEventListener('submit', function(e) {
        if (!confirm('确定要保存这些修改吗？')) {
            e.preventDefault();
        }
    });
</script>
</body>
</html>
