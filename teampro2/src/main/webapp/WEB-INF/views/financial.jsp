<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<style>
    .form-group {
        margin-bottom: 20px;
        width: 300px;
    }
    .btn-dark {
        background-color: #343a40;
        color: white;
    }
    .upload-container {
        height: 900px;
        display: flex;
        justify-content: center;
        align-items: center;
        margin-top: -100px;
    }
    .upload-box {
        padding: 40px;
        border: 1px solid #ccc;
        border-radius: 10px;
        background-color: #f8f9fa;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        max-width: 600px;
        width: 100%;
    }
    .upload-button {
        margin-top: 20px;
        font-size: 1.2rem;
        padding: 10px 20px;
    }
    .form-label {
        font-size: 1.2rem;
        font-weight: bold;
    }
    .alert {
        font-size: 1.8rem; /* 폰트 크기 증가 */
    }
    .form-control {
        font-size: 1rem;
        padding: 10px;
    }
</style>

<div class="container upload-container">
    <div class="upload-box text-center">
        <div class="alert alert-light bg-light rounded p-3 text-dark mb-4">
            <b>PDF 파일을 업로드하세요.</b>
        </div>
        <form action=" http://192.168.0.15:5000/user_finance" method="post" enctype="multipart/form-data">
            <div class="form-group mx-auto">
                <label for="fileUpload" class="form-label">&#128228;파일 선택&#128228;</label>
                <input type="file" name="file" class="form-control" id="fileUpload" required>
            </div>
            <button type="submit" class="btn btn-dark upload-button">분석 시작</button>
        </form>
    </div>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>