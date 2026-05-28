<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Dnf_Battle.*" %>
<%
    String selectName = request.getParameter("selectName");
    if (selectName != null && !selectName.isEmpty()) {
        session.setAttribute("현재캐릭터명", selectName);
    }
    response.sendRedirect("index.jsp");
%>
