<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DnF.*" %>
<%
    request.setCharacterEncoding("UTF-8");

    String 전투결과메시지 = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String 플레이어id = request.getParameter("playerId");

        // 세션에서 전투시스템 및 캐릭터 객체 불러오기
        전투 전투시스템 = (전투) session.getAttribute("battleSystem");
        캐릭터 선택된캐릭터 = (캐릭터) session.getAttribute("character");

        if (전투시스템 == null || 선택된캐릭터 == null) {
            전투결과메시지 = "<span style='color:red;'>[오류] 캐릭터가 존재하지 않습니다. 먼저 캐릭터를 생성하세요.</span>";
        } else {
            // 전투 클래스로 공격 요청 후 결과 문자열 반환받기
            String 결과 = 전투시스템.몬스터공격(플레이어id, 선택된캐릭터);
            
            // 등급에 따라 색상 다르게 표현
            if(결과.contains("인증 실패")) {
                전투결과메시지 = "<span style='color:red;'>" + 결과 + "</span>";
            } else {
                전투결과메시지 = "<span style='color:green; font-weight:bold;'>" + 결과 + "</span>";
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>던전앤파이터 - 몬스터 공격</title>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; padding: 20px; }
        .box { border: 1px solid #ccc; padding: 20px; width: 300px; border-radius: 5px; background-color: #f9f9f9; }
        input, button { margin-top: 5px; margin-bottom: 15px; width: 100%; padding: 5px; }
    </style>
</head>
<body>
    <h2>🔥 몬스터 공격 🔥</h2>
    
    <div class="box">
        <% 
            캐릭터 현재캐릭터 = (캐릭터) session.getAttribute("character");
            if (현재캐릭터 != null) { 
        %>
            <p><b>선택된 캐릭터:</b> <%= 현재캐릭터.get캐릭터명() %> (<%= 현재캐릭터.getClass().getSimpleName() %>)</p>
        <% } else { %>
            <p style="color:gray;">선택된 캐릭터가 없습니다.</p>
        <% } %>

        <form method="post" action="Attack_Monster_UI.jsp">
            <label>플레이어 ID 확인:</label>
            <input type="text" name="playerId" required placeholder="ID를 입력하세요 (hero)">
            
            <button type="submit" style="background-color: darkred; color: white;">몬스터 공격!</button>
        </form>
    </div>

    <div style="margin-top: 20px; padding: 10px; border-left: 4px solid darkred; background-color:#fff3f3;">
        <b>전투 결과:</b><br><br>
        <%= 전투결과메시지.equals("") ? "대기 중..." : 전투결과메시지 %>
    </div>
    
    <br>
    <a href="Create_Character_UI.jsp">◀ 캐릭터 생성 화면으로 돌아가기</a>
</body>
</html>