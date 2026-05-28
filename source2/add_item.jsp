<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Dnf_Battle.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    전투 전투 = (전투) session.getAttribute("전투");
    if (전투 == null) { response.sendRedirect("index.jsp"); return; }

    String 현재캐릭터명 = (String) session.getAttribute("현재캐릭터명");
    if (현재캐릭터명 == null) {
%>
    <script> 
    	alert('먼저 캐릭터를 생성하거나 선택해주세요.'); 
    	location.href='index.jsp';
    </script>
<%
        return;
    }

    String 결과메시지 = null;
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String pid   = request.getParameter("pid");
        String iname = request.getParameter("iname");
        String itype = request.getParameter("itype");
        int value    = Integer.parseInt(request.getParameter("value"));
        boolean 성공 = 전투.아이템획득(pid, 현재캐릭터명, iname, itype, value);
        결과메시지 = 성공 ? "✅ 아이템 획득 성공!" : "❌ 아이템 획득 실패 (인증 실패 / 캐릭터 없음 / 인벤토리 가득 참).";
    }

    캐릭터 c = 전투.캐릭터_가져오기(현재캐릭터명);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>아이템획득</title>
    <style>
        body { font-family: 'Segoe UI', 'Malgun Gothic', sans-serif; background-color: #f4f7f6; max-width: 640px; margin: 30px auto; color: #333; }
        .card { background: white; border-radius: 12px; padding: 25px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        h2 { color: #c0392b; border-bottom: 2px solid #c0392b; padding-bottom: 10px; margin-top: 0; }
        input, select { width: 100%; padding: 10px; margin: 8px 0; border: 1px solid #ddd; border-radius: 6px; box-sizing: border-box; }
        button { width: 100%; padding: 12px; background: #c0392b; color: #fff; border: none; border-radius: 6px; cursor: pointer; font-weight: bold; margin-top: 10px; }
        button:hover { background: #a93226; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #eee; }
        th { background-color: #f8f9fa; font-size: 0.9em; color: #666; }
        .back-link { display: block; margin-top: 20px; text-align: center; color: #c0392b; text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>
    <div class="card">
        <h2>💎 아이템 획득</h2>
        <p>현재 접속 캐릭터: <b><%= 현재캐릭터명 %></b></p>
        
        <% if (결과메시지 != null) { %>
            <div style="padding: 10px; background-color: #e8f4fd; border-radius: 6px; margin-bottom: 20px; color: #2980b9;">
                <%= 결과메시지 %>
            </div>
        <% } %>

        <form action="add_item.jsp" method="post">
            <label>플레이어 ID</label>
            <input type="text" name="pid" value="hero" required>
            <label>아이템 이름</label>
            <input type="text" name="iname" value="둠스데이" required>
            <label>아이템 타입</label>
            <select name="itype">
                <option value="무기">⚔️ 무기</option>
                <option value="방어구">🛡️ 방어구</option>
                <option value="물약">🧪 물약</option>
            </select>
            <label>아이템 가치 (G)</label>
            <input type="number" name="value" value="1200" min="0">
            <button type="submit">인벤토리에 추가</button>
        </form>

        <h3 style="margin-top: 30px;">📦 인벤토리 현황 
            <% if (c != null) { %>
                <span style="font-size: 0.7em; color: #888;">(<%= c.인벤토리_가져오기().현재개수() %>/<%= c.인벤토리_가져오기().최대용량_가져오기() %>)</span>
            <% } %>
        </h3>
        
        <% if (c != null && c.인벤토리_가져오기().현재개수() > 0) { %>
            <table>
                <thead>
                    <tr>
                        <th>아이템명</th>
                        <th>타입</th>
                        <th>등급</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (아이템 it : c.인벤토리_가져오기().아이템리스트_가져오기()) { %>
                        <tr>
                            <td><%= it.아이템명_가져오기() %></td>
                            <td><%= it.타입_가져오기() %></td>
                            <td><span style="font-weight:bold; color: <%= it.등급_가져오기().contains("전설") ? "#e67e22" : (it.등급_가져오기().contains("희귀") ? "#9b59b6" : "#7f8c8d") %>;"><%= it.등급_가져오기() %></span></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } else { %>
            <p style="text-align: center; color: #999; padding: 20px;">인벤토리가 비어 있습니다.</p>
        <% } %>

        <a href="index.jsp" class="back-link">← 메인 화면으로</a>
    </div>
</body>
</html>
