<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PicShare - 图片分享系统</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* 导航栏 */
        .navbar {
            position: fixed;
            top: 0;
            width: 100%;
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            z-index: 1000;
            animation: slideDown 0.8s ease-out;
        }

        .logo {
            font-size: 1.8rem;
            font-weight: bold;
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .logo::before {
            content: "📸";
            font-size: 2rem;
            animation: bounce 2s infinite;
        }

        .nav-links {
            display: flex;
            gap: 1.5rem;
        }

        .nav-link {
            color: white;
            text-decoration: none;
            padding: 0.5rem 1.5rem;
            border-radius: 25px;
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(5px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .nav-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .nav-link:hover::before {
            left: 100%;
        }

        .nav-link:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        }

        /* 主要内容区 */
        .main-content {
            padding-top: 100px;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: white;
        }

        /* 英雄区域 */
        .hero {
            max-width: 800px;
            padding: 2rem;
            animation: fadeInUp 1s ease-out 0.3s both;
        }

        .hero h1 {
            font-size: 3.5rem;
            margin-bottom: 1rem;
            background: linear-gradient(45deg, #fff, #e0e0e0);
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: textGlow 3s ease-in-out infinite alternate;
        }

        .hero p {
            font-size: 1.3rem;
            margin-bottom: 3rem;
            opacity: 0.9;
            line-height: 1.6;
        }

        /* 按钮组 */
        .button-group {
            display: flex;
            gap: 2rem;
            justify-content: center;
            flex-wrap: wrap;
            margin-bottom: 4rem;
        }

        .btn {
            padding: 1rem 2.5rem;
            background: linear-gradient(45deg, #ff6b6b, #ff8e53);
            color: white;
            text-decoration: none;
            border-radius: 50px;
            font-weight: bold;
            font-size: 1.1rem;
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
            box-shadow: 0 8px 30px rgba(255, 107, 107, 0.3);
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(45deg, #ff8e53, #ff6b6b);
            transition: left 0.4s ease;
        }

        .btn:hover::before {
            left: 0;
        }

        .btn span {
            position: relative;
            z-index: 1;
        }

        .btn:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 15px 40px rgba(255, 107, 107, 0.4);
        }

        .btn.secondary {
            background: linear-gradient(45deg, #4ecdc4, #44a08d);
            box-shadow: 0 8px 30px rgba(78, 205, 196, 0.3);
        }

        .btn.secondary::before {
            background: linear-gradient(45deg, #44a08d, #4ecdc4);
        }

        .btn.secondary:hover {
            box-shadow: 0 15px 40px rgba(78, 205, 196, 0.4);
        }

        /* 特性展示 */
        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            max-width: 1000px;
            width: 100%;
            padding: 0 2rem;
            animation: fadeInUp 1s ease-out 0.6s both;
        }

        .feature-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 2rem;
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
        }

        .feature-card::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
            transform: scale(0);
            transition: transform 0.6s ease;
        }

        .feature-card:hover::before {
            transform: scale(1);
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
            background: rgba(255, 255, 255, 0.15);
        }

        .feature-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            display: block;
            animation: float 3s ease-in-out infinite;
        }

        .feature-card:nth-child(2) .feature-icon {
            animation-delay: -1s;
        }

        .feature-card:nth-child(3) .feature-icon {
            animation-delay: -2s;
        }

        .feature-card h3 {
            font-size: 1.3rem;
            margin-bottom: 1rem;
            position: relative;
            z-index: 1;
        }

        .feature-card p {
            opacity: 0.9;
            line-height: 1.5;
            position: relative;
            z-index: 1;
        }

        /* 浮动元素 */
        .floating-elements {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            overflow: hidden;
        }

        .floating-circle {
            position: absolute;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            animation: floatUpDown 6s ease-in-out infinite;
        }

        .floating-circle:nth-child(1) {
            width: 80px;
            height: 80px;
            top: 20%;
            left: 10%;
            animation-delay: 0s;
        }

        .floating-circle:nth-child(2) {
            width: 120px;
            height: 120px;
            top: 60%;
            right: 10%;
            animation-delay: -2s;
        }

        .floating-circle:nth-child(3) {
            width: 60px;
            height: 60px;
            top: 40%;
            left: 70%;
            animation-delay: -4s;
        }

        /* 动画效果 */
        @keyframes slideDown {
            from {
                transform: translateY(-100%);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        @keyframes fadeInUp {
            from {
                transform: translateY(30px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {
                transform: translateY(0);
            }
            40% {
                transform: translateY(-10px);
            }
            60% {
                transform: translateY(-5px);
            }
        }

        @keyframes float {
            0% {
                transform: translateY(0px);
            }
            50% {
                transform: translateY(-10px);
            }
            100% {
                transform: translateY(0px);
            }
        }

        @keyframes floatUpDown {
            0%, 100% {
                transform: translateY(0px);
            }
            50% {
                transform: translateY(-20px);
            }
        }

        @keyframes textGlow {
            from {
                text-shadow: 0 0 20px rgba(255, 255, 255, 0.5);
            }
            to {
                text-shadow: 0 0 30px rgba(255, 255, 255, 0.8);
            }
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .navbar {
                padding: 1rem;
            }

            .nav-links {
                gap: 1rem;
            }

            .nav-link {
                padding: 0.4rem 1rem;
                font-size: 0.9rem;
            }

            .hero h1 {
                font-size: 2.5rem;
            }

            .hero p {
                font-size: 1.1rem;
            }

            .button-group {
                gap: 1rem;
            }

            .btn {
                padding: 0.8rem 2rem;
                font-size: 1rem;
            }

            .features {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }
        }
    </style>
</head>
<body>
<!-- 浮动装饰元素 -->
<div class="floating-elements">
    <div class="floating-circle"></div>
    <div class="floating-circle"></div>
    <div class="floating-circle"></div>
</div>

<!-- 导航栏 -->
<nav class="navbar">
    <a href="#" class="logo">PicShare</a>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/login" class="nav-link">
            <span>登录</span>
        </a>
        <a href="${pageContext.request.contextPath}/register" class="nav-link">
            <span>注册</span>
        </a>
    </div>
</nav>

<!-- 主要内容 -->
<main class="main-content">
    <section class="hero">
        <h1>分享美好瞬间</h1>
        <p>
            创建属于你的相册，上传精彩照片，与世界分享你的视角。
            <br>
            在这里，每一张照片都有它的故事，每一个瞬间都值得被珍藏。
        </p>

        <div class="button-group">
            <a href="${pageContext.request.contextPath}/register" class="btn">
                <span>开始创作</span>
            </a>
            <a href="${pageContext.request.contextPath}/login" class="btn secondary">
                <span>立即登录</span>
            </a>
        </div>
    </section>

    <section class="features">
        <div class="feature-card">
            <span class="feature-icon">📷</span>
            <h3>创建相册</h3>
            <p>轻松创建个人相册，分类整理你的珍贵回忆，让每个主题都有专属空间。</p>
        </div>

        <div class="feature-card">
            <span class="feature-icon">🌟</span>
            <h3>公开分享</h3>
            <p>设置相册为公开模式，让更多人欣赏你的作品，获得点赞和收藏。</p>
        </div>

        <div class="feature-card">
            <span class="feature-icon">❤️</span>
            <h3>互动交流</h3>
            <p>为喜欢的照片点赞收藏，与摄影爱好者互动，发现更多精彩内容。</p>
        </div>
    </section>
</main>

<script>
    // 页面加载动画
    document.addEventListener('DOMContentLoaded', function() {
        // 添加页面加载完成的类
        document.body.classList.add('loaded');

        // 为按钮添加点击效果
        const buttons = document.querySelectorAll('.btn');
        buttons.forEach(button => {
            button.addEventListener('click', function(e) {
                // 创建点击波纹效果
                const ripple = document.createElement('span');
                const rect = this.getBoundingClientRect();
                const size = Math.max(rect.width, rect.height);
                const x = e.clientX - rect.left - size / 2;
                const y = e.clientY - rect.top - size / 2;

                ripple.style.cssText = `
                        position: absolute;
                        width: ${size}px;
                        height: ${size}px;
                        left: ${x}px;
                        top: ${y}px;
                        background: rgba(255, 255, 255, 0.3);
                        border-radius: 50%;
                        transform: scale(0);
                        animation: ripple 0.6s ease-out;
                        pointer-events: none;
                    `;

                this.appendChild(ripple);

                setTimeout(() => {
                    ripple.remove();
                }, 600);
            });
        });

        // 添加导航链接悬停效果
        const navLinks = document.querySelectorAll('.nav-link');
        navLinks.forEach(link => {
            link.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-2px) scale(1.05)';
            });

            link.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0) scale(1)';
            });
        });

        // 滚动视差效果
        window.addEventListener('scroll', function() {
            const scrolled = window.pageYOffset;
            const rate = scrolled * -0.5;

            const floatingElements = document.querySelectorAll('.floating-circle');
            floatingElements.forEach((element, index) => {
                const speed = 0.1 + (index * 0.05);
                element.style.transform = `translateY(${scrolled * speed}px)`;
            });
        });
    });

    // CSS 动画样式添加
    const style = document.createElement('style');
    style.textContent = `
            @keyframes ripple {
                to {
                    transform: scale(2);
                    opacity: 0;
                }
            }
        `;
    document.head.appendChild(style);
</script>
</body>
</html>
