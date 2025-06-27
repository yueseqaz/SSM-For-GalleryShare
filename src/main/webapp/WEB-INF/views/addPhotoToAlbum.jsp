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
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Microsoft YaHei", sans-serif;
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #333;
            min-height: 100vh;
            padding: 20px;
        }

        /* 全屏容器 */
        .fullscreen-container {
            max-width: 1200px;
            margin: 0 auto;
            width: 100%;
        }

        /* 头部标题 */
        .header {
            text-align: center;
            margin-bottom: 30px;
            color: white;
        }

        .header h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        .header p {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        /* 主要内容区域 */
        .main-content {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 30px;
            height: calc(100vh - 200px);
            min-height: 600px;
        }

        /* 上传区域 */
        .upload-section {
            background: rgba(255,255,255,0.95);
            border-radius: 20px;
            padding: 30px;
            backdrop-filter: blur(10px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .upload-area {
            border: 3px dashed #ddd;
            border-radius: 15px;
            padding: 40px 20px;
            text-align: center;
            margin-bottom: 25px;
            transition: all 0.3s ease;
            background: #fafafa;
            position: relative;
            min-height: 200px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .upload-area.dragover {
            border-color: #4a90e2;
            background-color: #e3f2fd;
            transform: scale(1.02);
        }

        .upload-area input[type="file"] {
            position: absolute;
            width: 100%;
            height: 100%;
            opacity: 0;
            cursor: pointer;
        }

        .upload-icon {
            font-size: 3rem;
            color: #4a90e2;
            margin-bottom: 15px;
        }

        .upload-text {
            font-size: 1.2rem;
            color: #2c3e50;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .upload-hint {
            color: #7f8c8d;
            font-size: 0.9rem;
        }

        /* 文件统计 */
        .file-stats {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 20px;
            background: #f8f9fa;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .stats-item {
            text-align: center;
        }

        .stats-number {
            font-size: 1.5rem;
            font-weight: bold;
            color: #4a90e2;
        }

        .stats-label {
            font-size: 0.9rem;
            color: #666;
        }

        /* 操作按钮 */
        .action-buttons {
            display: flex;
            gap: 15px;
        }

        .btn {
            flex: 1;
            padding: 15px 0;
            text-align: center;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }

        .btn-primary {
            background: linear-gradient(45deg, #4a90e2, #357abd);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(74, 144, 226, 0.4);
        }

        .btn-primary:disabled {
            background: #bdc3c7;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }

        .btn-secondary {
            background: rgba(255,255,255,0.2);
            color: #666;
            border: 2px solid #ddd;
        }

        .btn-secondary:hover {
            background: #f8f9fa;
            border-color: #4a90e2;
            color: #4a90e2;
        }

        /* 预览区域 */
        .preview-section {
            background: rgba(255,255,255,0.95);
            border-radius: 20px;
            padding: 30px;
            backdrop-filter: blur(10px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .preview-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #eee;
        }

        .preview-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: #2c3e50;
        }

        .select-all-btn {
            padding: 8px 16px;
            background: #4a90e2;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.9rem;
            transition: background 0.3s ease;
        }

        .select-all-btn:hover {
            background: #357abd;
        }

        /* 预览网格 */
        .preview-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            gap: 15px;
            max-height: calc(100vh - 400px);
            overflow-y: auto;
            padding-right: 10px;
        }

        .preview-grid::-webkit-scrollbar {
            width: 6px;
        }

        .preview-grid::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 3px;
        }

        .preview-grid::-webkit-scrollbar-thumb {
            background: #c1c1c1;
            border-radius: 3px;
        }

        .preview-grid::-webkit-scrollbar-thumb:hover {
            background: #a8a8a8;
        }

        /* 预览项 */
        .preview-item {
            position: relative;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .preview-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        .preview-item.selected {
            border: 3px solid #4a90e2;
            transform: scale(1.05);
        }

        .preview-img {
            width: 100%;
            height: 120px;
            object-fit: cover;
            display: block;
        }

        .preview-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0,0,0,0.7);
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .preview-item:hover .preview-overlay {
            opacity: 1;
        }

        .preview-item.selected .preview-overlay {
            opacity: 1;
            background: rgba(74, 144, 226, 0.8);
        }

        /* 复选框 */
        .preview-checkbox {
            position: absolute;
            top: 8px;
            right: 8px;
            width: 20px;
            height: 20px;
            background: white;
            border: 2px solid #ddd;
            border-radius: 4px;
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 2;
        }

        .preview-item.selected .preview-checkbox {
            background: #4a90e2;
            border-color: #4a90e2;
            color: white;
        }

        .preview-checkbox::after {
            content: '✓';
            font-size: 12px;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .preview-item.selected .preview-checkbox::after {
            opacity: 1;
        }

        /* 文件信息 */
        .file-info {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background: rgba(0,0,0,0.8);
            color: white;
            padding: 8px;
            font-size: 0.8rem;
            transform: translateY(100%);
            transition: transform 0.3s ease;
        }

        .preview-item:hover .file-info {
            transform: translateY(0);
        }

        .file-name {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            margin-bottom: 2px;
        }

        .file-size {
            color: #bbb;
            font-size: 0.7rem;
        }

        /* 删除按钮 */
        .remove-btn {
            position: absolute;
            top: 8px;
            left: 8px;
            width: 24px;
            height: 24px;
            background: #e74c3c;
            color: white;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            opacity: 0;
            transition: all 0.3s ease;
            z-index: 3;
        }

        .preview-item:hover .remove-btn {
            opacity: 1;
        }

        .remove-btn:hover {
            background: #c0392b;
            transform: scale(1.1);
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .main-content {
                grid-template-columns: 1fr;
                gap: 20px;
                height: auto;
            }

            .header h1 {
                font-size: 2rem;
            }

            .preview-grid {
                grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
                max-height: 400px;
            }

            .upload-area {
                padding: 30px 15px;
                min-height: 150px;
            }
        }

        /* 空状态 */
        .empty-state {
            text-align: center;
            color: #999;
            padding: 40px 20px;
        }

        .empty-state .icon {
            font-size: 3rem;
            margin-bottom: 15px;
        }

        .empty-state h3 {
            margin-bottom: 10px;
            color: #666;
        }
    </style>
</head>
<body>
<div class="fullscreen-container">
    <div class="header">
        <h1>📸 图片上传中心</h1>
        <p>拖拽或点击选择图片，支持多选和预览</p>
    </div>

    <div class="main-content">
        <!-- 上传区域 -->
        <div class="upload-section">
            <form id="uploadForm" action="/addPhotoToAlbum" method="post" enctype="multipart/form-data">
                <div class="upload-area" id="uploadArea">
                    <div class="upload-icon">📁</div>
                    <div class="upload-text">选择图片文件</div>
                    <div class="upload-hint">支持 JPG、PNG、GIF 格式<br>可以拖拽文件到此处</div>
                    <input type="file" name="photos" multiple accept="image/*" id="photoInput">
                </div>

                <div class="file-stats">
                    <div class="stats-item">
                        <div class="stats-number" id="totalFiles">0</div>
                        <div class="stats-label">总文件数</div>
                    </div>
                    <div class="stats-item">
                        <div class="stats-number" id="selectedFiles">0</div>
                        <div class="stats-label">已选择</div>
                    </div>
                    <div class="stats-item">
                        <div class="stats-number" id="totalSize">0 KB</div>
                        <div class="stats-label">总大小</div>
                    </div>
                </div>

                <input type="hidden" name="albumId" value="${albumId}">
                <div class="action-buttons">
                    <button type="submit" class="btn btn-primary" id="uploadBtn" disabled>
                        🚀 上传选中图片
                    </button>
                    <a href="${pageContext.request.contextPath}/myalbum" class="btn btn-secondary">
                        ← 返回相册
                    </a>
                </div>
            </form>
        </div>

        <!-- 预览区域 -->
        <div class="preview-section">
            <div class="preview-header">
                <h3 class="preview-title">图片预览</h3>
                <button type="button" class="select-all-btn" id="selectAllBtn">全选</button>
            </div>
            <div class="preview-grid" id="previewGrid">
                <div class="empty-state">
                    <div class="icon">🖼️</div>
                    <h3>暂无图片</h3>
                    <p>请选择要上传的图片文件</p>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    class ImageUploader {
        constructor() {
            this.files = [];
            this.selectedFiles = new Set();
            this.initElements();
            this.bindEvents();
        }

        initElements() {
            this.uploadArea = document.getElementById('uploadArea');
            this.photoInput = document.getElementById('photoInput');
            this.previewGrid = document.getElementById('previewGrid');
            this.uploadBtn = document.getElementById('uploadBtn');
            this.selectAllBtn = document.getElementById('selectAllBtn');
            this.totalFilesEl = document.getElementById('totalFiles');
            this.selectedFilesEl = document.getElementById('selectedFiles');
            this.totalSizeEl = document.getElementById('totalSize');
        }

        bindEvents() {
            // 文件选择事件
            this.photoInput.addEventListener('change', (e) => {
                this.handleFiles(Array.from(e.target.files));
            });

            // 拖拽事件
            this.uploadArea.addEventListener('dragover', (e) => {
                e.preventDefault();
                this.uploadArea.classList.add('dragover');
            });

            this.uploadArea.addEventListener('dragleave', () => {
                this.uploadArea.classList.remove('dragover');
            });

            this.uploadArea.addEventListener('drop', (e) => {
                e.preventDefault();
                this.uploadArea.classList.remove('dragover');
                const files = Array.from(e.dataTransfer.files).filter(file =>
                    file.type.startsWith('image/')
                );
                this.handleFiles(files);
            });

            // 全选按钮
            this.selectAllBtn.addEventListener('click', () => {
                this.toggleSelectAll();
            });

            // 表单提交事件
            document.getElementById('uploadForm').addEventListener('submit', (e) => {
                e.preventDefault();
                this.uploadSelectedFiles();
            });
        }

        handleFiles(newFiles) {
            // 过滤重复文件
            const uniqueFiles = newFiles.filter(file =>
                !this.files.some(existingFile =>
                    existingFile.name === file.name && existingFile.size === file.size
                )
            );

            this.files = [...this.files, ...uniqueFiles];
            this.renderPreview();
            this.updateStats();
        }

        renderPreview() {
            if (this.files.length === 0) {
                this.previewGrid.innerHTML = `
                        <div class="empty-state">
                            <div class="icon">🖼️</div>
                            <h3>暂无图片</h3>
                            <p>请选择要上传的图片文件</p>
                        </div>
                    `;
                return;
            }

            this.previewGrid.innerHTML = '';
            this.files.forEach((file, index) => {
                const reader = new FileReader();
                reader.onload = (e) => {
                    const previewItem = this.createPreviewItem(file, index, e.target.result);
                    this.previewGrid.appendChild(previewItem);
                };
                reader.readAsDataURL(file);
            });
        }

        createPreviewItem(file, index, src) {
            const item = document.createElement('div');
            item.className = 'preview-item';
            item.dataset.index = index;

            const isSelected = this.selectedFiles.has(index);
            if (isSelected) {
                item.classList.add('selected');
            }

            item.innerHTML = `
                    <img src="\${src}" alt="\${file.name}" class="preview-img">
                    <div class="preview-checkbox"></div>
                    <button class="remove-btn" title="删除">×</button>
                    <div class="preview-overlay"></div>
                    <div class="file-info">
                        <div class="file-name">\${file.name}</div>
                        <div class="file-size">\${this.formatFileSize(file.size)}</div>
                    </div>
                `;

            // 点击选择/取消选择
            item.addEventListener('click', (e) => {
                if (e.target.classList.contains('remove-btn')) return;
                this.toggleFileSelection(index);
            });

            // 删除按钮
            item.querySelector('.remove-btn').addEventListener('click', (e) => {
                e.stopPropagation();
                this.removeFile(index);
            });

            return item;
        }

        toggleFileSelection(index) {
            if (this.selectedFiles.has(index)) {
                this.selectedFiles.delete(index);
            } else {
                this.selectedFiles.add(index);
            }
            this.updatePreviewSelection();
            this.updateStats();
        }

        updatePreviewSelection() {
            document.querySelectorAll('.preview-item').forEach(item => {
                const index = parseInt(item.dataset.index);
                if (this.selectedFiles.has(index)) {
                    item.classList.add('selected');
                } else {
                    item.classList.remove('selected');
                }
            });
        }

        toggleSelectAll() {
            if (this.selectedFiles.size === this.files.length) {
                // 取消全选
                this.selectedFiles.clear();
                this.selectAllBtn.textContent = '全选';
            } else {
                // 全选
                this.selectedFiles.clear();
                this.files.forEach((_, index) => this.selectedFiles.add(index));
                this.selectAllBtn.textContent = '取消全选';
            }
            this.updatePreviewSelection();
            this.updateStats();
        }

        removeFile(index) {
            this.files.splice(index, 1);
            this.selectedFiles.delete(index);

            // 重新索引选中的文件
            const newSelectedFiles = new Set();
            this.selectedFiles.forEach(selectedIndex => {
                if (selectedIndex < index) {
                    newSelectedFiles.add(selectedIndex);
                } else if (selectedIndex > index) {
                    newSelectedFiles.add(selectedIndex - 1);
                }
            });
            this.selectedFiles = newSelectedFiles;

            this.renderPreview();
            this.updateStats();
        }

        updateStats() {
            this.totalFilesEl.textContent = this.files.length;
            this.selectedFilesEl.textContent = this.selectedFiles.size;

            const totalSize = this.files.reduce((sum, file) => sum + file.size, 0);
            this.totalSizeEl.textContent = this.formatFileSize(totalSize);

            // 更新上传按钮状态
            this.uploadBtn.disabled = this.selectedFiles.size === 0;

            // 更新全选按钮文本
            if (this.files.length === 0) {
                this.selectAllBtn.textContent = '全选';
            } else if (this.selectedFiles.size === this.files.length) {
                this.selectAllBtn.textContent = '取消全选';
            } else {
                this.selectAllBtn.textContent = '全选';
            }
        }

        formatFileSize(bytes) {
            if (bytes === 0) return '0 B';
            const k = 1024;
            const sizes = ['B', 'KB', 'MB', 'GB'];
            const i = Math.floor(Math.log(bytes) / Math.log(k));
            return parseFloat((bytes / Math.pow(k, i)).toFixed(1)) + ' ' + sizes[i];
        }

        uploadSelectedFiles() {
            if (this.selectedFiles.size === 0) {
                alert('请选择要上传的图片！');
                return;
            }

            const formData = new FormData();
            const selectedFilesArray = Array.from(this.selectedFiles);

            selectedFilesArray.forEach(index => {
                formData.append('photos', this.files[index]);
            });

            formData.append('albumId', document.querySelector('input[name="albumId"]').value);

            // 显示上传进度
            this.showUploadProgress();

            fetch('/addPhotoToAlbum', {
                method: 'POST',
                body: formData
            })
                .then(response => {
                    if (response.ok) {
                        alert('图片上传成功！');
                        window.location.href = '${pageContext.request.contextPath}/myalbum';
                    } else {
                        throw new Error('上传失败');
                    }
                })
                .catch(error => {
                    alert('上传失败：' + error.message);
                })
                .finally(() => {
                    this.hideUploadProgress();
                });
        }

        showUploadProgress() {
            this.uploadBtn.disabled = true;
            this.uploadBtn.textContent = '⏳ 上传中...';
        }

        hideUploadProgress() {
            this.uploadBtn.disabled = this.selectedFiles.size === 0;
            this.uploadBtn.textContent = '🚀 上传选中图片';
        }
    }

    // 初始化上传器
    document.addEventListener('DOMContentLoaded', () => {
        new ImageUploader();
    });
</script>
</body>
</html>
