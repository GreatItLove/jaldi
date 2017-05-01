package com.jaldi.services.dao;

import com.jaldi.services.dao.mapper.UserMapper;
import com.jaldi.services.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 3/27/17
 * Time: 4:37 PM
 */
@Repository
public class UserDaoImpl {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private NamedParameterJdbcTemplate namedJdbc;

    public User getByUsernameAndPassword(String username, String password) {
        try {
            String sql = "SELECT `id`, `email`, `name`, `phone`, `password`, `role`, `type`, `isActive`, `isDeleted`, `creationDate` FROM `user` WHERE `email` = ? AND password(?) = `password`;";
            User user = jdbcTemplate.queryForObject(
                    sql, new UserMapper(), username, password);
            return user;
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    public User loadUserByUsername(String username) {
        try {
            String sql = "SELECT `id`, `email`, `name`, `phone`, `password`, `role`, `type`, `isActive`, `isDeleted`, `creationDate` FROM `user` WHERE `email` = ?;";
            User user = jdbcTemplate.queryForObject(
                    sql, new UserMapper(), username, username);
            return user;
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }
}
