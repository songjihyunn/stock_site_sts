<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<script>
	var msg = "${msg}"; //로그인 정보가 들릴 경우
	if(msg != ""){
		alert(msg);
	}
</script>
<center>

<h3>로그인</h3>
<form method="post">
    <div class="row mb-4 align-items-center" style="width:600px">
        <div class="col">
            <label for="floatingInput" class="col-form-label"> 아이디 </label>
        </div>
        <div class="col">
            <input type="email" class="form-control" id="floatingInput" placeholder="email@example.com" name="useremail" style="width:350px">
        </div>
    </div>

    <div class="row mb-4 align-items-center" style="width:600px">
        <div class="col">
            <label for="floatingPassword" class="col-form-label">비밀번호</label>
        </div>
        <div class="col">
            <input type="password" class="form-control" id="floatingPassword" placeholder="Password" name="userpw" style="width:350px">
        </div>
    </div>
    <button type="button" class="btn btn-warning" onclick="kakaoLogin()" style="width: 70px; border-radius:15px">
    	<svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" fill="currentColor" class="bi bi-chat-fill" viewBox="0 0 16 16">
  			<path d="M8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6-.097 1.016-.417 2.13-.771 2.966-.079.186.074.394.273.362 2.256-.37 3.597-.938 4.18-1.234A9 9 0 0 0 8 15"/>
		</svg>
	</button>
	<button id="naverIdLogin_loginButton" type="button" class="btn btn-success" onclick="naverLogin()" style="width: 70px; color: black; border-radius:15px">
		<img width="15" height="15" src="/img/n.png" >
	</button>
    <button type="submit" class="btn btn-dark">로그인</button>
</form>
</center>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>