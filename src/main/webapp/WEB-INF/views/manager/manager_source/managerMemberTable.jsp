<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.to.member.MemberTO" %>
<%@page import="com.to.member.MemberDAO"%>
<%@ page import="java.util.ArrayList" %>

<%

MemberDAO dao = new MemberDAO();
ArrayList<MemberTO> memberLists = dao.memberList();

int totalRecord = memberLists.size();

StringBuilder sbHtml = new StringBuilder();

for( MemberTO to : memberLists){
	String name = to.getName();
	String email = to.getEmail();
	 
	sbHtml.append("<tr>");
	sbHtml.append("<td>&nbsp;</td>");
	sbHtml.append("<td>" + name + "</td>");
	sbHtml.append("<td>" + email + "</td>");
	sbHtml.append("<td>&nbsp;</td>");
	sbHtml.append("</tr>");
 }
%>
    
    
    
<hr/>    

		<div class="container mt-5">
			<div class="row">

            <div class="page-heading">
                <section class="section">
                    <div class="card">
                        <div class="card-header bg-white">
                          <h3>회원관리</h3>
                          <p class="text-subtitle text-muted">회원을 검색/수정 관리합니다.</p>
                        </div>
                        <div class="card-body">
                            <table class="table table-hover" id="table1">
                                    <tr>
                                        <th>번호</th>
                                        <th>이름</th>
                                        <th>아이디</th>
                                        <th>이메일</th>
                                        <th>생년월일</th>
                                        <th>기능</th>
                                    </tr>
                                    <%=sbHtml.toString() %>
                                <tbody>
            <%-- 
            <c:when test="${!empty membersList}">
                <c:forEach var="mem" items="${membersList}">
                    <tr>
                        <td>${mem.id }</td>
                        <td>${mem.password }</td>
                        <td>${mem.name }</td>
                        <td>${mem.email }</td>
                        <td><a href="${contextPath}/.do?id=${mem.id}">수정</a></td>
                        <td><a href="${contextPath}/.do?id=${mem.id}">삭제</a></td>
                    </tr>
                </c:forEach>
            </c:when>
        </c:choose> --%>
   </table>
    <br>
</div>
</div>

               </section>
            </div>
         </div>
       </div>
