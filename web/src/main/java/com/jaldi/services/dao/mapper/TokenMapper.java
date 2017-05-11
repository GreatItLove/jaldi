package com.jaldi.services.dao.mapper;

import com.jaldi.services.model.Token;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 5/11/17
 * Time: 4:23 PM
 */
public class TokenMapper implements RowMapper<Token> {

    @Override
    public Token mapRow(ResultSet rs, int i) throws SQLException {
        Token token = new Token();
        token.setId(rs.getLong("id"));
        token.setToken(rs.getString("token"));
        token.setUserId(rs.getLong("userId"));
        token.setType(Token.Type.valueOf(rs.getString("type")));
        return token;
    }
}
