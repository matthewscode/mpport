package com.mp.mpport.security;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.mp.mpport.dao.UserDAO;
import com.mp.mpport.domain.UserRole;

@Service("userDetailsService")
public class PortUserDetailsService implements UserDetailsService{

	@Autowired
	private UserDAO userDao;

	
	@Override
	@Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
	public UserDetails loadUserByUsername(final String username) 
		throws UsernameNotFoundException {
		
		com.mp.mpport.domain.User user = userDao.findByUserName(username);
		List<GrantedAuthority> authorities =  buildUserAuthority(user.getUserRole());
		return buildUserForAuthentication(user, authorities);
		
	}
	
	private User buildUserForAuthentication(com.mp.mpport.domain.User user, 
			List<GrantedAuthority> authorities) {
			return new User(user.getUserName(), user.getPassword(), 
				user.isEnabled(), true, true, true, authorities);
		}
	private List<GrantedAuthority> buildUserAuthority(Set<UserRole> userRoles) {

		Set<GrantedAuthority> setAuths = new HashSet<GrantedAuthority>();

		// Build user's authorities
		for (UserRole userRole : userRoles) {
			setAuths.add(new SimpleGrantedAuthority(userRole.getRole()));
		}

		List<GrantedAuthority> Result = new ArrayList<GrantedAuthority>(setAuths);

		return Result;
	}


}
