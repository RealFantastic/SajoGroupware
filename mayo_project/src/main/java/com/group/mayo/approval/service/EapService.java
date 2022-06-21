package com.group.mayo.approval.service;

import java.util.List;

import com.group.mayo.approval.domain.EapDomain;
import com.group.mayo.eaform.domain.EaForm;

public interface EapService {
	/**
	 * 
	 * @param eap 결재문서 파라미터
	 * @return JHPark
	 */
	public int insertEap(EapDomain eap);
	
	/**
	 * 
	 * @return JHPark
	 */
	public List<EaForm> selectListEaForm();
	
	/**
	 * 
	 * @param form_code : 양식코드
	 * @return JHPark
	 */
	public EaForm selectForm(String form_code);
}
