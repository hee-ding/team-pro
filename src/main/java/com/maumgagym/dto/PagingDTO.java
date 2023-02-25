package com.maumgagym.dto;
 
public class PagingDTO {
    
    public int boardCount; // 전체 글 개수
    private int currentPage; // 현재 보고 있는 페이지
    private int totalPages; // 전체 페이지 개수
    private int startPage; // 시작 페이지 번호
    private int endPage; // 끝 페이지 번호
    private static final int belowNum = 10; // 페이지는 10개씩 링크 표시(하단에 깔릴 버튼은 10개) 
    private static final int boardNum = 10; // 글 10개씩 표시 
	private String keyword;
	private int category;

    
    public PagingDTO(int boardCount, int currentPage) {
        this.boardCount = boardCount;
        this.currentPage = currentPage;
        
// ---------------------------------------------------------------------------------------
        // 개시글 갯수를 이용해 전체페이지 갯수 구하기 (totalPages값 구하기)
        if(boardCount == 0) {
            this.totalPages = 0;
            this.startPage = 0;
            this.endPage = 0;
        }else {
            if(boardCount % belowNum == 0) { //전체 글 개수가 10의 배수로 떨어지면 
                totalPages = boardCount / belowNum;
            }else {
                //10의 배수로 떨어지지 않을 경우 ex) 42/10 = 나머지가 2이기 때문에 10의 배수가 아니므로 +1 을해줘서 
                //남는 글들을 표현해줄 페이지 하나가 더 필요
                totalPages = (boardCount/belowNum) + 1; 
            }
// ---------------------------------------------------------------------------------------
                // 현재 조회중인 페이지 그룹의 시작 페이지 구하기 (startPages값 구하기 - 아래 깔릴 페이지 버튼)
                
                int bNum = 0; //식별번호
                if(currentPage % belowNum == 0) {
                    
                    bNum = (currentPage-1)/belowNum;
                }else {
                    bNum = currentPage / belowNum;
                }
                
                //식별번호를 구했으면 * 10 + 1 을해서 시작번호 구한다.
                //어떻게 해도 식별번호는 0이 되어야하고, 위의 startPage 식으로 구해서 무조건 1이 startPage가되게 만든다. 
                startPage = (bNum * 10) + 1; 
                
// ---------------------------------------------------------------------------------------
                // 현재 조회중인 페이지 그룹의 끝페이지 구하기 (endPage값 구하기 - 아래 깔릴 페이지 버튼)
                
                endPage = startPage + (10-1);
                if(endPage > totalPages) {
                    endPage = totalPages;
                }
        }
    }
    
    public int getBoardCount() {
        return boardCount;
    }
    public void setBoardCount(int boardCount) {
        this.boardCount = boardCount;
    }
    
    public boolean hasNoBoard() {
        return boardCount  == 0; //표시할 게시물이 없으면 버튼도 깔지 마라.
    }
    
    public boolean hasBoard() {
        return boardCount  > 0; //표시할 게시물이 있으면 버튼을 깔아라.
    }
    
    public int getCurrentPage() {
        return currentPage;
    }
    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }
    public int getTotalPages() {
        return totalPages;
    }
    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;
    }
    public int getStartPage() {
        return startPage;
    }
    public void setStartPage(int startPage) {
        this.startPage = startPage;
    }
    public int getEndPage() {
        return endPage;
    }
    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }
    public static int getBelownum() {
        return belowNum;
    }
    public static int getBoardnum() {
        return boardNum;
    }
    
	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

//	@Override
//    public String toString() {
//        return "PagingDTO [ boardCount = "+ boardCount +" , currentPage = "+ currentPage +" , totalPages = "
//                +totalPages+" , startPage = "+startPage+", endPage = "+endPage+" ]";
//    }
//    
}