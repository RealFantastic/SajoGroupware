package com.group.mayo.company.model.service;

import com.group.mayo.company.domain.Company;

public interface CompanyService {

	/**
	 * 
	 * @return 추가된 회사수
	 * @author XeonSnee
	 */
	public int insertCompany(Company company);
	/**
	 * 
	 * @return 사업자 번호 중복확인
	 * @author XeonSnee
	 */
	public int checkCpNumber(String cp_number);
}
