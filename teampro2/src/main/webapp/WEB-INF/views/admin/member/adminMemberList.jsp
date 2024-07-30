<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<center>
<h1>회원 목록</h1>

<div>총 회원 수 : ${total }</div>
<br>
<div class="list-group" style="width: 1000px;">
	<div class="container text-center">
		<div class="row">
			<div class="col-1" width="5%"></div>
			<div class="col-3">User E-Mail</div>
			<div class="col">Name</div>
			<div class="col-1">Type</div>
			<div class="col-2">Phone Number</div>
			<div class="col">Signdate</div>
			<div class="col-1">Level</div>
			<div class="col-1"></div>
		</div>
	</div>
	<c:set var="startNum" value="${adminpm.totalCount - (adminpm.acri.page - 1) * adminpm.acri.perPageNum}" /> <!-- 시작 번호 계산 -->
	<c:forEach var="member" items="${member}" varStatus="loop">
		<a href="#" class="list-group-item list-group-item-action <c:if test='${board.title eq "관리자에 의해 삭제된 글입니다"}'></c:if>">
	      	<div class="container text-center">
				<div class="row">
					<div class="col-1" width="5%">${startNum - loop.index }</div>
					<div class="col-3">${member.useremail}</div>
					<div class="col">${member.username}</div>
					<div class="col-1">
						<c:choose>
							<c:when test="${member.connecttype eq '정지' || member.connecttype eq '탈퇴'}"><span style="color:red;">${member.connecttype}</span></c:when>
							<c:when test="${member.connecttype eq '카카오'}"><span style="color:brown;">${member.connecttype}</span></c:when>
							<c:when test="${member.connecttype eq '네이버'}"><span style="color:green;">${member.connecttype}</span></c:when>
							<c:otherwise><span style="color:blue;">${member.connecttype}</span></c:otherwise>
						</c:choose>
					</div>
					<div class="col-2">${member.phone1}-${member.phone2}-${member.phone3}</div>
					<div class="col">
						<fmt:parseDate var="parsedDate" value="${member.signdate}" pattern="yyyy-MM-dd" />
		                <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd" />
					</div>
					<div class="col-1">${member.level}</div>
					<div class="col-1">
						<input type="button" value="수정" class="btn btn-warning btn-sm" onclick="location.href='/admin/member/adminMemberModify?useremail=${member.useremail}&page=${acri.page}&perPageNum=${acri.perPageNum}&searchType=${acri.searchType}&keyword=${acri.keyword}'">
					</div>
				</div>
			</div>
      	</a>
	</c:forEach>
</div>
<br>

<nav aria-label="Page navigation example">
  <ul class="pagination justify-content-center">
    <c:if test="${adminpm.prev}">
      <li class="page-item">
        <a class="page-link" href="adminMemberList${adminpm.makeSearch(adminpm.startPage - 1)}" aria-label="Previous">&laquo;</a>
      </li>
    </c:if>

    <c:forEach var="idx" begin="${adminpm.startPage}" end="${adminpm.endPage}">
      <li class="page-item <c:if test='${adminpm.acri.page == idx}'>active</c:if>">
        <a class="page-link" href="adminMemberList${adminpm.makeSearch(idx)}">${idx}</a>
      </li>
    </c:forEach>

    <c:if test="${adminpm.next && adminpm.endPage > 0}">
      <li class="page-item">
        <a class="page-link" href="adminMemberList${adminpm.makeSearch(adminpm.endPage + 1)}" aria-label="Next">&raquo;</a>
      </li>
    </c:if>
  </ul>
</nav>
</center>

<%@ include file="/WEB-INF/views/admin/include/footer.jsp" %>