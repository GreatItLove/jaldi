package com.jaldi.services.common.security;

import com.jaldi.services.dao.UserDaoImpl;
import com.jaldi.services.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.RememberMeAuthenticationToken;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 3/29/17
 * Time: 4:04 AM
 */
@Component
public class CustomAuthenticationProvider  implements AuthenticationProvider {

    @Autowired
    private UserDaoImpl userDao;

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        String email = authentication.getName();
        String password = authentication.getCredentials().toString();
        User user = userDao.getByUsernameAndPassword(email, password);
        if (user != null && user.isActive()) {
            List<GrantedAuthority> grantedAuths = new ArrayList<>();
            grantedAuths.add(new SimpleGrantedAuthority(user.getRole().name()));
            CustomAuthenticationToken auth = new CustomAuthenticationToken(email, password, grantedAuths);
            auth.setUser(user);
            return auth;
        } else {
            return null;
        }
    }

    @Override
    public boolean supports(Class<?> authentication) {
        return authentication.equals(UsernamePasswordAuthenticationToken.class) ||
                authentication.equals(RememberMeAuthenticationToken.class);
    }
}
