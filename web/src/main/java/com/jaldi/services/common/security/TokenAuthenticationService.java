package com.jaldi.services.common.security;

import com.jaldi.services.dao.UserDaoImpl;
import com.jaldi.services.model.User;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Component
class TokenAuthenticationService {

  static final long EXPIRATION_TIME = 864_000_000_00L; // 1000 days
  static final String SECRET = "0_JaldiSecret_0";
  static final String TOKEN_PREFIX = "Bearer";
  static final String HEADER_STRING = "Authorization";

  @Autowired
  private UserDaoImpl userDao;

  public void addAuthentication(HttpServletResponse res, String username) {
    String JWT = Jwts.builder()
        .setSubject(username)
        .setExpiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
        .signWith(SignatureAlgorithm.HS512, SECRET)
        .compact();
    res.addHeader(HEADER_STRING, TOKEN_PREFIX + " " + JWT);
  }

  public Authentication getAuthentication(String token) {
    if (token != null) {
      // parse the token.
      try {
        String username = Jwts.parser()
                .setSigningKey(SECRET)
                .parseClaimsJws(token.replace(TOKEN_PREFIX, ""))
                .getBody()
                .getSubject();
        User user = userDao.loadUserByUsername(username);
        if (user != null && user.isActive() && !user.isDeleted()) {
          List<GrantedAuthority> grantedAuths = new ArrayList<>();
          grantedAuths.add(new SimpleGrantedAuthority(user.getRole().name()));
          CustomAuthenticationToken auth = new CustomAuthenticationToken(username, null, grantedAuths);
          auth.setUser(user);
          return auth;
        }
      } catch (MalformedJwtException e) {
        e.printStackTrace();
      }
    }
    return null;
  }
}