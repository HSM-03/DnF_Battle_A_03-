<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DnF.*" %> <!-- Java 클래스 패키지 임포트 -->
<%
    // 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    String 시스템메시지 = "";
    
    // POST 요청(버튼 클릭)이 들어왔을 때 로직 수행
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String 플레이어id = request.getParameter("playerId");
        String 캐릭터명 = request.getParameter("charName");
        String 직업 = request.getParameter("job");
        int 레벨 = Integer.parseInt(request.getParameter("level"));

        // 전투 시스템 객체 생성 및 캐릭터 생성 요청
        전투 전투시스템 = new 전투();
        boolean 생성결과 = 전투시스템.캐릭터생성(플레이어id, 캐릭터명, 직업, 레벨);

        if (생성결과) {
            캐릭터 생성된캐릭터 = 전투시스템.get생성된캐릭터();
            
            // 몬스터 공격 화면에서 사용하기 위해 세션(Session)에 객체 저장
            session.setAttribute("battleSystem", 전투시스템);
            session.setAttribute("character", 생성된캐릭터);
            
            시스템메시지 = "<span style='color:blue;'>[성공] 캐릭터 생성 완료! <br>"
                        + "직업: " + 직업 + " | HP: " + 생성된캐릭터.getHP() 
                        + " | 공격력: " + 생성된캐릭터.get공격력() + "</span>";
        } else {
            시스템메시지 = "<span style='color:red;'>[인증 실패] 플레이어 ID가 일치하지 않거나 오류가 발생했습니다.</span>";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>던전앤파이터 - 캐릭터 생성</title>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; padding: 20px; }
        .box { border: 1px solid #ccc; padding: 20px; width: 300px; border-radius: 5px; }
        input, select, button { margin-top: 5px; margin-bottom: 15px; width: 100%; padding: 5px; }
    </style>
</head>
<body>
    <h2>⚔️ 캐릭터 생성 ⚔️</h2>
    
    <div class="box">
        <form method="post" action="Create_Character_UI.jsp">
            <label>플레이어 ID (hero 입력):</label>
            <input type="text" name="playerId" required value="hero">
            
            <label>캐릭터명:</label>
            <input type="text" name="charName" required>
            
            <label>직업 선택:</label>
            <select name="job">
                <option value="전사">전사</option>
                <option value="마법사">마법사</option>
            </select>
            
            <label>레벨 (숫자):</label>
            <input type="number" name="level" min="1" required value="1">
            
            <button type="submit">캐릭터 생성하기</button>
        </form>
    </div>

    <div style="margin-top: 20px;">
        <b><%= 시스템메시지 %></b>
    </div>
    
    <br>
    <a href="Attack_Monster_UI.jsp">▶ 몬스터 공격하러 가기</a>
</body>
</html>