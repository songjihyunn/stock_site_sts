<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<!-- 간단한 스타일링 추가 -->
<style>
    /* 폼 전체 스타일링 */
    form {
        max-width: 600px;
        margin: 0 auto;
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 10px;
        background-color: #f9f9f9;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    /* 레이블 스타일링 */
    label {
        font-weight: bold;
        display: block;
        margin-bottom: 8px;
    }

    /* 텍스트 영역 스타일링 */
    textarea {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 16px;
        margin-bottom: 20px;
        resize: vertical; /* 세로로만 크기 조절 가능 */
    }

    /* 제출 버튼 스타일링 */
    input[type="submit"] {
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 5px;
        padding: 10px 20px;
        font-size: 16px;
        cursor: pointer;
    }

    /* 제출 버튼 호버 효과 */
    input[type="submit"]:hover {
        background-color: #0056b3;
    }
</style>

<form action="http://192.168.0.15:5000/uploads" method="post">
    <label for="news">뉴스 감정 분석:</label>
    <textarea id="news" name="news" rows="4" cols="50" placeholder="예: 최근 기술 주식에 대한 긍정적인 뉴스가 많이 나왔습니다."></textarea>

    <label for="ml">머신러닝 예측:</label>
    <textarea id="ml" name="ml" rows="4" cols="50" placeholder="예: 다음 분기 동안 AI 기반 기업의 주가 상승이 예상됩니다."></textarea>

    <label for="analysis">기본 분석:</label>
    <textarea id="analysis" name="analysis" rows="4" cols="50" placeholder="예: 재무제표 분석 결과, 매출이 꾸준히 증가하고 있는 기술 산업의 기업을 추천합니다."></textarea>

    <input type="submit" value="제출">
</form>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>