
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<hr/>
	
	<br/><br/><br/>
	<div class="container px-3 px-lg-5">
			<!--게시판-->
			<p class="h2" style="font-weight: bold;">제목이 들어감.</p>
			<br/>
			<div class="board_view">
				<table class="table text-start table-bordered">
				<tr>
					<th width="10%" class="text-bg-light p-3">제목</th>
					<td width="45%">제목들어감</td>
					<th width="10%" class="text-bg-light p-3">등록일</th>
					<td width="55%">등록일들어감</td>
				</tr>
				<tr>
					<th class="text-bg-light p-3">글쓴이</th>
					<td>글쓴이나옴</td>
					<th class="text-bg-light p-3">조회</th>
					<td>조회나옴</td>
				</tr>
				<tr>
					<td colspan="4" height="320" valign="top" style="padding: 20px; line-height: 160%">내용나옴</td>
				</tr>
				</table>
			</div>
			
			<div class="row">
				<div class="text-end">
					<input type="button" value="목록" class="btn btn-primary" style="cursor: pointer;" onclick="location.href='./notificationPage.jsp'" />
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
