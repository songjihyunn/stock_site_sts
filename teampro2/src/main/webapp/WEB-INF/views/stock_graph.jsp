<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<html xmlns:th="http://www.thymeleaf.org">

<iframe src="http://192.168.0.48:5000/stock_graph" width="1400" height="600" frameborder="0">
</iframe>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

<script>

function handleFormSubmit() {
    var startDate = document.getElementById('start_date').value;
    var endDate = document.getElementById('end_date').value;
    var stockCode = document.getElementById('stock_code').value;

    if (!startDate || !endDate || !stockCode) {
        alert("모든 필드를 입력해주세요.");
        return false; // 폼 제출을 막음
    }

    var iframe = document.getElementById('stock_chart_iframe');
    iframe.src = 'http://192.168.0.15:5000/stock_graph?start_date=${startDate}&end_date=${endDate}&stock_code=${stockCode}';
    return true; // 폼 제출을 진행함
}
16
</script>

