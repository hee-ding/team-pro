
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="com.maumgagym.dto.BoardTO"%>

<%

	BoardTO to = (BoardTO)request.getAttribute("to");
	
	int seq = to.getSeq();
	String subject = to.getTitle();
	String date = to.getWrite_date();
	String writer = to.getWriter();
	String content = to.getContent();

%>
<hr/>
	
	<br/><br/><br/>
	<form action="/community/modifyok?seq=<%=seq %>" method="post" name="mfrm">
	<div class="container px-3 px-lg-5">
			<!--게시판-->
			<p class="h2" style="font-weight: bold;">커뮤니티 수정</p>
			<br/><br/>
			<div class="board_view">
				<table class="table text-start table-bordered">
				<tr>
					<th width="10%" class="text-bg-light p-3">제목</th>
					<td width="35%"><input type="text" name="subject" value="<%= subject %>" class="form-control" /></td>
					<th width="15%" class="text-bg-light p-3">등록일</th>
					<td width="40%"><input type="text" name="date" value="<%= date %>" class="form-control" /></td>
				</tr>
				<tr>
					<th class="text-bg-light p-3">글쓴이</th>
					<td><input type="text" name="writer" value="<%= writer %>" class="form-control" /></td>
					<th class="text-bg-light p-3">비밀번호</th>
					<td><input type="password" name="password" class="form-control" /></td>
				</tr>
				<tr>
					<th width="15%" class="text-bg-light p-3" >내용</th>
					<td colspan="3"><textarea id="summernote" name="contents" class="form-control" ><%= content %></textarea></td>
				</tr>
				</table>
			</div>
			
			<div class="row">
				<div class="col-md-6">
					<input type="button" value="목록" class="btn btn-primary" style="cursor: pointer;" onclick="location.href='/community/list'" />
				</div>
				<div class="col-md-6 text-end">
					<input type="button" id="mbtn" value="수정하기" class="btn btn-outline-dark" style="cursor: pointer;" />
				<!--	<input type="button" value="삭제" class="btn btn-outline-danger" style="cursor: pointer;" onclick="" />
				<!--<input type="button" value="쓰기" class="btn btn-outline-info" style="cursor: pointer;" onclick="" />  -->	
				</div> 
			</div>
			<!--//게시판-->
		
	
	<br/><br/><br/>
	</div>
	</form>
</div>
