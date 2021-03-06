package com.mp.mpport.dao;

import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mp.mpport.domain.Client;

@Repository("clientDao")
public class ClientDAO {
	
	@Autowired
    private SessionFactory sessionFactory;
	
	public boolean addClient(Client client){
		try{
			sessionFactory.getCurrentSession().saveOrUpdate(client);
			return true;
		}catch(HibernateException e){
			e.printStackTrace();
			return false;
		}
	}

	public Client getClientBySlug(String clientSlug) {
		return (Client) sessionFactory.getCurrentSession().createCriteria(Client.class).add(Restrictions.eq("slug", clientSlug)).uniqueResult();
	}
}
