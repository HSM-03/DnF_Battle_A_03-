<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Dnf_Battle.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    전투 전투 = (전투) session.getAttribute("전투");
    if (전투 == null) { response.sendRedirect("index.jsp"); return; }

    String 결과메시지 = null;
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String pid   = request.getParameter("pid");
        String iname = request.getParameter("iname");
        String itype = request.getParameter("itype");
        int value    = Integer.parseInt(request.getParameter("value"));
        boolean 성공 = 전투.아이템획득(pid, iname, itype, value);   // 인증 + 인벤토리 추가
        결과메시지 = 성공 ? "✅ 아이템 획득 성공!" : "❌ 아이템 획득 실패 (인증 실패 / 캐릭터 없음 / 인벤토리 가득 참).";
    }

    캐릭터 c = 전투.get캐릭터("hero");
%>
<!DOCTYPE html>
<html lang="ko"><head><meta charset="UTF-8"><title>아이템획득</title>
<style>body{font-family:'맑은 고딕',sans-serif;max-width:640px;margin:30px auto;}
input,select{padding:6px;margin:3px 0;} button{padding:7px 14px;background:#c0392b;color:#fff;border:none;border-radius:5px;cursor:pointer;}
table{border-collapse:collapse;width:100%;margin-top:10px;} td,th{border:1px solid #ddd;padding:6px;text-align:left;}</style></head>
<body>
    <h2>③ 아이템획득 (Add_Item_UI)</h2>
    <% if (결과메시지 != null) { %><p><%= 결과메시지 %></p><% } %>

    <form action="add_item.jsp" method="post">
        플레이어id: <input type="text" name="pid" value="hero"><br>
        아이템명: <input type="text" name="iname" value="둠스데이"><br>
        타입:
        <select name="itype">
            <option value="무기">무기</option>
            <option value="방어구">방어구</option>
            <option value="물약">물약</option>
        </select><br>
        가치: <input type="number" name="value" value="1200" min="0"><br>
        <button type="submit">획득</button>
    </form>

    <h3>📦 현재 인벤토리
        <% if (c != null) { %>(<%= c.get인벤토리().현재개수() %>/<%= c.get인벤토리().get최대용량() %>)<% } %></h3>
    <% if (c != null && c.get인벤토리().현재개수() > 0) { %>
        <table>
            <tr><th>아이템명</th><th>타입</th><th>가치</th><th>등급</th></tr>
            <% for (아이템 it : c.get인벤토리().get아이템리스트()) { %>
                <tr>
                    <td><%= it.get아이템명() %></td>
                    <td><%= it.get타입() %></td>
                    <td><%= it.get가치() %></td>
                    <td><%= it.get등급() %></td>
                </tr>
            <% } %>
        </table>
    <% } else { %>
        <p>보유 아이템이 없습니다.</p>
    <% } %>

    <p><a href="index.jsp">← 메인으로</a></p>
</body></html>
