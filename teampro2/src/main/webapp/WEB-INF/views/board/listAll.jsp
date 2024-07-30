<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/header.jsp" %>
<script>
	var result = "${msg}";

	if(result == "register"){
		alert("작성 완료!");
	}else if(result == "delete"){
		alert("삭제 완료!");
	}else if(result == "modify"){
		alert("수정 완료!");
	}
</script>

<script>
function change(ppn){
	location.href="listAll?page=1&perPageNum="+ppn+"&searchType=${cri.searchType}&keyword=${cri.keyword}";
}
</script>

<br>
<center>

<h3 style="font-weight: bold; font-size: 30px;">게시판</h3>
<!-- 
param.page : ${param.page } <br>
cri.page : ${cri.page } <br>
pageMaker.cri.page : ${pageMaker.cri.page } <br>
-->

<div class="list-group" style="width: 975px;">
	<div class="row">
		<div class="col-1">Total : ${pageMaker.totalCount }</div>
		<div class="col-11"></div>
	</div>
	<div class="row">
		<div class="col-1">
			<select class="form-select form-select-sm" name="perPageNum" onchange="change(this.value)" style="">
				<option value="1" <c:if test="${pageMaker.cri.perPageNum == 1}">selected</c:if>>1개</option>
				<option value="2" <c:if test="${pageMaker.cri.perPageNum == 2}">selected</c:if>>2개</option>
				<option value="4" <c:if test="${pageMaker.cri.perPageNum == 4}">selected</c:if>>4개</option>
				<option value="5" <c:if test="${pageMaker.cri.perPageNum == 5}">selected</c:if>>5개</option>
				<option value="10" <c:if test="${pageMaker.cri.perPageNum == 10}">selected</c:if>>10개</option>
			</select>
		</div>
		<div class="col"></div>
		<div class="col-5">
			<form method="get">
				<div class="input-group mb-3">
  					<span class="input-group-text" id="basic-addon1">&#128269;</span>
					<input type="hidden" name="perPageNum" value="${pageMaker.cri.perPageNum}">
					<select name="searchType" class="form-control form-select">
						<option value="n" ${cri.searchType == null?'selected':''} style="text-align: center;">선택하세요</option>
						<option value="t" ${cri.searchType eq 't'?'selected':''}>제목</option>
						<option value="c" ${cri.searchType eq 'c'?'selected':''}>내용</option>
						<option value="w" ${cri.searchType eq 'w'?'selected':''}>작성자</option>
						<option value="tc" ${cri.searchType eq 'tc'?'selected':''}>제목 OR 내용</option>
						<option value="cw" ${cri.searchType eq 'cw'?'selected':''}>내용 OR 작성자</option>	
						<option value="tcw" ${cri.searchType eq 'tcw'?'selected':''}>제목 OR 내용 OR 작성자</option>
					</select>
					<input name='keyword' id="keywordInput" value='${cri.keyword }' type="text" class="form-control" aria-label="Recipient's username" aria-describedby="button-addon2" style="width:150px;">
	  				<button class="btn btn-outline-primary" type="submit" id="button-addon2">검색</button>
  				</div>
			</form>
		</div>
	</div>
</div>
<div class="list-group" style="width: 1000px;">
	<div class="container text-center">
		<c:if test="${empty list}">
			<div class="list-group-item list-group-item-action role="alert" style="width: 1000px; text-align: center;">
					        해당 검색어가 없습니다.
			</div>
		</c:if>
		<c:set var="startNum" value="${pageMaker.totalCount - (pageMaker.cri.page - 1) * pageMaker.cri.perPageNum}" /> <!-- 시작 번호 계산 -->
		<c:forEach var="boardVO" items="${list}" varStatus="loop">
			<a href="#" class="list-group-item list-group-item-action <c:if test='${board.title eq "관리자에 의해 삭제된 글입니다"}'></c:if>">
				<div class="row">
					<div class="col-sm-1">${startNum - loop.index }</div>
					<div class="col-sm-4">
					    <c:choose>
							<c:when test="${boardVO.show_code eq '삭제'}">
								<span style="color:red;">관리자에 의해 삭제된 게시물입니다.</span>
							</c:when>
							<c:when test="${boardVO.show_code ne '삭제'}">
								<c:choose>
							        <c:when test="${boardVO.code eq '비밀'}">
							            <c:choose>
							                <c:when test="${sessionScope.id eq boardVO.writer or sessionScope.level eq 10}">
							                    <!-- 본인 또는 관리자 -->
												<span onclick="location.href='read${pageMaker.makeSearch(pageMaker.cri.page)}&bno=${boardVO.bno }'">${boardVO.title }</span>
							                </c:when>
							                <c:otherwise>
							                    <span style="color: gray;">비밀글입니다</span>
							                </c:otherwise>
							            </c:choose>
							        </c:when>
							        <c:otherwise>
									<span onclick="location.href='read${pageMaker.makeSearch(pageMaker.cri.page)}&bno=${boardVO.bno }'">${boardVO.title }</span>
							            <c:if test="${not empty boardVO.file01 || not empty boardVO.file02 || not empty boardVO.file03}">
							                <span style="font-size: 10px;">[첨부]</span>
							            </c:if>
							        </c:otherwise>
								</c:choose>
							</c:when>
					    </c:choose>
					</div>
					<div class="col-sm-4">${boardVO.writer }</div>
					<div class="col">
						<fmt:formatDate value="${boardVO.regdate}" pattern="yyyy-MM-dd" />
					</div>
					<div class="col-sm-1">${boardVO.viewcnt }</div>
				</div>
	      	</a>
		</c:forEach>
	</div>
</div>
<br>
<div class="container text-center" style="width:975px;">
  <div class="row">
    <div class="col-1"></div>
    <div class="col-10">
      <nav aria-label="Page navigation example">
        <ul class="pagination justify-content-center">
          <c:choose>
            <c:when test="${pageMaker.prev}">
              <li class="page-item">
                <a class="page-link" href="listAll${pageMaker.makeSearch(pageMaker.startPage - 1) }" aria-label="Previous">
                  <span aria-hidden="true">&laquo;</span>
                </a>
              </li>
            </c:when>
            <c:otherwise>
              <li class="page-item disabled">
                <a class="page-link" href="#" aria-label="Previous">
                  <span aria-hidden="true">&laquo;</span>
                </a>
              </li>
            </c:otherwise>
          </c:choose>
          
          <c:forEach var="idx" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
            <c:choose>
              <c:when test="${pageMaker.cri.page == idx}">
                <li class="page-item active">
                  <a class="page-link" href="listAll${pageMaker.makeSearch(idx)}">${idx}</a>
                </li>
              </c:when>
              <c:otherwise>
                <li class="page-item">
                  <a class="page-link" href="listAll${pageMaker.makeSearch(idx)}">${idx}</a>
                </li>
              </c:otherwise>
            </c:choose>
          </c:forEach>
          
          <c:choose>
            <c:when test="${pageMaker.next && pageMaker.endPage > 0}">
              <li class="page-item">
                <a class="page-link" href="listAll${pageMaker.makeSearch(pageMaker.endPage + 1) }" aria-label="Next">
                  <span aria-hidden="true">&raquo;</span>
                </a>
              </li>
            </c:when>
            <c:otherwise>
              <li class="page-item disabled">
                <a class="page-link" href="#" aria-label="Next">
                  <span aria-hidden="true">&raquo;</span>
                </a>
              </li>
            </c:otherwise>
          </c:choose>
        </ul>
      </nav>
    </div>
    <div class="col-1">
      <!-- <c:if test="${sessionScope.id != null}"> -->
      <input type="button" value="글쓰기" class="btn btn-outline-warning" style="width:75px;"
        onclick="location.href='/board/register${pageMaker.makeSearch(pageMaker.cri.page)}'">
      <!-- </c:if> -->
    </div>
  </div>
</div>

<br>

</center>
<br>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>