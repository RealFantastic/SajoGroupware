package com.group.mayo.company.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.group.mayo.company.domain.Company;
import com.group.mayo.company.model.dao.CompanyDao;

@Service
public class CompanyServiceImpl implements CompanyService{
	@Autowired
	private CompanyDao dao;
	

	@Override
	public int insertCompany(Company company) {
		return dao.insertCompany(company);
	}


	

}
