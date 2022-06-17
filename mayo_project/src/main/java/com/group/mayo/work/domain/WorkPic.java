package com.group.mayo.work.domain;

import org.springframework.stereotype.Component;

@Component
public class WorkPic {
	
//	WORK_NO     NOT NULL NUMBER       
//	WORK_PIC_ID          VARCHAR2(50) 
	
	private int work_no;
	private String work_pic_id;
	
	public int getWork_no() {
		return work_no;
	}
	public String getWork_pic_id() {
		return work_pic_id;
	}
	public void setWork_no(int work_no) {
		this.work_no = work_no;
	}
	public void setWork_pic_id(String work_pic_id) {
		this.work_pic_id = work_pic_id;
	}
	
	
}
