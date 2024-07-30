<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<style>
    .centered-container {
        width: 70%;
        margin: 0 auto;
        text-align: center;
    }
</style>
<div class="centered-container my-5">
    <div class="text-center mb-4">
        <h2>포트폴리오 보기</h2>
    </div>
    <div class="row row-cols-1 row-cols-md-3 g-4">
        <c:forEach var="portVO" items="${list}">
            <div class="col">
                <div class="card h-100 shadow">
                    <div class="card-body d-flex flex-column align-items-center justify-content-center">
                        <h5 class="card-title">${portVO.company}</h5>
                        <form id="deleteForm${portVO.stock_id}" action="${pageContext.request.contextPath}/port/delete" method="post">
                            <input type="hidden" name="userid" value="${sessionScope.id}">
                            <input type="hidden" name="company" value="${portVO.company}">
                            <input type="hidden" name="stock_id" value="${portVO.stock_id}">
                            <c:forEach var="sd" items="${sd}">
                                <c:if test="${sd.stock_id eq portVO.stock_id}">
								    현재 주가: <fmt:formatNumber value="${sd.price}" type="currency" currencySymbol="" groupingUsed="true" /> 원
								</c:if>
                            </c:forEach>
                            <div class="form-check" align="left">
                                <input class="form-check-input select-checkbox" type="checkbox" value="${portVO.stock_id}" id="select${portVO.stock_id}" onclick="limitSelection(this)">
                                <label class="form-check-label" for="select${portVO.stock_id}">
                                    선택
                                </label>
                            </div>
                            <button type="button" class="btn btn-danger mt-3" onclick="deletePortfolio(${portVO.stock_id})">삭제</button>
                        </form>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    <div class="row justify-content-center mt-4">
        <div class="col-auto">
            <c:if test="${empty list}">
                <button type="button" class="btn btn-dark btn-lg" style="color: white;" onclick="window.location.href='/';">기업 보러 가기</button>
            </c:if>
            <c:if test="${not empty list}">
                <form id="uploadForm" action="http://192.168.0.15:5000/uploads" method="post">
                    <c:forEach var="portVO" items="${list}" varStatus="status">
                        <input type="hidden" name="stock_id${status.index + 1}" value="${portVO.stock_id}">
                    </c:forEach>
                    <button type="button" id="portfolioSubmitBtn" class="btn btn-primary btn-lg" style="color: white;" onclick="submitPortfolio()">완성하기</button>
                </form>
            </c:if>
        </div>
    </div>
</div>

<c:if test="${empty list}"> 
    <div class="centered-container my-5" style="height: 100px;">
        <div class="alert alert-secondary alert-dismissible fade show" role="alert">
            <svg width="30px" height="30px" xmlns="http://www.w3.org/2000/svg" class="bi bi-exclamation-triangle-fill flex-shrink-0 me-2" viewBox="0 0 16 16" role="img" aria-label="Warning:">
                <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
            </svg>
            <strong>포트폴리오 목록이 비어 있습니다.</strong>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </div>
</c:if>

<script>
    function submitPortfolio() {
        const selectedCheckboxes = document.querySelectorAll('.select-checkbox:checked');
        
        if (selectedCheckboxes.length === 0) {
            alert('최소 하나의 항목을 선택해야 합니다.');
            return;
        }

        selectedCheckboxes.forEach(checkbox => {
            const hiddenInput = document.createElement('input');
            hiddenInput.type = 'hidden';
            hiddenInput.name = 'selectedStockIds';
            hiddenInput.value = checkbox.value;
            document.getElementById('uploadForm').appendChild(hiddenInput);
        });

        document.getElementById('portfolioSubmitBtn').disabled = true;
        document.getElementById('portfolioSubmitBtn').innerHTML = `
            <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
            <span class="visually-hidden">Loading...</span>
        `;
        document.getElementById('uploadForm').submit();
    }

    function deletePortfolio(stockId) {
        const deleteButton = document.getElementById('deleteForm' + stockId).querySelector('button');
        deleteButton.disabled = true;
        deleteButton.innerHTML = `
            <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
            <span class="visually-hidden">Loading...</span>
        `;
        document.getElementById('deleteForm' + stockId).submit();
    }

    function limitSelection(checkbox) {
        const selectedCheckboxes = document.querySelectorAll('.select-checkbox:checked');
        if (selectedCheckboxes.length > 3) {
            checkbox.checked = false;
            alert('최대 3개 항목만 선택할 수 있습니다.');
        }
    }
</script>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>