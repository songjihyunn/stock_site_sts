<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<style>
    /* 추가된 CSS */
    .input-group .form-control {
        border-radius: 10px; /* 필요에 따라 입력 필드의 테두리를 조정할 수 있습니다. */
    }

    .input-group-append .btn {
        border-radius: 10px; /* 검색 버튼의 테두리도 조정할 수 있습니다. */
        margin-left: 10px; /* 검색 버튼과 입력 필드 사이의 간격을 조정합니다. */
    }
    
    /* Custom CSS */
    .rounded-start-0 {
        border-top-left-radius: 10px !important;
        border-bottom-left-radius: 10px !important;
    }

    .rounded-end-0 {
        border-top-right-radius: 10px !important;
        border-bottom-right-radius: 10px !important;
    }
    /* 테이블 전체 스타일 */
    .table {
        width: 100%;
        border-collapse: collapse;
    }

    /* 각 열의 너비 설정 */
    .table th, .table td {
        padding: 8px;
        text-align: left;
    }

    /* 제목 열 */
    .table th:nth-child(1) {
        width: 30%;
    }

    /* 내용 열 */
    .table td:nth-child(2) {
        width: 40%;
    }

    /* 이미지 열 */
    .table td:nth-child(3) {
        width: 20%;
    }

    /* 분석 열 */
    .table td:nth-child(4) {
        width: 10%;
    }

    /* 이미지 크기 조정 */
    .table img {
        width: 150px;
        height: auto;
    }

	/* 긍정 or 부정 */
   .sentiment-positive {
    color: blue !important;
    font-weight: bold;
	}
	
	.sentiment-negative {
	    color: red !important;
	    font-weight: bold;
	}

   /* 이미지 열과 Sentiment 열 가운데 정렬 */
    .table td:nth-child(3), /* 이미지 열 */
    .table td:nth-child(4) { /* Sentiment 열 */
        text-align: center;
    }

    /* Sentiment 열 글자 크기와 가운데 정렬 */
    .table td:nth-child(4) {
        font-size: 20px; /* 글자 크기 조정 */
        vertical-align: middle; /* 수직 정렬 중앙으로 설정 */
    }
</style>


<div class="container mt-4">
    <h1 class="mb-4">News</h1>
    <form id="searchForm" class="mb-4">
        <div class="input-group" style="border-radius: 10px;">
            <input type="text" id="search_keyword" class="form-control rounded-end-0" placeholder="검색어를 입력하세요">
            <div class="input-group-append">
                <button type="submit" class="btn btn-primary rounded-start-0">검색</button>
            </div>
        </div>
    </form>
    
    <!-- 데이터 테이블 -->
    <div id="newsTable" class="table-responsive">
        <table class="table">
            <thead>
			    <tr>
			        <th style="text-align: center; font-size: 20px;">제목</th>
			        <th style="text-align: center; font-size: 20px;">내용</th>
			        <th style="text-align: center; font-size: 20px;">이미지</th>
			        <th style="text-align: center; font-size: 20px;">분석</th> <!-- 새로 추가된 열 -->
			    </tr>
			</thead>

            <tbody id="newsTableBody">
                <!-- 여기에 JSON 데이터를 받아와서 반복적으로 테이블 로우를 생성 -->
            </tbody>
        </table>
    </div>

    <!-- 페이징 -->
    <nav>
        <ul id="pagination" class="pagination justify-content-center">
            <!-- 여기에 페이징 버튼이 추가될 예정 -->
        </ul>
    </nav>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    var currentPage = 1; // 현재 페이지
    var itemsPerPage = 20; // 페이지당 표시할 데이터 개수
    var pagesPerSection = 5; // 섹션당 표시할 페이지 개수

    loadAllData();

    $('#searchForm').on('submit', function(event) {
        event.preventDefault();
        currentPage = 1; // 검색 시 첫 페이지로 초기화
        var searchKeyword = $('#search_keyword').val().trim();
        if (searchKeyword === '') {
            loadAllData();
        } else {
            loadData(searchKeyword);
        }
    });

    function loadAllData() {
        $.ajax({
            url: 'http://localhost:5000/news',
            type: 'GET',
            dataType: 'json',
            success: function(response) {
                displayData(response);
                renderPagination(response.length);
            },
            error: function(xhr, status, error) {
                console.error('전체 데이터를 불러오는 중 오류가 발생했습니다:', status, error);
            }
        });
    }

    function loadData(keyword) {
        $.ajax({
            url: 'http://localhost:5000/news',
            type: 'POST',
            data: { search_keyword: keyword },
            dataType: 'json',
            success: function(response) {
                displayData(response);
                renderPagination(response.length);
            },
            error: function(xhr, status, error) {
                console.error('검색 데이터를 불러오는 중 오류가 발생했습니다:', status, error);
            }
        });
    }

    function displayData(data) {
        var tbody = $('#newsTable tbody');
        tbody.empty();

        var startIndex = (currentPage - 1) * itemsPerPage;
        var endIndex = Math.min(startIndex + itemsPerPage, data.length);

        for (var i = startIndex; i < endIndex; i++) {
            var item = data[i];
            var title = item.title || '';
            var content = item.content || '';
            var sentimentPrediction = item.sentimentPrediction || ''; // 추가된 부분

            // Sentiment에 따라 분석 열의 클래스 설정
            var sentimentClass = '';
            if (sentimentPrediction === '긍정') {
                sentimentClass = 'sentiment-positive';
            } else if (sentimentPrediction === '부정') {
                sentimentClass = 'sentiment-negative';
            }

            var row = '<tr>' +
                '<td>' + title + '</td>' +
                '<td>' + content + '</td>' +
                '<td>';

            if (Array.isArray(item.imageFileNames)) {
                $.each(item.imageFileNames, function(idx, imgName) {
                    row += '<img src="/resources/img/' + imgName + '" width="100">';
                });
            } else if (typeof item.imageFileNames === 'string') {
                row += '<img src="/resources/img/' + item.imageFileNames + '" width="100">';
            }

            row += '</td>' +
                '<td class="' + sentimentClass + '">' + sentimentPrediction + '</td>' + // 분석 컬럼 추가
                '</tr>';
            tbody.append(row);
        }
    }

    function renderPagination(totalItems) {
        var totalPages = Math.ceil(totalItems / itemsPerPage);
        var totalSections = Math.ceil(totalPages / pagesPerSection);
        var currentSection = Math.ceil(currentPage / pagesPerSection);

        var pagination = $('#pagination');
        pagination.empty();

        // '<' 버튼 추가
        var previousButton = '<li class="page-item ' + (currentPage === 1 ? 'disabled' : '') + '">' +
            '<a class="page-link" href="#" data-page="' + (currentPage - 1) + '">이전</a>' +
            '</li>';
        pagination.append(previousButton);

        // 페이지 버튼 추가
        var startPage = (currentSection - 1) * pagesPerSection + 1;
        var endPage = Math.min(startPage + pagesPerSection - 1, totalPages);

        for (var i = startPage; i <= endPage; i++) {
            var li = '<li class="page-item ' + (i === currentPage ? 'active' : '') + '">' +
                '<a class="page-link" href="#" data-page="' + i + '">' + i + '</a>' +
                '</li>';
            pagination.append(li);
        }

        // '>' 버튼 추가
        var nextButton = '<li class="page-item ' + (currentPage === totalPages ? 'disabled' : '') + '">' +
            '<a class="page-link" href="#" data-page="' + (currentPage + 1) + '">다음</a>' +
            '</li>';
        pagination.append(nextButton);

        // 페이지 번호 클릭 시 이벤트 처리
        pagination.find('a').click(function(event) {
            event.preventDefault();
            currentPage = parseInt($(this).data('page'));
            if ($('#search_keyword').val().trim() === '') {
                loadAllData();
            } else {
                loadData($('#search_keyword').val().trim());
            }
        });
    }
});

</script>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
