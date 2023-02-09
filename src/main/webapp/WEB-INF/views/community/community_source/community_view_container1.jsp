
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="com.to.board.CommunityDAO"%>
<%@page import="com.to.board.BoardTO"%>
<%

	request.setCharacterEncoding("utf-8");

	BoardTO to = new BoardTO();
	to.setSeq(Integer.parseInt(request.getParameter("seq")));
	
	CommunityDAO dao = new CommunityDAO();
	to = dao.boardView(to);
	
	int seq = to.getSeq();
	String subject = to.getTitle();
	String date = to.getWrite_date();
	String writer = to.getWriter();
	String content = to.getContent();

%>

<hr/>
	
	<br/><br/><br/>
	<div class="container px-3 px-lg-5">
			<p class="h2" style="font-weight: bold;"><%= subject %></p>
			<div class="text-end">
				<b>좋아요</b>
				    <i class="bi-heart" style="font-size:30px; color: red; cursor: pointer;"></i>
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
					       <b>0 개의 댓글</b>&nbsp;<i class="fa-sharp fa-solid fa-comment"></i>
					</div><br/>
					<div class="container">
						<ul class="list-group list-group-flush">
						    <li class="list-group-item">
						<!--<div class="row">
							<div class="col-md-4">
								<label for="replyId"><i class="fa-sharp fa-solid fa-user"></i></label>
								<input type="text" class="form-control" placeholder="Enter yourId" id="replyId">
							</div>
							<div class="col-md-4">
								<label for="replyPassword" class="ml-4"><i class="fa fa-unlock-alt"></i></label>
								<input type="password" class="form-control ml-2" placeholder="Enter password" id="replyPassword">
							</div> 
						    </div>-->
							<div class="text-end">
							<textarea class="form-control" id="exampleFormControlTextarea1" rows="3"></textarea>
							<button type="button" class="btn btn-dark mt-3" onClick="javascript:addReply();"><i class="fa-solid fa-floppy-disk"></i>&nbsp;댓글쓰기</button>
						    </div>
						    </li>
						</ul>
					</div>
				</td>
				</tr>
				</table>
			</div>
			
			<div class="row">
				<div class="col-md-6">
					<input type="button" value="목록" class="btn btn-primary" style="cursor: pointer;" onclick="location.href='./communityPage.jsp'" />
				</div>
				<div class="col-md-6 text-end">
					<input type="button" value="수정" class="btn btn-outline-primary" style="cursor: pointer;" onclick="location.href='./community_modifyPage.jsp?seq=<%=seq %>'"/>
					<input type="button" value="삭제" class="btn btn-outline-danger" style="cursor: pointer;" onclick="" />
				<!--<input type="button" value="쓰기" class="btn btn-outline-info" style="cursor: pointer;" onclick="" />  -->	
				</div> 
			</div>
			<!--//게시판-->
		
	
	<br/><br/><br/>
	</div>	
</div>
