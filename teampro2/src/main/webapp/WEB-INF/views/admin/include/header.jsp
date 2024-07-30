<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Spring MVC</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="stylesheet" href="/css/basic.css">
<!-- 추가 -->
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.4.1.min.js"></script>
<!-- 구글폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
<style>
.white-background {
    background-color: white;
}
input::placeholder {
    color: ##2B3035;
}
</style>
</head>
<body>
<script>
	function handleLinkClick(event, level) {
	    if (level === null || level === '') {
	        event.preventDefault();
	        alert('로그인 후 이용가능 ');
	    }		// <a href="your-desired-url" onclick="handleLinkClick(event, '<c:out value="${sessionScope.level}"/>')">
	}           // 이거 사용하면 로그인 전 로그인 alert 가능
	function validateSearch() {
        var keyword = document.getElementById("keywordInput").value.trim();
        if (keyword === "") {
            alert("검색어를 입력하세요.");
            return false; // 검색 중지
        }
        return true; // 검색 진행
    }
</script>
<%-- id : ${sessionScope.email}<br>
name : ${sessionScope.name}<br>
level : ${sessionScope.level}<br> --%>
<nav class="navbar navbar-expand-lg bg-body-tertiary" data-bs-theme="dark" style="color: white;">
  <div class="container-fluid">
    <a class="navbar-brand" href="/" style="color: red;"><svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-graph-up-arrow" viewBox="0 0 16 16">
    <path fill-rule="evenodd" d="M0 0h1v15h15v1H0zm10 3.5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 .5.5v4a.5.5 0 0 1-1 0V4.9l-3.613 4.417a.5.5 0 0 1-.74.037L7.06 6.767l-3.656 5.027a.5.5 0 0 1-.808-.588l4-5.5a.5.5 0 0 1 .758-.06l2.609 2.61L13.445 4H10.5a.5.5 0 0 1-.5-.5"/>
</svg></a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link" href="/board/listAll" style="color: white;" onclick="handleLinkClick(event, '<c:out value="${sessionScope.level}"/>')">&#128203;게시판&nbsp;&nbsp;&nbsp;|</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/financial" style="color: white;" onclick="handleLinkClick(event, '<c:out value="${sessionScope.level}"/>')">&#128373;재무재표 분석&nbsp;&nbsp;&nbsp;|</a>
        </li>     
        <li class="nav-item">
          <a class="nav-link" href="/port/list" aria-disabled="true" style="color: white;"onclick="handleLinkClick(event, '<c:out value="${sessionScope.level}"/>')">&#128077;포트폴리오 추천 받기&nbsp;&nbsp;&nbsp;|</a>
        </li>
        <li class="nav-item"><!-- 수정 -->
          <a class="nav-link" href="/news" aria-disabled="true" style="color: white;"onclick="handleLinkClick(event, '<c:out value="${sessionScope.level}"/>')">&#128240;기사 분석<c:if test="${sessionScope.level == 10 }">&nbsp;&nbsp;&nbsp;|</c:if></a>
        </li>
        <c:choose>
		  <c:when test="${sessionScope.level == 10 }">
		  	 <li class="nav-item dropdown">
			    <a class="nav-link dropdown-toggle" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="color: white;">
			        &#128295;관리자 전용 
			    </a>
		     	<ul class="dropdown-menu">
		      		<li><a class="dropdown-item" href="/admin/member/adminMemberList" onclick="handleLinkClick(event, '<c:out value="${sessionScope.level}"/>')">&#128100;회원관리</a></li>
		      			<hr>
		        	<li><a class="dropdown-item" href="/admin/board/adminBoardList" onclick="handleLinkClick(event, '<c:out value="${sessionScope.level}"/>')">&#128209;게시물관리</a></li>
		        		<hr>
		        	<li><a class="dropdown-item" href="/admin/financia_admin" onclick="handleLinkClick(event, '<c:out value="${sessionScope.level}"/>')">&#128736;재무재표 관리&#128373;</a></li>
	         	</ul>
		   	  </li>
		   </c:when>
	    </c:choose>
      </ul>
       <c:choose>
		  <c:when test="${sessionScope.level == 10 }">
		    <button type="button" class="btn btn-outline-light me-2" onclick="location.href='/member/logout';">로그아웃</button>
		    <button type="button" class="btn btn-outline-success me-2" onclick="location.href='/member/joinup';">회원수정</button>
		  </c:when>
		  <c:when test="${sessionScope.name != null }">
		  	<c:choose>
				<c:when test="${sessionScope.connecttype eq '카카오'}">
					<button type="button" class="btn btn-outline-warning me-2" onclick="kakaoLogout()">로그아웃</button>
		    		<button type="button" class="btn btn-outline-light me-2" onclick="location.href='/member/joinup';">회원수정</button>
				</c:when>
				<c:when test="${sessionScope.connecttype eq '네이버'}">
					<button type="button" class="btn btn-outline-success me-2" onclick="naverLogout()">로그아웃</button>
		    		<button type="button" class="btn btn-outline-light me-2" onclick="location.href='/member/joinup';">회원수정</button>
				</c:when>
				<c:otherwise>
					<button type="button" class="btn btn-outline-light me-2" onclick="location.href='/member/logout';">로그아웃</button>
		    		<button type="button" class="btn btn-outline-light me-2" onclick="location.href='/member/joinup';">회원수정</button>
				</c:otherwise>
			</c:choose>
		  </c:when>
		  <c:otherwise>
		  	<button type="button" class="btn btn-outline-light me-2" onclick="location.href='/member/find';">비밀번호 찾기</button>
		    <button type="button" class="btn btn-outline-light me-2" onclick="location.href='/member/login';">로그인</button>
		    <button type="button" class="btn btn-outline-light me-2" onclick="location.href='/member/join';">회원가입</button>
		  </c:otherwise>
	  </c:choose>
	    <form class="d-flex" role="search" action="/search" method="get" onsubmit="return validateSearch()">
		    <input class="form-control me-2 white-background" type="search" placeholder="Search" aria-label="Search" name="keyword" id="keywordInput" value="${cri.keyword}">
		    <button class="btn btn-outline-success" type="submit">Search</button>
		</form>
    </div>
  </div>
</nav>
<br>
<br>
