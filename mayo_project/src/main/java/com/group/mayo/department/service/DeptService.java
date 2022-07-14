package com.group.mayo.department.service;

import java.util.List;
import java.util.Map;


public interface DeptService {
	/**
	 * 
	 * @return 부서목록(번호, 이름)
	 * @author JHPark
	 */
	public List<Map<String,Object>> selectDeptList();
}
