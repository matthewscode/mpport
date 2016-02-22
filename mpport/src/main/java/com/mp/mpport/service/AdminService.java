package com.mp.mpport.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.mp.mpport.dao.ClientDAO;
import com.mp.mpport.domain.Client;

@Service("adminService")
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
public class AdminService {
	
	@Autowired
	private ClientDAO clientDao;
	
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	public boolean addClient(Client client){
		return clientDao.addClient(client);
	}
}
