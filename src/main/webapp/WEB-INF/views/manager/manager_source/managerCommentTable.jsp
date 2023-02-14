<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.maumgagym.dto.CommentTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.maumgagym.dao.CommentDAO"%> 
<%
	
	ArrayList<CommentTO> commentLists = (ArrayList) request.getAttribute("commentList");
	
	int totalRecord = commentLists.size(); //총데이터갯수
	
	StringBuilder cmto = new StringBuilder();
			 
			 for( CommentTO to : commentLists){
				int seq = to.getSeq();
				String category = to.getCategory();
				String topic = to.getTopic();
				String title = to.getTitle();
				String content = to.getContent();
				String nickname = to.getNickname();
				String date = to.getWrite_date();
				 
				cmto.append("<tr>");
				cmto.append("<td scope='row'>" + seq + "</td>");
				cmto.append("<td>" + category + "</td>");
				cmto.append("<td>" + topic + "</td>");
				cmto.append("<td class='text-start fw-bold'>");
				cmto.append("<a href='/community/view?seq=" + seq + "'>" + title + "</a>&nbsp;"); 
				cmto.append("</td>");
				cmto.append("<td>" + content + "</td>");
				cmto.append("<td>" + nickname + "</td>");
				cmto.append("<td>" + date + "</td>");
				cmto.append("<td><a onclick=\"deleteboard('"+seq+"');\"><span class=\"badge bg-danger\">삭제</span></a></td>");
				cmto.append("</tr>");
			 }
%>    
<script type="text/javascript">
function deleteboard(deleteSeq) {
	   var param = {
	      seq : deleteSeq
	   }
	   
	   var ans = confirm("선택하신 글을 삭제하시겠습니까?");
	   console.log('click!!!!!');
	   if(ans === true) {
	      $.ajax({
	         url: "/manager/commentDelete",
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
<hr/>    

		<div class="container mt-5">
			<div class="row">

            <div class="page-heading">
                <section class="section">
                    <div class="card">
                        <div class="card-header bg-white">
                          <h3>댓글 통합관리</h3>
                          <p class="text-subtitle text-muted">생성된 게시판의 댓글들을 통합하여 관리합니다.</p>
                        </div>
                        <div class="card-body">
                            <table class="table table-hover" id="table1">
                                <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th>원글 카테고리</th>
                                        <th>원글 토픽</th>
                                        <th>원글 제목</th>
                                        <th>댓글(리뷰) 내용</th>
                                        <th>작성자</th>
                                        <th>작성일</th>
                                        <th>기능</th>
                                    </tr>
                                </thead>
                                <%= cmto.toString() %>
                            </table>
                        </div>
                    </div>

                </section>
            </div>
         </div>
       </div>
