<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<!-- Bootstrap CSS -->
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.min.js"></script>

<style>
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
        position: relative;
    }

    .form-control {
        width: 70%;
    }

    .highlight {
        background-color: yellow;
    }

    .search-container {
        display: flex;
        justify-content: space-between;
        margin-bottom: 1rem;
        position: sticky;
        top: 0;
        background-color: white;
        z-index: 1000;
        padding-top: 1rem;
        padding-bottom: 1rem;
    }

    .search-container input {
        flex-grow: 1;
        margin-right: 0.5rem;
    }

    .search-container button {
        flex-shrink: 0;
    }
</style>

<div class="card" style="height:600px; overflow: auto;">
    <div class="card-body">
        <!-- 검색 입력 필드와 버튼 -->
        <div class="search-container">
            <input type="text" id="searchInput" placeholder="검색어를 입력하세요..." class="form-control">
            <button onclick="filterCompanies()" class="btn btn-primary">검색</button>
        </div>
        <ul class="list-group" id="companyList">
            <c:forEach items="${list}" var="item" varStatus="loop">
                <li class="list-group-item d-flex justify-content-between align-items-center" style="width:100%;">
                    <span id="company_name_${loop.index}" onclick="goToStock(${loop.index})" style="cursor:pointer;">${item.company_name}</span>
                    <span id="stockcode_${loop.index}" style="display:none;">${item.stockcode}</span>
                    <button class="btn btn-primary" onclick="goToStock(${loop.index})">보기</button>
                </li>
            </c:forEach>
        </ul>
    </div>
</div>

<script>
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
        var stockcode = document.getElementById("stockcode_" + index).innerText.trim();
        /* alert("주식 코드: " + stockcode); */
        location.href = "/stock/stockview?stockcode="+stockcode;
    }
</script>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
