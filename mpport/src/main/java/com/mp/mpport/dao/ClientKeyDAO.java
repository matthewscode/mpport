package com.mp.mpport.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mp.mpport.domain.ClientKey;
import com.mp.mpport.domain.User;

@Repository("clientKeyDao")
public class ClientKeyDAO {
	@Autowired
	private SessionFactory sessionFactory;
	
	@SuppressWarnings("unchecked")
	public List<ClientKey> getUserClientKeyList(User user) {
		return sessionFactory.getCurrentSession().createCriteria(ClientKey.class).add(Restrictions.eq("user", user)).list();
	}
}
