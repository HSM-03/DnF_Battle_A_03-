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
    캐릭터 c = 전투.get캐릭터(pid);
%>
<!DOCTYPE html>
<html lang="ko"><head><meta charset="UTF-8"><title>캐릭터생성 결과</title></head>
<body style="font-family:'맑은 고딕',sans-serif; max-width:600px; margin:30px auto;">
    <h2>① 캐릭터생성 결과</h2>
    <% if (성공) { %>
        <p>✅ 캐릭터 생성 성공!</p>
        <ul>
            <li>캐릭터명: <%= c.get캐릭터명() %></li>
            <li>레벨: <%= c.get레벨() %></li>
            <li>HP: <%= c.getHP() %></li>
            <li>공격력: <%= c.get공격력() %></li>
            <li>인벤토리: <%= c.get인벤토리().현재개수() %>/<%= c.get인벤토리().get최대용량() %> (빈 인벤토리 자동 생성)</li>
        </ul>
    <% } else { %>
        <p>❌ 캐릭터 생성 실패 (인증 실패 또는 잘못된 직업). 플레이어id는 "hero" 여야 합니다.</p>
    <% } %>
    <a href="index.jsp">← 메인으로</a>
</body></html>
