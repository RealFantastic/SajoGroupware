package com.group.mayo.approval.domain;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class EapDomain {
//	--------------- -------- -------------- 
//	EA_NO           NOT NULL VARCHAR2(50)   
//	EA_TITLE        NOT NULL VARCHAR2(100)  
//	EA_CONTENT      NOT NULL VARCHAR2(1000) 
//	DRAFTER_ID      NOT NULL VARCHAR2(50)   
//	DRAFT_DATE      NOT NULL TIMESTAMP(6)   
//	FIRST_APPROVER           VARCHAR2(50)   
//	SECOND_APPROVER          VARCHAR2(50)   
//	THIRD_APPROVER           VARCHAR2(50)   
//	FINAL_APPROVER           VARCHAR2(50)   
//	STATUS_CODE              NUMBER         
//	RESULT_CODE              VARCHAR2(1)    
//	FORM_CODE       NOT NULL VARCHAR2(20)   
//	RETURN_RESON             VARCHAR2(200)  
//	UPDATE_DATE              DATE   
	
	private String ea_no;	//NN
	private String ea_title;	//NN
	private String ea_content;	//NN
	private String drafter_id;	//NN
	private Timestamp draft_date;	//NN
	private String first_approver;
	private String second_approver;
	private String third_approver;
	private String final_approver;
	private List<String> approver_emp_no;
	private int status_code;
	private String result_code;
	private String form_code;	//NN
	private String return_reson;
	private String update_date;
	private String isemergency;
	
	private String form_title;
	//ÆÄÀÏ
	private List<ApprovalFile> approvalFiles;
	

	
	@Override
	public String toString() {
		return "EapDomain [ea_no=" + ea_no + ", ea_title=" + ea_title + ", ea_content=" + ea_content + ", drafter_id="
				+ drafter_id + ", draft_date=" + draft_date + ", first_approver=" + first_approver
				+ ", second_approver=" + second_approver + ", third_approver=" + third_approver + ", final_approver="
				+ final_approver + ", approver_emp_no=" + approver_emp_no + ", status_code=" + status_code
				+ ", result_code=" + result_code + ", form_code=" + form_code + ", return_reson=" + return_reson
				+ ", update_date=" + update_date + ", isemergency=" + isemergency + ", form_title=" + form_title
				+ ", approvalFiles=" + approvalFiles + "]";
	}
	
	public String getEa_no() {
		return ea_no;
	}
	public void setEa_no(String ea_no) {
		this.ea_no = ea_no;
	}
	public String getEa_title() {
		return ea_title;
	}
	public void setEa_title(String ea_title) {
		this.ea_title = ea_title;
	}
	public String getEa_content() {
		return ea_content;
	}
	public void setEa_content(String ea_content) {
		this.ea_content = ea_content;
	}
	public String getDrafter_id() {
		return drafter_id;
	}
	public void setDrafter_id(String drafter_id) {
		this.drafter_id = drafter_id;
	}
	public Timestamp getDraft_date() {
		return draft_date;
	}
	public void setDraft_date(Timestamp draft_date) {
		this.draft_date = draft_date;
	}
	public String getFirst_approver() {
		return first_approver;
	}
	public void setFirst_approver(String first_approver) {
		this.first_approver = first_approver;
	}
	public String getSecond_approver() {
		return second_approver;
	}
	public void setSecond_approver(String second_approver) {
		this.second_approver = second_approver;
	}
	public String getThird_approver() {
		return third_approver;
	}
	public void setThird_approver(String third_approver) {
		this.third_approver = third_approver;
	}
	public String getFinal_approver() {
		return final_approver;
	}
	public void setFinal_approver(String final_approver) {
		this.final_approver = final_approver;
	}
	public List<String> getApprover_emp_no() {
		return approver_emp_no;
	}
	public void setApprover_emp_no(List<String> approver_emp_no) {
		this.approver_emp_no = approver_emp_no;
	}
	public int getStatus_code() {
		return status_code;
	}
	public void setStatus_code(int status_code) {
		this.status_code = status_code;
	}
	public String getResult_code() {
		return result_code;
	}
	public void setResult_code(String result_code) {
		this.result_code = result_code;
	}
	public String getForm_code() {
		return form_code;
	}
	public void setForm_code(String form_code) {
		this.form_code = form_code;
	}
	public String getReturn_reson() {
		return return_reson;
	}
	public void setReturn_reson(String return_reson) {
		this.return_reson = return_reson;
	}
	public String getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}

	public String getIsemergency() {
		return isemergency;
	}

	public void setIsemergency(String isemergency) {
		this.isemergency = isemergency;
	}
	public String getForm_title() {
		return form_title;
	}
	public void setForm_title(String form_title) {
		this.form_title = form_title;
	}

	public List<ApprovalFile> getApprovalFiles() {
		return approvalFiles;
	}

	public void setApprovalFiles(List<ApprovalFile> approvalFiles) {
		this.approvalFiles = approvalFiles;
	}


	


	
	
	
	
}
