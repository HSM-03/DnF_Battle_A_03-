<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Dnf_Battle.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    전투 전투 = (전투) session.getAttribute("전투");
    if (전투 == null) { response.sendRedirect("index.jsp"); return; }

    String pid = request.getParameter("pid");
    String charName = request.getParameter("charName");

    if (charName == null || charName.isEmpty()) {
        charName = (String) session.getAttribute("현재캐릭터명");
    }

    캐릭터 캐릭터 = 전투.캐릭터_가져오기(charName);

    String 메시지 = 전투.몬스터공격(pid, 캐릭터);
    %>
<!DOCTYPE html>
<html lang="ko"><head><meta charset="UTF-8"><title>몬스터공격 결과</title></head>
<body style="font-family:'맑은 고딕',sans-serif; max-width:600px; margin:30px auto;">
    <h2>② 몬스터공격 결과</h2>
    <p><%= 메시지 %></p>
    <a href="index.jsp">← 메인으로</a>
</body></html>
