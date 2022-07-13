package com.group.mayo.approval.service;

import java.util.List;

import com.group.mayo.approval.domain.EapDomain;
import com.group.mayo.eaform.domain.EaForm;
import com.group.mayo.employee.domain.Employee;

public interface EapService {
	/**
	 * 
	 * @param eap 결재문서 파라미터
	 * @return 0 or 1
	 * @author JHPark
	 */
	public int insertEap(EapDomain eap);
	
	/**
	 * @return 결재양식 목록 
	 * @auther JHPark
	 */
	public List<EaForm> selectListEaForm();
	
	/**
	 * 
	 * @param form_code : 양식코드
	 * @return 결재양식명, 양식내용 
	 * @auther JHPark
	 */
	public EaForm selectForm(String form_code);
	/**
	 * 
	 * @param employee : 사용자
	 * @return 본인이 작성한 기안문 목록
	 */
	public List<EapDomain> selectMyList(Employee employee);
}
