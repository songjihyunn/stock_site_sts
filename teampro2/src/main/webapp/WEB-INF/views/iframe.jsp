<%@ include file="/WEB-INF/views/include/header.jsp" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Iframe Example</title>
</head>
<body>
    <h1>Main Page</h1>
    <p>${message}</p>
    <iframe src="graph.html"></iframe>
</body>
</html>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
