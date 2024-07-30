<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<style>
    /* 기본적으로 #result 요소를 숨김 처리 */
    #result {
        visibility: hidden;  
    }
    
    .centered-container {
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        flex-direction: column;
    }
    .card {
        width: 100%;
        max-width: 600px; /* 카드의 최대 너비를 설정하여 크기 줄이기 */
    }
    .card pre {
        white-space: pre-wrap; /* 줄바꿈을 유지하도록 설정 */
    }
    .form-control {
        width: 60%;
    }
</style>
<script>
	// 오늘 날짜를 yyyy-mm-dd 형식으로 설정하는 함수
	function setTodayDate() {
	    var today = new Date();
	    var dd = String(today.getDate()).padStart(2, '0');
	    var mm = String(today.getMonth() + 1).padStart(2, '0'); // 1월은 0부터 시작하므로 +1
	    var yyyy = today.getFullYear();
	
	    today = yyyy + '-' + mm + '-' + dd;
	    document.getElementById("date").value = today;
	}
	
	// 페이지가 로드될 때 오늘 날짜 설정
	window.onload = function() {
	    setTodayDate();
</script>
<center>
    <div class="container my-5">
        <!-- API 요청 폼 -->
        <div class="card mb-4">
            <div class="card-body">
                <h2 class="card-title">종목 조회</h2>
                <form id="apiForm">
                    <div class="mb-3">
                        <label for="itmsNm" class="form-label">종목 이름:</label>
                        <input type="text" class="form-control" id="itmsNm" name="itmsNm" required>
                    </div>
                   <input type="hidden" class="form-control" id="basDt" name="basDt" value="20240521">
                  <button type="submit" class="btn btn-dark" style="margin-top: 10px; width:250px">검색</button>
                </form>
            </div>
        </div>

        <!-- 결과 표시 폼 -->
        <div class="card">
            <div class="card-body">
                <h2 class="card-title">종목 정보</h2>
                <form id="outputForm" method="post" action="${pageContext.request.contextPath}/port/join">
                    <div class="mb-3">
                        <label for="outputBasDt" class="form-label">기준 날짜:</label>
                        <input type="text" class="form-control" id="outputBasDt" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="outputSrtnCd" class="form-label">단축 코드:</label>
                        <input type="text" class="form-control" id="outputSrtnCd" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="outputIsinCd" class="form-label">ISIN 코드:</label>
                        <input type="text" class="form-control" id="outputIsinCd" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="outputMrktCtg" class="form-label">시장 구분:</label>
                        <input type="text" class="form-control" id="outputMrktCtg" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="outputItmsNm" class="form-label">종목 이름:</label>
                        <input type="text" class="form-control" id="outputItmsNm" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="outputCrno" class="form-label">법인 등록번호:</label>
                        <input type="text" class="form-control" id="outputCrno" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="outputCorpNm" class="form-label">법인 이름:</label>
                        <input type="text" class="form-control" id="outputCorpNm" readonly>
                    </div>
                    <input type="hidden" name="userid" value="${sessionScope.id}">
                    <input type="hidden" name="company" value="">
                    <button type="submit" class="btn btn-dark" style="width:250px">담기</button>
                </form>
            </div>
        </div>
        <!-- 숫자 표현 기업코드 -->
        <div class="mt-3">
            <input type="hidden" class="form-control" id="transformedValue" readonly>
        </div>
        
        <!-- API 결과 표시 이거 있어야 함 -->
        <div id="result" class="card mb-4">
            <div class="card-body">
                <h2 class="card-title">API 결과</h2>
                <pre id="resultContent" class="bg-light p-3 border rounded">API 결과가 여기에 표시됩니다.</pre>
            </div>
        </div>
    </div>
</center>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.min.js"></script>
<script>
    document.getElementById("apiForm").addEventListener("submit", function(event) {
        event.preventDefault(); // 기본 제출 동작 방지

        // 사용자 입력 가져오기
        const itmsNm = document.getElementById("itmsNm").value;
        const basDt = document.getElementById("basDt").value.replace(/-/g, ""); // 날짜 형식을 YYYYMMDD로 변환

        // API 요청을 보내는 함수
        function fetchData() {
            const numOfRows = 10; // 한 페이지 결과 수
            const pageNo = 1; // 페이지 번호
            const resultType = 'json'; // 결과 형식 (xml 또는 json)
            const serviceKey = 'UvV6%2BzR0Lup2dbFMgyX%2F5594xYCQbm56hEGBnnptwg4VVTr5vW7sRJi%2FxQBqPMfJknYaf35ZpqIcz0AR9i57aw%3D%3D'; // 서비스 키

            // URL 생성 (실제 API URL로 대체해야 합니다)
            const baseURL = 'https://apis.data.go.kr/1160100/service/GetKrxListedInfoService/getItemInfo';
            const queryParams = "?numOfRows=" + numOfRows +
                                "&pageNo=" + pageNo +
                                "&resultType=" + resultType +
                                "&serviceKey=" + serviceKey +
                                "&likeCorpNm=" + encodeURIComponent(itmsNm) +
                                "&basDt=" + basDt;
            const fullURL = baseURL + queryParams;

            // fetch API 사용하여 요청 보내기
            fetch(fullURL)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('네트워크 응답이 올바르지 않습니다.');
                    }
                    return response.json(); // 또는 .text()로 변경 가능
                })
                .then(data => {
                    // JSON 데이터를 보기 좋게 포맷하여 출력
                    displayResult(data);

                    // JSON 데이터를 파싱하여 다른 form 태그에 출력
                    const item = data.response.body.items.item[0];

                    if (item) {
                        document.getElementById("outputBasDt").value = item.basDt || 'N/A';
                        document.getElementById("outputSrtnCd").value = item.srtnCd || 'N/A';
                        document.getElementById("outputIsinCd").value = item.isinCd || 'N/A';
                        document.getElementById("outputMrktCtg").value = item.mrktCtg || 'N/A';
                        document.getElementById("outputItmsNm").value = item.itmsNm || 'N/A';
                        document.getElementById("outputCrno").value = item.crno || 'N/A';
                        document.getElementById("outputCorpNm").value = item.corpNm || 'N/A';

                        // Hidden input에 종목 이름 (company) 설정
                        document.querySelector('input[name="company"]').value = item.itmsNm || '';
                    } else {
                        document.getElementById("resultContent").innerText = '데이터가 없습니다.';
                    }
                })
                .catch(error => {
                    // 에러 메시지를 화면에 표시
                    document.getElementById("resultContent").innerText = '데이터를 가져오는데 실패했습니다.';
                    console.error('오류:', error);
                });
        }

        // 결과를 보기 좋게 출력하는 함수
        function displayResult(data) {
            const resultContainer = document.getElementById("result");
            const resultContent = document.getElementById("resultContent");
            
            if (data && data.response && data.response.body && data.response.body.items && data.response.body.items.item) {
                const items = data.response.body.items.item;

                // 결과를 보기 좋게 포맷
                resultContent.innerText = JSON.stringify(items, null, 2);
                resultContainer.style.display = 'block'; // 결과가 있을 때만 표시
            } else {
                resultContainer.style.display = 'none'; // 결과가 없을 때는 숨기기
            }
        }

        // fetchData 함수를 호출하여 데이터 가져오기
        fetchData();
    });

    document.getElementById('outputForm').addEventListener('submit', function(event) {
        // 기본 제출 동작 방지
        event.preventDefault(); 

        // Get the value of the outputSrtnCd field
        const outputSrtnCdValue = document.getElementById('outputSrtnCd').value;

        // Check if the value exists and has the expected format
        if (outputSrtnCdValue && outputSrtnCdValue.startsWith('A')) {
            // Remove the leading 'A' character
            const transformedValue = outputSrtnCdValue.slice(1);

            // Store the transformed value in the transformedValue field or another variable
            document.getElementById('transformedValue').value = transformedValue;

            // You can also perform other actions with the transformed value here
            console.log('Transformed Value:', transformedValue);
        } else {
            console.error('Invalid outputSrtnCd value');
        }

        // 데이터를 서버로 전송하기 위해 Ajax 사용
        const formData = new FormData(document.getElementById('outputForm'));

        fetch('/port/join', {
            method: 'POST',
            body: formData
        })
        .then(response => response.text()) // 서버에서 받은 응답을 텍스트로 변환
        .then(result => {
            console.log('Success:', result);
            alert('선택하신 종목을 담았습니다.');
            // 리디렉트 또는 다른 작업 수행
            window.location.href = '/'; // 홈으로 리디렉트
        })
        .catch(error => {
            console.error('Error:', error);
            alert('선택하신 종목을 담는데 실패했습니다.');
        });
    });
</script>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
