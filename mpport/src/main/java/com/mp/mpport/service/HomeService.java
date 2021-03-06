package com.mp.mpport.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.mp.mpport.dao.ClientDAO;
import com.mp.mpport.dao.UserDAO;
import com.mp.mpport.domain.Client;
import com.mp.mpport.domain.ClientKey;
import com.mp.mpport.domain.User;

@Service("homeService")
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
public class HomeService {
	
	@Autowired
	private UserDAO userDao;
	@Autowired
	private ClientDAO clientDao;
	
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	public List<Client> getUserClientList(){
		
		UserDetails userDetails = (UserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		User user = userDao.findByUserName(userDetails.getUsername());
		List<ClientKey> ckList = user.getKeyList();
		List<Client> clientList = new ArrayList<>();
		for(ClientKey ck : ckList){
			clientList.add(ck.getClient());
		}
		return clientList;
	}

	@Transactional
	public Client getClientBySlug(String clientSlug) {
		Client client = clientDao.getClientBySlug(clientSlug);
		return client;
	}

	@Transactional
	public User getUserByUsername() {
		UserDetails userDetails = (UserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		return userDao.findByUserName(userDetails.getUsername());
	}

	public ClientKey getUserKey(Client currentClient) {
		UserDetails userDetails = (UserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		User user = userDao.findByUserName(userDetails.getUsername());
		for(ClientKey ck : user.getKeyList()){
			if(ck.getClient().getId() == currentClient.getId()){
				return ck;
			}
		}
		return null;
	}
}