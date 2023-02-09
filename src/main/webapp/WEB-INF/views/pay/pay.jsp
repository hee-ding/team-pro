<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	<!-- The Modal -->
	<div class="modal fade" id="myModal">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h4 class="modal-title">결제 확인</h4>
	        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
	      </div>
	
	      <!-- Modal body -->
	      <div id="confirmMebership" class="modal-body">
	      </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	      	<button id="paymentOk" type="button" class=" btn btn-primary"  data-bs-dismiss="modal">결제하기</button> <!-- 결제하기 버튼 생성 -->
	        <button id="paymentcancle" type="button" class="btn btn-danger" data-bs-dismiss="modal">취소하기</button>
	      </div>
	
	    </div>
	  </div>
	</div>


