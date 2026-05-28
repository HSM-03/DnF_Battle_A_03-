<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Dnf_Battle.*" %>
<%@ page import="java.util.Map" %>
<%
    // ===== 전투(Control) 객체를 세션에 1개만 유지 =====
    전투 전투 = (전투) session.getAttribute("전투");
    if (전투 == null) {
        전투 = new 전투();
        // 길드는 외부에서 이미 생성된 객체 (Aggregation) → 미리 등록해 둔다.
        전투.길드등록(new 길드("길드2"));
        전투.길드등록(new 길드("길드1"));
        session.setAttribute("전투", 전투);
    }

    // 캐릭터 전환 로직 (기존 switch_character.jsp 통합)
    String selectName = request.getParameter("selectName");
    if (selectName != null && !selectName.isEmpty()) {
        session.setAttribute("현재캐릭터명", selectName);
    }

    // 현재 접속 중인 캐릭터 관리
    String 현재캐릭터명 = (String) session.getAttribute("현재캐릭터명");
    캐릭터 현재캐릭터 = null;
    if (현재캐릭터명 != null) {
        현재캐릭터 = 전투.캐릭터_가져오기(현재캐릭터명);
    }
    
    Map<String, 캐릭터> 캐릭터맵 = 전투.캐릭터맵_가져오기();
    Map<String, 길드> 길드맵 = 전투.길드맵_가져오기();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>던전앤파이터 시스템 v2.0</title>
    <style>
        :root {
            --primary-color: #c0392b;
            --bg-color: #f4f7f6;
            --card-bg: #ffffff;
            --text-color: #333;
            --accent-color: #e67e22;
        }
        body { 
            font-family: 'Segoe UI', 'Malgun Gothic', sans-serif; 
            background-color: var(--bg-color);
            color: var(--text-color);
            max-width: 900px; 
            margin: 0 auto; 
            padding: 20px;
        }
        header {
            text-align: center;
            padding: 20px 0;
            border-bottom: 4px solid var(--primary-color);
            margin-bottom: 30px;
        }
        h1 { margin: 0; color: var(--primary-color); font-size: 2.5em; }
        .container { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .box { 
            background: var(--card-bg);
            border-radius: 12px; 
            padding: 20px; 
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            transition: transform 0.2s;
        }
        .box:hover { transform: translateY(-5px); }
        .box h2 { 
            margin-top: 0; 
            font-size: 1.2em; 
            color: var(--primary-color);
            border-left: 5px solid var(--primary-color);
            padding-left: 10px;
            margin-bottom: 15px;
        }
        .status-panel {
            grid-column: span 2;
            background: linear-gradient(135deg, #2c3e50, #4ca1af);
            color: white;
            padding: 25px;
            border-radius: 15px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .status-info b { font-size: 1.4em; color: #f1c40f; }
        .status-stats { display: flex; gap: 20px; }
        .stat-item { text-align: center; }
        .stat-value { font-weight: bold; font-size: 1.1em; display: block; }
        .stat-label { font-size: 0.8em; opacity: 0.8; }

        input, select { 
            width: 100%;
            padding: 10px; 
            margin: 8px 0; 
            border: 1px solid #ddd;
            border-radius: 6px;
            box-sizing: border-box;
        }
        button { 
            width: 100%;
            padding: 12px; 
            background: var(--primary-color); 
            color: #fff; 
            border: none; 
            border-radius: 6px; 
            cursor: pointer; 
            font-weight: bold;
            font-size: 1em;
            margin-top: 10px;
        }
        button:hover { background: #a93226; }
        
        .list-table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        .list-table th, .list-table td { 
            padding: 10px; 
            text-align: left; 
            border-bottom: 1px solid #eee; 
        }
        .list-table th { font-size: 0.9em; color: #777; }
        
        .nav-links { 
            grid-column: span 2;
            display: flex;
            gap: 15px;
            margin-top: 10px;
        }
        .nav-links a { 
            flex: 1;
            text-align: center;
            padding: 15px;
            background: var(--card-bg);
            text-decoration: none;
            color: var(--primary-color);
            font-weight: bold;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        .nav-links a:hover { background: var(--primary-color); color: white; }
    </style>
</head>
<body>
    <header>
        <h1>⚔ 던전앤파이터 시스템 v2.0</h1>
    </header>

    <div class="status-panel">
        <div class="status-info">
            <% if (현재캐릭터 == null) { %>
                <p>현재 접속 중인 캐릭터가 없습니다. 목록에서 선택하거나 새로 생성하세요.</p>
                <small>(플레이어id는 <b>hero</b>)</small>
            <% } else { %>
                <div>현재 접속 중: <b><%= 현재캐릭터.캐릭터명_가져오기() %></b></div>
                <small>플레이어 ID: hero</small>
            <% } %>
        </div>
        <% if (현재캐릭터 != null) { %>
            <div class="status-stats">
                <div class="stat-item">
                    <span class="stat-value"><%= 현재캐릭터.레벨_가져오기() %></span>
                    <span class="stat-label">Lv</span>
                </div>
                <div class="stat-item">
                    <span class="stat-value"><%= 현재캐릭터.HP_가져오기() %></span>
                    <span class="stat-label">HP</span>
                </div>
                <div class="stat-item">
                    <span class="stat-value"><%= 현재캐릭터.공격력_가져오기() %></span>
                    <span class="stat-label">공격력</span>
                </div>
                <div class="stat-item">
                    <span class="stat-value"><%= 현재캐릭터.인벤토리_가져오기().현재개수() %>/<%= 현재캐릭터.인벤토리_가져오기().최대용량_가져오기() %></span>
                    <span class="stat-label">인벤토리</span>
                </div>
            </div>
        <% } %>
    </div>

    <div class="container">
        <!-- Create_Character_UI -->
        <div class="box">
            <h2>① 캐릭터 생성</h2>
            <form action="create_character.jsp" method="post">
                <label>플레이어 ID</label>
                <input type="text" name="pid" value="hero" required>
                <label>캐릭터명</label>
                <input type="text" name="name" value="" required>
                <label>직업 선택</label>
                <select name="job">
                    <option value="전사">🛡️ 전사</option>
                    <option value="마법사">🪄 마법사</option>
                </select>
                <label>시작 레벨</label>
                <input type="number" name="level" value="5" min="1" max="99">
                <button type="submit">캐릭터 생성</button>
            </form>
        </div>

        <!-- Attack_Monster_UI -->
        <div class="box">
            <h2>② 몬스터 공격</h2>
            <p style="font-size: 0.9em; color: #666; margin-bottom: 20px;">
                필드에 나타난 몬스터를 공격하여 실력을 검증하세요.
            </p>
            <form action="attack_monster.jsp" method="post">
                <label>플레이어 ID 확인</label>
                <input type="text" name="pid" value="hero" required>
                <input type="hidden" name="charName" value="<%= 현재캐릭터명 != null ? 현재캐릭터명 : "" %>">
                <button type="submit" <%= 현재캐릭터 == null ? "disabled" : "" %> style="height: 100px; font-size: 1.5em; background: <%= 현재캐릭터 == null ? "#ccc" : "linear-gradient(to bottom, #c0392b, #962d22)" %>;">
                    <%= 현재캐릭터 == null ? "캐릭터를 선택하세요" : "⚔️ 공격 개시!" %>
                </button>
            </form>
        </div>

        <!-- Character List -->
        <div class="box">
            <h2>📜 전체 캐릭터 목록</h2>
            <table class="list-table">
                <thead>
                    <tr>
                        <th>이름</th>
                        <th>Lv</th>
                        <th>HP</th>
                        <th>액션</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Map.Entry<String, 캐릭터> entry : 캐릭터맵.entrySet()) { 
                        캐릭터 c = entry.getValue();
                        boolean isCurrent = c.캐릭터명_가져오기().equals(현재캐릭터명);
                    %>
                    <tr style="<%= isCurrent ? "background-color: #fff9db; font-weight: bold;" : "" %>">
                        <td><%= c.캐릭터명_가져오기() %></td>
                        <td><%= c.레벨_가져오기() %></td>
                        <td><%= c.HP_가져오기() %></td>
                        <td>
                            <% if (!isCurrent) { %>
                                <form action="index.jsp" method="post" style="margin:0;">
                                    <input type="hidden" name="selectName" value="<%= c.캐릭터명_가져오기() %>">
                                    <button type="submit" style="padding: 4px 8px; font-size: 0.8em; margin:0; width: auto;">선택</button>
                                </form>
                            <% } else { %>
                                <span style="color: #27ae60; font-size: 0.8em;">접속중</span>
                            <% } %>
                        </td>
                    </tr>
                    <% } %>
                    <% if (캐릭터맵.isEmpty()) { %>
                        <tr><td colspan="4" style="text-align:center; color:#999; padding:20px;">생성된 캐릭터가 없습니다.</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- Guild List -->
        <div class="box">
            <h2>🏰 길드 현황</h2>
            <table class="list-table">
                <thead>
                    <tr>
                        <th>길드명</th>
                        <th>인원</th>
                        <th>상태</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (길드 g : 길드맵.values()) { %>
                    <tr>
                        <td><%= g.길드명_가져오기() %></td>
                        <td><%= g.현재인원() %> / <%= g.최대인원_가져오기() %></td>
                        <td><%= g.정원초과인가() ? "❌ 만석" : "✅ 모집중" %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <div class="nav-links">
            <a href="add_item.jsp">💎 아이템 획득하기</a>
            <a href="join_guild.jsp">🤝 길드 가입 신청</a>
        </div>
    </div>

    <footer style="margin-top: 40px; text-align: center; color: #888; font-size: 0.8em;">
        &copy; 2026 Dungeon & Fighter System v2.0
    </footer>
</body>
</html>
