<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

    
<%@page import="com.maumgagym.dto.PagingDTO"%>
<%@page import="com.maumgagym.dto.NotificationDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.maumgagym.dao.NotificationDAO"%>

<%
	String id = (String)session.getAttribute("id");
	
	ArrayList<NotificationDTO> notificationList = (ArrayList) request.getAttribute("notificationList"); // 커뮤니티리스트 호출
	int boardCount = (Integer)request.getAttribute("boardCount"); //총데이터갯수
	PagingDTO pto = (PagingDTO)request.getAttribute("pto"); //아래 페이지네이션처리
	
	StringBuilder sbHtml = new StringBuilder();
		 
	for( NotificationDTO to : notificationList){
		
			int seq = to.getSeq();
			String category = to.getCategory();
			String subject = to.getSubject();
			String writer = to.getWriter();
			String date = to.getDate();
			int hit =  to.getHit();
			 
			sbHtml.append("<tr>");
			sbHtml.append("<td>&nbsp;</td>");
			sbHtml.append("<td scope='row'>" + seq + "</td>");
			sbHtml.append("<td class='text-muted'> " +category +"</td>");
			sbHtml.append("<td class='text-start fw-bold'>");
			sbHtml.append("<a href='/notification/view?seq="+seq+"' style='text-decoration-line: none;'>" + subject + "</a>&nbsp;"); 
			sbHtml.append("</td>");
			sbHtml.append("<td>" + writer + "</td>");
			sbHtml.append("<td>" + date + "</td>");
			sbHtml.append("<td>" + hit + "</td>");
			sbHtml.append("<td>&nbsp;</td>");
			sbHtml.append("</tr>");
		}
%>    

<hr/>
	
	<br/><br/>
	<!--
	<div class="container text-center">
         <p class="h1 text-center" >"HOT EVENT"</p><br/>
	     <a href="#"><img src="./resources/asset/images/event1_image.jpg" style="width:1000px; height:100%;" class="img-responsive rounded"></a>
    </div>
     -->
    
	<div class="container px-3 px-lg-5">
        <p class="h2" style="font-weight: bold;">공지사항/이벤트</p>
	    <br/><br/>
	    <form class="row domain-search bg-pblue">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <p class="h5">실시간 전체글 <span class="count"> <%= boardCount %></span>개</p>
                </div>
                <div class="col-md-2 text-end ">
					 <select class="form-select" name="searchtype" aria-label="Default select example">
						  <option selected>분류 선택</option>
						  <option value="13">공지사항</option>
						  <option value="14">이벤트</option>
					</select>
				</div>
			    
		        <div class="col-md-4">
		            <div class="input-group">
		                 <input type="text" name="keyword" id="keyword" class="form-control" placeholder="키워드로 검색해보세요." >
		                <input type="button" class="btn btn-outline-primary" id="search" value="검색">
		            </div>
		        </div>
            </div>
        </div>
       </form>
		<br/>
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
		<%= sbHtml.toString() %>
	</table>
	
	<br/><br/><br/>
		<nav>
              <ul class='pagination justify-content-center'>
				<c:if test = "${pto.startPage ne 1}"> <!-- startPage가 1이 아니면 &lt;표시가 나타남. -->
					<li class='page-item'><a class='page-link' href='http://localhost:8080/notification/listsearch?pageNum=${pto.startPage-1}&keyword=${pto.keyword}&category=${pto.category}'> &lt; </a></li>
				</c:if>
				
				<c:forEach var="pageIndex"  begin="${pto.startPage}" end="${pto.endPage}">
					<li class='page-item'><a class='page-link' href='http://localhost:8080/notification/listsearch?pageNum=${pageIndex}&keyword=${pto.keyword}&category=${pto.category}'>${pageIndex}</a></li>
				</c:forEach>
				
				<c:if test = "${pto.totalPages ne pto.endPage}"> <!-- 전체페이지와 마지막 페이지가 같으면  &gt; 표시가 없어짐 -->
					<li class='page-item'><a class='page-link' href='http://localhost:8080/notification/listsearch?pageNum=${pto.endPage+1}&keyword=${pto.keyword}&category=${pto.category}'> &gt; </a></li>
				</c:if>
            </ul>
            </nav>
</div>
<script>

window.onload=function(){
		 let BoardCount = <%= boardCount %>;
		 
		 if(BoardCount == 0){
			 alert ('해당되는 게시물이 없습니다.');
			 history.back();
		 }
	}
	
</script>