<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/header.jsp" %>

<script>
	var result = "${msg}";

if(result == "register"){
		alert("작성 완료!");
	}else if(result == "delete"){
		alert("삭제 완료!");
	}else if(result == "modify"){
		alert("수정 완료!");
	}
</script>

<br>
<center>

<h3>LIST PAGE</h3>

<table border=1 width=700>
	<tr>
		<th style="width:10px">BNO</th>
		<th>TITLE</th>
		<th>WRITER</th>
		<th>REGDATE</th>
		<th style="width: 40px">VIEWCNT</th>
	</tr>
	<c:forEach var="boardVO" items="${list}">
	<tr>
		<td align=center>${boardVO.bno }</td>
		<td><a href="/board/read?bno=${boardVO.bno }">${boardVO.title }</a></td>
		<td align=center>${boardVO.writer }</td>
		<!-- <td>${boardVO.regdate }</td>  --> 
		<td align=center><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${boardVO.regdate }"/></td>
		<td align=center>${boardVO.viewcnt }</td>
	</tr>
	</c:forEach>
</table>
<br>
<table border=0 width=700>
	<tr>
		<td align=right><a href="register">[글쓰기]</a></td>
	</tr>
</table>

</center>
<br>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>