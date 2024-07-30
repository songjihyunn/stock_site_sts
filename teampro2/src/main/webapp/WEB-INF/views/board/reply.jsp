<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/header.jsp" %>

<center>

<h3>AJAX TEST</h3>

Total : <span id="total_conunt"></span> 

<style>
#modDiv {
	width: 300px;
	height: 100px;
	background-color: gray;
	position: absolute;
	top: 50%;
	left: 50%;
	margin-top: -50px;
	margin-left: -150px;
	padding: 10px;
	z-index: 1000;
}
</style>

<!-- MOD 버튼 -->
<table id='modDiv' style="display:none;">
	<tr>
		<td class='modal-title' style="padding-right:5px;"></td>
		<td id="replyer"></td>
	</tr>
	<tr>
		<td><input type='text' id='replytext'></td>
	</tr>
	<tr>
		<td>
		<c:choose>
		<c:when test="${userEmail eq boardVO.writer or sessionScope.level eq 10}">
			<button type="button" id="replyModBtn">수정</button>
			<button type="button" id="replyDelBtn">삭제</button>
			<button type="button" id='closeBtn'>닫기</button>
		</c:when>
		<c:otherwise>
			<button type="button" id='closeBtn'>닫기</button>
		</c:otherwise>
		</c:choose>
		</td>
	</tr>
</table>

<!-- 댓글 작성 -->
<table border=1>
	<tr>
		<td>글쓴이</td>
		<td><input type='text' name='replyer' id='newReplyWriter' value="${userEmail}"></td>
		<td>댓글 내용</td>
		<td><input type='text' name='replytext' id='newReplyText'></td>
		<td></td>
		<td><button id="replyAddBtn">댓글 작성</button></td>
	</tr>
</table>
<br>

<!-- 댓글 목록 출력 영역 -->
<table id="replies" border=1>

</table>

<script>
var bno = ${boardVO.bno};

getAllList(); //총 게시물 수

getPageList(1); //페이징 처리된 리스트

//댓글 목록을 가져와서 출력하는 함수
function getAllList() {
  $.getJSON("/replies/all/" + bno, function(data) {
    $("#total_conunt").text(data.length);

    var str = "";
    $(data).each(function() {
    	var replyer = this.replyer;
      	str += "<tr class='replyRow'>"
      		+ "<td class='ellipsis' style='padding-left: 5px; width: 180px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;'>" + replyer + "</td>"
      		+ "<td style='padding-left: 5px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;'>" + this.replytext + "</td>"
        	+ "<td data-replyer='"+replyer+"'data-rno='" + this.rno + "' data-str='" + this.replytext + "' class='replyLi' style='text-align: right; width: 80px;'><button class='modeBtn'>mode</button></td>"
        	+ "</tr>";
    });

    $("#replies").html(str);
  });
}

// 문서가 준비되면 댓글 목록을 가져옴
$(document).ready(function() {
  getAllList();
  
  // 이벤트 위임을 사용하여 동적으로 생성된 mode 버튼에 클릭 이벤트 추가
  $('#replies').on('click', '.modeBtn', function(event) {
    // 모달 창 요소 가져오기
    var modalDiv = document.getElementById('modDiv');

    // 클릭한 댓글의 위치 가져오기
    var rect = this.closest('tr').getBoundingClientRect();

    // 모달 창의 위치 설정
    var modalTop = rect.top + window.scrollY; // 댓글의 위쪽
    var modalLeft = rect.right + window.scrollX+10; // 댓글의 오른쪽

    // 모달 창 스타일 설정
    modalDiv.style.top = modalTop + 'px';
    modalDiv.style.left = modalLeft + 'px';
    modalDiv.style.display = 'block'; // 모달 창 보이기
  });
});

//글 등록
$("#replyAddBtn").on("click",function(){
	var replyer = $("#newReplyWriter").val();
	var replytext = $("#newReplyText").val();
	
	$.ajax({
		type: 'post',
		url: '/replies/',
		headers: {
			"Content-Type" : "application/json"
		},
		dataType: 'text',
		data:JSON.stringify({
			bno : bno,
			replyer : replyer,
			replytext : replytext
		}),
		success: function(result){
			if(result == 'success'){
				alert("글 등록됨");
				getAllList(); //목록 출력
				
				//글 작성후 null처리
				$("#newReplyWriter").val("");
				$("#newReplyText").val("");
			}
		}
	});
});

//글 수정
$("#replyModBtn").on("click",function(){
	var rno = $(".modal-title").html();
	var replytext = $("#replytext").val();

	$.ajax({
		type:'put',
		url:'/replies/'+rno,
		headers: {
			"Content-Type": "application/json",
			"X-HTTP-Method-Override": "PUT"
		},
		dataType:'text',
		data:JSON.stringify({
			replytext : replytext
		}),
		success:function(result){
			if(result == 'success'){
				alert("수정 되었습니다.");
				$("#modDiv").hide("slow");

				getAllList();
			}
		}
	});
});

//글 삭제
$("#replyDelBtn").on("click", function() {
	var rno = $(".modal-title").html();

	$.ajax({
		type : 'delete',
		url : '/replies/' + rno,		
		headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "DELETE"
		},
		dataType : 'text',
		success : function(result) {
			if (result == 'success') {
				alert("삭제 되었습니다.");
				$("#modDiv").hide("slow");
				getAllList();
			}
		}
	});
});

//mode 열기
$("#replies").on("click", ".replyLi button", function() {
	var reply = $(this).parent(); //자기 자신의 부모 요소를 선택한다. <tr>
	var rno = reply.attr("data-rno");
	var replyer = reply.attr("data-replyer");
	var replytext = reply.attr("data-str");

	//alert(rno + " : " + replytext);

	$(".modal-title").html(rno);
	$("#replyer").html(replyer);
	$("#replytext").val(replytext);
	$("#modDiv").show("slow");
});

// mode닫기
$("#closeBtn").on("click", function() {
	$("#modDiv").hide("slow");
	getAllList();
});
</script>

		
<%@ include file="/WEB-INF/views/include/footer.jsp" %>