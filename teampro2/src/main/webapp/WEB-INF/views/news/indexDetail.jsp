<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<style>
    .large-bold-title {
        font-size: 32px;
        font-weight: bold;
        padding-bottom: 10px;
    }
    .container {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        margin-top: 20px;
        margin-bottom: 150px;
    }
    .left-content {
        width: 70%;
        padding-right: 20px;
    }
    .right-content {
        width: 30%;
    }
    .news-table {
        width: 100%;
        border-collapse: collapse;
    }
    .news-table th, .news-table td {
        border: 0px solid #ddd;
        padding: 5px;
    }
    .news-table th {
        padding-top: 8px;
        padding-bottom: 8px;
        text-align: left;
    }
    .news-content {
        width: 100%;
        white-space: pre-line;
        font-size: 18px;
    }
    .info-table {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
    }
    .info-table .stock-code {
        border-radius: 8px;
        padding: 8px 12px;
        text-align: center;
        font-weight: bold;
        width: 100px; /* 3개의 열로 나누기 */
        margin-bottom: 10px;
    }
    .related-title {
        font-size: 18px;
        font-weight: bold;
        margin-bottom: 10px;
        text-align: left;
        padding-top: 8px;
    }
    .news-image {
        width: 100%;
        max-height: 400px;
        object-fit: cover;
        padding-bottom: 15px;
    }
</style>
<center>
<div class="container">
    <div class="left-content">
        <table class="news-table">
            <tr>
                <th colspan="2" class="large-bold-title">${news.title}</th>
            </tr>
            <tr>
            	<td colspan="2"style="font-size: 15px; text-align: left;">${news.date }</td>
            </tr>
            <tr>
                <td style="vertical-align: top;">
                    <c:if test="${not empty news.imageFileNames}">
                        <img src="${pageContext.request.contextPath}/index_image/${news.imageFileNames}" alt="News Image" class="news-image">
                    </c:if>
                </td>
            </tr>
            <tr>
                <td class="news-content" id="newsContent">${news.content}</td>
            </tr>
            <tr>
            	<td style="padding-top: 20px; text-align: right">
                	<a href="/" class="btn btn-outline-dark">돌아가기</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="right-content">
    <c:choose>
        <c:when test="${not empty news.stockCode}">
            <div class="related-title">관련 항목</div>
            <div class="info-table">
                <c:set var="stockCodes" value="${fn:replace(news.stockCode, ',', '')}" />
                <c:set var="stockCodesArray" value="${fn:split(stockCodes, ' ')}" />
                
                <table style="table-layout: fixed; width: 100%;">
                    <c:forEach var="stockCode" items="${stockCodesArray}" varStatus="loop">
                        <c:if test="${loop.index % 3 == 0}">
                            <c:if test="${loop.index > 0}">
                                </tr>
                            </c:if>
                            <tr>
                        </c:if>
                        <td style="width: 100px;">
                            <div class="stock-code">
                                <c:set var="foundInStockList" value="false" />
                                <c:forEach var="stock" items="${stockList}">
                                    <c:if test="${stock.stockcode eq stockCode}">
                                        <div class="stock-item" style="border: 1px solid #ddd; border-radius: 5px; box-shadow: 2px 2px 5px rgba(0,0,0,0.1); padding: 10px;">
                                            <a href="${pageContext.request.contextPath}/stock/stockview?id=${stock.id}&stockcode=${stock.stockcode}" class="stock-link">
                                                ${stock.stockcode}
                                            </a>
                                        </div>
                                        <c:set var="foundInStockList" value="true" />
                                    </c:if>
                                </c:forEach>
                            
                                <c:if test="${not foundInStockList}">
                                    <div class="stock-item" style="border: 1px solid #ddd; border-radius: 5px; box-shadow: 2px 2px 5px rgba(0,0,0,0.1); padding: 10px;">
                                        <span class="text-muted">${stockCode}</span>
                                    </div>
                                </c:if>
                            </div>
                        </td>
                        <c:if test="${loop.index % 3 == 2 or loop.last}">
                            </tr>
                        </c:if>
                    </c:forEach>
                </table>
            </div>
        </c:when>
    </c:choose>
</div>

</div>
</center>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
