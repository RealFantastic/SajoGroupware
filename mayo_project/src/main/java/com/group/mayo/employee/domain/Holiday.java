package com.group.mayo.employee.domain;

import java.sql.Date;
import java.sql.Timestamp;

import org.springframework.stereotype.Component;

@Component
public class Holiday {
//이름       널?       유형            
//-------- -------- ------------- 
//HD_NO    NOT NULL NUMBER        
//EMP_NO   NOT NULL VARCHAR2(50)  
//REQ_DATE          TIMESTAMP(6)  
//HD_START          DATE          
//HD_END            DATE          
//HD_CODE           VARCHAR2(1)   
//HD_COUNT          NUMBER        
//HD_RESON          VARCHAR2(100) 

	private int HD_NO;
	private String EMP_NO;
	private	Timestamp REQ_DATE;
	private	Date HD_START;
	private	Date HD_END;
	private	String HD_CODE;
	private	int HD_COUNT;
	private	String HD_RESON;
	
	
	@Override
	public String toString() {
		return "Rest [HD_NO=" + HD_NO + ", EMP_NO=" + EMP_NO + ", REQ_DATE=" + REQ_DATE + ", HD_START=" + HD_START
				+ ", HD_END=" + HD_END + ", HD_CODE=" + HD_CODE + ", HD_COUNT=" + HD_COUNT + ", HD_RESON=" + HD_RESON
				+ "]";
	}


	public int getHD_NO() {
		return HD_NO;
	}


	public void setHD_NO(int hD_NO) {
		HD_NO = hD_NO;
	}


	public String getEMP_NO() {
		return EMP_NO;
	}


	public void setEMP_NO(String eMP_NO) {
		EMP_NO = eMP_NO;
	}


	public Timestamp getREQ_DATE() {
		return REQ_DATE;
	}


	public void setREQ_DATE(Timestamp rEQ_DATE) {
		REQ_DATE = rEQ_DATE;
	}


	public Date getHD_START() {
		return HD_START;
	}


	public void setHD_START(Date hD_START) {
		HD_START = hD_START;
	}


	public Date getHD_END() {
		return HD_END;
	}


	public void setHD_END(Date hD_END) {
		HD_END = hD_END;
	}


	public String getHD_CODE() {
		return HD_CODE;
	}


	public void setHD_CODE(String hD_CODE) {
		HD_CODE = hD_CODE;
	}


	public int getHD_COUNT() {
		return HD_COUNT;
	}


	public void setHD_COUNT(int hD_COUNT) {
		HD_COUNT = hD_COUNT;
	}


	public String getHD_RESON() {
		return HD_RESON;
	}


	public void setHD_RESON(String hD_RESON) {
		HD_RESON = hD_RESON;
	}
	
	
	
}
