package com.mp.mpport.service;

import java.io.IOException;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.mp.mpport.dao.ClientDAO;
import com.mp.mpport.dao.ClientKeyDAO;
import com.mp.mpport.dao.UserDAO;
import com.mp.mpport.domain.Client;
import com.mp.mpport.domain.ClientKey;
import com.mp.mpport.domain.User;

@Service("adminService")
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
public class AdminService {
	
	@Autowired
	private ClientDAO clientDao;
	@Autowired
	private ClientKeyDAO clientKeyDao;
	@Autowired
	private UserDAO userDao;
	
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	public boolean addClient(Client client){
		return clientDao.addClient(client);
	}
	
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	public boolean addUserKey(String username, String clientSlug){
		//TODO: check for unique in the future
		User user = userDao.findByUserName(username);
		Client client = clientDao.getClientBySlug(clientSlug);
		
		if(!checkUserKey(user,client)){
			String key = UUID.randomUUID().toString();
			ClientKey newCk = new ClientKey();
			newCk.setUser(user);
			newCk.setClient(client);
			newCk.setKey(key);
			try {
				propogateKey(client, newCk);
			} catch (IOException e) {
				e.printStackTrace();
			}
			clientKeyDao.addClientKey(newCk);
			return true;
		}
		return false;
	}
	
	public boolean checkUserKey(User user, Client client){
		for(ClientKey ck : user.getKeyList()){
			if(ck.getClient().equals(client)){
				return true;
			}
		}
		return false;
	}
	
	private void propogateKey(Client client, ClientKey newCk) throws IOException {
		String postData = "username=" + URLEncoder.encode(newCk.getUser().getUserName(), "UTF-8") + "&keyString=" + URLEncoder.encode(newCk.getKey(), "UTF-8");
		URL url = new URL(client.getApiLocation()+"/api/user-key/create/");
		HttpURLConnection  httpConn = (HttpURLConnection) url.openConnection();
        httpConn.setUseCaches(false);
        httpConn.setDoInput(true);
        httpConn.setDoOutput(true);
        OutputStreamWriter writer = new OutputStreamWriter(
        httpConn.getOutputStream());
        writer.write(postData);
        writer.flush();
	}
}
