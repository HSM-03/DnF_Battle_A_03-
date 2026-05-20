package DnF;

public class 플레이어 {
    private String 플레이어id;

    public 플레이어() {
        // 요구사항: 플레이어id는 "hero"
        this.플레이어id = "hero"; 
    }

    // 시퀀스 다이어그램의 플레이어체크()
    public boolean 플레이어체크(String 입력id) {
        return this.플레이어id.equals(입력id);
    }
}