package com.group.mayo.company.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.group.mayo.company.domain.Company;
import com.group.mayo.company.model.dao.CompanyDao;

@Service
public class CompanyServiceImpl implements CompanyService{
	@Autowired
	private CompanyDao dao;
	
	//회사등록
	@Override
	public int insertCompany(Company company) {
		return dao.insertCompany(company);
	}
	
	//사업자 번호 중복 확인
	@Override
	public int checkCpNumber(String cp_number) {
		int result = dao.checkCpNumber(cp_number);
		return result;
	}
	

	

}
