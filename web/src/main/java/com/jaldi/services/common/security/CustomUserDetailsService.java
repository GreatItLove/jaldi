package com.jaldi.services.common.security;

import com.jaldi.services.dao.UserDaoImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 3/29/17
 * Time: 2:03 PM
 */
@Component
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private UserDaoImpl userDao;

    @Override
    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {
        com.jaldi.services.model.User innerUser = userDao.loadUserByUsername(s);
        List<GrantedAuthority> grantedAuths = new ArrayList<>();
        grantedAuths.add(new SimpleGrantedAuthority(innerUser.getRole()));
        User springUser = new User(innerUser.getUsername(), innerUser.getPassword(), innerUser.isActive(),
                true, true, true,
                grantedAuths);
        return springUser;
    }
}
