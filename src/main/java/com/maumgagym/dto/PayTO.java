package com.maumgagym.dto;

import java.util.UUID;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class PayTO {
	
	String merchant_uid;					// 마음가짐 고유 주문번호
	int membership_seq;						// 업체별 고유 회원권 번호
	String type;							// 1: 카드. 2: 현금 등오로 표시할 것.
	String imp_uid;							// 1: 카드. 2: 현금 등오로 표시할 것.
	
	
	String pay_date;						// 결제일( now() )
	String pay_status; 						// 결제 상세 내역 상태 ==> 1: 완료 , 2: 실패, 3: 환불, 헷갈릴경우 TO 클래스 분할
	
	int membership_register_seq;			// 회원권 상태 ==> 1: 승인 대기, 2: 정상, 3: 홀딩, 4: 만료
	String membership_register_date;		// 등록일
	String membership_expiry_date;			// 만료일
	String membership_register_status;		// 회원권 상태 ==> 1: 승인 대기, 2: 정상, 3: 홀딩, 4: 만료
	
	
	String hold_date;						// 홀딩 시작일		==> 업체 마이페이지에서 홀딩 버튼 클릭시 다음날로 설정
	String hold_end_date;					// 홀딩 정지일		==> 업체 마이페이지에서 홀딩 중지 버튼 클릭시 
	String hold_sum_date;					// 홀딩 총 기간	==> 중지 버튼 클릭시 자동 생성
	
	int flag;
	
	public PayTO() {
		this.merchant_uid =  "merchant_" + UUID.randomUUID().toString();
	}
	
}
