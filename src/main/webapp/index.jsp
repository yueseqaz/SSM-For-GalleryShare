<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PicShare - 图片分享系统</title>
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
        }
    </style>
</head>
<body class="font-inter bg-light text-dark antialiased">
<!-- 导航栏 -->
<header class="fixed top-0 left-0 right-0 bg-white/90 backdrop-blur-sm z-50 transition-all duration-300 shadow-sm" id="navbar">
    <div class="container mx-auto px-4 py-3 flex items-center justify-between">
        <div class="flex items-center space-x-2">
            <i class="fa fa-camera-retro text-primary text-2xl"></i>
            <span class="text-xl font-bold text-primary">PicShare</span>
        </div>

        <nav class="hidden md:flex items-center space-x-8">
            <a href="#features" class="text-dark/80 hover:text-primary transition-colors">功能</a>
            <a href="#showcase" class="text-dark/80 hover:text-primary transition-colors">展示</a>
            <a href="#stats" class="text-dark/80 hover:text-primary transition-colors">数据</a>
            <a href="#faq" class="text-dark/80 hover:text-primary transition-colors">常见问题</a>
        </nav>

        <div class="flex items-center space-x-4">
            <a href="${pageContext.request.contextPath}/login" class="px-4 py-2 text-primary hover:text-primary/80 transition-colors">登录</a>
            <a href="${pageContext.request.contextPath}/register" class="px-4 py-2 bg-primary hover:bg-primary/90 text-white rounded-lg shadow-md hover:shadow-lg transition-custom">注册</a>
            <button class="md:hidden text-dark" id="menu-toggle">
                <i class="fa fa-bars text-xl"></i>
            </button>
        </div>
    </div>

    <!-- 移动端菜单 -->
    <div class="md:hidden hidden bg-white shadow-lg absolute w-full" id="mobile-menu">
        <div class="container mx-auto px-4 py-3 flex flex-col space-y-3">
            <a href="#features" class="text-dark/80 hover:text-primary py-2 transition-colors">功能</a>
            <a href="#showcase" class="text-dark/80 hover:text-primary py-2 transition-colors">展示</a>
            <a href="#stats" class="text-dark/80 hover:text-primary py-2 transition-colors">数据</a>
            <a href="#faq" class="text-dark/80 hover:text-primary py-2 transition-colors">常见问题</a>
        </div>
    </div>
</header>

<!-- 英雄区域 -->
<section class="pt-32 pb-20 bg-gradient-to-br from-primary/5 to-light relative overflow-hidden">
    <div class="container mx-auto px-4 relative z-10">
        <div class="grid md:grid-cols-2 gap-12 items-center">
            <div class="max-w-lg">
                <h1 class="text-[clamp(2.5rem,5vw,4rem)] font-bold leading-tight text-dark mb-6">
                    分享你的<span class="text-primary">精彩瞬间</span>
                </h1>
                <p class="text-dark/70 text-lg mb-8">
                    PicShare 是一个现代化的图片分享平台，让你可以轻松上传、管理和分享你的精彩照片。支持瀑布流展示、图片收藏和下载，保护你的隐私同时展示你的创意。
                </p>
                <div class="flex flex-wrap gap-4">
                    <a href="${pageContext.request.contextPath}/register" class="px-8 py-3 bg-primary hover:bg-primary/90 text-white rounded-lg shadow-lg hover:shadow-xl transition-custom font-medium">
                        开始使用 <i class="fa fa-arrow-right ml-2"></i>
                    </a>
                    <a href="#features" class="px-8 py-3 bg-white hover:bg-gray-50 text-primary border border-primary/20 rounded-lg shadow-md hover:shadow-lg transition-custom font-medium">
                        了解更多 <i class="fa fa-angle-down ml-2"></i>
                    </a>
                </div>
            </div>
            <div class="relative">
                <div class="absolute -inset-4 bg-primary/10 rounded-2xl blur-xl opacity-70"></div>
                <img src="https://picsum.photos/id/26/600/400" alt="图片分享展示" class="rounded-xl shadow-2xl relative z-10 hover-scale">
                <div class="absolute -bottom-6 -left-6 bg-white p-4 rounded-lg shadow-lg z-20 hover-scale">
                    <div class="flex items-center space-x-3">
                        <div class="w-12 h-12 rounded-full overflow-hidden">
                            <img src="https://picsum.photos/id/64/100/100" alt="用户头像" class="w-full h-full object-cover">
                        </div>
                        <div>
                            <p class="font-medium">张小明</p>
                            <p class="text-sm text-dark/60">刚刚上传了12张照片</p>
                        </div>
                    </div>
                </div>
                <div class="absolute -top-6 -right-6 bg-white p-4 rounded-lg shadow-lg z-20 hover-scale">
                    <div class="flex items-center space-x-3">
                        <div class="bg-green-100 p-2 rounded-full">
                            <i class="fa fa-check text-green-600"></i>
                        </div>
                        <div>
                            <p class="font-medium">已保存</p>
                            <p class="text-sm text-dark/60">你的照片已安全存储</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 装饰元素 -->
    <div class="absolute top-1/4 -right-16 w-64 h-64 bg-primary/10 rounded-full blur-3xl"></div>
    <div class="absolute bottom-1/4 -left-16 w-80 h-80 bg-secondary/10 rounded-full blur-3xl"></div>
</section>

<!-- 功能特性 -->
<section id="features" class="py-20 bg-white">
    <div class="container mx-auto px-4">
        <div class="text-center max-w-3xl mx-auto mb-16">
            <h2 class="text-[clamp(1.8rem,4vw,2.5rem)] font-bold text-dark mb-4">强大功能，简单操作</h2>
            <p class="text-dark/70 text-lg">PicShare 提供丰富的功能，满足你所有的图片分享需求</p>
        </div>

        <div class="grid md:grid-cols-3 gap-8">
            <!-- 功能卡片 1 -->
            <div class="bg-white rounded-xl p-8 shadow-md hover:shadow-xl transition-custom card-shadow">
                <div class="w-14 h-14 bg-primary/10 rounded-lg flex items-center justify-center mb-6">
                    <i class="fa fa-cloud-upload text-primary text-2xl"></i>
                </div>
                <h3 class="text-xl font-bold mb-3">图片上传与管理</h3>
                <p class="text-dark/70 mb-4">轻松上传、编辑和组织你的图片，创建相册分类，让你的图片井井有条。</p>
                <a href="#" class="text-primary font-medium hover:underline flex items-center">
                    了解更多 <i class="fa fa-long-arrow-right ml-2"></i>
                </a>
            </div>

            <!-- 功能卡片 2 -->
            <div class="bg-white rounded-xl p-8 shadow-md hover:shadow-xl transition-custom card-shadow">
                <div class="w-14 h-14 bg-primary/10 rounded-lg flex items-center justify-center mb-6">
                    <i class="fa fa-th text-primary text-2xl"></i>
                </div>
                <h3 class="text-xl font-bold mb-3">瀑布流展示</h3>
                <p class="text-dark/70 mb-4">采用优雅的瀑布流布局，让你的图片以最美的方式展示，浏览体验更加流畅。</p>
                <a href="#" class="text-primary font-medium hover:underline flex items-center">
                    了解更多 <i class="fa fa-long-arrow-right ml-2"></i>
                </a>
            </div>

            <!-- 功能卡片 3 -->
            <div class="bg-white rounded-xl p-8 shadow-md hover:shadow-xl transition-custom card-shadow">
                <div class="w-14 h-14 bg-primary/10 rounded-lg flex items-center justify-center mb-6">
                    <i class="fa fa-heart text-primary text-2xl"></i>
                </div>
                <h3 class="text-xl font-bold mb-3">图片收藏</h3>
                <p class="text-dark/70 mb-4">发现喜欢的图片可以一键收藏，创建自己的灵感库，随时查看喜爱的内容。</p>
                <a href="#" class="text-primary font-medium hover:underline flex items-center">
                    了解更多 <i class="fa fa-long-arrow-right ml-2"></i>
                </a>
            </div>

            <!-- 功能卡片 4 -->
            <div class="bg-white rounded-xl p-8 shadow-md hover:shadow-xl transition-custom card-shadow">
                <div class="w-14 h-14 bg-primary/10 rounded-lg flex items-center justify-center mb-6">
                    <i class="fa fa-download text-primary text-2xl"></i>
                </div>
                <h3 class="text-xl font-bold mb-3">高清下载</h3>
                <p class="text-dark/70 mb-4">支持多种格式和分辨率的图片下载，保存你喜爱的内容到本地设备。</p>
                <a href="#" class="text-primary font-medium hover:underline flex items-center">
                    了解更多 <i class="fa fa-long-arrow-right ml-2"></i>
                </a>
            </div>

            <!-- 功能卡片 5 -->
            <div class="bg-white rounded-xl p-8 shadow-md hover:shadow-xl transition-custom card-shadow">
                <div class="w-14 h-14 bg-primary/10 rounded-lg flex items-center justify-center mb-6">
                    <i class="fa fa-lock text-primary text-2xl"></i>
                </div>
                <h3 class="text-xl font-bold mb-3">隐私保护</h3>
                <p class="text-dark/70 mb-4">支持设置图片为公开或私有，保护你的个人照片不被未授权访问。</p>
                <a href="#" class="text-primary font-medium hover:underline flex items-center">
                    了解更多 <i class="fa fa-long-arrow-right ml-2"></i>
                </a>
            </div>

            <!-- 功能卡片 6 -->
            <div class="bg-white rounded-xl p-8 shadow-md hover:shadow-xl transition-custom card-shadow">
                <div class="w-14 h-14 bg-primary/10 rounded-lg flex items-center justify-center mb-6">
                    <i class="fa fa-cog text-primary text-2xl"></i>
                </div>
                <h3 class="text-xl font-bold mb-3">专业管理</h3>
                <p class="text-dark/70 mb-4">管理员可以对用户和图片进行全面管理，确保平台内容健康有序。</p>
                <a href="#" class="text-primary font-medium hover:underline flex items-center">
                    了解更多 <i class="fa fa-long-arrow-right ml-2"></i>
                </a>
            </div>
        </div>
    </div>
</section>

<!-- 图片展示 -->
<section id="showcase" class="py-20 bg-gray-50">
    <div class="container mx-auto px-4">
        <div class="text-center max-w-3xl mx-auto mb-16">
            <h2 class="text-[clamp(1.8rem,4vw,2.5rem)] font-bold text-dark mb-4">精彩内容展示</h2>
            <p class="text-dark/70 text-lg">探索社区中最受欢迎的图片作品</p>
        </div>

        <!-- 瀑布流布局示例 -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <div class="space-y-6">
                <div class="bg-white rounded-xl overflow-hidden shadow-md hover:shadow-xl transition-custom hover-scale">
                    <img src="https://picsum.photos/id/29/600/800" alt="风景摄影作品" class="w-full h-auto">
                    <div class="p-4">
                        <div class="flex justify-between items-center mb-2">
                            <h4 class="font-medium">山间云雾</h4>
                            <div class="flex items-center">
                                <i class="fa fa-heart text-red-500 mr-1"></i>
                                <span class="text-sm">245</span>
                            </div>
                        </div>
                        <p class="text-sm text-dark/60">拍摄于黄山云海</p>
                    </div>
                </div>

                <div class="bg-white rounded-xl overflow-hidden shadow-md hover:shadow-xl transition-custom hover-scale">
                    <img src="https://picsum.photos/id/42/600/400" alt="城市建筑摄影" class="w-full h-auto">
                    <div class="p-4">
                        <div class="flex justify-between items-center mb-2">
                            <h4 class="font-medium">都市天际线</h4>
                            <div class="flex items-center">
                                <i class="fa fa-heart text-red-500 mr-1"></i>
                                <span class="text-sm">189</span>
                            </div>
                        </div>
                        <p class="text-sm text-dark/60">上海陆家嘴夜景</p>
                    </div>
                </div>
            </div>

            <div class="space-y-6">
                <div class="bg-white rounded-xl overflow-hidden shadow-md hover:shadow-xl transition-custom hover-scale">
                    <img src="https://picsum.photos/id/65/600/600" alt="人像摄影" class="w-full h-auto">
                    <div class="p-4">
                        <div class="flex justify-between items-center mb-2">
                            <h4 class="font-medium">秋日肖像</h4>
                            <div class="flex items-center">
                                <i class="fa fa-heart text-red-500 mr-1"></i>
                                <span class="text-sm">312</span>
                            </div>
                        </div>
                        <p class="text-sm text-dark/60">模特：李婷婷</p>
                    </div>
                </div>

                <div class="bg-white rounded-xl overflow-hidden shadow-md hover:shadow-xl transition-custom hover-scale">
                    <img src="https://picsum.photos/id/87/600/900" alt="自然风光" class="w-full h-auto">
                    <div class="p-4">
                        <div class="flex justify-between items-center mb-2">
                            <h4 class="font-medium">宁静湖泊</h4>
                            <div class="flex items-center">
                                <i class="fa fa-heart text-red-500 mr-1"></i>
                                <span class="text-sm">176</span>
                            </div>
                        </div>
                        <p class="text-sm text-dark/60">瑞士阿尔卑斯山区</p>
                    </div>
                </div>
            </div>

            <div class="space-y-6">
                <div class="bg-white rounded-xl overflow-hidden shadow-md hover:shadow-xl transition-custom hover-scale">
                    <img src="https://picsum.photos/id/96/600/500" alt="美食摄影" class="w-full h-auto">
                    <div class="p-4">
                        <div class="flex justify-between items-center mb-2">
                            <h4 class="font-medium">法式甜点</h4>
                            <div class="flex items-center">
                                <i class="fa fa-heart text-red-500 mr-1"></i>
                                <span class="text-sm">208</span>
                            </div>
                        </div>
                        <p class="text-sm text-dark/60">巴黎米其林餐厅</p>
                    </div>
                </div>

                <div class="bg-white rounded-xl overflow-hidden shadow-md hover:shadow-xl transition-custom hover-scale">
                    <img src="https://picsum.photos/id/106/600/700" alt="动物摄影" class="w-full h-auto">
                    <div class="p-4">
                        <div class="flex justify-between items-center mb-2">
                            <h4 class="font-medium">丛林之王</h4>
                            <div class="flex items-center">
                                <i class="fa fa-heart text-red-500 mr-1"></i>
                                <span class="text-sm">267</span>
                            </div>
                        </div>
                        <p class="text-sm text-dark/60">肯尼亚野生动物保护区</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="text-center mt-12">
            <a href="${pageContext.request.contextPath}/login" class="inline-block px-8 py-3 bg-primary hover:bg-primary/90 text-white rounded-lg shadow-lg hover:shadow-xl transition-custom font-medium">
                浏览更多作品 <i class="fa fa-compass ml-2"></i>
            </a>
        </div>
    </div>
</section>

<!-- 统计数据 -->
<section id="stats" class="py-20 bg-white">
    <div class="container mx-auto px-4">
        <div class="text-center max-w-3xl mx-auto mb-16">
            <h2 class="text-[clamp(1.8rem,4vw,2.5rem)] font-bold text-dark mb-4">平台数据</h2>
            <p class="text-dark/70 text-lg">加入我们不断成长的社区</p>
        </div>

        <div class="grid grid-cols-2 md:grid-cols-4 gap-8">
            <div class="bg-white p-8 rounded-xl shadow-md hover:shadow-xl transition-custom text-center">
                <div class="text-primary text-4xl font-bold mb-2 counter" data-target="1500000">0</div>
                <p class="text-dark/70">活跃用户</p>
            </div>

            <div class="bg-white p-8 rounded-xl shadow-md hover:shadow-xl transition-custom text-center">
                <div class="text-primary text-4xl font-bold mb-2 counter" data-target="3200000">0</div>
                <p class="text-dark/70">上传图片</p>
            </div>

            <div class="bg-white p-8 rounded-xl shadow-md hover:shadow-xl transition-custom text-center">
                <div class="text-primary text-4xl font-bold mb-2 counter" data-target="8500000">0</div>
                <p class="text-dark/70">每日访问量</p>
            </div>

            <div class="bg-white p-8 rounded-xl shadow-md hover:shadow-xl transition-custom text-center">
                <div class="text-primary text-4xl font-bold mb-2 counter" data-target="98">0</div>
                <p class="text-dark/70">满意度(%)</p>
            </div>
        </div>
    </div>
</section>

<!-- 常见问题 -->
<section id="faq" class="py-20 bg-gray-50">
    <div class="container mx-auto px-4">
        <div class="text-center max-w-3xl mx-auto mb-16">
            <h2 class="text-[clamp(1.8rem,4vw,2.5rem)] font-bold text-dark mb-4">常见问题</h2>
            <p class="text-dark/70 text-lg">解答你可能有的疑问</p>
        </div>

        <div class="max-w-3xl mx-auto">
            <div class="space-y-4">
                <!-- FAQ 项目 1 -->
                <div class="bg-white rounded-xl shadow-md overflow-hidden">
                    <button class="faq-toggle w-full px-6 py-4 text-left font-medium flex justify-between items-center focus:outline-none">
                        <span>如何注册 PicShare 账号？</span>
                        <i class="fa fa-chevron-down text-primary transition-transform duration-300"></i>
                    </button>
                    <div class="faq-content px-6 pb-4 hidden">
                        <p class="text-dark/70">点击页面右上角的"注册"按钮，填写你的邮箱地址、用户名和密码，然后点击"创建账号"即可完成注册。注册后你可以完善个人信息并开始上传图片。</p>
                    </div>
                </div>

                <!-- FAQ 项目 2 -->
                <div class="bg-white rounded-xl shadow-md overflow-hidden">
                    <button class="faq-toggle w-full px-6 py-4 text-left font-medium flex justify-between items-center focus:outline-none">
                        <span>如何设置图片的隐私权限？</span>
                        <i class="fa fa-chevron-down text-primary transition-transform duration-300"></i>
                    </button>
                    <div class="faq-content px-6 pb-4 hidden">
                        <p class="text-dark/70">在上传图片时，你可以在上传表单中选择图片的隐私设置。你可以选择"公开"让所有用户都能看到你的图片，或选择"私有"只有你自己可以查看。对于已上传的图片，你可以在图片管理页面修改其隐私设置。</p>
                    </div>
                </div>

                <!-- FAQ 项目 3 -->
                <div class="bg-white rounded-xl shadow-md overflow-hidden">
                    <button class="faq-toggle w-full px-6 py-4 text-left font-medium flex justify-between items-center focus:outline-none">
                        <span>图片的最大上传大小是多少？</span>
                        <i class="fa fa-chevron-down text-primary transition-transform duration-300"></i>
                    </button>
                    <div class="faq-content px-6 pb-4 hidden">
                        <p class="text-dark/70">免费用户的单张图片最大上传大小为10MB，付费会员用户可以上传最大50MB的图片。我们建议上传高质量的原始图片，系统会自动生成不同尺寸的缩略图以优化加载速度。</p>
                    </div>
                </div>

                <!-- FAQ 项目 4 -->
                <div class="bg-white rounded-xl shadow-md overflow-hidden">
                    <button class="faq-toggle w-full px-6 py-4 text-left font-medium flex justify-between items-center focus:outline-none">
                        <span>如何联系管理员？</span>
                        <i class="fa fa-chevron-down text-primary transition-transform duration-300"></i>
                    </button>
                    <div class="faq-content px-6 pb-4 hidden">
                        <p class="text-dark/70">你可以在"关于我们"页面找到管理员联系方式，或在APP内使用"反馈与支持"功能提交问题。我们的客服团队会在24小时内回复你的咨询。</p>
                    </div>
                </div>

                <!-- FAQ 项目 5 -->
                <div class="bg-white rounded-xl shadow-md overflow-hidden">
                    <button class="faq-toggle w-full px-6 py-4 text-left font-medium flex justify-between items-center focus:outline-none">
                        <span>平台支持哪些图片格式？</span>
                        <i class="fa fa-chevron-down text-primary transition-transform duration-300"></i>
                    </button>
                    <div class="faq-content px-6 pb-4 hidden">
                        <p class="text-dark/70">PicShare支持常见的图片格式，包括JPG、PNG、GIF、WEBP和BMP。我们建议使用JPG格式上传照片，以获得最佳的质量和文件大小平衡。</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- 行动号召 -->
<section class="py-20 bg-primary">
    <div class="container mx-auto px-4 text-center">
        <h2 class="text-[clamp(1.8rem,4vw,2.5rem)] font-bold text-white mb-6">准备好开始分享你的精彩瞬间了吗？</h2>
        <p class="text-white/80 text-lg max-w-2xl mx-auto mb-10">加入PicShare社区，与世界分享你的视角，发现令人惊叹的创意作品</p>
        <div class="flex flex-wrap justify-center gap-4">
            <a href="${pageContext.request.contextPath}/register" class="px-8 py-3 bg-white hover:bg-gray-100 text-primary rounded-lg shadow-lg hover:shadow-xl transition-custom font-medium">
                免费注册 <i class="fa fa-user-plus ml-2"></i>
            </a>
            <a href="${pageContext.request.contextPath}/login" class="px-8 py-3 bg-transparent hover:bg-white/10 text-white border border-white/30 rounded-lg transition-custom font-medium">
                登录账号 <i class="fa fa-sign-in ml-2"></i>
            </a>
        </div>
    </div>
</section>

<!-- 页脚 -->
<footer class="bg-dark text-white/80 py-12">
    <div class="container mx-auto px-4">
        <div class="grid md:grid-cols-4 gap-8">
            <div>
                <div class="flex items-center space-x-2 mb-6">
                    <i class="fa fa-camera-retro text-primary text-2xl"></i>
                    <span class="text-xl font-bold text-white">PicShare</span>
                </div>
                <p class="mb-6">分享你的精彩瞬间，发现世界的美丽</p>
                <div class="flex space-x-4">
                    <a href="#" class="text-white/60 hover:text-primary transition-colors">
                        <i class="fa fa-facebook"></i>
                    </a>
                    <a href="#" class="text-white/60 hover:text-primary transition-colors">
                        <i class="fa fa-twitter"></i>
                    </a>
                    <a href="#" class="text-white/60 hover:text-primary transition-colors">
                        <i class="fa fa-instagram"></i>
                    </a>
                    <a href="#" class="text-white/60 hover:text-primary transition-colors">
                        <i class="fa fa-pinterest"></i>
                    </a>
                </div>
            </div>

            <div>
                <h4 class="text-white font-medium mb-6">功能</h4>
                <ul class="space-y-3">
                    <li><a href="#" class="hover:text-primary transition-colors">图片上传</a></li>
                    <li><a href="#" class="hover:text-primary transition-colors">图片管理</a></li>
                    <li><a href="#" class="hover:text-primary transition-colors">瀑布流浏览</a></li>
                    <li><a href="#" class="hover:text-primary transition-colors">图片收藏</a></li>
                    <li><a href="#" class="hover:text-primary transition-colors">隐私设置</a></li>
                </ul>
            </div>

            <div>
                <h4 class="text-white font-medium mb-6">支持</h4>
                <ul class="space-y-3">
                    <li><a href="#" class="hover:text-primary transition-colors">帮助中心</a></li>
                    <li><a href="#" class="hover:text-primary transition-colors">常见问题</a></li>
                    <li><a href="#" class="hover:text-primary transition-colors">联系我们</a></li>
                    <li><a href="#" class="hover:text-primary transition-colors">使用条款</a></li>
                    <li><a href="#" class="hover:text-primary transition-colors">隐私政策</a></li>
                </ul>
            </div>

            <div>
                <h4 class="text-white font-medium mb-6">订阅更新</h4>
                <p class="mb-4">获取最新功能和平台更新的通知</p>
                <form class="flex">
                    <input type="email" placeholder="你的邮箱地址" class="px-4 py-2 rounded-l-lg focus:outline-none focus:ring-2 focus:ring-primary flex-grow">
                    <button type="submit" class="bg-primary hover:bg-primary/90 text-white px-4 py-2 rounded-r-lg transition-colors">
                        <i class="fa fa-paper-plane"></i>
                    </button>
                </form>
            </div>
        </div>

        <div class="border-t border-white/10 mt-12 pt-8 text-center text-sm">
            <p>&copy; 2025 PicShare. 保留所有权利。</p>
        </div>
    </div>
</footer>

<script>
    // 导航栏滚动效果
    const navbar = document.getElementById('navbar');
    window.addEventListener('scroll', () => {
        if (window.scrollY > 50) {
            navbar.classList.add('py-2', 'shadow-md');
            navbar.classList.remove('py-3', 'shadow-sm');
        } else {
            navbar.classList.add('py-3', 'shadow-sm');
            navbar.classList.remove('py-2', 'shadow-md');
        }
    });

    // 移动端菜单切换
    const menuToggle = document.getElementById('menu-toggle');
    const mobileMenu = document.getElementById('mobile-menu');
    menuToggle.addEventListener('click', () => {
        mobileMenu.classList.toggle('hidden');
        const icon = menuToggle.querySelector('i');
        if (mobileMenu.classList.contains('hidden')) {
            icon.classList.remove('fa-times');
            icon.classList.add('fa-bars');
        } else {
            icon.classList.remove('fa-bars');
            icon.classList.add('fa-times');
        }
    });

    // FAQ 切换效果
    const faqToggles = document.querySelectorAll('.faq-toggle');
    faqToggles.forEach(toggle => {
        toggle.addEventListener('click', () => {
            const content = toggle.nextElementSibling;
            const icon = toggle.querySelector('i');

            // 关闭其他所有FAQ
            document.querySelectorAll('.faq-content').forEach(item => {
                if (item !== content) {
                    item.classList.add('hidden');
                    const otherIcon = item.previousElementSibling.querySelector('i');
                    otherIcon.classList.remove('rotate-180');
                }
            });

            // 切换当前FAQ
            content.classList.toggle('hidden');
            if (!content.classList.contains('hidden')) {
                icon.classList.add('rotate-180');
            } else {
                icon.classList.remove('rotate-180');
            }
        });
    });

    // 数字计数动画
    const counters = document.querySelectorAll('.counter');
    const speed = 200;

    const animateCounter = () => {
        counters.forEach(counter => {
            const target = +counter.getAttribute('data-target');
            const count = +counter.innerText;

            const increment = target / speed;

            if (count < target) {
                counter.innerText = Math.ceil(count + increment);
                setTimeout(animateCounter, 1);
            } else {
                counter.innerText = target.toLocaleString();
            }
        });
    };

    // 当元素进入视口时触发动画
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                animateCounter();
                observer.unobserve(entry.target);
            }
        });
    }, { threshold: 0.5 });

    if (counters.length > 0) {
        observer.observe(document.querySelector('#stats'));
    }

    // 平滑滚动
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();

            const targetId = this.getAttribute('href');
            if (targetId === '#') return;

            const targetElement = document.querySelector(targetId);
            if (targetElement) {
                window.scrollTo({
                    top: targetElement.offsetTop - 80,
                    behavior: 'smooth'
                });

                // 关闭移动菜单（如果打开）
                if (!mobileMenu.classList.contains('hidden')) {
                    mobileMenu.classList.add('hidden');
                    const icon = menuToggle.querySelector('i');
                    icon.classList.remove('fa-times');
                    icon.classList.add('fa-bars');
                }
            }
        });
    });
</script>
</body>
</html>
