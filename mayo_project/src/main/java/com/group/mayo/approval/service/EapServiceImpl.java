package com.group.mayo.approval.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.group.mayo.approval.domain.EapDomain;
import com.group.mayo.approval.model.dao.EapDao;

@Service
@Transactional
public class EapServiceImpl implements EapService {
	@Autowired
	private EapDao dao;
	
	
	@Override
	public int insertEap(EapDomain eap) {
		
		return dao.insertEap(eap);
	}

}
