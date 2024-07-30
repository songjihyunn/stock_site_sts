<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<style>
    .container {
        display: flex;
        flex-direction: column;
        margin-top: 20px;
        width: 1200px;
        height: 1200px;
    }
    .carousel-container {
        width: 100%;
        margin-bottom: 20px;
    }
    .content-container {
    	width: 100%;
    	height: 100%;
        display: flex;
    }
    .news-container, .side-container {
        flex: 1;
        margin: 20px;
        width: 50%;
    }
    .news-image {
        width: 100%;
        height: 400px;
        display: block;
    }
    .iframe-container {
        margin-top: 20px;
    }
    a:hover {
        text-decoration: underline !important;
    }
    .carousel-inner img {
        width: 100%;
        height: 80%;
        object-fit: fill;
    }
    .carousel-indicators button {
        background-color: black;
    }
    .card {
        height: 300px;
        overflow: auto;
    }
    .input-group .form-control {
        flex: 1;
    }
    .highlight {
        background-color: yellow;
    }
    .list-group-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
</style>

<div class="container">
    <!-- Carousel Section -->
    <div class="carousel-container">
        <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
            </div>
            <div class="carousel-inner" style="height:200px">
                <!-- Slide 1 -->
                <div class="carousel-item active">
                    <a href="https://www.ssfutures.com/ssf/customer/event/CUS_01202.cmd?EVENT_SEQ=130" target="_blank">
                        <img src="/ad/ad1.jpg" class="img-fluid" alt="Ad 1" class="d-block w-100">
                    </a>
                </div>
                <!-- Slide 2 -->
                <div class="carousel-item">
                    <a href="https://www.samsungfund.com/etf/insight/house-view/view.do?seq=58874&utm_source=investing&utm_medium=desktop_billboard_pc&utm_campaign=fri6pm_manhattan&utm_content=manhattan_240525" target="_blank">
                        <img src="/ad/ad2.jpg" class="img-fluid" alt="Ad 2" class="d-block w-100">
                    </a>
                </div>
                <!-- Slide 3 -->
                <div class="carousel-item">
                    <a href="https://mablewide.kbsec.com/go.able?forwardcd=m01010000&utm_source=investing&utm_medium=bboard_media_economy&utm_campaign=243q_event_plat0&utm_content=b_zero" target="_blank">
                        <img src="/ad/ad3.jpg" class="img-fluid" alt="Ad 3" class="d-block w-100">
                    </a>
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
    </div>
    
    <!-- Content Section -->
    <div class="content-container">
        <div class="news-container">
            <div style="width: 100%;">
                <c:choose>
                    <c:when test="${empty indexnews}">
                        <p>데이터가 없습니다.</p>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="news" items="${indexnews}">
                            <div>
                                <strong>
                                    <a href="${pageContext.request.contextPath}/indexDetail?id=${news.id}&stockCode=${news.stockCode}" style="text-decoration: none; color: black;">
                                        ${fn:substring(news.title, 0, 50)}${fn:length(news.title) > 50 ? '...' : ''}
                                    </a>
                                </strong>
                                <p style="margin-bottom: 0;">
                                    ${fn:substring(news.content, 0, 100)}${fn:length(news.content) > 100 ? '...' : ''}
                                </p>
                            </div>
                            <hr style="border-top: 1px solid #ddd; margin: 10px;">
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <div class="side-container">
            <iframe src="http://192.168.0.15:5000/kospi_kosdaq" width="550px" height="500px" frameborder="0"></iframe>

            <div class="card mt-4">
                <div class="card-body">
                    <!-- 검색 입력 필드와 버튼 -->
                    <div class="input-group mb-3">
                        <input type="text" class="form-control" id="searchInput" placeholder="검색어를 입력하세요..." aria-label="Recipient's username" aria-describedby="button-addon2">
                        <button onclick="filterCompanies()" class="btn btn-outline-primary" type="button" id="button-addon2" style="z-index: 0">검색</button>
                    </div>
                    <ul class="list-group" id="companyList">
                        <c:forEach items="${list}" var="item" varStatus="loop">
                            <li class="list-group-item">
                                <span id="company_name_${loop.index}" onclick="goToStock(${loop.index})" style="cursor:pointer;">${item.company_name}</span>
                                <span id="id_${loop.index}" style="display:none;">${item.id}</span>
                                <span id="stockcode_${loop.index}" style="display:none;">${item.stockcode}</span>
                                <button class="btn btn-primary" onclick="goToStock(${loop.index})">보기</button>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script>
	document.addEventListener('DOMContentLoaded', function () {
	    var swiper = new Swiper('.swiper-container', {
	        slidesPerView: 1, // 한 번에 하나의 슬라이드만 보여줌
	        spaceBetween: 800, // 슬라이드 간의 간격을 0으로 설정
	        pagination: {
	            el: '.swiper-pagination',
	            clickable: true,
	        },
	        autoplay: {
	            delay: 5000, // 5초 간격으로 슬라이드 전환
	            disableOnInteraction: false,
	        },
	        loop: false, // 무한 루프 비활성화
	    });
	});
	
    function filterCompanies() {
        // 검색 입력 필드의 값을 가져옴
        var input = document.getElementById('searchInput');
        var filter = input.value.toLowerCase();
        var ul = document.getElementById("companyList");
        var li = ul.getElementsByTagName('li');
        var firstMatch = null;

        // 이전 강조 표시 제거
        for (var i = 0; i < li.length; i++) {
            li[i].getElementsByTagName("span")[0].classList.remove('highlight');
            li[i].style.display = "none"; // 일단 모두 숨김
        }

        // 목록을 순회하면서 필터 적용
        for (var i = 0; i < li.length; i++) {
            var companyName = li[i].getElementsByTagName("span")[0];
            if (companyName) {
                var txtValue = companyName.textContent || companyName.innerText;
                if (txtValue.toLowerCase().indexOf(filter) > -1) {
                    li[i].style.display = ""; // 일치하는 항목 표시
                    if (!firstMatch) {
                        firstMatch = li[i]; // 첫 번째 일치 항목 저장
                    }
                }
            }
        }

        // 첫 번째 일치 항목 강조 및 포커스 이동
        if (firstMatch) {
            var firstMatchName = firstMatch.getElementsByTagName("span")[0];
            firstMatchName.classList.add('highlight');
            firstMatch.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
    }
    
    function goToStock(index){
        var id = document.getElementById("id_" + index).innerText.trim();
        var stockcode = document.getElementById("stockcode_" + index).innerText.trim();
        location.href = "/stock/stockview?id="+id+"&stockcode="+stockcode;
    }
</script>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
