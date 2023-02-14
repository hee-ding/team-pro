<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.maumgagym.dto.BoardTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.maumgagym.dao.BoardDAO"%>    
<%
	
	ArrayList<BoardTO> boardLists = (ArrayList) request.getAttribute("boardList");
	//
	int totalRecord = boardLists.size(); //총데이터갯수

	
	StringBuilder sbBoard = new StringBuilder();
			
			 for( BoardTO to : boardLists){
				int seq = to.getSeq();
				String category = to.getCategory();
				String topic = to.getTopic();
				String title = to.getTitle();
				String nickname = to.getNickname();
				String date = to.getWrite_date();
				 
				sbBoard.append("<tr>");
				sbBoard.append("<td scope='row'>" + seq + "</td>");
				sbBoard.append("<td>" + category + "</td>");
				sbBoard.append("<td>" + topic + "</td>");
				sbBoard.append("<td class='text-start fw-bold'>");
				sbBoard.append("<a href='/community/view?seq=" + seq + "'>" + title + "</a>&nbsp;"); 
				sbBoard.append("</td>");
				sbBoard.append("<td>" + nickname + "</td>");
				sbBoard.append("<td>" + date + "</td>");
				sbBoard.append("<td><a onclick=\"deleteboard('"+seq+"');\"><span class=\"badge bg-danger\">삭제</span></a></td>");
				sbBoard.append("</tr>");
			 }
%>    
<hr/>
<script type="text/javascript">
function deleteboard(deleteSeq) {
	   var param = {
	      seq : deleteSeq
	   }
	   
	   var ans = confirm("선택하신 글을 삭제하시겠습니까?");
	   console.log('click!!!!!');
	   if(ans === true) {
	      $.ajax({
	         url: "/manager/boardDelete",
	         method: "GET",
	         dataType: "json",
	         data:param,
	         success: function(data) {
	            console.log(data);
	            location.reload();
	            alert("삭제되었습니다.");
	         }
	      });
	   }else {
	      return false;
	}

}
</script>

		<div class="container mt-5">
			<div class="row">

            <div class="page-heading">
                <section class="section">
                    <div class="card">
                        <div class="card-header bg-white">
                          <h3>게시물관리</h3>
                          <p class="text-subtitle text-muted">공지/이벤트, 커뮤니티 게시글들을 통합하여 관리합니다.</p>
                        </div>
                        <div class="card-body">
                            <table class="table table-hover" id="table1">
                                <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th>카테고리</th>
                                        <th>토픽</th>
                                        <th>제목</th>
                                        <th>작성자</th>
                                        <th>작성일</th>
                                        <th>기능</th>
                                    </tr>
                                </thead>
                                <%= sbBoard.toString() %>
                          
                            </table>
                        </div>
                    </div>

                </section>
            </div>
         </div>
       </div>
