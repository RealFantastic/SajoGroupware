package com.group.mayo.eaform.domain;

public class EaForm {
//	이름           널?       유형             
//			------------ -------- -------------- 
//			FORM_CODE    NOT NULL VARCHAR2(20)   
//			FORM_TITLE            VARCHAR2(500)  
//			FORM_CONTENT          VARCHAR2(1000) 
	private String form_code;
	private String form_title;
	private String form_content;
	@Override
	public String toString() {
		return "EaForm [form_code=" + form_code + ", form_title=" + form_title + ", form_content=" + form_content + "]";
	}
	
	
	public String getForm_code() {
		return form_code;
	}
	public void setForm_code(String form_code) {
		this.form_code = form_code;
	}
	public String getForm_title() {
		return form_title;
	}
	public void setForm_title(String form_title) {
		this.form_title = form_title;
	}
	public String getForm_content() {
		return form_content;
	}
	public void setForm_content(String form_content) {
		this.form_content = form_content;
	}
	
	
	
}
