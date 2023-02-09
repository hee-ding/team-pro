<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.to.board.BoardTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.to.board.BoardDAO"%>  
    <%
	
	BoardDAO dao = new BoardDAO();
	ArrayList<BoardTO> boardLists = dao.boardList();
	
	
	StringBuilder sbBoard = new StringBuilder();
		
			 for( BoardTO to : boardLists){
				 int seq = to.getSeq();
				String title = to.getTitle();
				String nickname = to.getNickname();
				 
				sbBoard.append("<tr>");
				sbBoard.append("<td>");
				sbBoard.append("<a href='community_viewPage.jsp?seq=" + seq + "'>" + title + "</a>&nbsp;"); 
				sbBoard.append("</td>");

				sbBoard.append("<td class='w-25 text-end'>" + nickname + "</td>");
				sbBoard.append("</tr>");
			 }
	ArrayList<BoardTO> facilityBoardLists = dao.facilityBoardList();

	StringBuilder sbFacility = new StringBuilder();
			 
			 for( BoardTO to : facilityBoardLists){
				 int seq = to.getSeq();
				String title = to.getTitle();
				String name = to.getName();
				 
				sbFacility.append("<tr>");
				sbFacility.append("<td>");
				sbFacility.append("<a href='viewPage.jsp?seq=" + seq + "'>" + title + "</a>&nbsp;"); 
				sbFacility.append("</td>");

				sbFacility.append("<td class='w-25 text-end'>" + name + "</td>");
				sbFacility.append("</tr>");
			 }


%>

<hr />
<div class="container mt-5">
	<div class="row">

		<!-- Basic Tables start -->
		<section class="section">
			<div class="row" id="basic-table">
				<div class="col-12 col-md-6" style="height: 420px;">
					<div class="card">
						<div class="card-header">
							<h4 class="card-title">
								최근 운동시설 게시물 <a href="./managerFacilityBoardPage.jsp"><i
									class="bi bi-box-arrow-in-up-right text-nowrap text-end"></i></a>
							</h4>
						</div>
						<div class="card-content">
							<div class="card-body">
								<!-- Table with outer spacing -->
								<div class="table-responsive">
									<table class="table table-sm">
										<thead>
											<tr>
												<th>업체게시글</th>
												<th class="w-25 text-end">업체명</th>
											</tr>
										</thead>
										<tbody>

											<%= sbFacility.toString() %>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="col-12 col-md-6" style="height: 420px;">
					<div class="card">
						<div class="card-header">
							<h4 class="card-title">
								공지/이벤트・커뮤니티 최근게시물<a href="./managerBoardPage.jsp"><i
									class="bi bi-box-arrow-in-up-right text-nowrap text-end"></i></a>
							</h4>
						</div>
						<div class="card-content">
							<div class="card-body">
								<!-- Table with outer spacing -->
								<div class="table-responsive">
									<table class="table table-sm">
										<thead>
											<tr>
												<th>제목</th>
												<th class="w-25 text-end">작성자</th>
											</tr>
										</thead>
										<tbody>
											<%= sbBoard.toString() %>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>
		</section>
		<!-- Basic Tables end -->

	</div>
</div>
