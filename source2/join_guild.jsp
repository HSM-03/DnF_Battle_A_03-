<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Dnf_Battle.*" %>
<%@ page import="java.util.Map" %>
<%
    request.setCharacterEncoding("UTF-8");
    전투 전투 = (전투) session.getAttribute("전투");
    if (전투 == null) { response.sendRedirect("index.jsp"); return; }

    String 현재캐릭터명 = (String) session.getAttribute("현재캐릭터명");
    if (현재캐릭터명 == null) {
%>
    <script>alert('먼저 캐릭터를 생성하거나 선택해주세요.'); location.href='index.jsp';</script>
<%
        return;
    }

    String 결과메시지 = null;
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String pid   = request.getParameter("pid");
        String gname = request.getParameter("gname");
        boolean 성공 = 전투.길드가입(pid, 현재캐릭터명, gname);
        결과메시지 = 성공 ? "✅ 길드가입 성공!" : "❌ 길드가입 실패 (인증 실패 / 캐릭터 없음 / 없는 길드 / 정원 초과).";
    }
    
    Map<String, 길드> 길드맵 = 전투.길드맵_가져오기();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>길드가입</title>
    <style>
        body { font-family: 'Segoe UI', 'Malgun Gothic', sans-serif; background-color: #f4f7f6; max-width: 640px; margin: 30px auto; color: #333; }
        .card { background: white; border-radius: 12px; padding: 25px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        h2 { color: #c0392b; border-bottom: 2px solid #c0392b; padding-bottom: 10px; margin-top: 0; }
        input, select { width: 100%; padding: 10px; margin: 8px 0; border: 1px solid #ddd; border-radius: 6px; box-sizing: border-box; }
        button { width: 100%; padding: 12px; background: #c0392b; color: #fff; border: none; border-radius: 6px; cursor: pointer; font-weight: bold; margin-top: 10px; }
        button:hover { background: #a93226; }
        .guild-info { background-color: #f8f9fa; padding: 15px; border-radius: 8px; margin-bottom: 20px; font-size: 0.9em; }
        .back-link { display: block; margin-top: 20px; text-align: center; color: #c0392b; text-decoration: none; font-weight: bold; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #eee; }
    </style>
</head>
<body>
    <div class="card">
        <h2>🤝 길드 가입 신청</h2>
        <p>현재 캐릭터: <b><%= 현재캐릭터명 %></b></p>
        
        <div class="guild-info">
            ※ 길드는 외부에서 생성된 객체입니다(Aggregation).<br>
            현재 등록된 길드들의 현황을 확인하고 가입을 신청하세요.
        </div>

        <% if (결과메시지 != null) { %>
            <div style="padding: 10px; background-color: #e8f4fd; border-radius: 6px; margin-bottom: 20px; color: #2980b9;">
                <%= 결과메시지 %>
            </div>
        <% } %>

        <form action="join_guild.jsp" method="post">
            <label>플레이어 ID</label>
            <input type="text" name="pid" value="hero" required>
            <label>가입할 길드 선택</label>
            <select name="gname">
                <% for (길드 g : 길드맵.values()) { %>
                    <option value="<%= g.길드명_가져오기() %>"><%= g.길드명_가져오기() %> (<%= g.현재인원() %>/<%= g.최대인원_가져오기() %>)</option>
                <% } %>
                <option value="없는길드">실패 테스트용 길드</option>
            </select>
            <button type="submit">길드 가입 신청하기</button>
        </form>

        <h3 style="margin-top: 30px;">🏰 전체 길드 목록</h3>
        <table>
            <thead>
                <tr>
                    <th>길드명</th>
                    <th>현재 인원</th>
                    <th>상태</th>
                </tr>
            </thead>
            <tbody>
                <% for (길드 g : 길드맵.values()) { %>
                    <tr>
                        <td><b><%= g.길드명_가져오기() %></b></td>
                        <td><%= g.현재인원() %> / <%= g.최대인원_가져오기() %></td>
                        <td>
                            <span style="color: <%= g.정원초과인가() ? "#e74c3c" : "#27ae60" %>; font-weight: bold;">
                                <%= g.정원초과인가() ? "정원 초과" : "가입 가능" %>
                            </span>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>

        <a href="index.jsp" class="back-link">← 메인 화면으로</a>
    </div>
</body>
</html>
