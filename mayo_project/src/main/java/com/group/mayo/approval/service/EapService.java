package com.group.mayo.approval.service;

import com.group.mayo.approval.domain.EapDomain;

public interface EapService {
	/**
	 * 
	 * @param eap 결재문서 파라미터
	 * @return JHPark
	 */
	public int insertEap(EapDomain eap);
}
