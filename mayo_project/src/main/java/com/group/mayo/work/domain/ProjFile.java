package com.group.mayo.work.domain;

import org.springframework.stereotype.Component;

@Component
public class ProjFile {

	private int file_no;
	private String proj_file_path;
 	private String proj_original_filename;
 	
	@Override
	public String toString() {
		return "ProjFile [file_no=" + file_no + ", proj_file_path=" + proj_file_path + ", proj_original_filename="
				+ proj_original_filename + "]";
	}

	public int getFile_no() {
		return file_no;
	}
	public String getProj_file_path() {
		return proj_file_path;
	}
	public String getProj_original_filename() {
		return proj_original_filename;
	}
	public void setFile_no(int file_no) {
		this.file_no = file_no;
	}
	public void setProj_file_path(String proj_file_path) {
		this.proj_file_path = proj_file_path;
	}
	public void setProj_original_filename(String proj_original_filename) {
		this.proj_original_filename = proj_original_filename;
	}
 	

 	
}
