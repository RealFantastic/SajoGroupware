package com.group.mayo.holidayEmp.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.group.mayo.employee.domain.HolidayEmployee;

@Repository
public class EmpHolidayDao {
	@Autowired
	SqlSession sqlSession;
	
	public int insertTotal(HolidayEmployee hemployee) {
		return sqlSession.insert("EmpHoliday.insertTotal",hemployee);
	}
	
	public int updateEmpHd(HolidayEmployee hemployee) {
		return sqlSession.update("EmpHoliday.updateEmpHd",hemployee);
	}
	
	public int updateRestore(HolidayEmployee hemployee) {
		return sqlSession.update("EmpHoliday.updateRestore",hemployee);
	}
}
