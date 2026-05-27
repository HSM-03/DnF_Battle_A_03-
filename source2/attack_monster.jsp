<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Dnf_Battle.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    전투 전투 = (전투) session.getAttribute("전투");
    if (전투 == null) { response.sendRedirect("index.jsp"); return; }

    String pid = request.getParameter("pid");
    캐릭터 캐릭터 = 전투.get캐릭터(pid);

    // 스킬 데미지/등급을 화면에 보여주기 위해 콘솔 출력과 별개로 직접 계산값을 사용
    String 메시지;
    if (!"hero".equals(pid)) {
        메시지 = "❌ 인증 실패: 플레이어id는 \"hero\" 여야 합니다.";
    } else if (캐릭터 == null) {
        메시지 = "❌ 공격할 캐릭터가 없습니다. 먼저 캐릭터를 생성하세요.";
    } else {
        double 데미지 = 캐릭터.스킬발동();   // 콘솔에 스킬명 출력 + 데미지 반환
        String 등급 = (데미지 >= 200) ? "S급" : (데미지 >= 100) ? "A급" : "B급";
        String 스킬명 = (캐릭터 instanceof 전사) ? "검 휘두르기!" : "파이어볼!";
        메시지 = "✅ " + 스킬명 + " 데미지 = " + 데미지 + " | 등급 = " + 등급;
    }
%>
<!DOCTYPE html>
<html lang="ko"><head><meta charset="UTF-8"><title>몬스터공격 결과</title></head>
<body style="font-family:'맑은 고딕',sans-serif; max-width:600px; margin:30px auto;">
    <h2>② 몬스터공격 결과</h2>
    <p><%= 메시지 %></p>
    <a href="index.jsp">← 메인으로</a>
</body></html>
