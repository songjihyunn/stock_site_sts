<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
  
  <!-- 네이버 스크립트 -->

<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>

<script>

// 로그인 페이지 활성

var naverLogin = new naver.LoginWithNaverId(
	{
		clientId: "PzI_TyCP7ljqIwPxS7xu", //내 애플리케이션 정보에 cliendId를 입력해줍니다.
		callbackUrl: "http://localhost:8080/member/naverLogin", // 내 애플리케이션 API설정의 Callback URL 을 입력해줍니다.
		isPopup: false,
		callbackHandle: true
	}
);	
naverLogin.init();
// 로그아웃
function openPopUp() {
	testPopUp= window.open("https://nid.naver.com/nidlogin.logout", "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,width=1,height=1");
}
function closePopUp(){
	location.href="/member/logout";
	testPopUp.close();
}
function naverLogout() {
	openPopUp();
	setTimeout(function() {
		closePopUp();
	}, 1000);
}
</script>

<!-- 카카오 스크립트 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
Kakao.init('c90f2fe6dbfb9972b2908d9e81e07d61'); //발급받은 키 중 javascript키를 사용해준다.
console.log(Kakao.isInitialized()); // sdk초기화여부판단
//카카오로그인
function kakaoLogin() {
	Kakao.Auth.login({
		success: function (response) {
			Kakao.API.request({
				url: '/v2/user/me',
				success: function (response) {

					//console.log(response); //회원정보 객체
					//console.log("식별 아이디:"+response.id);
					//console.log("이메일:"+response.kakao_account.email);

					//회원가입 처리 및 세션 처리
					$.ajax({
						url: "/member/kakao",
						type: "get",
						dataType: "text",
						data: "useremail="+response.kakao_account.email,
						success:function(num){
							//추가 내용 작성
							location.href="/"; //첫 페이지로 이동
						}
					});
				},
				fail: function (error) {
					console.log(error)
				},
			})
		},
		fail: function (error) {
			console.log(error)
		},
	});
}

//카카오로그아웃  
function kakaoLogout() {
	if (Kakao.Auth.getAccessToken()) {
		Kakao.API.request({
			url: '/v1/user/unlink',
			success: function (response) {
				//console.log(response);
				//로그아웃 세션 삭제후 첫 페이지 이동
				$.ajax({
					url: "/member/kakaoLogout",
					type: "get",
					dataType: "text",
					success:function(num){
						if(num == 'kakaoLogout'){
							location.href="/";
						}
					}
				});
			},
			fail: function (error) {
				console.log(error);
			},			
		})
		Kakao.Auth.setAccessToken(undefined);		
	}
}
</script>