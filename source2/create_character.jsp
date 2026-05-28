<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Dnf_Battle.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    전투 전투 = (전투) session.getAttribute("전투");
    if (전투 == null) { response.sendRedirect("index.jsp"); return; }

    String pid  = request.getParameter("pid");
    String name = request.getParameter("name");
    String job  = request.getParameter("job");
    int level   = Integer.parseInt(request.getParameter("level"));

    boolean 성공 = 전투.캐릭터생성(pid, name, job, level);   // 내부에서 플레이어체크 수행
    캐릭터 c = 전투.캐릭터_가져오기(name);
    if (성공) {
        session.setAttribute("현재캐릭터명", name);
    }
%>
<!DOCTYPE html>
<html lang="ko"><head><meta charset="UTF-8"><title>캐릭터생성 결과</title></head>
<body style="font-family:'맑은 고딕',sans-serif; max-width:600px; margin:30px auto;">
    <h2>① 캐릭터생성 결과</h2>
    <% if (성공) { %>
        <p>✅ 캐릭터 생성 성공!</p>
        <ul>
            <li>캐릭터명: <%= c.캐릭터명_가져오기() %></li>
            <li>레벨: <%= c.레벨_가져오기() %></li>
            <li>HP: <%= c.HP_가져오기() %></li>
            <li>공격력: <%= c.공격력_가져오기() %></li>
            <li>인벤토리: <%= c.인벤토리_가져오기().현재개수() %>/<%= c.인벤토리_가져오기().최대용량_가져오기() %> (빈 인벤토리 자동 생성)</li>
        </ul>
    <% } else { %>
        <p>❌ 캐릭터 생성 실패 (인증 실패 또는 잘못된 직업). 플레이어id는 "hero" 여야 합니다.</p>
    <% } %>
    <a href="index.jsp">← 메인으로</a>
</body></html>
