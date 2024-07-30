<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<center>
    <div class="container my-5">
        <form method="post">
            <div class="card mx-auto" style="max-width: 600px;">
                <div class="card-header text-center bg-dark text-white">
                    <h5>나의 포트폴리오</h5>
                </div>
                <div class="card-body">
                    <div class="mb-3">
                        <input type="text" name="password1" class="form-control" placeholder="회사1" required>
                    </div>
                    <div class="mb-3">
                        <input type="text" name="password2" class="form-control" placeholder="회사2" required>
                    </div>
                    <div class="mb-3">
                        <input type="text" name="password3" class="form-control" placeholder="회사3" required>
                    </div>
                    <div class="mb-3">
                        <input type="text" name="password3" class="form-control" placeholder="회사4" required>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-dark">제출</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</center>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>