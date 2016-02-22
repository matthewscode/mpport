package com.mp.mpport.dao;

import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mp.mpport.domain.User;

@Repository("userDao")
public class UserDAO {


	@Autowired
	private SessionFactory sessionFactory;

	public User findByUserName(String username) {
		return (User) sessionFactory.getCurrentSession().createCriteria(User.class).add(Restrictions.eq("userName", username)).uniqueResult();
	}
}
