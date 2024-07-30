<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>

<center>
<h1>회원수정</h1>

<c:if test="${not empty msg}">
    <script type="text/javascript">
        alert("${msg}");
    </script>
</c:if>

<input type="hidden" value="${page }">
<input type="hidden" value="${perMemberPage }">
<input type="hidden" value="${searchType }">
<input type="hidden" value="${keyword }">

<form method="post" enctype="multipart/form-data">
<div class="container-md">
	<div class="input-group mb-3" style="width:500px">
		<span class="input-group-text" id="basic-addon1" style="width:100px">E-mail</span>
		<input type="text" class="form-control" name="useremail" value="${member.useremail }" aria-label="Username" aria-describedby="basic-addon1">
	</div>
	<div class="input-group mb-3" style="width:500px">
		<span class="input-group-text" id="basic-addon1" style="width:100px">Password</span>
		<input type="text" class="form-control" name="userpw" value="${member.userpw }" aria-label="Username" aria-describedby="basic-addon1">
	</div>
	<div class="input-group mb-3" style="width:500px">
		<span class="input-group-text" id="basic-addon1" style="width:100px">Name</span>
		<input type="text" class="form-control" name="username" value="${member.username }" aria-label="Username" aria-describedby="basic-addon1">
	</div>
	<div class="input-group mb-3" style="width:500px">
		<select name="connecttype"  class="form-select" aria-label="Default select example">
			<c:choose>
				<c:when test="${member.connecttype eq '로컬'}">
					<option value="로컬" selected>로컬</option>
					<option value="카카오">카카오</option>
					<option value="네이버">네이버</option>
					<option value="정지">정지</option>
					<option value="탈퇴">탈퇴</option>
				</c:when>
				<c:when test="${member.connecttype eq '카카오'}">
					<option value="로컬">로컬</option>
					<option value="카카오" selected>카카오</option>
					<option value="네이버">네이버</option>
					<option value="정지">정지</option>
					<option value="탈퇴">탈퇴</option>
				</c:when>
				<c:when test="${member.connecttype eq '네이버'}">
					<option value="로컬">로컬</option>
					<option value="카카오">카카오</option>
					<option value="네이버" selected>네이버</option>
					<option value="정지">정지</option>
					<option value="탈퇴">탈퇴</option>
				</c:when>
				<c:when test="${member.connecttype eq '정지'}">
					<option value="로컬">로컬</option>
					<option value="카카오">카카오</option>
					<option value="네이버">네이버</option>
					<option value="정지" selected>정지</option>
					<option value="탈퇴">탈퇴</option>
				</c:when>
				<c:when test="${member.connecttype eq '탈퇴'}">
					<option value="로컬">로컬</option>
					<option value="카카오">카카오</option>
					<option value="네이버">네이버</option>
					<option value="정지">정지</option>
					<option value="탈퇴" selected>탈퇴</option>
				</c:when>
			</c:choose>
		</select>
	</div>
	<div class="input-group mb-3" style="width:500px">
		<span class="input-group-text" id="basic-addon1" style="width:100px">E-mail result</span>
		<input type="text" class="form-control" name="emailresult" value="${member.emailresult }" aria-label="Username" aria-describedby="basic-addon1">
	</div>
	<div class="input-group mb-3" style="width:500px">
		<span class="input-group-text" id="basic-addon1" style="width:100px">Phone</span>
		<input type="text" class="form-control" name="phone1" value="${member.phone1 }" aria-label="Username" aria-describedby="basic-addon1">
		<input type="text" class="form-control" name="phone2" value="${member.phone2 }" aria-label="Username" aria-describedby="basic-addon1">
		<input type="text" class="form-control" name="phone3" value="${member.phone3 }" aria-label="Username" aria-describedby="basic-addon1">
	</div>
	<div class="input-group mb-3" style="width:500px">
		<span class="input-group-text" id="basic-addon1" style="width:100px">Signdate</span>
		<input type="text" class="form-control" value="${member.signdate }" aria-label="Username" aria-describedby="basic-addon1">
	</div>
	
	<div class="input-group" align="center" style="width:500px;">
		<div class="input-group">
			<input type="text" class="form-control" id="sample4_postcode" value="${member.zipcode }" name="zipcode" pattern="^[0-9]{3,20}" title="우편번호는 필수입력사항입니다!" style="width:250px;" required>
			<input type="button" class="form-control btn btn-outline-success" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" style="width:250px;">
		</div>
		<div class="input-group" align="center" style="width:500px">
			<input type="text" class="form-control" id="sample4_roadAddress" value="${member.zipcode1 }" name="zipcode1">
			<input type="text" class="form-control" id="sample4_jibunAddress" value="${member.zipcode2 }" name="zipcode2">
		</div>
		<div class="input-group" align="center" style="width:500px">
			<input type="text" class="form-control" id="sample4_extraAddress" value="${member.zipcode3 }" name="zipcode3">
			<input type="text" class="form-control" id="sample4_detailAddress" value="${member.zipcode4 }" name="zipcode4">
		</div>
	</div>
	<br>
	<div class="input-group mb-3" style="width:500px">
		<select name="level"  class="form-select" aria-label="Default select example">
		    <c:set var="i" value="1"/>
		    <c:forEach var="level" begin="${i}" end="10">
		        <c:choose>
		            <c:when test="${member.level == level}">
		                <option value="${level}" selected>${level}</option>
		            </c:when>
		            <c:otherwise>
		                <option value="${level}">${level}</option>
		            </c:otherwise>
		        </c:choose>
		    </c:forEach>
		</select>
	</div>
	<div class="btn-group" role="group" aria-label="Basic outlined example">
		<input type="button" class="btn btn-outline-primary" value="뒤로가기" style="width:150px;"
		 onclick="location.href='/admin/member/adminMemberList${adminpm.makeSearch(adminpm.acri.page)}'">
		<button class="btn btn-outline-primary" style="width:150px;">저장</button>
	</div>
</div>
</form>

<br>
</center>
<%@ include file="/WEB-INF/views/admin/include/footer.jsp" %>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 다음 우편번호 API 스크립트 -->
<script>
// 다음 우편번호 API 실행 함수
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {

            var roadAddr = data.roadAddress;
            var extraRoadAddr = '';

            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }

            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }

            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            document.getElementById('sample4_postcode').value = data.zonecode;
            document.getElementById("sample4_roadAddress").value = roadAddr;
            document.getElementById("sample4_jibunAddress").value = data.jibunAddress;

            if(roadAddr !== ''){
                document.getElementById("sample4_extraAddress").value = extraRoadAddr;
            } else {
                document.getElementById("sample4_extraAddress").value = '';
            }

            var guideTextBox = document.getElementById("guide");

            if(data.autoRoadAddress) {
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                guideTextBox.style.display = 'block';

            } else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                guideTextBox.style.display = 'block';
            } else {
                guideTextBox.innerHTML = '';
                guideTextBox.style.display = 'none';
            }
        }
    }).open();
}
</script>