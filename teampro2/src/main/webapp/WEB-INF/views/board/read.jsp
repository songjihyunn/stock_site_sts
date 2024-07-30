<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<c:if test="${sessionScope.level eq null}">
	<script>
		alert("로그인 후 사용 가능합니다.");
		location.href = "/member/login";
	</script>
</c:if>

<br>
<center>

<h3 style="font-weight: bold; font-size: 30px;">상세 보기</h3>

<c:choose>
	<c:when test="${boardVO.show_code eq '삭제' }">
		<div class="container-md">
			<div class="input-group mb-3" style="width:800px">
				<span class="input-group-text" id="basic-addon1" style="width:50px">제목</span>
				<input type="text" class="form-control" name="title" value="${del_msg }" aria-label="Username" aria-describedby="basic-addon1" readonly>
			</div>
			<div class="input-group" style="width:800px">
				<span class="input-group-text" id="writer" style="width:50px">작성자</span>
				<input type="text" class="form-control" name="writer" value="${boardVO.writer}" aria-label="Username" aria-describedby="basic-addon1" readonly>
				<span class="input-group-text" id="basic-addon1" style="width:50px">작성일</span>
				<input type="text" class="form-control" name="regdate" value="<fmt:formatDate value="${boardVO.regdate}" pattern="yyyy-MM-dd" />" aria-label="Username" aria-describedby="basic-addon1" readonly>
			</div>
			<br>
			<div class="input-group mb-3" style="width:800px;">
				<textarea class="form-control" aria-label="With textarea" rows="10" name="content" readonly>${del_msg }</textarea>
			</div>
		</div>
		<div class="btn-group" role="group" aria-label="Basic outlined example">
			<input type="button" class="btn btn-outline-primary" value="뒤로가기" style="width:150px;"
			 onclick="location.href='adminBoardList${adminpm.makeSearch(adminpm.acri.page)}'">
			<button type="submit" class="btn btn-outline-primary" style="width:150px;">정정</button>
		</div>
	</c:when>
	
	<c:when test="${boardVO.show_code ne '삭제' }">
		<div class="container-md">
			<div class="input-group mb-3" style="width:800px">
				<span class="input-group-text" id="basic-addon1" style="width:50px">제목</span>
				<input type="text" class="form-control" name="title" value="${boardVO.title}" aria-label="Username" aria-describedby="basic-addon1" readonly>
			</div>
			<div class="input-group" style="width:800px">
				<span class="input-group-text" id="writer" style="width:50px">작성자</span>
				<input type="text" class="form-control" name="writer" value="${boardVO.writer}" aria-label="Username" aria-describedby="basic-addon1" readonly>
				<span class="input-group-text" id="basic-addon1" style="width:50px">작성일</span>
				<input type="text" class="form-control" name="regdate" value="<fmt:formatDate value="${boardVO.regdate}" pattern="yyyy-MM-dd" />" aria-label="Username" aria-describedby="basic-addon1" readonly>
			</div>
			<br>
			<div class="input-group mb-3" style="width:800px">
				<textarea class="form-control" aria-label="With textarea" rows="10" name="content" readonly>${boardVO.content} ${board.code }</textarea>
			</div>
		    <c:if test="${not empty boardVO.file01}">
				<img src="/upload/${boardVO.file01}" alt="첨부 이미지" style="max-width: 265px; max-height: 265px;" />
			</c:if>
			<c:if test="${not empty boardVO.file02}">
				<img src="/upload/${boardVO.file02}" alt="첨부 이미지" style="max-width: 265px; max-height: 265px;" />
			</c:if>
			<c:if test="${not empty boardVO.file03}">
				<img src="/upload/${boardVO.file03}" alt="첨부 이미지" style="max-width: 265px; max-height: 265px;" />
			</c:if>
			<c:if test="${empty boardVO.file01 and empty boardVO.file02 and empty boardVO.file03}">
				<div class="input-group mb-3" style="width:800px">
					<input type="text" class="form-control" name="writer" value="첨부파일 없음" aria-label="Username" aria-describedby="basic-addon1" readonly>
				</div>
			</c:if>
		</div>
		<br>
	</c:when>
</c:choose>
<c:if test="${sessionScope.id eq boardVO.writer || sessionScope.level eq 10}">
	<div class="container-md">
		<div class="row" style="width:820px">
			<div class="col-2">
				<div class="btn-group" role="group" aria-label="Basic outlined example">
					<input type="button" class="btn btn-outline-primary" value="뒤로가기" style="width:150px;"
					 onclick="location.href='listAll${pageMaker.makeSearch(pageMaker.cri.page)}'">
				</div>
			</div>
			<div class="col"></div>
			<div class="col-1" style="text-align:left;">
				<div class="btn-group" role="group" aria-label="Basic outlined example">
				<input type="button" class="btn btn-outline-success" value="수정" style="width:90px;"
				 onclick="location.href='/board/modify${pageMaker.makeSearch(pageMaker.cri.page)}&bno=${boardVO.bno }'">
				</div>
			</div>
			<div class="col-2" style="text-align:right;">
				<div class="btn-group" role="group" aria-label="Basic outlined example">
					<input type="button" class="btn btn-outline-danger" value="삭제" style="width:90px;"
					 onclick="location.href='/board/remove${pageMaker.makeSearch(pageMaker.cri.page)}&bno=${boardVO.bno }'">
				</div>
			</div>
		</div>
	</div>
</c:if>
<br>
<style>
#modDiv {
	width: 230px;
	height: auto;
	background-color: #E3E1E3;
	position: absolute;
	padding: 10px;
	z-index: 1000;
	display: none;
}
.active{
	font-weight:bold;
	
}
</style>

<!-- MOD 버튼 -->

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h1 class="modal-title fs-5" id="exampleModalLabel">댓글 수정</h1>
				<span id="rno" style="display: none;"></span>
			</div>
			<div class="modal-body">
				<textarea id="replytext" class="form-control" rows="5"></textarea>
			</div>
			<div class="modal-footer">
		  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		  <button type="button" class="btn btn-primary" id="replySaveBtn">저장</button>
		  <button type="button" class="btn btn-danger" id="replyDeleteBtn">삭제</button>
			</div>
		</div>
	</div>
</div>
<%-- <c:if test="${sessionScope.id != null}"> --%>
<!-- 댓글 작성 -->
<div class="container-md">
	<div class="row" style="width:820px">
		<div class="input-group mb-3">
			<span class="input-group-text" name="replyer" id="newReplyWriter" style="width:200px;">${sessionScope.id }</span>
			<input type="text" class="form-control" name='replytext' id='newReplyText' aria-label="Example text with button addon" aria-describedby="button-addon1" required>
			<button class="btn btn-outline-secondary" type="button" id='replyAddBtn'>댓글작성</button>
			<input id="sessionlevel" type="hidden" value="${sessionScope.level }">
		</div>
	</div>
</div>
<%-- </c:if> --%>

<!-- 댓글 목록 출력 영역 -->
<div class="container-md" id="replies"></div>

<!-- 페이징 -->
<div class="pagination" id="replies" style="width:800px">
</div>

<br><br><br><br><br>

<style>
  .page-item.active {
    z-index: 100;
    /* 원하는 z-index 값을 설정하세요 */
    position: relative; /* z-index가 적용되려면 position 속성이 필요합니다. */
  }
</style>
<script>
var bno = ${boardVO.bno};

getAllList(); // 총 게시물 수
getPageList(1); // 페이징 처리된 리스트

var replyPage = 1;
var pageSize = 5; // 페이지당 댓글 수

var sessionId = $("#newReplyWriter").text(); // 텍스트 값을 가져옴
var sessionLevel = $("#sessionlevel").val(); // 입력된 값을 가져옴

// 댓글 목록을 가져와서 출력하는 함수
function getAllList() {
  getPageList(replyPage);
}

// 페이지 목록을 가져와서 출력하는 함수
function getPageList(page) {
  $.getJSON("/replies/" + bno + "/" + page + "?pageSize=" + pageSize, function(data) {
    $("#total_count").text(data.totalCount); // 총 댓글 수 표시

    if (data.list.length > 0) {
      var str = "";
      $(data.list).each(function() {
        str += "<div class='replyRow row' style='width:820px;'>"
            + "<div class='col-1 ellipsis'>" + this.replyer + "</div>"
            + "<div class='col'>" + this.replytext + "</div>"
            + "<div class='col-1' data-replyer='" + this.replyer + "' data-rno='" + this.rno + "' data-str='" + this.replytext + "'>";

            // 각 댓글의 작성자 ID와 비교하여 값을 콘솔에 출력
            console.log("Replyer:", this.replyer);
            console.log("Session ID:", sessionId);
            console.log("Session Level:", sessionLevel);
            if (sessionId === this.replyer || this.sessionLevel === "10") { // sessionLevel이 문자열로 비교되도록 변경
              console.log("Button should be displayed for:", this.replyer); // 조건이 만족할 때 로그 출력
              str += "<button class='modeBtn btn btn-outline-secondary btn-sm'>mode</button>";
            }

        str += "</div>"
            + "</div>";
      });
    } else {
      // 댓글이 없는 경우에는 '댓글없음' 메시지를 출력
      str = "<div class='row'><div class='col'>댓글이 없습니다.</div></div>";
    }

    $("#replies").html(str);
    printPaging(data.pageMaker); // 페이지 매김 정보 출력
  });
}



// 페이지 매김 정보를 이용해서 화면에 페이지 번호를 출력
function printPaging(pageMaker) {
  var str = "";

  str += "<nav aria-label='Page navigation'>";
  str += "<ul class='pagination pagination-sm'>";
  
  if (pageMaker.prev) {
    str += "<li class='page-item'><a class='page-link' href='" + (pageMaker.startPage - 1) + "' aria-label='Previous'><span aria-hidden='true'>&laquo;</span></a></li>";
  } else {
    str += "<li class='page-item disabled'><a class='page-link' href='#' aria-label='Previous'><span aria-hidden='true'>&laquo;</span></a></li>";
  }

  for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
    var strClass = pageMaker.cri.page == i ? ' active' : '';
    str += "<li class='page-item" + strClass + "'><a class='page-link' href='" + i + "'>" + i + "</a></li>";
  }

  if (pageMaker.next) {
    str += "<li class='page-item'><a class='page-link' href='" + (pageMaker.endPage + 1) + "' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>";
  } else {
    str += "<li class='page-item disabled'><a class='page-link' href='#' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>";
  }

  str += "</ul>";
  str += "</nav>";

  $('.pagination').html(str);
}

$(".pagination").on("click", "nav ul li a", function(event){
	event.preventDefault(); // <a href="">태그의 기본 동작인 페이지 전환을 막는 역활을 한다.
	replyPage = $(this).attr("href"); // 클릭된 페이지의 번호를 얻는 역활을 한다.
	getPageList(replyPage);
});

//글 등록
$("#replyAddBtn").on("click", function() {
var replyer = $("#newReplyWriter").text();
var replytext = $("#newReplyText").val();

//replytext가 비어있을 경우 전송을 막고 알림 표시
if (!replytext.trim()) { // 공백만 있는 경우도 체크
	alert("댓글 내용을 입력해주세요.");
	return;
}

$.ajax({
	type: 'post',
	url: '/replies/',
	headers: {
	  "Content-Type": "application/json"
	},
		dataType: 'text',
		data: JSON.stringify({
		  bno: bno,
		  replyer: replyer,
		  replytext: replytext
		}),
		success: function(result) {
			if (result == 'success') {
				alert("글 등록됨");
				getAllList(); // 목록 출력
		
				// 글 작성후 null처리
				$("#newReplyText").val("");
			}
		}
	});
});

// 댓글 수정 모달 띄우기
$('#replies').on('click', '.modeBtn', function(event) {
  var rno = $(this).parent().data('rno');
  var replyer = $(this).parent().data('replyer');
  var replytext = $(this).parent().data('str');

  // 모달의 타이틀에 rno를 저장하고, 모달의 텍스트 필드에 댓글 내용을 설정
  $('#exampleModal').data('rno', rno).modal('show');
  $("#rno").html(rno);
  $("#replyer").html("작성자: " + replyer);
  $("#replytext").val(replytext);
});

//글 수정
$("#replySaveBtn").on("click", function() {
	var rnoText = $('#rno').text(); // rno를 모달에서 가져옴 (문자열 형태)
	var rno = parseInt(rnoText); // 문자열을 정수로 변환
	var replytext = $("#replytext").val();
	
	$.ajax({
		type: 'put',
		url: '/replies/' + rno,
		headers: {
			"Content-Type": "application/json",
			"X-HTTP-Method-Override": "PUT"
			},
			dataType: 'text',
			data: JSON.stringify({
				replytext: replytext
			}),
			success: function(result) {
			if (result == 'success') {
				alert("수정 되었습니다.");
				$('#exampleModal').modal("hide"); // 모달 닫기
				getAllList(); // 목록 갱신
			}
		}
	});
});

// 댓글 삭제 버튼 클릭 시 댓글 삭제
$('#replyDeleteBtn').on('click', function() {
  var rno = $('#exampleModal').data('rno');

  $.ajax({
    type: 'delete',
    url: '/replies/' + rno,
    headers: {
      "Content-Type": "application/json",
      "X-HTTP-Method-Override": "DELETE"
    },
    dataType: 'text',
    success: function(result) {
      if (result == 'success') {
        alert("삭제 되었습니다.");
        $('#exampleModal').modal('hide');
        getAllList();
      }
    }
  });
});

// mode 열기
$("#replies").on("click", ".replyLi button", function() {
  var reply = $(this).parent(); // 자기 자신의 부모 요소를 선택한다. <tr>
  var rno = reply.attr("data-rno");
  var replyer = reply.attr("data-replyer");
  var replytext = reply.attr("data-str");

  // alert(rno + " : " + replytext);

  $(".modal-title").html(rno);
  $("#replyer").html("작성자: " + replyer);
  $("#replytext").val(replytext);
  $("#modDiv").show("slow");
});

// mode닫기
$("#closeBtn").on("click", function() {
  $("#modDiv").hide("slow");
  getAllList();
});

</script>

</center>
<br>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>