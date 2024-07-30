<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<script>

	var msg = "${msg}";
	
	if(msg == "modify"){
		alert("수정 되었습니다.");
	}

</script>

<center>


<h3>회원수정</h3>
<div class="container">
  <form method="post">
    <table class="table table-bordered" style="width: 600px;">
      <tr>
        <td width="100">메일주소</td>
        <td>
          <input id="useremail" name="useremail" class="form-control" style="width: 350px;" value="${member.useremail}">
        </td>
      </tr>
      <tr height="60px">
        <td>변경 비밀번호</td>
        <td><input type="password" name="userpw" class="form-control" style="width: 350px;"></td>
      </tr>
      <tr height="60px">
        <td>비밀번호 확인</td>
        <td><input type="password" name="userpw2" class="form-control" style="width: 350px;"></td>
      </tr>
      <tr>
        <td>이름</td>
        <td><input name="username" class="form-control" style="width: 350px;" value="${member.username}"></td>
      </tr>
      <tr>
        <td>연락처</td>
        <td>
          <div style="display: flex; flex-direction: row;">
            <input name="phone1" value="010" class="form-control" style="width: 80px; margin-right: 5px;" value="${member.phone1}">
            <input name="phone2" class="form-control" style="width: 80px; margin-right: 5px;" value="${member.phone2}">
            <span>- </span>
            <input name="phone3" class="form-control" style="width: 80px;" value="${member.phone3}">
          </div>
        </td>
      </tr>
      <tr>
        <td>주소</td>
        <td>
          <div style="display: flex; align-items: center;">
            <input type="text" id="sample4_postcode" name="zipcode" class="form-control" style="width: 120px; margin-right: 5px;" value="${member.zipcode}">
            <button type="button" class="btn btn-dark" onclick="sample4_execDaumPostcode()">우편번호 찾기</button>
          </div>
          <input type="text" id="sample4_roadAddress" name="zipcode1" class="form-control" placeholder="도로명주소" style="margin-top: 10px;" value="${member.zipcode1}">
          <input type="text" id="sample4_jibunAddress" name="zipcode2" class="form-control" placeholder="지번주소" style="margin-top: 10px;" value="${member.zipcode2}">
          <span id="guide" style="color: #999; display: none;"></span>
          <input type="text" id="sample4_detailAddress" name="zipcode3" class="form-control" placeholder="상세주소" style="margin-top: 10px;" value="${member.zipcode3}">
          <input type="text" id="sample4_extraAddress" name="zipcode4" class="form-control" placeholder="참고항목" style="margin-top: 10px;" value="${member.zipcode4}">
        </td>
      </tr>
      <tr>
        <td></td>
        <td>
          <button type="submit" class="btn btn-dark">회원수정</button>
        </td>
      </tr>
    </table>
  </form>
</div>
</center>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.

    function sample4_execDaumPostcode() {

        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }

                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                

                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }
                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
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

<%@ include file="/WEB-INF/views/include/footer.jsp" %>