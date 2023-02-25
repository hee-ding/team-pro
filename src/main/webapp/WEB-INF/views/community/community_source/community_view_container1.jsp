<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     


<%@page import="com.maumgagym.dto.CommentTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.maumgagym.dto.BoardTO"%>
<%
	request.setCharacterEncoding("UTF-8");

	String id1 = null;
	String nickname1 = null;
	if( session.getAttribute("id") != null ) {
		id1 = ( String ) session.getAttribute("id");
		nickname1 = ( String ) session.getAttribute("nickname");
	}
	
	System.out.println(id1); //로그인한 회원의 id
	System.out.println(nickname1); //로그인한 회원의 닉네임

	BoardTO to = (BoardTO)request.getAttribute("bto");
	
	int seq = to.getSeq();
	String id = to.getId();
	System.out.println(to.getId());
	String subject = to.getTitle();
	String date = to.getWrite_date();
	String writer = to.getWriter();
	String content = to.getContent();
	
	System.out.println(id); // 게시글을 작성한 id
	
	
	//System.out.println( "제목 : " + subject );
	
  	// 댓글
	ArrayList<CommentTO> cmtList = (ArrayList)request.getAttribute( "commentList" );
  	
	//System.out.println( "댓글 리스트 : " + cmtList.size() );
 	
 	StringBuilder sbCmt = new StringBuilder();
 	int size = cmtList.size();
 	
 	int cmtseq = 0;
 		
 	for( CommentTO cmtto : cmtList ) {
 		
 		cmtseq = cmtto.getSeq();
 		String nickname = cmtto.getNickname();
 		String writeDate = cmtto.getWrite_date();
 		String comment = cmtto.getContent();
 		
  		//System.out.println( "내용 : " + cmtto.getContent() );
		
  		sbCmt.append( "	 	<div class='d-flex justify-content-between mb-2'>");
		sbCmt.append( "  		<div class='d-flex flex-row align-items-center'>");
		sbCmt.append( "    			<span class='small mb-0 ms-2 fs-6 fw-bold' id='writer'><i class='material-icons'></i>&nbsp;" + nickname +"</span> <span class='text-end'></span>");
		sbCmt.append( "	  		</div>");
		sbCmt.append( "	  		<div class='d-flex flex-row align-items-center'>");
		sbCmt.append( "	    		<small>&nbsp;" + writeDate +"</small>");
	 	sbCmt.append( " 		</div>");
	 	sbCmt.append( "		</div>");
		
	 	sbCmt.append( "		<div class='d-flex justify-content-between mb-3'>");
 	 	sbCmt.append( "			<div class='d-flex flex-row align-items-center'>");
	 	sbCmt.append( "				<p class='small mb-0 ms-2'> " + comment +" </p>");
	 	sbCmt.append( "			</div>"); 
		if(nickname.equals(nickname1)){
			sbCmt.append( "	  		<div class='d-flex flex-row align-items-center'>");
			sbCmt.append( "	    	    <a id='cmtdmt'><small>삭제</small></a> &nbsp");
		 	sbCmt.append( " 		</div>");
		}
	 	sbCmt.append( "		</div>");
	 	sbCmt.append( "		<hr>");
 	}

%>

<hr/>
	
	<br/><br/><br/>
	<div class="container px-3 px-lg-5">
			<p class="h2" style="font-weight: bold;"><%= subject %></p>
			<div class="text-end">
				<table class="text-end">
					<th>
					    <i class="bi-heart" style="font-size:30px; color: red; cursor: pointer;" id="heartimg"></i>
						<input type="hidden" name="board_seq" id="board_seq" value="<%= seq %>" />
						<input type="hidden" name="user" id="user" value="<%= id1 %>" />
						<input type="hidden" name="cmtseq" id="cmtseq" value="<%= cmtseq %>" />
					</th>
						<td>
						  <b>좋아요 <span id="likenumber"></span></b> 
						</td>
				</table>
			</div>
	</div>
	<div class="container px-3 px-lg-5">
			<!--게시판-->
			<div class="board_view">
				<table class="table text-start table-bordered">
				<tr>
					<th width="10%" class="text-bg-light p-3">제목</th>
					<td width="45%"><%= subject %></td>
				</tr>
				<tr>
					<th width="10%" class="text-bg-light p-3">등록일</th>
					<td width="55%"><%= date %></td>
				</tr>
				<tr>
					<th class="text-bg-light p-3">글쓴이</th>
					<td colspan="3"><%= writer %></td>
				</tr>
				<tr>
					<td colspan="4" height="320" valign="top" style="padding: 20px; line-height: 160%"><%= content %></td>
				</tr>
				<tr>
				<td colspan="4">
					<div class="card-header bg-light">
						<b><%=size %> 개의 댓글</b>&nbsp;<i class="fa-sharp fa-solid fa-comment"></i>
						<br/><br/>
		                  <div class="card-body">
							<%=sbCmt.toString() %> 
		                  </div>
					</div><br/>
					 <form>
						<div class="container">
							<ul class="list-group list-group-flush">
							    <li class="list-group-item text-end">
									<textarea class="form-control" name="textarea" id="textarea" rows="3"></textarea>
								    <!--<input type="text" class="form-control" style="width:100%;height:100px;" id="textarea" name="textarea">  -->
									<input type="button" class="btn btn-dark mt-3" id="cmtbtn" value="댓글쓰기">
						            <input type="hidden" name="nickname1" id="nickname1" value="<%= nickname1 %>" />
							    </li>
							</ul>
						</div>
					</form>
				</td>
				</tr>
				</table>
			</div>
			
			<div class="row">
				<div class="col-md-6">
					<input type="button" value="목록" class="btn btn-primary" style="cursor: pointer;" onclick="location.href='/community/list'" />
				</div>
				<% if( id.equals(id1) ){ %>
					<div class="col-md-6 text-end">
						<input type="button" value="수정" class="btn btn-outline-primary" style="cursor: pointer;" onclick="location.href='/community/modify?seq=<%=seq %>'"/>
						<input type="button" value="삭제" class="btn btn-outline-danger" style="cursor: pointer;" onclick="location.href='/community/delete?seq=<%=seq %>'" />
					</div> 
			
				<% } else if ( id == null ) {%>
					<div class="col-md-6 text-end">
						<input type="button" value="수정" class="btn btn-outline-primary" style="cursor: pointer;" onclick="location.href='/community/modify?seq=<%=seq %>'"/>
						<input type="button" value="삭제" class="btn btn-outline-danger" style="cursor: pointer;" onclick="location.href='/community/delete?seq=<%=seq %>'" />
					</div>
				<% }%>
			</div>
			<!--//게시판-->
		
	
	<br/><br/><br/>
	</div>	
</div>

<script>
	 $(document).ready(function (){
 		
		 let heart = 0;
		 
		 let user = $('#user').val();
		 let board_seq = $('#board_seq').val();
			
			$.ajax({
				 url: '/community/alreadylike',
				 type: 'post',
				 data :
					{
					 "user" : user,
					 "board_seq" : board_seq
					},
				success:function(data){
					if(data == 1){
						console.log('성공');
						$('#heartimg').attr('class','bi-heart-fill');
					}
				}
			});
			 heart++;
		
		//댓글
		$('#cmtbtn').click(function(){
			
			 let comments = $('#textarea').val();
			 let cmt_nickname = $('#nickname1').val();
			 
			console.log(cmt_nickname);
			 console.log(comments);
			 
			if( user === 'null'){
				alert('로그인 후 이용해주세요.');
				return;
			}
			
			if( comments === 'null'){
				alert('내용을 입력해주세요.');
				return;
			}
			
			$.ajax({
    	        type: 'POST',
    	        url: '/comment/write',
    	        data: {
    	        	"comments": comments,
    	        	"cmt_nickname": cmt_nickname,
    	        	"board_seq": board_seq
    	        },
    	        success: function (result) {
    	        	console.log('성공');
    	        	location.reload();
    	        }
			});
		});
		
		//댓글삭제
		$('#cmtdmt').click(function(){
			
			let cmtseq = $('#cmtseq').val();
			//console.log(cmtseq);
			
			alert('댓글을 삭제 하시겠습니까?');
			
			$.ajax({
   	        type: 'POST',
   	        url: '/comment/delete',
   	        data: {
   	        	"cmtseq": cmtseq
   	        },
   	        success: function (result) {
   	        	location.reload();
	   	        }
			});
		});
		
			
			 
		//좋아요
		$('i').on('click',function(){
			
			if( user === 'null'){
				alert('로그인 후 이용해주세요.');
				return;
			}
			
			if(heart == 0){
				 $.ajax({
					 url: '/community/like',
					 type: 'post',
					 data :
						{
						 "user" : user,
						 "board_seq" : board_seq
						},
					success:function(result){
						if(result == 1){
							console.log('성공');
							$('#heartimg').attr('class','bi-heart-fill');
							//document.getElementById('likenumber').innerHTML = +1;
						}
					},
					error : function (err) { // 실패하면 0
						console.log('실패');
					}
					 
				 	});
				 heart++;
			}
				 
			else if (heart == 1){
				 $.ajax({
					 url: '/community/dislike',
					 type: 'post',
					 data :
						{
						 "user" : user,
						 "board_seq" : board_seq
						},
					success:function(result){
						if(result == 1){
							$('#heartimg').attr('class','bi-heart');
							//document.getElementById('likenumber').innerHTML = -1;
							
						}
					},
					error : function (err) { // 실패하면 0
						console.log('실패');
					}
					 
				 	});
				 heart--;
				 }
				 
			});
		
	 });
	</script>


