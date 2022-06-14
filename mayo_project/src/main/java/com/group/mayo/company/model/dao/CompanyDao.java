package com.group.mayo.company.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.group.mayo.company.domain.Company;

@Repository
public class CompanyDao {
	@Autowired
	SqlSession sqlSession;
	
	//회사등록
	public int insertCompany(Company company) {
		return sqlSession.insert("Company.insertCompany",company);
	}
	//사업자 번호 중복 확인
	public int checkCpNumber(String cp_number) {
		int result = sqlSession.selectOne("Company.checkCpNumber",cp_number);
		System.out.println("안녕1!!");
		
		
		
		return result;
	}

}
