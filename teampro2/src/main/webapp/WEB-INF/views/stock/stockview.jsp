<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.min.js"></script>
<c:if test="${sessionScope.level eq null}">
	<script>
		alert("로그인 후 사용 가능합니다.");
		location.href = "/member/login";
	</script>
</c:if>
<!-- 기본 정보 -->
<div class="container text-center">

    <div class="row">
		<div class="row">
			<div class="col-2">
				<div style="text-align:left;"><strong><h1>${stock.company_name}</h1></strong></div>
			</div>
			<c:if test="${sessionScope.level != null }">
				<div class="col-10">
	                <c:choose>
	                    <c:when test="${portCount == 0}">
	                        <div style="text-align:right;">
	                            <button id="in_polio" class="btn btn-outline-warning btn-lg">포트폴리오 담기</button>
	                        </div>
	                    </c:when>
	                    <c:otherwise>
	                        <div style="text-align:right;">
	                            <button id="in_polio" class="btn btn-warning btn-lg" style="color:white;" disabled>추가된 포트폴리오</button>
	                        </div>
	                    </c:otherwise>
	                </c:choose>
				</div>
			</c:if>
		</div>
	<hr>
		<div class="row bg-dark text-light">
			<div class="col">
				<label for="floatingInputValue">주식 코드</label>
				<div id="floatingInputValue"><font style="font-size:16px;">${stock.stockcode}</font></div>
			</div>
			<div class="col">
                <c:choose>
                    <c:when test="${stock.listing eq 'KS'}">
						<label for="floatingInputValue">상장</label>
                        <div id="floatingInputValue"><font style="font-size:16px;">KOSPI</font></div>
                    </c:when>
                    <c:when test="${stock.listing eq 'KQ'}">
						<label for="floatingInputValue">상장</label>
                        <div id="floatingInputValue"><font style="font-size:16px;">KOSDAQ</font></div>
                    </c:when>
                </c:choose>
			</div>
			<div class="col">
				<label for="floatingInputValue">업종</label>
				<div id="floatingInputValue"><font style="font-size:16px;">${stock.market_type }</font></div>
			</div>
			<div class="col">
				<label for="floatingInputValue">상장일</label>
				<div id="floatingInputValue"><font style="font-size:16px;"><fmt:formatDate value="${stock.listing_date }"/></font></div>
			</div>
		</div>
	<hr>

	    <div class="row">
	        <div style="text-align:left; font-size:18px; font-weight:bold;">${stock.company_name} 관련기사</div>
	    </div>
      	<c:choose>
			<c:when test="${newsCount eq 0 }">
 				<div class="row">
			        <div class="col-sm-12" style="text-align:left;">
 						<h6>관련 뉴스가 없습니다.</h6>
 					</div>
 				</div>
      		</c:when>
      		<c:otherwise>
	      		<div class="row">
			        <div class="col-sm-6" style="text-align:left;">
			            <div>
			                <c:forEach var="news" items="${news}" varStatus="loop" end="4">
			                    <div id="title_${loop.index}">
			                        <a href="/newsDetail?id=${news.id }">
			                            <c:choose>
			                                <c:when test="${fn:length(news.title) > 40}">
			                                    <div class="input-group mb-3">
			                                        <span class="input-group-text bg-danger text-light" id="basic-addon1" style="width:35px;"><strong>${loop.index + 1}</strong></span>
			                                        <div class="form-control">${fn:substring(news.title, 0, 40)}...</div>
			                                    </div>
			                                </c:when>
			                                <c:otherwise>
			                                    <div class="input-group mb-3">
			                                        <span class="input-group-text bg-danger text-light" id="basic-addon1" style="width:35px;"><strong>${loop.index + 1}</strong></span>
			                                        <div class="form-control">${news.title}</div>
			                                    </div>
			                                </c:otherwise>
			                            </c:choose>
			                        </a>
			                    </div>
			                </c:forEach>
			            </div>
			        </div>
			        <div class="col-sm-6" style="text-align:left;">
			            <div>
			                <c:forEach var="news" items="${news}" varStatus="loop" begin="5" end="9">
			                    <div id="title_${loop.index}">
			                        <a href="/newsDetail?id=${news.id }">
			                            <c:choose>
			                                <c:when test="${fn:length(news.title) > 40}">
			                                    <div class="input-group mb-3">
			                                        <span class="input-group-text bg-danger text-light" id="basic-addon1" style="width:35px;"><strong>${loop.index + 1}</strong></span>
			                                        <div class="form-control">${fn:substring(news.title, 0, 40)}...</div>
			                                    </div>
			                                </c:when>
			                                <c:otherwise>
			                                    <div class="input-group mb-3">
			                                        <span class="input-group-text bg-danger text-light" id="basic-addon1" style="width:35px;"><strong>${loop.index + 1}</strong></span>
			                                        <div class="form-control">${news.title}</div>
			                                    </div>
			                                </c:otherwise>
			                            </c:choose>
			                        </a>
			                    </div>
			                </c:forEach>
			            </div>
			        </div>
			    </div>
      		</c:otherwise>
      	</c:choose>    
	<hr><br><br>
	    <div class="row">
	        <div class="col-sm-2 mb-4">
	            <div>
	                <form method="POST" action="http://192.168.0.15:5000/prediction_kr" onsubmit="return handleFormSubmit()">
					    <div class="input-container" style="vertical-align: middle;">
					        <input type="hidden" id="stock_code" name="stock_code" value="${stock.stockcode}.${stock.listing}">
					        <input type="hidden" id="stock_id" name="stock_id" value="${stock.id}">
					        <input type="hidden" id="user_id" name="user_id" value="${sessionScope.id}">
					        <button id="prediction_button" type="submit" class="btn btn-outline-primary" style="width:100%; height:40px;font-size:20px;">머신러닝 주가 예측</button>
					    </div>
					</form>
	                <br>
	                <div class="results">
	                    <div class="result-item">
	                        <div class="col-md">
	                            <div class="form-floating">
	                                <div class="form-control" id="linear_avg" style="font-size:16px;"></div>
	                                <label for="floatingInputGrid">Model A 예상 주가</label>
	                            </div>
	                            <div class="form-floating">
	                                <div class="form-control" id="svm_avg" style="font-size:16px;"></div>
	                                <label for="floatingInputGrid">Model B 예상 주가</label>
	                            </div>
	                            <div class="form-floating">
	                                <div class="form-control" id="rf_avg" style="font-size:16px;"></div>
	                                <label for="floatingInputGrid">Model C 예상 주가</label>
	                            </div>
	                            <div class="form-floating">
	                                <div class="form-control" id="lstm_avg" style="font-size:16px;"></div>
	                                <label for="floatingInputGrid">Model D 예상 주가</label>
	                            </div>
	                            <div class="form-floating">
	                                <div class="form-control" id="xgboost_avg" style="font-size:16px;"></div>
	                                <label for="floatingInputGrid">Model E 예상 주가</label>
	                            </div>
	                            <div class="form-floating">
	                                <div class="form-control" id="avg_prediction" style="font-size:16px;"></div>
	                                <label for="floatingInputGrid">Model Average</label>
	                            </div>
	                            <br>
	                            <div class="form-floating">
	                                <div class="form-control" id="current_price" style="font-size:16px;"></div>
	                                <label for="floatingInputGrid">현재 주가</label>
	                            </div>
	                            <div class="form-floating">
	                                <div class="form-control" id="next_day_prediction" style="font-size:20px; font-weight:bold;"></div>
	                                <label for="floatingInputGrid">Machine Learning 예상가</label>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	        <div class="col-sm-10">
	            <c:choose>
	                <c:when test="${stock.finance_analysis ne null}">
	                    <div class="form-floating mb-3">
	                    	<div><label for="floatingTextarea2Disabled" style="font-size:24px;"><strong style="font-size:28px; color:black;">${stock.company_name}</strong> AI 재무제표 분석</label></div><br>
	                        <textarea class="form-control" placeholder="Leave a comment here" id="floatingTextarea2Disabled" style="height: 397px; background-color:white; font-size:16px;" disabled>${stock.finance_analysis}</textarea>
	                    </div>
	                </c:when>
	                <c:otherwise>
	                    <div class="form-floating mb-3">
	                    	<div><strong style="font-size:28px; color:black;">${stock.company_name}</strong> AI 재무제표 분석</label></div><br>
	                        <textarea class="form-control" placeholder="Leave a comment here" id="floatingTextarea2Disabled" style="height: 397px; background-color:white; font-size:18px;" disabled></textarea>
	                    </div>
	                </c:otherwise>
	            </c:choose>
	        </div>
	    </div>
	</div>
	<hr>
	
    <div class="row">
        <div class="col-sm-12">
            <h1>${stock.company_name}</h1>
            <h5>기간별 주가 차트 검색</h5>
            <div class="chart-container" style="width: 100%; overflow-x: auto;">
                <iframe src="http://192.168.0.15:5000/stock_graph?stockcode=${stock.stockcode}" width="100%" height="600" frameborder="1"></iframe>
            </div>
        </div>
    </div>
    <br><br><br><br><br>
</div>

<div id="polio_name" style="display: None">${stock.company_name}</div>
<div id="polio_id" style="display: None">${stock.id}</div>
<div id="polio_userid" style="display: None">${sessionID}</div>

<!-- 포트폴리오 담기 함수 -->
<!-- 포트폴리오 담기 함수 -->
<script>
    document.getElementById("in_polio").addEventListener("click", function() {
        const polio_name = document.getElementById("polio_name").textContent;
        const polio_id = document.getElementById("polio_id").textContent;
        const polio_userid = document.getElementById("polio_userid").textContent;
 
        var data = {
            userid: polio_userid,
            company: polio_name,
            stock_id: polio_id
        };
 
        fetch('/stock/stockview/addToPortfolio', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        })
        .then(response => response.json())
        .then(result => {
            if (result.success) {
                alert('포트폴리오에 추가되었습니다!');
                window.location.reload();
            } else {
                alert('추가 중 오류가 발생했습니다.');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('서버 오류가 발생했습니다.');
        });
    });
    
    function handleFormSubmit() {
        var stockCode = document.getElementById('stock_code').value;

        conf = confirm("머신러닝 완료까지 2~3분 가량 소요됩니다.")
        if (conf == true) {
            var predictionButton = document.getElementById('prediction_button');
            // Replace the button with the spinner button
            predictionButton.outerHTML = `
                <button class="btn btn-primary" type="button" disabled style="width:100%; height:40px; font-size:20px;">
                    <span class="spinner-border spinner-border-sm" aria-hidden="true"></span>
                    <span role="status" style="font-size:20px;">주가 예측 중</span>
                </button>
            `;
            return true; // Proceed with form submission
        } else {
            alert("취소하였습니다")
            return false;
        }
    }
    
    // 페이지 로드 시 URL에서 쿼리 파라미터 추출 및 표시
    window.onload = function() {
        const urlParams = new URLSearchParams(window.location.search);
        const linearAvg = urlParams.get('A');
        const svmAvg = urlParams.get('B');
        const rfAvg = urlParams.get('C');
        const lstmAvg = urlParams.get('D');
        const xgboostAvg = urlParams.get('E');
        const avgPrediction = urlParams.get('av');
        const currentPrice = urlParams.get('cu');
        const nextDayPrediction = urlParams.get('pr');

        // 값을 페이지에 표시
        document.getElementById('linear_avg').textContent = linearAvg ? parseFloat(linearAvg).toFixed(2) : '-';
        document.getElementById('svm_avg').textContent = svmAvg ? parseFloat(svmAvg).toFixed(2) : '-';
        document.getElementById('rf_avg').textContent = rfAvg ? parseFloat(rfAvg).toFixed(2) : '-';
        document.getElementById('lstm_avg').textContent = lstmAvg ? parseFloat(lstmAvg).toFixed(2) : '-';
        document.getElementById('xgboost_avg').textContent = xgboostAvg ? parseFloat(xgboostAvg).toFixed(2) : '-';
        document.getElementById('avg_prediction').textContent = avgPrediction ? parseFloat(avgPrediction).toFixed(2) : '-';
        document.getElementById('current_price').textContent = currentPrice ? parseFloat(currentPrice).toFixed(2) : '-';
        document.getElementById('next_day_prediction').textContent = nextDayPrediction ? nextDayPrediction : '-';

        // 예상 값을 페이지에 표시하고 색상 변경
        const nextDayPredictionElement = document.getElementById('next_day_prediction');
        nextDayPredictionElement.textContent = nextDayPrediction ? nextDayPrediction : '-';

        if (nextDayPrediction === "상승 예상") {
            nextDayPredictionElement.style.color = 'red';
        } else {
            nextDayPredictionElement.style.color = 'blue';
        }
        
    }
    
</script>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
