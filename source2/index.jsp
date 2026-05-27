<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Dnf_Battle.*" %>
<%
    // ===== 전투(Control) 객체를 세션에 1개만 유지 =====
    전투 전투 = (전투) session.getAttribute("전투");
    if (전투 == null) {
        전투 = new 전투();
        // 길드는 외부에서 이미 생성된 객체 (Aggregation) → 미리 등록해 둔다.
        전투.길드등록(new 길드("불꽃군단"));
        전투.길드등록(new 길드("심연의탑"));
        session.setAttribute("전투", 전투);
    }
    캐릭터 현재캐릭터 = 전투.get캐릭터("hero");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>던전앤파이터 시스템 v2.0</title>
    <style>
        body { font-family: "맑은 고딕", sans-serif; max-width: 760px; margin: 30px auto; color: #222; }
        h1 { border-bottom: 3px solid #c0392b; padding-bottom: 8px; }
        .box { border: 1px solid #ddd; border-radius: 8px; padding: 16px 20px; margin: 16px 0; }
        .box h2 { margin-top: 0; font-size: 1.05em; color: #c0392b; }
        input, select { padding: 6px; margin: 3px 0; }
        button { padding: 7px 14px; background: #c0392b; color: #fff; border: none; border-radius: 5px; cursor: pointer; }
        .nav a { display: inline-block; margin-right: 10px; }
        .status { background: #fbeee6; padding: 10px 14px; border-radius: 6px; }
    </style>
</head>
<body>
    <h1>⚔ 던전앤파이터 시스템 v2.0</h1>

    <div class="status">
    <% if (현재캐릭터 == null) { %>
        현재 생성된 캐릭터가 없습니다. 아래에서 캐릭터를 생성하세요. (플레이어id는 <b>hero</b>)
    <% } else { %>
        <b><%= 현재캐릭터.get캐릭터명() %></b> (Lv.<%= 현재캐릭터.get레벨() %>) |
        HP <%= 현재캐릭터.getHP() %> | 공격력 <%= 현재캐릭터.get공격력() %> |
        인벤토리 <%= 현재캐릭터.get인벤토리().현재개수() %>/<%= 현재캐릭터.get인벤토리().get최대용량() %>
    <% } %>
    </div>

    <!-- Create_Character_UI -->
    <div class="box">
        <h2>① 캐릭터생성</h2>
        <form action="create_character.jsp" method="post">
            플레이어id: <input type="text" name="pid" value="hero"><br>
            캐릭터명: <input type="text" name="name" value="두키"><br>
            직업:
            <select name="job">
                <option value="전사">전사</option>
                <option value="마법사">마법사</option>
            </select><br>
            레벨: <input type="number" name="level" value="5" min="1"><br>
            <button type="submit">생성</button>
        </form>
    </div>

    <!-- Attack_Monster_UI -->
    <div class="box">
        <h2>② 몬스터공격</h2>
        <form action="attack_monster.jsp" method="post">
            플레이어id: <input type="text" name="pid" value="hero"><br>
            <button type="submit">공격</button>
        </form>
    </div>

    <div class="box nav">
        <h2>신규 기능</h2>
        <a href="add_item.jsp">③ 아이템획득 →</a>
        <a href="join_guild.jsp">④ 길드가입 →</a>
    </div>
</body>
</html>
