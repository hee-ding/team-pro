package com.maumgagym.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class MemberShipTO {
	
	int membership_seq;
	String membership_name;
	String full_membership_name;
	int membership_price;
	int membership_period;
	
	int flag;
	
}
