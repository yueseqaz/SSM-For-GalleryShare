<%--
  Created by IntelliJ IDEA.
  User: sakura
  Date: 2025/6/25
  Time: 20:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>创建图册</title>
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            width: 100vw;
            overflow-x: hidden;
        }

        .container {
            width: 100vw;
            min-height: 100vh;
            background: white;
            display: flex;
            flex-direction: column;
        }

        .header {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            text-align: center;
            padding: 30px;
            width: 100%;
        }

        .header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
        }

        .form-container {
            flex: 1;
            padding: 40px;
            max-width: 1200px;
            margin: 0 auto;
            width: 100%;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
            font-size: 1.1em;
        }

        .form-control {
            width: 100%;
            padding: 15px;
            border: 2px solid #e1e8ed;
            border-radius: 10px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        .form-control:focus {
            outline: none;
            border-color: #4facfe;
            background: white;
            box-shadow: 0 0 0 3px rgba(79, 172, 254, 0.1);
        }

        textarea.form-control {
            resize: vertical;
            min-height: 100px;
        }

        /* 优化后的标签选择样式 */
        .tags-container {
            border: 2px solid #e1e8ed;
            border-radius: 10px;
            padding: 15px;
            background: #f8f9fa;
            transition: all 0.3s ease;
            max-height: 200px;
            overflow-y: auto;
        }

        .tags-container:focus-within {
            border-color: #4facfe;
            background: white;
            box-shadow: 0 0 0 3px rgba(79, 172, 254, 0.1);
        }

        .tags-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(80px, 1fr));
            gap: 8px;
        }

        .tag-item {
            position: relative;
        }

        .tag-checkbox {
            display: none;
        }

        .tag-label {
            display: block;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 20px;
            text-align: center;
            cursor: pointer;
            transition: all 0.2s ease;
            font-size: 14px;
            background: white;
            color: #666;
        }

        .tag-label:hover {
            border-color: #4facfe;
            background: #f0f8ff;
            color: #4facfe;
        }

        .tag-checkbox:checked + .tag-label {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            border-color: #4facfe;
            color: white;
            transform: scale(0.95);
        }

        .selected-tags {
            margin-top: 10px;
            font-size: 14px;
            color: #666;
        }

        .selected-count {
            background: #4facfe;
            color: white;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: bold;
            margin-right: 10px;
        }

        .status-group {
            display: flex;
            gap: 20px;
            margin-top: 10px;
        }

        .radio-option {
            display: flex;
            align-items: center;
            padding: 12px 20px;
            border: 2px solid #e1e8ed;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s ease;
            flex: 1;
            justify-content: center;
        }

        .radio-option input[type="radio"] {
            margin-right: 8px;
        }

        .upload-area {
            border: 3px dashed #d1d9e0;
            border-radius: 15px;
            padding: 40px 20px;
            text-align: center;
            background: #f8f9fa;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .upload-area:hover {
            border-color: #4facfe;
            background: #f0f8ff;
        }

        .upload-text h3 {
            color: #333;
            margin-bottom: 10px;
        }

        .upload-text p {
            color: #666;
            margin-bottom: 15px;
        }

        .file-input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .preview-container {
            margin-top: 20px;
            display: none;
        }

        .preview-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            gap: 15px;
            margin-top: 15px;
        }

        .preview-item {
            position: relative;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: transform 0.2s ease;
        }

        .preview-item:hover {
            transform: scale(1.02);
        }

        .preview-image {
            width: 100%;
            height: 150px;
            object-fit: cover;
            display: block;
        }

        .preview-remove {
            position: absolute;
            top: 8px;
            right: 8px;
            background: rgba(255, 0, 0, 0.8);
            color: white;
            border: none;
            border-radius: 50%;
            width: 28px;
            height: 28px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.3s ease, background-color 0.3s ease;
            backdrop-filter: blur(2px);
        }

        .preview-item:hover .preview-remove {
            opacity: 1;
        }

        .preview-remove:hover {
            background: rgba(255, 0, 0, 1);
            transform: scale(1.1);
        }

        .submit-btn {
            width: 100%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 18px;
            border-radius: 15px;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 30px;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
        }

        .file-count {
            background: #4facfe;
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: bold;
            display: inline-block;
            margin-bottom: 10px;
        }

        .cover-badge {
            position: absolute;
            bottom: 5px;
            left: 5px;
            background: rgba(79, 172, 254, 0.9);
            color: white;
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: bold;
        }

        .tags-container::-webkit-scrollbar {
            width: 6px;
        }

        .tags-container::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 3px;
        }

        .tags-container::-webkit-scrollbar-thumb {
            background: #c1c1c1;
            border-radius: 3px;
        }

        .tags-container::-webkit-scrollbar-thumb:hover {
            background: #4facfe;
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .form-container {
                padding: 20px;
            }

            .header h1 {
                font-size: 2em;
            }

            .tags-grid {
                grid-template-columns: repeat(auto-fit, minmax(60px, 1fr));
            }

            .status-group {
                flex-direction: column;
                gap: 10px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>创建图册</h1>
        <p>分享你的美好时光</p>
    </div>

    <div class="form-container">
        <form action="${pageContext.request.contextPath}/album/create"
              method="post"
              enctype="multipart/form-data">

            <div class="form-group">
                <label for="title">图册标题</label>
                <input type="text"
                       id="title"
                       name="title"
                       class="form-control"
                       placeholder="为你的图册起个好听的名字..."
                       required>
            </div>

            <div class="form-group">
                <label for="description">图册描述</label>
                <textarea id="description"
                          name="description"
                          class="form-control"
                          placeholder="描述一下这个图册的故事..."></textarea>
            </div>

            <div class="form-group">
                <label>选择标签</label>
                <div class="tags-container">
                    <div class="tags-grid">
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="风景" id="tag-风景" class="tag-checkbox">
                            <label for="tag-风景" class="tag-label">风景</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="旅行" id="tag-旅行" class="tag-checkbox">
                            <label for="tag-旅行" class="tag-label">旅行</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="美食" id="tag-美食" class="tag-checkbox">
                            <label for="tag-美食" class="tag-label">美食</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="日常" id="tag-日常" class="tag-checkbox">
                            <label for="tag-日常" class="tag-label">日常</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="艺术" id="tag-艺术" class="tag-checkbox">
                            <label for="tag-艺术" class="tag-label">艺术</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="摄影" id="tag-摄影" class="tag-checkbox">
                            <label for="tag-摄影" class="tag-label">摄影</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="萌宠" id="tag-萌宠" class="tag-checkbox">
                            <label for="tag-萌宠" class="tag-label">萌宠</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="建筑" id="tag-建筑" class="tag-checkbox">
                            <label for="tag-建筑" class="tag-label">建筑</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="人物" id="tag-人物" class="tag-checkbox">
                            <label for="tag-人物" class="tag-label">人物</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="自然" id="tag-自然" class="tag-checkbox">
                            <label for="tag-自然" class="tag-label">自然</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="夜景" id="tag-夜景" class="tag-checkbox">
                            <label for="tag-夜景" class="tag-label">夜景</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="文化" id="tag-文化" class="tag-checkbox">
                            <label for="tag-文化" class="tag-label">文化</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="运动" id="tag-运动" class="tag-checkbox">
                            <label for="tag-运动" class="tag-label">运动</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="音乐" id="tag-音乐" class="tag-checkbox">
                            <label for="tag-音乐" class="tag-label">音乐</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="节日" id="tag-节日" class="tag-checkbox">
                            <label for="tag-节日" class="tag-label">节日</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="科技" id="tag-科技" class="tag-checkbox">
                            <label for="tag-科技" class="tag-label">科技</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="时尚" id="tag-时尚" class="tag-checkbox">
                            <label for="tag-时尚" class="tag-label">时尚</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="教育" id="tag-教育" class="tag-checkbox">
                            <label for="tag-教育" class="tag-label">教育</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="美妆" id="tag-美妆" class="tag-checkbox">
                            <label for="tag-美妆" class="tag-label">美妆</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="书法" id="tag-书法" class="tag-checkbox">
                            <label for="tag-书法" class="tag-label">书法</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="电影" id="tag-电影" class="tag-checkbox">
                            <label for="tag-电影" class="tag-label">电影</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="手工" id="tag-手工" class="tag-checkbox">
                            <label for="tag-手工" class="tag-label">手工</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="咖啡" id="tag-咖啡" class="tag-checkbox">
                            <label for="tag-咖啡" class="tag-label">咖啡</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="游戏" id="tag-游戏" class="tag-checkbox">
                            <label for="tag-游戏" class="tag-label">游戏</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="动漫" id="tag-动漫" class="tag-checkbox">
                            <label for="tag-动漫" class="tag-label">动漫</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="美甲" id="tag-美甲" class="tag-checkbox">
                            <label for="tag-美甲" class="tag-label">美甲</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="宠物" id="tag-宠物" class="tag-checkbox">
                            <label for="tag-宠物" class="tag-label">宠物</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="植物" id="tag-植物" class="tag-checkbox">
                            <label for="tag-植物" class="tag-label">植物</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="心情" id="tag-心情" class="tag-checkbox">
                            <label for="tag-心情" class="tag-label">心情</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="校园" id="tag-校园" class="tag-checkbox">
                            <label for="tag-校园" class="tag-label">校园</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="婚礼" id="tag-婚礼" class="tag-checkbox">
                            <label for="tag-婚礼" class="tag-label">婚礼</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="派对" id="tag-派对" class="tag-checkbox">
                            <label for="tag-派对" class="tag-label">派对</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="手绘" id="tag-手绘" class="tag-checkbox">
                            <label for="tag-手绘" class="tag-label">手绘</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="风格" id="tag-风格" class="tag-checkbox">
                            <label for="tag-风格" class="tag-label">风格</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="写真" id="tag-写真" class="tag-checkbox">
                            <label for="tag-写真" class="tag-label">写真</label>
                        </div>
                        <div class="tag-item">
                            <input type="checkbox" name="tagsName" value="其他" id="tag-其他" class="tag-checkbox">
                            <label for="tag-其他" class="tag-label">其他</label>
                        </div>
                    </div>
                </div>
                <div class="selected-tags">
                    <span class="selected-count" id="selectedCount">已选择 0 个</span>
                    <span id="selectedTagsList">请选择图册标签</span>
                </div>
            </div>

            <div class="form-group">
                <label>发布状态</label>
                <div class="status-group">
                    <div class="radio-option">
                        <input type="radio" name="status" value="public" id="public" checked>
                        <label for="public">公开</label>
                    </div>
                    <div class="radio-option">
                        <input type="radio" name="status" value="private" id="private">
                        <label for="private">私密</label>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label>选择图片</label>
                <div class="upload-area">
                    <div class="upload-text">
                        <h3>选择图片文件</h3>
                        <p>支持 JPG、PNG、GIF 格式，可选择多张图片</p>
                        <p>第1张图片将会作为你的相册封面</p>
                    </div>
                    <input type="file"
                           name="photos"
                           id="photoInput"
                           class="file-input"
                           multiple
                           accept="image/*"
                           required
                           onchange="handleFileSelect(this)">
                </div>

                <div class="preview-container" id="previewContainer">
                    <div class="file-count" id="fileCount">已选择 0 张图片</div>
                    <div class="preview-grid" id="previewGrid"></div>
                </div>
            </div>

            <button type="submit" class="submit-btn">
                创建图册
            </button>
        </form>
    </div>
</div>

<script>
    // 存储选中的文件数组
    var selectedFiles = [];

    function handleFileSelect(input) {
        var files = Array.from(input.files);
        selectedFiles = files;
        updatePreview();
    }

    function updatePreview() {
        var previewContainer = document.getElementById('previewContainer');
        var previewGrid = document.getElementById('previewGrid');
        var fileCount = document.getElementById('fileCount');

        if (selectedFiles.length > 0) {
            previewContainer.style.display = 'block';
            fileCount.textContent = '已选择 ' + selectedFiles.length + ' 张图片';
            previewGrid.innerHTML = '';

            selectedFiles.forEach(function(file, index) {
                if (file.type.indexOf('image/') === 0) {
                    var reader = new FileReader();
                    reader.onload = function(e) {
                        var previewItem = document.createElement('div');
                        previewItem.className = 'preview-item';
                        previewItem.innerHTML =
                            '<img src="' + e.target.result + '" class="preview-image" alt="预览图片">' +
                            '<button type="button" class="preview-remove" onclick="removeFile(' + index + ')" title="删除图片">×</button>' +
                            (index === 0 ? '<div class="cover-badge">封面</div>' : '');
                        previewGrid.appendChild(previewItem);
                    };
                    reader.readAsDataURL(file);
                }
            });
        } else {
            previewContainer.style.display = 'none';
        }
    }

    function removeFile(index) {
        selectedFiles.splice(index, 1);
        updateFileInput();
        updatePreview();
    }

    function updateFileInput() {
        var input = document.getElementById('photoInput');
        var dt = new DataTransfer();

        selectedFiles.forEach(function(file) {
            dt.items.add(file);
        });

        input.files = dt.files;

        // 如果没有文件了，需要重新设置required属性
        if (selectedFiles.length === 0) {
            input.required = true;
        }
    }

    // 标签选择功能
    document.addEventListener('DOMContentLoaded', function() {
        var tagCheckboxes = document.querySelectorAll('.tag-checkbox');
        var selectedCount = document.getElementById('selectedCount');
        var selectedTagsList = document.getElementById('selectedTagsList');

        function updateSelectedTags() {
            var selectedTags = [];
            tagCheckboxes.forEach(function(checkbox) {
                if (checkbox.checked) {
                    selectedTags.push(checkbox.value);
                }
            });

            selectedCount.textContent = '已选择 ' + selectedTags.length + ' 个';

            if (selectedTags.length > 0) {
                selectedTagsList.textContent = selectedTags.join(', ');
            } else {
                selectedTagsList.textContent = '请选择图册标签';
            }
        }

        tagCheckboxes.forEach(function(checkbox) {
            checkbox.addEventListener('change', updateSelectedTags);
        });
    });
</script>
</body>
</html>