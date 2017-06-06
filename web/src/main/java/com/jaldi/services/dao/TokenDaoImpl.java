package com.jaldi.services.dao;

import com.jaldi.services.dao.mapper.TokenMapper;
import com.jaldi.services.model.Token;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 5/11/17
 * Time: 4:21 PM
 */
@Repository
public class TokenDaoImpl {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public void create(Token token) {
        jdbcTemplate.update("INSERT INTO token(`token`, `userId`, `type`) VALUES (?, ?, ?);",
                token.getToken(), token.getUserId(), token.getType().name());
    }

    public Token getToken(String token, Token.Type type) {
        try {
            String sql = "SELECT `id`, `token`, `userId`, `type` from `token` WHERE `token` = ? and `type` = ?;";
            Token tokenObj = jdbcTemplate.queryForObject(
                    sql, new TokenMapper(), token, type.name());
            return tokenObj;
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    public void removeToken(long id) {
        jdbcTemplate.update("DELETE FROM token WHERE id = ?;", id);
    }

    public void removeToken(Token.Type type, long userId) {
        jdbcTemplate.update("DELETE from token WHERE type = ? and userId = ?;", type.name(), userId);
    }

    @Transactional
    public void update(Token deviceToken) {
        removeToken(deviceToken.getType(), deviceToken.getUserId());
        create(deviceToken);
    }
}
