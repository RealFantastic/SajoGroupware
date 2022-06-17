package com.group.mayo.work.domain;

import org.springframework.stereotype.Component;

@Component
public class WorkFile {

//	FILE_NO                NOT NULL NUMBER        
//	PROJ_FILE_PATH                  VARCHAR2(300) 
//	PROJ_FILENAME                   VARCHAR2(200) 
//	PROJ_ORIGINAL_FILENAME          VARCHAR2(200) 
//	WORK_NO                NOT NULL NUMBER     
	
	private int file_no;
	private String proj_file_path;
	private String proj_filename;
	private String proj_original_filename;
	private int work_no;
	
	
	@Override
	public String toString() {
		return "WorkFile [file_no=" + file_no + ", proj_file_path=" + proj_file_path + ", proj_filename="
				+ proj_filename + ", proj_original_filename=" + proj_original_filename + ", work_no=" + work_no + "]";
	}
	
	public int getFile_no() {
		return file_no;
	}
	public String getProj_file_path() {
		return proj_file_path;
	}
	public String getProj_filename() {
		return proj_filename;
	}
	public String getProj_original_filename() {
		return proj_original_filename;
	}
	public int getWork_no() {
		return work_no;
	}
	public void setFile_no(int file_no) {
		this.file_no = file_no;
	}
	public void setProj_file_path(String proj_file_path) {
		this.proj_file_path = proj_file_path;
	}
	public void setProj_filename(String proj_filename) {
		this.proj_filename = proj_filename;
	}
	public void setProj_original_filename(String proj_original_filename) {
		this.proj_original_filename = proj_original_filename;
	}
	public void setWork_no(int work_no) {
		this.work_no = work_no;
	}
	
	
}
