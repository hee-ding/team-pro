<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<hr/><br/><br/>
<div class="container px-3">
	<h4 class="fw-bold py-3">글쓰기</h4>
	<table class="table table-bordered">
		<tr>
			<th class="fs-bold fw-4 bg-light" width="15%">글쓴이</th>
			<td><input type="text" name="writer" value="" class="form-control"/></td>
		</tr>
		<tr>
			<th class="fs-bold fw-4 bg-light">제목</th>
			<td><input type="text" name="subject" value="" class="form-control" /></td>
		</tr>
		<!--  
		<tr>
			<th class="fs-bold fw-4">비밀번호</th>
			<td><input type="password" name="password" value="" class="board_view_input_mail"/></td>
		</tr>
		-->
		<tr>
			<th class="fs-bold fw-4 bg-light">내용</th>
			<td>
  				<div id="summernote" class="form-control"></div>    
			</td>
		</tr>
	</table>
	<div class="col text-end">
		    <button type="submit" class="btn btn-outline-secondary mb-3">글쓰기</button>
	</div>

	
</div>