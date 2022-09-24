<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ page import="kopo.poly.util.CmmUtil" %>
<%@page import="kopo.poly.dto.CCTVDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>


<%
    String SS_USER_ID = CmmUtil.nvl((String) session.getAttribute("SS_USER_ID"));

    List<CCTVDTO> rList = (List<CCTVDTO>) request.getAttribute("rList");

%>

    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>
<% 	for(CCTVDTO e : rList) { %>
<div><%=e.getLot() %></div>
<div><%=e.getLat() %></div>
<%} %>
</body>
<script type="text/javascript">


</script>
</html>