<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<style>
	th{
		border-bottom: 1px solid black;
	}
	.table-wrapper {
	    margin-bottom: 100px;
	}
</style>
<br>
<center>
<h3 style="font-weight: bold; font-size: 30px; margin-bottom: 30px;">'<c:out value="${keyword}" />' 검색결과</h3>

<!-- 게시판 검색 결과 -->
<h2 style="font-weight: bold; margin: 0px;">게시판 검색 결과</h2>
<table style="width:700px; border-top: 1px solid black; border-bottom: 1px solid black; border-collapse: collapse; position: relative; top: 40px; text-align: center; margin-bottom: 50px;">
	<tr style=" height: 30px; border-bottom: 1px solid black; background-color: black; color: white; font-weight: bold;">
		<th>번호</th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성날짜</th>
		<th>조회수</th>
	</tr>
	<c:set var="number" value="${pageMaker.totalCount - (pageMaker.cri.page - 1) * pageMaker.cri.perPageNum }" />
	<c:choose>
    <c:when test="${empty boardResults}">
        <tr>
            <td colspan="5" class="search-message">검색어 '${keyword}'에 대한 게시글이 없습니다.</td>
        </tr>
    </c:when>
    <c:otherwise>
    <c:forEach var="boardVO" items="${boardResults}" varStatus="status">
        <c:if test="${fn:containsIgnoreCase(boardVO.title, keyword) || fn:containsIgnoreCase(boardVO.content, keyword) || boardVO.title.toLowerCase().contains(keyword.toLowerCase()) || boardVO.content.toLowerCase().contains(keyword.toLowerCase())}">
            <tr>
                <td>${status.index + 1}</td>
                <td>
                    <a href="board/read?page=${pageMaker.cri.page}&perPageNum=${pageMaker.cri.perPageNum}&searchType=tc&keyword=${param.keyword}&bno=${boardVO.bno}">
                        ${boardVO.title}
                    </a>

                    <c:if test="${not empty boardVO.file01 || not empty boardVO.file02 || not empty boardVO.file03}">
                        [첨부]
                    </c:if>
                </td>
                <td>${boardVO.writer}</td>
                <td><fmt:formatDate pattern="yyyy-MM-dd" value="${boardVO.regdate}"/></td>
                <td>${boardVO.viewcnt}</td>
            </tr>
        </c:if>
    </c:forEach>
	    <c:if test="${fn:length(boardResults) == 0}">
	        <tr>
	            <td colspan="5" class="search-message">검색어 '${keyword}'에 대한 게시글이 없습니다.</td>
	        </tr>
	    </c:if>
	</c:otherwise>
</c:choose>
</table>

<br>

<!-- 페이지 네비게이션 -->
<c:if test="${pageMaker.totalCount > 0 && (keyword == '' || filteredResults > 0)}">
<table border=0 style="position: relative; top: 20px;">
	<tr>
		<c:if test="${pageMaker.prev}">
			<td><a href="search?${pageMaker.makeSearch(pageMaker.startPage - 1) }">&laquo;</a></td>
		</c:if>

		<c:forEach var="idx" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
			<td style="padding-left: 5px; padding-right: 5px;">
				<c:if test="${pageMaker.cri.page == idx}"><b></c:if>
				<a href="search${pageMaker.makeSearch(idx)}">${idx}</a>
				<c:if test="${pageMaker.cri.page == idx}"></b></c:if>
			</td>
		</c:forEach>

		<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
			<td><a href="search${pageMaker.makeSearch(pageMaker.endPage +1)}">&raquo;</a></td>
		</c:if>
	</tr>
</table>
</c:if>

<hr>

<!-- 뉴스 검색 결과 -->
<h2 style="font-weight: bold;">뉴스 검색 결과</h2>
<c:choose>
    <c:when test="${not empty newsResults and not empty indexNewsResults}">
        <!-- 둘 다 결과가 있는 경우 -->
        <table class = "table table-hover" style="width: 1000px; border-collapse: collapse; text-align: center; margin-bottom: 100px;">

            <thead>
                <tr>
                    <th scope="col" style="padding: 10px;">번호</th>
                    <th scope="col" style="padding: 10px;">제목</th>
                    <th scope="col" style="padding: 10px;">내용</th>
                </tr>
            </thead>
            <tbody class="table-group-divider">
                <c:set var="totalIndex" value="1" />
                <c:forEach var="newsVO" items="${newsResults}">
                    <tr>
                        <td scope="col">${totalIndex}</td>
                        <td><a href="newsDetail?id=${newsVO.id}">${fn:substring(newsVO.title, 0, 20)}${fn:length(newsVO.title) > 20 ? '...' : newsVO.title}</a></td>
                        <td>${fn:substring(newsVO.content, 0, 50)}${fn:length(newsVO.content) > 50 ? '...' : ''}</td>
                    </tr>
                    <c:set var="totalIndex" value="${totalIndex + 1}" />
                </c:forEach>
                <c:forEach var="indexNewsVO" items="${indexNewsResults}">
                    <tr>
                        <td>${totalIndex}</td>
                        <td><a href="indexDetail?id=${indexNewsVO.id}&stockCode=${indexNewsVO.stockCode}">${fn:substring(indexNewsVO.title, 0, 20)}${fn:length(indexNewsVO.title) > 20 ? '...' : indexNewsVO.title}</a></td>
                        <td>${fn:substring(indexNewsVO.content, 0, 50)}${fn:length(indexNewsVO.content) > 50 ? '...' : ''}</td>
                    </tr>
                    <c:set var="totalIndex" value="${totalIndex + 1}" />
                </c:forEach>
            </tbody>
        </table>
    </c:when>
    <c:when test="${not empty newsResults}">
        <!-- newsResults만 결과가 있는 경우 -->
        <table class = "table table-hover" style="width: 1000px; border-collapse: collapse; text-align: center; padding-bottom: 100px;">
            <thead>
                <tr>
                    <th scope="col" style="padding: 10px;">번호</th>
                    <th scope="col" style="padding: 10px;">제목</th>
                    <th scope="col" style="padding: 10px;">내용</th>
                </tr>
            </thead>
            <tbody>
                <c:set var="totalIndex" value="1" />
                <c:forEach var="newsVO" items="${newsResults}">
                    <tr>
                        <td scope="col">${totalIndex}</td>
                        <td><a href="newsDetail?id=${newsVO.id}">${fn:substring(newsVO.title, 0, 20)}${fn:length(newsVO.title) > 20 ? '...' : newsVO.title}</a></td>
                        <td>${fn:substring(newsVO.content, 0, 50)}${fn:length(newsVO.content) > 50 ? '...' : ''}</td>
                    </tr>
                    <c:set var="totalIndex" value="${totalIndex + 1}" />
                </c:forEach>
            </tbody>
        </table>
    </c:when>
    <c:when test="${not empty indexNewsResults}">
        <!-- indexNewsResults만 결과가 있는 경우 -->
        <table class = "table table-hover"style="width: 1000px; border-collapse: collapse; text-align: center; padding-bottom: 100px;">
            <thead>
                <tr>
                    <th scope="col" style="padding: 10px;">번호</th>
                    <th scope="col" style="padding: 10px;">제목</th>
                    <th scope="col" style="padding: 10px;">내용</th>
                </tr>
            </thead>
            <tbody>
                <c:set var="totalIndex" value="1" />
                <c:forEach var="indexNewsVO" items="${indexNewsResults}">
                    <tr>
                        <td scope="col">${totalIndex}</td>
                        <td><a href="indexDetail?id=${indexNewsVO.id}&stockCode=${indexNewsVO.stockCode}">${fn:substring(indexNewsVO.title, 0, 20)}${fn:length(indexNewsVO.title) > 20 ? '...' : indexNewsVO.title}</a></td>
                        <td>${fn:substring(indexNewsVO.content, 0, 50)}${fn:length(indexNewsVO.content) > 50 ? '...' : ''}</td>
                    </tr>
                    <c:set var="totalIndex" value="${totalIndex + 1}" />
                </c:forEach>
            </tbody>
        </table>
    </c:when>
    <c:otherwise>
        <!-- 둘 다 결과가 없는 경우 -->
        <p class="search-message">검색어 '${keyword}'에 대한 뉴스가 없습니다.</p>
    </c:otherwise>
</c:choose>

</center>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
