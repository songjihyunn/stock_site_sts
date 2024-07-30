<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
    <style>
        .form-group {
            margin-bottom: 15px;
        }
        .btn-dark {
            background-color: #343a40;
            color: white;
        }
    </style>
<center class="bg-dark text-light" style="margin-top:-50px">
	<div class="container d-flex flex-column justify-content-center align-items-center vh-100" style="margin-top:-200px">
        <div class="chat-container">
            <div class="chat-message user bg-light rounded p-2 text-dark">
                <b>PDF 파일을 업로드하세요.</b>
            </div>
        </div>
        <div class="input-container bg-light rounded p-3 mt-3">
            <form action="http://192.168.0.15:5000/upload" method="post" enctype="multipart/form-data">
	            <div class="form-group">
	                <label for="fileInput" class="text-dark">PDF 파일 선택:</label>
	                <input type="file" name="file" style="color: black" required>
	            </div>
	            <div class="form-group">
	                <!-- 세션 ID를 숨겨진 필드에 설정 -->
	                <input type="hidden" id="user_id" name="user_id" value="${sessionScope.id}">
	                <!-- 오늘 날짜를 숨겨진 필드에 설정 (JavaScript로 설정됨) -->
	            </div>
	            <button type="submit" class="btn btn-dark" style="margin-top:10px">분석 시작</button>
	        </form>
        </div>
    </div>	
</center>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>s