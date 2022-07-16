package com.group.mayo.approval.domain;

import org.springframework.stereotype.Component;

@Component
public class ApprovalFile {
	private int f_no;
	private String doc_no;
	private String f_original_name;
	private String f_upload_name;
	private String f_path;
	@Override
	public String toString() {
		return "ApprovalFile [f_no=" + f_no + ", doc_no=" + doc_no + ", f_original_name=" + f_original_name
				+ ", f_upload_name=" + f_upload_name + ", f_path=" + f_path + "]";
	}
	public int getF_no() {
		return f_no;
	}
	public void setF_no(int f_no) {
		this.f_no = f_no;
	}
	public String getDoc_no() {
		return doc_no;
	}
	public void setDoc_no(String doc_no) {
		this.doc_no = doc_no;
	}
	public String getF_original_name() {
		return f_original_name;
	}
	public void setF_original_name(String f_original_name) {
		this.f_original_name = f_original_name;
	}
	public String getF_upload_name() {
		return f_upload_name;
	}
	public void setF_upload_name(String f_upload_name) {
		this.f_upload_name = f_upload_name;
	}
	public String getF_path() {
		return f_path;
	}
	public void setF_path(String f_path) {
		this.f_path = f_path;
	}
	
	
}
