<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String nickname = (String) session.getAttribute("nickname");
	//System.out.println( "세션으로 받아오는 닉네임 : " + nickname );

%>    

<script type="text/javascript">

	function selectseq() {
		var selected = document.getElementById( "category" );
		
		var seq = selected.options[document.getElementById("category").selectedIndex].value;
	}
	
	window.onload = function() {	
		

		document.getElementById( 'wbtn' ).onclick = function() {
			if( document.getElementById("category").selectedIndex == 0 ) {
				alert("카테고리를 선택해 주세요.");
				return false;
			}
			
			if( document.wfrm.subject.value.trim() == "" ) {
				alert("제목을 입력해 주세요.");
				return false;
			}
			
			if( document.wfrm.content.value.trim() == "" ) {
				alert("내용을 입력해 주세요.");
				return false;
			}

			document.wfrm.submit();
		}
	}
	
	

</script>

<hr/><br/><br/>
<div class="container px-3">
	<!--  <h4 class="fw-bold py-3">글쓰기</h4>-->
	<div class="row">
		<div class="col-sm-2 h3 fw-bold py-3">글쓰기</div>
		<div class="col-sm-10 text-secondary fs-6 fw-lighter"  style="margin-top:25px">글쓰기 버튼 클릭 시 마음가짐 관리자가 확인 후 등룍 완료 됩니다.</div>
	</div>
	<div class="con_txt">
		<form action="/facility/writeOK" method="post" name="wfrm" enctype="multipart/form-data">
			<table class="table table-bordered">
				<tr>
					<th class="fs-bold fw-4 bg-light" width="15%">카테고리</th>
					<td>
						<select class="form-select" role="button" id="category" name="category" onchange="selectseq()">
			  				<option selected>카테고리를 선택해 주세요.</option>
			  				<option value="1">피트니스</option>
							<option value="2">요가</option>
							<option value="3">수영</option>
							<option value="4">테니스</option>
							<option value="5">타바타</option>
							<option value="6">필라테스</option>
							<option value="7">골프</option>
							<option value="8">복싱</option>
							<option value="9">댄스</option>
						</select>
						<input type="hidden" id="nickname" name="nickname" value="<%=nickname%>"/>
					</td>
				</tr>
				<tr>
					<th class="fs-bold fw-4 bg-light">제목</th>
					<td><input type="text" name="title" id="title" value="" class="form-control" /></td>
				</tr>
				<tr>
					<th class="fs-bold fw-4 bg-light" >회원권(1개월)</th>
					<td><input type="text" name="membership1" id="membership1" value="" class="form-control" /></td>
				</tr>
				<tr>
					<th class="fs-bold fw-4 bg-light">회원권(3개월)</th>
					<td><input type="text" name="membership3" id="membership3" value="" class="form-control" /></td>
				</tr>	
				<tr>
					<th class="fs-bold fw-4 bg-light">회원권(6개월)</th>
					<td><input type="text" name="membership6" id="membership6" value="" class="form-control" /></td>
				</tr>	
				<tr>
					<th class="fs-bold fw-4 bg-light">회원권(12개월)</th>
					<td><input type="text" name="membership12" id="membership12" value="" class="form-control" /></td>
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
		  				<textarea id="summernote" name="content" class="form-control" ></textarea> 
		  				<!-- <input type="hidden" name="file" id="file" value=""></input> -->
					</td>
				</tr>
				<tr>
					<th class="fs-bold fw-4 bg-light">첨부파일</th>
					<td>
						<input type="file" name="upload" value="" class="board_view_input" />
					</td>
				</tr>
					
			</table>
			<div class="col text-end">
				<button type="submit" id="wbtn" class="btn btn-outline-secondary mb-3">글쓰기</button>
			</div>
		</form>
	</div>	
</div>