<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Dnf_Battle.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    전투 전투 = (전투) session.getAttribute("전투");
    if (전투 == null) { response.sendRedirect("index.jsp"); return; }

    String 결과메시지 = null;
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String pid   = request.getParameter("pid");
        String gname = request.getParameter("gname");
        boolean 성공 = 전투.길드가입(pid, gname);   // 인증 + 기존 길드 가입(Aggregation)
        결과메시지 = 성공 ? "✅ 길드가입 성공!" : "❌ 길드가입 실패 (인증 실패 / 캐릭터 없음 / 없는 길드 / 정원 초과).";
    }
%>
<!DOCTYPE html>
<html lang="ko"><head><meta charset="UTF-8"><title>길드가입</title>
<style>body{font-family:'맑은 고딕',sans-serif;max-width:600px;margin:30px auto;}
input,select{padding:6px;margin:3px 0;} button{padding:7px 14px;background:#c0392b;color:#fff;border:none;border-radius:5px;cursor:pointer;}</style></head>
<body>
    <h2>④ 길드가입 (Join_Guild_UI)</h2>
    <p style="color:#666;">※ 길드는 외부에서 이미 생성된 객체입니다(Aggregation). 등록된 길드: <b>불꽃군단</b>, <b>심연의탑</b> (정원 각 5명)</p>
    <% if (결과메시지 != null) { %><p><%= 결과메시지 %></p><% } %>

    <form action="join_guild.jsp" method="post">
        플레이어id: <input type="text" name="pid" value="hero"><br>
        길드명:
        <select name="gname">
            <option value="불꽃군단">불꽃군단</option>
            <option value="심연의탑">심연의탑</option>
            <option value="없는길드">없는길드 (실패 테스트)</option>
        </select><br>
        <button type="submit">가입</button>
    </form>

    <p><a href="index.jsp">← 메인으로</a></p>
</body></html>
