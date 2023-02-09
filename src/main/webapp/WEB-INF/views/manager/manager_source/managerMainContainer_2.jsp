<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

		<div class="container mt-5">
			<div class="row">
			
                <section class="section">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card">
                                <br>
                                <div class="card-header mb-5">
                                    <h4 class="card-title">게시물 통계 <a><i class="bi bi-box-arrow-in-up-right text-nowrap text-end"></i></a></h4>
                                </div>
                                <div class="card-body">
                                     <canvas id="chLine"></canvas>
                                </div>
                            </div>
                        </div>
                        
                        
                        <div class="col-md-6">
                            <div class="card">
                              <br>
                                <div class="card-header mb-5">
                                    <h4 class="card-title">접속 현황 <a><i class="bi bi-box-arrow-in-up-right text-nowrap text-end"></i></a></h4>
                                </div>
                                <div class="card-body">
                                    <canvas id="chBar"></canvas>
                                </div>
                            </div>
                        </div>
                        
                    </div>
                </section>
                
                
			</div>
		</div>