<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/header.jsp" %>
<style>
  .phone-input {
    display: flex;
    flex-direction: row;
  }
  .phone-input .form-control {
    margin-right: 5px;
    width: 80px;
  }
</style>
<script>
$(document).ready(function(){
    $("#useremail").keyup(function(event){        
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            $(this).val($(this).val().replace(/[^_a-z0-9@.]/gi,"")); // Allows only _, a-z, 0-9, @, .
        }
    });
});

let timer;

function startTimer(duration, display) {
    let timer = duration, minutes, seconds;
    setInterval(function () {
        minutes = parseInt(timer / 60, 10);
        seconds = parseInt(timer % 60, 10);

        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;

        display.textContent = minutes + ":" + seconds;

        if (--timer < 0) {
            timer = duration;
            display.textContent = "00:00";
            clearInterval(timer);
            alert("인증 시간이 만료되었습니다. 다시 시도해주세요.");
            $("#confirmation").prop("disabled", true);
            $("#verificationCodeDisplay").text(""); // Clear verification code
        }
    }, 1000);
}

function goEmail() {
    var email = buildEmail();
    if (!email) {
        alert("이메일을 정확히 입력해주세요.");
        return;
    }
    console.log("Constructed Email:", email); // Debugging line

    $.ajax({
        url: "/member/email",
        type: "get",
        dataType: "json",
        data: { email: email },
        error: function() {
            alert("메일 발송 실패");
        },
        success: function(response) {
            if (response.status === "success") {
                alert("메일 발송되었습니다.\n인증번호를 확인 후 기입하세요.");
                $("#verificationCodeDisplay").text(response.verificationCode); // For testing purposes
                $("#confirmation").prop("disabled", false); // Enable the confirmation input
                clearInterval(timer); // Clear any existing timer
                let threeMinutes = 60 * 3,
                    display = document.querySelector('#timerDisplay');
                startTimer(threeMinutes, display);
            } else {
                alert("메일 발송 실패");
            }
        }
    });
}

function buildEmail() {
    var userEmail = $("#useremail1").val();
    var emailProvider = $("#emailProvider").val();
    var customDomain = $("#customDomainInput").val();
    
    if (emailProvider === 'custom') {
        if (!customDomain) {
            return null;
        }
        document.getElementById("useremail").value = userEmail + customDomain;
        return userEmail + customDomain;
    } else {
    	document.getElementById("useremail").value = userEmail + '@' + emailProvider;
        return userEmail + '@' + emailProvider;
    }
}

function okEmail() {
    var code = $("#confirmation").val();
    var verificationCode = $("#verificationCodeDisplay").text().trim(); // verification code 추가 및 공백 제거

    // 입력 값과 표시된 인증 코드 값이 같은지 확인
    if (code.trim() === verificationCode) {
        // Ajax 요청
        $.ajax({
            url: "/member/ok",
            type: "get",
            dataType: "text",
            data: {
                confirmation: code, // confirmation 값
                verificationCode: verificationCode // verification code 값
            },
            error: function() {
                alert("인증번호 확인 실패");
                $("#verificationStatus").val("N");
            },
            success: function(str) {
                if (str === "yes") {
                    alert("인증번호가 확인되었습니다.");
                    $("#verificationStatus").val("Y");
                    $("#emailresult").val("Y");
                    clearInterval(timer); // Stop the timer on success
                } else {
                    alert("인증번호를 잘못 입력하셨습니다.");
                    $("#verificationStatus").val("N");
                    $("#emailresult").val("N");
                }
            }
        });
    } else {
        alert("인증번호가 일치하지 않습니다. 다시 확인해주세요.");
        $("#verificationStatus").val("N");
        $("#emailresult").val("N");
    }
}

function checkPasswordMatch() {
    var password = document.getElementsByName('userpw')[0].value;
    var confirmPassword = document.getElementsByName('userpw')[1].value;
    var message = document.getElementById('message');

    if (password === confirmPassword) {
        message.style.color = 'green';
        message.textContent = '비밀번호가 일치합니다. 사용 가능합니다.';
    } else {
        message.style.color = 'red';
        message.textContent = '비밀번호가 일치하지 않습니다. 다시 확인해주세요.';
    }
}

function toggleCustomDomainInput() {
    var emailProvider = document.getElementById('emailProvider');
    var customDomainInput = document.getElementById('customDomainInput');

    if (emailProvider.value === 'custom') {
        customDomainInput.removeAttribute('disabled');
    } else {
        customDomainInput.setAttribute('disabled', 'disabled');
        customDomainInput.value = '';
    }
}

function validateForm(event) {
    var verificationStatus = $("#verificationStatus").val();

    if (verificationStatus === "N") {
        alert("이메일 인증을 완료해주세요.");
        event.preventDefault(); // Prevent form submission

        // 입력란 비활성화
        $("#confirmation").prop("disabled", true);
        $("#userpw").prop("disabled", true);
        $("input[name='username']").prop("disabled", true);
        $("input[name^='phone']").prop("disabled", true);
        $("input[name^='zipcode']").prop("disabled", true);
        $("button[type='submit']").prop("disabled", true);
    }
}


</script>

<center>

<h3>회원가입</h3>
  <div class="container" style="margin-bottom:100px;">
    <form method="post" onsubmit="validateForm(event)">
        <input type="hidden" id="emailresult" name="emailresult" value="N">
        <table class="table table-bordered" style="width: 700px;">
             <tr>
                <td width="100">이메일 주소</td>
                <td>
                    <div style="display: flex; align-items: center;">
                        <input id="useremail1" name="useremail1" class="form-control" style="margin-right: 5px; width: 150px" required>
                        <span style="margin-right: 5px;">@</span>
                        <select id="emailProvider" class="form-select" style="margin-right: 5px; width: 100px" onchange="toggleCustomDomainInput()" required>
                            <option value="">선택하세요</option>
                            <option value="naver.com">naver.com</option>
                            <option value="gmail.com">gmail.com</option>
                            <option value="yahoo.com">yahoo.com</option>
                            <option value="hotmail.com">hotmail.com</option>
                            <option value="custom">직접 입력</option>
                        </select>
                        <input type="text" id="customDomainInput" name="customDomain" class="form-control" style="margin-right: 5px; width: 150px" placeholder="직접 입력" disabled>
                        <input type="button" value="메일인증" class="btn btn-dark" onclick="goEmail()">
                    </div>
                    <span id="id_result"></span>
                </td>
            </tr>
            <tr>
                <td>인증번호 입력</td>
                <td>
                    <div style="display: flex; flex-direction: row; align-items: center;">
                        <input type="text" id="confirmation" name="confirmation" class="form-control" style="width: 350px; margin-right: 10px;" required disabled>
                        <input type="button" value="확인" class="btn btn-dark" onclick="okEmail()">
                        <span id="verificationCodeDisplay" style="color: red;"></span> <!-- Display verification code for testing -->
                    </div>
                    <div id="timerDisplay" style="margin-top: 10px; color: red; font-weight: bold;"></div>
                </td>
            </tr>
            <tr height="60px">
                <td>비밀번호</td>
                <td><input type="password" name="userpw" class="form-control" style="width: 350px" onkeyup="checkPasswordMatch()" required></td>
            </tr>
            <tr height="60px">
                <td>비밀번호 확인</td>
                <td><input type="password" name="userpw" class="form-control" style="width: 350px" onkeyup="checkPasswordMatch()" required></td>
                <div id="message" class="message"></div>
            </tr>
            <tr>
                <td>이름</td>
                <td><input name="username" class="form-control" style="width: 350px" required></td>
            </tr>
            <tr>
                <td>전화번호</td>
                <td>
                    <div style="display: flex; flex-direction: row;">
                        <input name="phone1" value="010" class="form-control" style="width: 80px; margin-right: 5px;" required>
                        <span>- </span>
                        <input name="phone2" class="form-control" style="width: 80px; margin-right: 5px;" required>
                        <span>- </span>
                        <input name="phone3" class="form-control" style="width: 80px;" required>
                    </div>
                </td>
            </tr>
            <tr>
                <td>주소</td>
                <td>
                    <div style="display: flex; align-items: center;">
                        <input type="text" id="sample4_postcode" name="zipcode" class="form-control" style="width: 120px; margin-right: 5px;" required>
                        <button type="button" class="btn btn-dark" onclick="sample4_execDaumPostcode()">우편번호 찾기</button>
                    </div>
                    <input type="text" id="sample4_roadAddress" name="zipcode1" class="form-control" placeholder="도로명주소" style="margin-top: 10px;" required>
                    <input type="text" id="sample4_jibunAddress" name="zipcode2" class="form-control" placeholder="지번주소" style="margin-top: 10px;" required>
                    <span id="guide" style="color: #999; display: none;"></span>
                    <input type="text" id="sample4_detailAddress" name="zipcode3" class="form-control" placeholder="상세주소" style="margin-top: 10px;" required>
                    <input type="text" id="sample4_extraAddress" name="zipcode4" class="form-control" placeholder="참고항목" style="margin-top: 10px;" required>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                	<input type="hidden" id="useremail" name="useremail" class="form-control">
                    <button type="submit" class="btn btn-dark">회원가입</button>
                </td>
            </tr>
        </table>
    </form>
  </div>
</center>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	
	var userEmail1 = $("#useremail1").val(); 
	var emailProvider = $("#emailProvider").val();
	var customDomain = $("#customDomainInput").val();
	
	var email;
	if (emailProvider === 'custom') {
	    if (customDomain) {
	        email = userEmail1 + customDomain;
	    }
	} else {
	    email = userEmail1 + '@' + emailProvider;
	}
	
	document.getElementById("useremail").value = email;
	
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