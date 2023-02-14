<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.maumgagym.dto.MemberTO" %>
<%@page import="com.maumgagym.dao.MemberDAO"%>
<%@ page import="java.util.ArrayList" %>

<%

ArrayList<MemberTO> memberLists = (ArrayList) request.getAttribute("memberList");

int totalRecord = memberLists.size();

StringBuilder sbHtml = new StringBuilder();

for( MemberTO to : memberLists){
	int seq = to.getSeq();
	String name = to.getName();
	String id = to.getId();
	String email = to.getEmail();
	String birthday = to.getBirthday();
	 
	sbHtml.append("<tr>");
	sbHtml.append("<td>" + seq + "</td>");
	sbHtml.append("<td>" + name + "</td>");
	sbHtml.append("<td>" + id + "</td>");
	sbHtml.append("<td>" + email + "</td>");
	sbHtml.append("<td>" + birthday + "</td>");
	sbHtml.append("<td><a onclick=\"deleteboard('"+seq+"');\"><span class=\"badge bg-danger\">삭제</span></a></td>");
	sbHtml.append("</tr>");
 }
%> 
<hr/>   
	<script type="text/javascript">
		function deleteboard(deleteSeq) {
		//	alert(deleteSeq);
		var param = {
				seq : deleteSeq
		}
				var ans = confirm("선택하신 회원을 삭제하시겠습니까?");
				console.log('click!!!!!');
				if(ans === true){
			        $.ajax({
			            url: "/manager/memberDelete",
			            method: "GET",
			            dataType: "json",
			            data:param,
			            success: function (data) {
			                console.log(data);
			                location.reload();
			               	alert('삭제되었습니다.');
			            }
				      });
				   }else {
				      return false;
				}

			}
</script>
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
