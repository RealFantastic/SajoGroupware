package com.group.mayo.company.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.group.mayo.company.domain.Company;

@Repository
public class CompanyDao {
	@Autowired
	SqlSession sqlSession;
	
	//ȸ����
	public int insertCompany(Company company) {
		return sqlSession.insert("Company.insertCompany",company);
	}
	//����� ��ȣ �ߺ� Ȯ��
	public int checkCpNumber(String cp_number) {
		int result = sqlSession.selectOne("Company.checkCpNumber",cp_number);
		System.out.println("�ȳ�1!!");
		
		
		
		return result;
	}

}
