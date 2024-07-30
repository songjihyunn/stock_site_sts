<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/header.jsp" %>
 <script>
        // 페이지 로드 후 실행되는 함수
        window.onload = function() {
            // URL에서 message 파라미터 값 가져오기
            var message = new URLSearchParams(window.location.search).get('message');
            
            // 만약 메시지가 존재한다면
            if (message) {
                // 알림 창 표시
                alert(message);
            }
        };
 </script>
 <center>
 
<!--  <h3>아이디 찾기</h3>
 <br>
<form action="findUserId" method="post">
  <div class="row mb-4 align-items-center" style="max-width: 500px;">
    <div class="col-auto">
      <label for="phone" class="col-form-label">전화번호</label>
    </div>
    <div class="col-auto">
      <select class="form-select" style="width: 100px;" onchange="toggleCustomDomainInput()" required>
        <option value="">선택하세요</option>
        <option value="010">010</option>
        <option value="016">016</option>
        <option value="011">011</option>
      </select>
    </div>
    -
    <div class="col">
      <input type="text" class="form-control" name="phone2" id="phone2" style="width:100px;" placeholder="1234"> 
    </div>
    -
    <div class="col">
      <input type="text" class="form-control" name="phone3" id="phone3" style="width:100px;" placeholder="5678">
    </div>
  </div>
  <button type="submit" class="btn btn-dark">아이디 찾기</button>
</form>
<br> -->
<h3>비밀번호 찾기</h3>
<form action="findUserPass" method="post">
  <div class="row mb-4 align-items-center" style="max-width: 600px;">
    <div class="col-auto">
      <label for="email" class="col-form-label">E-mail</label>
    </div>
    <div class="col">
      <input class="form-control" type="email" id="email" name="email" style="width: 350px;" placeholder="example@example.com">
    </div>
  </div>
  <button type="submit" class="btn btn-dark">비밀번호 찾기</button>
</form>


</center>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>