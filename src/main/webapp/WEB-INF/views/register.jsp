<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8" />
    <title>用户注册 - PicShare</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#165DFF',
                        secondary: '#FF7D00',
                        dark: '#1D2939',
                        light: '#F9FAFB'
                    },
                    fontFamily: {
                        inter: ['Inter', 'system-ui', 'sans-serif'],
                    },
                }
            }
        }
    </script>
    <style type="text/tailwindcss">
        @layer utilities {
            .content-auto {
                content-visibility: auto;
            }
            .text-shadow {
                text-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            .transition-custom {
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            }
            .hover-scale {
                @apply hover:scale-105 transition-all duration-300;
            }
            .card-shadow {
                box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            }
            .form-input-focus {
                @apply focus:border-primary focus:ring-2 focus:ring-primary/20 focus:outline-none;
            }
            .email-suggestion {
                @apply px-4 py-2 text-primary hover:bg-primary/5 cursor-pointer transition-colors;
            }
        }
    </style>
</head>
<body class="font-inter bg-gradient-to-br from-primary/5 to-light min-h-screen flex items-center justify-center p-4">
<!-- 背景装饰 -->
<div class="absolute inset-0 overflow-hidden pointer-events-none">
    <div class="absolute top-0 right-0 w-96 h-96 bg-primary/10 rounded-full blur-3xl transform translate-x-1/2 -translate-y-1/2"></div>
    <div class="absolute bottom-0 left-0 w-96 h-96 bg-secondary/10 rounded-full blur-3xl transform -translate-x-1/2 translate-y-1/2"></div>
</div>

<div class="relative z-10 w-full max-w-md">
    <!-- 回到首页链接 -->
    <div class="text-center mb-8">
        <a href="${pageContext.request.contextPath}/" class="inline-flex items-center space-x-2 text-primary hover:text-primary/80 transition-colors">
            <i class="fa fa-arrow-left"></i>
            <span>回到首页</span>
        </a>
    </div>

    <!-- 注册卡片 -->
    <div class="bg-white rounded-2xl shadow-xl overflow-hidden card-shadow hover-scale">
        <!-- 卡片头部 -->
        <div class="bg-primary text-white p-6 text-center">
            <div class="flex items-center justify-center space-x-2 mb-2">
                <i class="fa fa-camera-retro text-2xl"></i>
                <h2 class="text-xl font-bold">PicShare</h2>
            </div>
            <p class="text-white/80">创建您的账户</p>
        </div>

        <!-- 注册表单 -->
        <div class="p-8">
            <form id="registerForm" action="${pageContext.request.contextPath}/register" method="post" onsubmit="return validateForm()">
                <!-- 邮箱输入 -->
                <div class="mb-6 relative">
                    <label for="email" class="block text-sm font-medium text-dark/70 mb-2">邮箱</label>
                    <input
                            type="text"
                            name="email"
                            id="email"
                            placeholder="请输入邮箱"
                            autocomplete="off"
                            spellcheck="false"
                            required
                            class="w-full px-4 py-3 rounded-lg border border-gray-300 form-input-focus transition-custom"
                    />
                    <div id="emailSuggestions" class="absolute top-full left-0 right-0 mt-1 bg-white rounded-lg shadow-lg z-10 hidden">
                        <!-- 邮箱建议将通过JS动态生成 -->
                    </div>
                </div>

                <!-- 密码输入 -->
                <div class="mb-6">
                    <label for="password" class="block text-sm font-medium text-dark/70 mb-2">密码</label>
                    <input
                            type="password"
                            name="password"
                            id="password"
                            placeholder="请输入密码"
                            required
                            class="w-full px-4 py-3 rounded-lg border border-gray-300 form-input-focus transition-custom"
                    />
                </div>

                <!-- 错误消息 -->
                <div class="mb-6">
                    <div class="text-red-500 text-sm text-center" id="errorMsg">
                        <c:if test="${not empty error}">
                            ${error}
                        </c:if>
                    </div>
                </div>

                <!-- 注册按钮 -->
                <button type="submit" class="w-full bg-primary hover:bg-primary/90 text-white py-3 rounded-lg font-medium transition-custom shadow-md hover:shadow-lg">
                    注册
                </button>
            </form>

            <!-- 已有账号链接 -->
            <div class="text-center mt-6">
                <a href="${pageContext.request.contextPath}/login" class="text-primary hover:text-primary/80 text-sm transition-colors">
                    已有账号？去登录
                </a>
            </div>
        </div>
    </div>

    <!-- 页脚 -->
    <div class="text-center text-dark/60 text-sm mt-8">
        <p>© 2025 PicShare. 保留所有权利。</p>
    </div>
</div>

<script>
    const emailInput = document.getElementById('email');
    const suggestionsBox = document.getElementById('emailSuggestions');
    const suffixes = ['@qq.com', '@163.com', '@gmail.com', '@outlook.com', '@icloud.com'];
    const errorMsg = document.getElementById('errorMsg');

    emailInput.addEventListener('input', () => {
        const val = emailInput.value.trim();
        const atIndex = val.indexOf('@');

        // 如果没输入 @ 并且有内容，显示补全
        if (val && atIndex === -1) {
            suggestionsBox.innerHTML = '';
            suffixes.forEach(suffix => {
                const div = document.createElement('div');
                div.textContent = val + suffix;
                div.className = 'email-suggestion';
                div.onclick = () => {
                    emailInput.value = div.textContent;
                    suggestionsBox.style.display = 'none';
                };
                suggestionsBox.appendChild(div);
            });
            suggestionsBox.style.display = 'block';
        } else {
            suggestionsBox.style.display = 'none';
        }
    });

    // 点击外部隐藏建议列表
    document.addEventListener('click', (e) => {
        if (e.target !== emailInput) {
            suggestionsBox.style.display = 'none';
        }
    });

    function validateEmail(email) {
        // 简单邮箱正则
        const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return re.test(email);
    }

    function validateForm() {
        errorMsg.textContent = '';
        const email = emailInput.value.trim();
        const password = document.getElementById('password').value.trim();

        if (!email) {
            errorMsg.textContent = '邮箱不能为空！';
            return false;
        }
        if (!validateEmail(email)) {
            errorMsg.textContent = '请输入有效的邮箱地址！';
            return false;
        }
        if (!password) {
            errorMsg.textContent = '密码不能为空！';
            return false;
        }
        if (/\s/.test(email) || /\s/.test(password)) {
            errorMsg.textContent = '邮箱和密码中不能包含空格！';
            return false;
        }

        return true;
    }
</script>
</body>
</html>
