<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>

<center>
<h1>admin board list</h1>

<div>총 게시물 수 : ${total }</div>
<br>
<div class="list-group" style="width: 1000px;">
	<div class="container text-center">
		<div class="row">
			<div class="col-1" width="5%"></div>
			<div class="col-3">Title</div>
			<div class="col">Writer</div>
			<div class="col">View Cnt</div>
			<div class="col">Regdate</div>
			<div class="col-1"></div>
		</div>
	</div>
	<c:set var="startNum" value="${adminpm.totalCount - (adminpm.acri.page - 1) * adminpm.acri.perPageNum}" /> <!-- 시작 번호 계산 -->
	<c:forEach var="board" items="${board}" varStatus="loop">
		<a href="#" class="list-group-item list-group-item-action">
	      	<div class="container text-center">
				<div class="row">
					<div class="col-1" width="5%">${startNum - loop.index }</div>
					<div class="col-3">
						<c:choose>
					        <c:when test="${board.show_code eq '삭제'}">
								<span style="color:red;">관리자에 의해 삭제된 게시물입니다.</span>
							</c:when>
							<c:otherwise>
								${board.title }
							</c:otherwise>
						</c:choose>
					</div>
					<div class="col">${board.writer }</div>
					<div class="col">${board.viewcnt }</div>
					<div class="col">
		                <fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd" />
					</div>
					<div class="col-1">
						<input type="button" value="수정" class="btn btn-warning btn-sm" onclick="location.href='/admin/board/adminBoardView${adminpm.makeSearch(adminpm.acri.page)}&bno=${board.bno }'">
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
        <a class="page-link" href="adminBoardList${adminpm.makeSearch(adminpm.startPage - 1)}" aria-label="Previous">&laquo;</a>
      </li>
    </c:if>

    <c:forEach var="idx" begin="${adminpm.startPage}" end="${adminpm.endPage}">
      <c:choose>
        <c:when test="${adminpm.acri.page == idx}">
          <li class="page-item active">
            <a class="page-link" href="adminBoardList${adminpm.makeSearch(idx)}">${idx}</a>
          </li>
        </c:when>
        <c:otherwise>
          <li class="page-item">
            <a class="page-link" href="adminBoardList${adminpm.makeSearch(idx)}">${idx}</a>
          </li>
        </c:otherwise>
      </c:choose>
    </c:forEach>

    <c:if test="${adminpm.next && adminpm.endPage > 0}">
      <li class="page-item">
        <a class="page-link" href="adminBoardList${adminpm.makeSearch(adminpm.endPage + 1)}" aria-label="Next">&raquo;</a>
      </li>
    </c:if>
  </ul>
</nav>

</center>

<%@ include file="/WEB-INF/views/admin/include/footer.jsp" %>
