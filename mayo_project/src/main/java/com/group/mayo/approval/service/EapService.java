package com.group.mayo.approval.service;

import java.util.List;

import com.group.mayo.approval.domain.EapDomain;
import com.group.mayo.eaform.domain.EaForm;
import com.group.mayo.employee.domain.Employee;
import com.group.mayo.employee.domain.Holiday;

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
	 * @author JHPark
	 */
	public List<EaForm> selectListEaForm();
	
	/**
	 * 
	 * @param form_code : 양식코드
	 * @return 결재양식명, 양식내용 
	 * @author JHPark
	 */
	public EaForm selectForm(String form_code);
	
	/**
	 * 
	 * @return 로그인 사용자 휴가 개수
	 */
	public double selectLoginUserHoliday(String emp_no);
	
	/**
	 * 
	 * @param employee : 사용자
	 * @return 본인이 작성한 기안문 목록
	 * @author JHPark
	 */
	public List<EapDomain> selectMyList(Employee employee);
	
	/**
	 * 
	 * @param eap
	 * @return 선택한 결재문서 상세
	 * @author JHPark
	 */
	public EapDomain selectDraft(EapDomain eap);
	/**
	 * 
	 * @param eap
	 * @return 새 문서번호 생성
	 */
	public String selectNewEaNo(EapDomain eap);
	
	/**
	 * 
	 * @param ea_no
	 * @return 0 or 1
	 * @author JHPark
	 */
	public int deleteEap(String ea_no);
	
	/**
	 * 
	 * @param emp_no
	 * @return JHPark
	 */
	public List<EapDomain> selectListWaitApprove(String emp_no);
	
	/**
	 * 
	 * @param eap
	 * @return 결재문서 상세
	 */
	public EapDomain selectWait(EapDomain eap);
	
	/**
	 * 
	 * @param eap
	 * @return 0 or 1
	 */
	public int updateAppr(EapDomain eap);
	
	/**
	 * 
	 * @param eap
	 * @return 0 or 1
	 */
	public int updateReject(EapDomain eap);
}
