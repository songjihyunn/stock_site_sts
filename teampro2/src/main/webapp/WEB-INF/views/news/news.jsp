<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<style>
    .pagination {
        display: flex;
        justify-content: center;
        margin-top: 20px;
    }

    .pagination a {
        color: black;
        float: left;
        padding: 8px 16px;
        text-decoration: none;
        transition: background-color .3s;
        border: 1px solid #ddd;
        margin: 0 4px;
    }

    .pagination a.active {
        background-color: black;
        color: white;
        border: black;
    }

    .pagination a:hover:not(.active) {
        background-color: black;
        color: white;
    }
</style>

<div class="container mt-4" style="height: 900px; margin-top: -200px;">
    <h1 class="mb-4">기사 분석</h1>

    <!-- 검색 폼 -->
    <form id="searchForm" class="mb-4" action="${pageContext.request.contextPath}/news" method="get">
        <div class="input-group" style="border-radius: 10px;">
            <input type="text" id="search_keyword" name="keyword" class="form-control rounded-end-0"
                   placeholder="검색어를 입력하세요" value="${empty param.keyword ? '' : param.keyword}">
            <div class="input-group-append">
                <button type="submit" class="btn rounded-start-0" style="background-color: black; color: white">검색</button>
            </div>
        </div>
    </form>

    <div class="container">
        <table style="border:0;border-collapse: collapse;">
            <thead style="font-weight: bold;">
                <tr>
                    <td style="padding-bottom: 5px;"></td>
                    <td style="padding-bottom: 5px; font-size: 24px;">제목/내용</td>
                    <td style="text-align:center; padding-bottom: 15px; font-size: 24px;">감정분석</td>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty list}">
                        <tr>
                            <td colspan="3">데이터가 없습니다.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="news" items="${list}">
                            <tr>
                                <td rowspan="2" style="width: 10%; padding-bottom: 10px; padding-top: 10px;text-align: center">
                                    <c:choose>
                                        <c:when test="${not empty news.imageFileNames}">
                                            <img src="${pageContext.request.contextPath}/img/${news.imageFileNames}" alt="News Image" style="width:100px; height:100px;">
                                        </c:when>
                                        <c:otherwise>
                                            <!-- 이미지가 없는 경우 아무것도 출력하지 않음 -->
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="width: 65%;">
								    <strong>
									    <a href="${pageContext.request.contextPath}/newsDetail?id=${news.id}" style="font-size: 20px;">
									        ${fn:substring(news.title, 0, 30)}${fn:length(news.title) > 30 ? '...' : ''}
									    </a>
									</strong>
								</td>
                                <td rowspan="2" style="font-size: 20px; font-weight: bold; text-align: center; padding-bottom: 10px;
								    color: ${news.sentimentPrediction == '긍정' ? 'blue' : (news.sentimentPrediction == '부정' ? 'red' : 'black')};">
								    ${news.sentimentPrediction}
								</td>

                            </tr>
                            <tr>
                                <td style="width: 25%;padding-bottom: 10px; font-size: 15px;">
                                    ${fn:substring(news.content, 0, 100)}${fn:length(news.content) > 100 ? '...' : ''}
                                </td>
                            </tr>
                            <tr><td colspan="3" style="border-bottom: 1px solid #ddd;"></td></tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
        <!-- 페이징 -->
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center">
                <c:if test="${pageMaker.prev}">
                    <li class="page-item">
                        <a class="page-link" href="${pageContext.request.contextPath}/news?page=${pageMaker.startPage - 1}&perPageNum=${pageMaker.cri.perPageNum}&keyword=${param.keyword}" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                </c:if>
                <c:forEach var="page" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                    <li class="page-item ${pageMaker.cri.page == page ? 'active' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/news?page=${page}&perPageNum=${pageMaker.cri.perPageNum}&keyword=${param.keyword}">${page}</a>
                    </li>
                </c:forEach>
                <c:if test="${pageMaker.next}">
                    <li class="page-item">
                        <a class="page-link" href="${pageContext.request.contextPath}/news?page=${pageMaker.endPage + 1}&perPageNum=${pageMaker.cri.perPageNum}&keyword=${param.keyword}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </div>
</div>


<%@ include file="/WEB-INF/views/include/footer.jsp" %>
