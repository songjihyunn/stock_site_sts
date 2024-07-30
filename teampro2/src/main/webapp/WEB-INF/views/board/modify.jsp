<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/header.jsp" %>

<br> 
<center>

<h3 style="font-weight: bold; font-size: 30px;">게시글 수정</h3>

<form method="post" enctype="multipart/form-data" style="margin-bottom: 100px;">
	<input type="hidden" name="bno" value="${boardVO.bno}">
	<input type="hidden" name="file01" value="${boardVO.file01}">
	<input type="hidden" name="file02" value="${boardVO.file02}">
	<input type="hidden" name="file03" value="${boardVO.file03}">
	<input type="hidden" name="file01_thum" value="${boardVO.file01_thum}">
	<div class="container-md">
		<div class="input-group mb-3" style="width:500px">
			<span class="input-group-text" id="basic-addon1" style="width:50px">제목</span>
			<input type="text" class="form-control" name="title" value="${boardVO.title}" aria-label="Username" aria-describedby="basic-addon1">
			<div class="btn-group" role="group" aria-label="Basic radio toggle button group" align="left">
				<c:if test="${sessionScope.level == 10 }">
                    <!-- name 속성을 모두 동일하게 설정하여 하나의 그룹으로 묶음 -->
                    <input type="radio" class="btn-check" name="code" id="btnradio1" autocomplete="off" value="공지" ${boardVO.code eq '공지' ? 'checked' : ''}>
                    <label class="btn btn-outline-danger" for="btnradio1">공지</label>
                </c:if>
            
                <input type="radio" class="btn-check" name="code" id="btnradio2" autocomplete="off" value="일반" ${boardVO.code eq '일반' ? 'checked' : ''}>
                <label class="btn btn-outline-success" for="btnradio2">일반</label>
            
                <input type="radio" class="btn-check" name="code" id="btnradio3" autocomplete="off" value="비밀" ${boardVO.code eq '비밀' ? 'checked' : ''}>
                <label class="btn btn-outline-dark" for="btnradio3">비밀</label>
			</div>
		</div>
		<div class="input-group mb-3" style="width:500px">
			<span class="input-group-text" id="basic-addon1" style="width:50px">작성자</span>
			<input type="text" class="form-control" name="writer" value="${sessionScope.id }" aria-label="Username" aria-describedby="basic-addon1" readonly>
		</div>
		<div class="input-group mb-3" style="width:500px">
			<textarea class="form-control" aria-label="With textarea" name="content" rows="20">${boardVO.content}</textarea>
		</div>
		<div class="input-group mb-3" style="width:500px">
			<label class="input-group-text" for="file01">Upload 1</label>
			<input type="file" class="form-control" id="file01" name="file">
			<span class="input-group-text" id="basic-addon1" style="width:200px;">
				<font color=red style="font-size:10px">${boardVO.file01}</font>
			</span>
		</div>
		<div class="input-group mb-3" style="width:500px">
			<label class="input-group-text" for="file02">Upload 2</label>
			<input type="file" class="form-control" id="file02" name="file">
			<span class="input-group-text" id="basic-addon1" style="width:200px;">
				<font color=red style="font-size:10px">${boardVO.file02}</font>
			</span>
		</div>
		<div class="input-group mb-3" style="width:500px">
			<label class="input-group-text" for="file03">Upload 3</label>
			<input type="file" class="form-control" id="file03" name="file">
			<span class="input-group-text" id="basic-addon1" style="width:200px;">
				<font color=red style="font-size:10px">${boardVO.file03}</font>
			</span>
		</div>
	</div>

	<div class="btn-group" role="group" aria-label="Basic outlined example">
		<input type="button" class="btn btn-outline-primary" value="뒤로가기" style="width:150px;"
		 onclick="location.href='/board/read?page=${page }&perPageNum=${perPageNum }&searchType=${searchType }&keyword=${keyword }&bno=${boardVO.bno }'">
		<button class="btn btn-outline-success" style="width:150px;">수정</button>
	</div>
</form>

</center>
<br>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>