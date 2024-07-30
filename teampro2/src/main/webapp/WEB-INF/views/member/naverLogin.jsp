<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>


<!-- 네이버 스크립트 -->
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<script>
// 네이버에서 전송된 객체를 이용해서 세션 생성 페이지로 이동
var naverLogin = new naver.LoginWithNaverId(
	{
		clientId: "PzI_TyCP7ljqIwPxS7xu", //내 애플리케이션 정보에 cliendId를 입력해줍니다.
		callbackUrl: "http://localhost:8080/member/naverLogin", // 내 애플리케이션 API설정의 Callback URL 을 입력해줍니다.
		isPopup: true,
		callbackHandle: true
	}
);	
naverLogin.init();

window.addEventListener('load', function () {
	naverLogin.getLoginStatus(function (status) {
		if (status) {

			var id = naverLogin.user.id;
			var email = naverLogin.user.getEmail(); // 필수로 설정할것을 받아와 아래처럼 조건문을 줍니다.
			var name = naverLogin.user.name;
			var mobile = naverLogin.user.mobile;

			if( email == undefined || email == null) {
				alert("이메일은 필수정보입니다. 정보제공을 동의해주세요.");
				naverLogin.reprompt();
				return;
			}

			location.href="/member/naver?useremail="+email+"&username="+name+"&phone="+mobile;
		} else {
			console.log("callback 처리에 실패하였습니다.");
		}
	});
});
</script>