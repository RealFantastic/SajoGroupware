package com.group.mayo.employee.domain;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

@Component
public class CommuteRecord {
//이름         널?       유형           
//---------- -------- ------------ 
//RECORD_NO  NOT NULL NUMBER		기록번호      
//EMP_NO     NOT NULL VARCHAR2(50)	사원번호(아이디)
//START_TIME          TIMESTAMP(6)	시작시간
//END_TIME            TIMESTAMP(6)	종료시간

	private int record_no;
	private String emp_no;
	private String today_start_time;
	private String today_end_time;
	
	private String start_time;
	private String end_time;
	
	private String wokr_day;
	private String oneday_work;
	private String week_work;
	private String week_work_mod;
	
	private String week_rate;
	private String mod_rate;
	


	@Override
	public String toString() {
		return "CommuteRecord [record_no=" + record_no + ", emp_no=" + emp_no + ", today_start_time=" + today_start_time
				+ ", today_end_time=" + today_end_time + ", start_time=" + start_time + ", end_time=" + end_time
				+ ", wokr_day=" + wokr_day + ", oneday_work=" + oneday_work + ", week_work=" + week_work
				+ ", week_work_mod=" + week_work_mod + ", week_rate=" + week_rate + ", mod_rate=" + mod_rate + "]";
	}

	public int getRecord_no() {
		return record_no;
	}

	public void setRecord_no(int record_no) {
		this.record_no = record_no;
	}

	public String getEmp_no() {
		return emp_no;
	}

	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}

	public String getToday_start_time() {
		return today_start_time;
	}

	public void setToday_start_time(String today_start_time) {
		this.today_start_time = today_start_time;
	}

	public String getToday_end_time() {
		return today_end_time;
	}

	public void setToday_end_time(String today_end_time) {
		this.today_end_time = today_end_time;
	}

	public String getStart_time() {
		return start_time;
	}

	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}

	public String getEnd_time() {
		return end_time;
	}

	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}

	public String getWokr_day() {
		return wokr_day;
	}

	public void setWokr_day(String wokr_day) {
		this.wokr_day = wokr_day;
	}

	public String getOneday_work() {
		return oneday_work;
	}

	public void setOneday_work(String oneday_work) {
		this.oneday_work = oneday_work;
	}

	public String getWeek_work() {
		return week_work;
	}

	public void setWeek_work(String week_work) {
		this.week_work = week_work;
	}

	public String getWeek_work_mod() {
		return week_work_mod;
	}

	public void setWeek_work_mod(String week_work_mod) {
		this.week_work_mod = week_work_mod;
	}

	public String getWeek_rate() {
		return week_rate;
	}

	public void setWeek_rate(String week_rate) {
		this.week_rate = week_rate;
	}

	public String getMod_rate() {
		return mod_rate;
	}

	public void setMod_rate(String mod_rate) {
		this.mod_rate = mod_rate;
	}
	
	

	
	
	}
