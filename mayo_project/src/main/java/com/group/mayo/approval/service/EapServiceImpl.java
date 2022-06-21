package com.group.mayo.approval.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.group.mayo.approval.domain.EapDomain;
import com.group.mayo.approval.model.dao.EapDao;
import com.group.mayo.eaform.domain.EaForm;

@Service
@Transactional
public class EapServiceImpl implements EapService {
	@Autowired
	private EapDao dao;
	
	
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
	
	

}
