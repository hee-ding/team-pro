
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<hr/>
	
	<br/><br/>
	<!--
	<div class="container text-center">
         <p class="h1 text-center" >"HOT EVENT"</p><br/>
	     <a href="#"><img src="./resources/asset/images/event1_image.jpg" style="width:1000px; height:100%;" class="img-responsive rounded"></a>
    </div>
     -->
    <br/>
	<div class="container px-3 px-lg-5">
        <p class="h2" style="font-weight: bold;">공지사항/이벤트</p>
	    <br/><br/>
	    <form class="row domain-search bg-pblue">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <p class="h5">실시간 전체글 <span class="count">5</span>개</p>
                </div>
			    <div class="col-md-2 text-end">
					  <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown">
					  분류
					  </button>
						  <ul class="dropdown-menu">
						    <li><a class="dropdown-item" href="#">전체보기</a></li>
						    <li><a class="dropdown-item" href="#">공지사항</a></li>
						    <li><a class="dropdown-item" href="#">이벤트</a></li>
						  </ul>
				</div> 
		        <div class="col-md-4">
		            <div class="input-group">
		                <input type="text" id="search" class="form-control" placeholder="키워드로 검색해보세요." >
		                <button class="btn btn-outline-primary" type="button" id="btn_search">찾기</button>
		            </div>
		        </div>
            </div>
        </div>
       </form>
		<br/><br/>
		<table class="table table-hover text-center">
		<thead class="table-primary">
		<tr>
			<th scope="col">&nbsp;</th>
			<th scope="col">번호</th>
			<th scope="col">분류</th>
			<th scope="col">제목</th>
			<th scope="col">글쓴이</th>
			<th scope="col">등록일</th>
			<th scope="col">조회</th>
			<th scope="col">&nbsp;</th>
		</tr>
		</thead>
		<tr>
			<td>&nbsp;</td>
			<td scope="row">5</td>
			<td class="text-muted">공지사항</td>
			<!--<td class="left"><a href="board_view1.jsp">adfas</a>&nbsp;<img src="./images/icon_new.gif" alt="NEW"></td> -->
			<td><a href="./notification_viewPage.jsp" style="text-decoration-line: none;">공지사항 입니다.1</a></td>
			<td>하태현</td>
			<td>2017-01-31</td>
			<td>0</td>	
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td scope="row">4</td>
			<td class="text-muted">공지사항</td>
			<!--<td class="left"><a href="board_view1.jsp">adfas</a>&nbsp;<img src="./images/icon_new.gif" alt="NEW"></td> -->
			<td>공지사항 입니다.2</td>
			<td>이현주</td>
			<td>2017-01-31</td>
			<td>0</td>
			<td>&nbsp;</td>
			</tr>
			
		<tr>
			<td>&nbsp;</td>
			<td scope="row">3</td>
			<td class="text-muted">공지사항</td>
			<!--<td class="left"><a href="board_view1.jsp">adfas</a>&nbsp;<img src="./images/icon_new.gif" alt="NEW"></td> -->
			<td>공지사항 입니다.3</td>
			<td>테스트</td>
			<td>2017-01-31</td>
			<td>0</td>
			<td>&nbsp;</td>
		</tr>			
		<tr>
			<td>&nbsp;</td>
			<td scope="row">2</td>
			<td class="text-muted">이벤트</td>
		<!--<td class="left"><a href="board_view1.jsp">adfas</a>&nbsp;<img src="./images/icon_new.gif" alt="NEW"></td> -->
			<td>이벤트 입니다.1</td>
			<td>김종희</td>
			<td>2017-01-31</td>
			<td>0</td>
			<td>&nbsp;</td>
		</tr>		
		<tr>
			<td>&nbsp;</td>
			<td scope="row">1</td>
			<td class="text-muted">이벤트</td>
			<!--<td class="left"><a href="board_view1.jsp">adfas</a>&nbsp;<img src="./images/icon_new.gif" alt="NEW"></td> -->
			<td>이벤트 입니다.2</td>
			<td>황병국</td>
			<td>2017-01-31</td>
			<td>0</td>
			<td>&nbsp;</td>
		</tr>
	</table>
	
	<br/><br/><br/>
		<ul class="pagination justify-content-center">
		  <li class="page-item"><a class="page-link" href="#"><</a></li>
		  <li class="page-item active"><a class="page-link" href="#">1</a></li>
		  <li class="page-item"><a class="page-link" href="#">2</a></li>
		  <li class="page-item"><a class="page-link" href="#">3</a></li>
		  <li class="page-item"><a class="page-link" href="#">></a></li>
		</ul>
	</div>	
</div>
