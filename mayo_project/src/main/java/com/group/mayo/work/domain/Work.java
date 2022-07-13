package com.group.mayo.work.domain;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class Work {

//	WORK_NO         NOT NULL NUMBER         
//	PROJ_NO         NOT NULL NUMBER         
//	WORK_TITLE               VARCHAR2(50)   
//	WORK_CONTENT             VARCHAR2(3000) 
//	WORK_MGR                 VARCHAR2(30)   
//	WORK_START_DATE          DATE           
//	WORK_DEADLINE            DATE           
//	WORK_PROGRESS            NUMBER         10% 단위
//	ISEMERGENCY     NOT NULL VARCHAR2(3)    
//	WORK_STATUS              NUMBER         0:요청 1:진행, 2: 완료, 3: 보류
//	WORK_DATE                TIMESTAMP(6)   

	private int work_no;
	private int proj_no;
	private String work_title;
	private String work_content;
	private String work_mgr;
	private Date work_start_date;
	private Date work_deadline;
	private int work_progress;
	private String isemergency;
	private int work_status;
	private Timestamp work_date;
	private String proj_name;
	private String work_pic;
	
	private List<ProjFile> projfilelist;

 	
	@Override
	public String toString() {
		return "Work [work_no=" + work_no + ", proj_no=" + proj_no + ", work_title=" + work_title + ", work_content="
				+ work_content + ", work_mgr=" + work_mgr + ", work_start_date=" + work_start_date + ", work_deadline="
				+ work_deadline + ", work_progress=" + work_progress + ", isemergency=" + isemergency + ", work_status="
				+ work_status + ", work_date=" + work_date + ", proj_name=" + proj_name + ", work_pic=" + work_pic
				+ ", projfilelist=" + projfilelist + "]";
	}

	public List<ProjFile> getProjfilelist() {
 		return projfilelist;
 	}
 	
 	public void setProjfilelist(List<ProjFile> projfilelist) {
 		this.projfilelist = projfilelist;
 	}
	
	public String getProj_name() {
		return proj_name;
	}

	public void setProj_name(String proj_name) {
		this.proj_name = proj_name;
	}
	
	public int getWork_no() {
		return work_no;
	}
	public int getProj_no() {
		return proj_no;
	}
	public String getWork_title() {
		return work_title;
	}
	public String getWork_content() {
		return work_content;
	}
	public String getWork_mgr() {
		return work_mgr;
	}
	public Date getWork_start_date() {
		return work_start_date;
	}
	public String getWork_pic() {
		return work_pic;
	}

	public void setWork_pic(String work_pic) {
		this.work_pic = work_pic;
	}

	public Date getWork_deadline() {
		return work_deadline;
	}
	public int getWork_progress() {
		return work_progress;
	}
	public String getIsemergency() {
		return isemergency;
	}
	public int getWork_status() {
		return work_status;
	}
	public Timestamp getWork_date() {
		return work_date;
	}
	public void setWork_no(int work_no) {
		this.work_no = work_no;
	}
	public void setProj_no(int proj_no) {
		this.proj_no = proj_no;
	}
	public void setWork_title(String work_title) {
		this.work_title = work_title;
	}
	public void setWork_content(String work_content) {
		this.work_content = work_content;
	}
	public void setWork_mgr(String work_mgr) {
		this.work_mgr = work_mgr;
	}
	public void setWork_start_date(Date work_start_date) {
		this.work_start_date = work_start_date;
	}
	public void setWork_deadline(Date work_deadline) {
		this.work_deadline = work_deadline;
	}
	public void setWork_progress(int work_progress) {
		this.work_progress = work_progress;
	}
	public void setIsemergency(String isemergency) {
		this.isemergency = isemergency;
	}
	public void setWork_status(int work_status) {
		this.work_status = work_status;
	}
	public void setWork_date(Timestamp work_date) {
		this.work_date = work_date;
	}
	
	
	
}
