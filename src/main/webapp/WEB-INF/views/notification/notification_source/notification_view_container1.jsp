
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="com.maumgagym.dto.NotificationDTO"%>
<%

	NotificationDTO to = (NotificationDTO)request.getAttribute("notificationDTO");
	
	int seq = to.getSeq();
	String subject = to.getSubject();
	String date = to.getDate();
	String writer = to.getWriter();
	int hit = to.getHit();
	String content = to.getContent();

%>

<hr/>
	
	<br/><br/><br/>
	<div class="container px-3 px-lg-5">
			<!--게시판-->
			<p class="h2" style="font-weight: bold;"><%= subject%></p>
			<br/>
			<div class="board_view">
				<table class="table text-start table-bordered">
				<tr>
					<th width="10%" class="text-bg-light p-3">제목</th>
					<td width="45%"><%= subject%></td>
					<th width="10%" class="text-bg-light p-3">등록일</th>
					<td width="55%"><%= date%></td>
				</tr>
				<tr>
					<th class="text-bg-light p-3">글쓴이</th>
					<td><%= writer%></td>
					<th class="text-bg-light p-3">조회</th>
					<td><%= hit%></td>
				</tr>
				<tr>
					<td colspan="4" height="320" valign="top" style="padding: 20px; line-height: 160%"><%= content%></td>
				</tr>
				</table>
			</div>
			
			<div class="row">
				<div class="text-end">
					<input type="button" value="목록" class="btn btn-primary" style="cursor: pointer;" onclick="location.href='/notification/list'" />
				</div>
			</div>	 
			<!--  
				<div class="col-md-6 text-end">
					<input type="button" value="수정" class="btn btn-primary" style="cursor: pointer;" onclick="" />
					<input type="button" value="삭제" class="btn btn-primary" style="cursor: pointer;" onclick="" />
					<input type="button" value="쓰기" class="btn btn-primary" style="cursor: pointer;" onclick="" />
				</div> -->
			<!--//게시판-->
		
	
	<br/><br/><br/>
	</div>	
</div>
