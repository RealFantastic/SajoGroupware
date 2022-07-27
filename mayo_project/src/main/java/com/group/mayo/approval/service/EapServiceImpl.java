package com.group.mayo.approval.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.group.mayo.approval.domain.EapDomain;
import com.group.mayo.approval.model.dao.EapDao;
import com.group.mayo.eaform.domain.EaForm;
import com.group.mayo.employee.domain.Employee;

@Service
@Transactional
public class EapServiceImpl implements EapService {
	@Autowired
	private EapDao dao;
	
	
	
	@Override
	public String selectNewEaNo(EapDomain eap) {
		return dao.selectNewEaNo(eap);
	}


	@Override
	public int insertEap(EapDomain eap) {
		
		return dao.insertEap(eap);
	}


	@Override
	public List<EaForm> selectListEaForm() {
		
		return dao.selectListEaForm();
	}


	@Override
	public EaForm selectForm(String form_code) {
		return dao.selectForm(form_code);
	}

	
	
	@Override
	public double selectLoginUserHoliday(String emp_no) {
		return dao.selectLoginUserHoliday(emp_no);
	}


	@Override
	public List<EapDomain> selectMyList(Employee employee) {
		
		return dao.selectMyList(employee);
	}


	@Override
	public EapDomain selectDraft(EapDomain eap) {
		return dao.selectDraft(eap);
	}


	@Override
	public int deleteEap(String ea_no) {
		return dao.deleteEap(ea_no);
	}


	@Override
	public List<EapDomain> selectListWaitApprove(String emp_no) {
		return dao.selectListWaitApprove(emp_no);
	}


	@Override
	public EapDomain selectWait(EapDomain eap) {
		return dao.selectWait(eap);
	}


	@Override
	public int updateAppr(EapDomain eap) {
		return dao.updateAppr(eap);
	}


	@Override
	public int updateReject(EapDomain eap) {
		return dao.updateReject(eap);
	}


	@Override
	public List<EapDomain> selectMyListProceeding(Employee employee) {
		return dao.selectMyListProceeding(employee);
	}


	@Override
	public List<EapDomain> selectMyListComplete(Employee employee) {
		return dao.selectMyListComplete(employee);
	}
	
	
	
	
	
	

}
