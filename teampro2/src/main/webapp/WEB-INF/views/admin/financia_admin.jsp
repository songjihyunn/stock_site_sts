<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
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
            height: 100%; /* 카드의 높이를 100%로 설정 */
        }

        .card-body {
            max-height: 500px; /* 카드 내용의 최대 높이 설정 */
            overflow-y: auto; /* 세로 스크롤바 표시 */
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

        .form-group {
            margin-bottom: 15px;
        }

        .btn-dark {
            background-color: #343a40;
            color: white;
        }

        .highlight {
            background-color: yellow;
        }
    </style>
<center>
    <div class="chat-container centered-container" style="height: 500px; margin-top: -100px">
        <div class="card" style="height: 500px">
            <div class="card-body">
                <div class="chat-message user bg-light rounded p-2 text-dark">
                    <h3>재무재표관리</h3>
                    <form action="http://192.168.0.15:5000/upload" method="post" enctype="multipart/form-data">        
                       <div class="form-group">
                           <input type="file" class="form-control" id="inputGroupFile04" aria-describedby="inputGroupFileAddon04" aria-label="Upload" name="file" required>
                        </div>
                        <div class="form-group">
                            <label for="stock_id" class="text-dark">등록할 기업 코드 기입:</label>
                            <input type="text" class="form-control" id="stock_id" name="stock_id" value="" required>
                        </div>
                        <button type="submit" class="btn btn-dark" style="margin-top:10px">분석 시작</button>
                    </form>
                </div>
                <div class="search-container">
                    <input type="text" id="searchInput" placeholder="검색어를 입력하세요..." class="form-control">
                    <button onclick="filterCompanies()" class="btn btn-primary">검색</button>
                </div>
                <ul class="list-group" id="companyList">
                    <c:forEach items="${list}" var="item" varStatus="loop">
                        <li class="list-group-item d-flex justify-content-between align-items-center" style="width:100%;">
                            <span id="company_name_${loop.index}" style="cursor:pointer;">${item.company_name}</span>
                            <span id="stockcode_${loop.index}" style="display:none;">${item.stockcode}</span>
                            <span id="company_id_${loop.index}" style="display:none;">${item.id}</span>
                            <button class="btn btn-dark" onclick="setStockId(${loop.index})">담기</button>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>

</center>

<script>
    function filterCompanies() {
        var input = document.getElementById('searchInput');
        var filter = input.value.toLowerCase();
        var ul = document.getElementById("companyList");
        var li = ul.getElementsByTagName('li');
        var firstMatch = null;

        for (var i = 0; i < li.length; i++) {
            li[i].getElementsByTagName("span")[0].classList.remove('highlight');
            li[i].style.display = "none";
        }

        for (var i = 0; i < li.length; i++) {
            var companyName = li[i].getElementsByTagName("span")[0];
            if (companyName) {
                var txtValue = companyName.textContent || companyName.innerText;
                if (txtValue.toLowerCase().indexOf(filter) > -1) {
                    li[i].style.display = "";
                    if (!firstMatch) {
                        firstMatch = li[i];
                    }
                }
            }
        }

        if (firstMatch) {
            var firstMatchName = firstMatch.getElementsByTagName("span")[0];
            firstMatchName.classList.add('highlight');
            firstMatch.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
    }

    function setStockId(index) {
        var companyID = document.getElementById("company_id_" + index).textContent.trim();
        document.getElementById("stock_id").value = companyID;
        // Scroll to the top of the page
        window.scrollTo(0, 0);
    }
</script>

<%@ include file="/WEB-INF/views/admin/include/footer.jsp" %>
