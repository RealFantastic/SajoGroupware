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
	private Timestamp draft_date;
	private String first_approver;



	private String second_approver;
	private String third_approver;
	private String final_approver;
	private List<String> approver_emp_no;
	private int status_code;
	private int result_code;
	private String form_code;	//NN
	private String return_reson;
	private String update_date;
	private String isemergency;
	
	//결재문서 상세보기 결재선 배치시 사용
	private String drafter_name;
	private String dept_name;
	private String form_title;
	private String first_name;
	private String second_name;
	private String third_name;
	private String final_name;
	private String drafter_sign_path;
	private String first_sign_path;
	private String second_sign_path;
	private String third_sign_path;
	private String final_sign_path;
	private String drafter_job_name;
	private String first_job_name;
	private String second_job_name;
	private String third_job_name;
	private String final_job_name;
	
	//파일
	private List<ApprovalFile> approvalFiles;


	@Override
	public String toString() {
		return "EapDomain [ea_no=" + ea_no + ", ea_title=" + ea_title + ", ea_content=" + ea_content + ", drafter_id="
				+ drafter_id + ", draft_date=" + draft_date + ", first_approver=" + first_approver
				+ ", second_approver=" + second_approver + ", third_approver=" + third_approver + ", final_approver="
				+ final_approver + ", approver_emp_no=" + approver_emp_no + ", status_code=" + status_code
				+ ", result_code=" + result_code + ", form_code=" + form_code + ", return_reson=" + return_reson
				+ ", update_date=" + update_date + ", isemergency=" + isemergency + ", drafter_name=" + drafter_name
				+ ", dept_name=" + dept_name + ", form_title=" + form_title + ", first_name=" + first_name
				+ ", second_name=" + second_name + ", third_name=" + third_name + ", final_name=" + final_name
				+ ", drafter_sign_path=" + drafter_sign_path + ", first_sign_path=" + first_sign_path
				+ ", second_sign_path=" + second_sign_path + ", third_sign_path=" + third_sign_path
				+ ", final_sign_path=" + final_sign_path + ", drafter_job_name=" + drafter_job_name
				+ ", first_job_name=" + first_job_name + ", second_job_name=" + second_job_name + ", third_job_name="
				+ third_job_name + ", final_job_name=" + final_job_name + ", approvalFiles=" + approvalFiles + "]";
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
	
	public Timestamp getDraft_date() {
		return draft_date;
	}
	public void setDraft_date(Timestamp draft_date) {
		this.draft_date = draft_date;
	}
	
	public int getResult_code() {
		return result_code;
	}
	public void setResult_code(int result_code) {
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
	public String getDrafter_name() {
		return drafter_name;
	}
	public void setDrafter_name(String drafter_name) {
		this.drafter_name = drafter_name;
	}
	public String getFirst_name() {
		return first_name;
	}
	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}
	public String getSecond_name() {
		return second_name;
	}
	public void setSecond_name(String second_name) {
		this.second_name = second_name;
	}
	public String getThird_name() {
		return third_name;
	}
	public void setThird_name(String third_name) {
		this.third_name = third_name;
	}
	public String getFinal_name() {
		return final_name;
	}
	public void setFinal_name(String final_name) {
		this.final_name = final_name;
	}
	public String getDrafter_sign_path() {
		return drafter_sign_path;
	}
	public void setDrafter_sign_path(String drafter_sign_path) {
		this.drafter_sign_path = drafter_sign_path;
	}
	public String getFirst_sign_path() {
		return first_sign_path;
	}
	public void setFirst_sign_path(String first_sign_path) {
		this.first_sign_path = first_sign_path;
	}
	public String getSecond_sign_path() {
		return second_sign_path;
	}
	public void setSecond_sign_path(String second_sign_path) {
		this.second_sign_path = second_sign_path;
	}
	public String getThird_sign_path() {
		return third_sign_path;
	}
	public void setThird_sign_path(String third_sign_path) {
		this.third_sign_path = third_sign_path;
	}
	public String getFinal_sign_path() {
		return final_sign_path;
	}
	public void setFinal_sign_path(String final_sign_path) {
		this.final_sign_path = final_sign_path;
	}
	public String getDrafter_job_name() {
		return drafter_job_name;
	}
	public void setDrafter_job_name(String drafter_job_name) {
		this.drafter_job_name = drafter_job_name;
	}
	public String getFirst_job_name() {
		return first_job_name;
	}
	public void setFirst_job_name(String first_job_name) {
		this.first_job_name = first_job_name;
	}
	public String getSecond_job_name() {
		return second_job_name;
	}
	public void setSecond_job_name(String second_job_name) {
		this.second_job_name = second_job_name;
	}
	public String getThird_job_name() {
		return third_job_name;
	}
	public void setThird_job_name(String third_job_name) {
		this.third_job_name = third_job_name;
	}
	public String getFinal_job_name() {
		return final_job_name;
	}
	public void setFinal_job_name(String final_job_name) {
		this.final_job_name = final_job_name;
	}


	public String getDept_name() {
		return dept_name;
	}


	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}

	
	


	
	
	
	
}
