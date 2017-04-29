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

    public List<User> loadAll() {
        try {
            String sql = "SELECT `id`, `email`, `name`, `username`, `password`, `role`, `isActive`, `partnerId`, `isRepresentative`, `profileImageId`, `creationDate` FROM `user`;";
            List<User> users = jdbcTemplate.query(
                    sql, new UserMapper());
            return users;
        } catch (DataAccessException e) {
            return Collections.emptyList();
        }
    }

    public void create(User user) {
        jdbcTemplate.update("INSERT INTO user(`email`, `name`, `username`, `password`, `partnerId`) VALUES (?, ?, ?, password(?), ?);",
                user.getEmail(), user.getName(), user.getUsername(), user.getPassword(), user.getPartnerId());
    }

    public boolean checkUsername(String username) {
        String sql = "SELECT count(*) FROM `user` WHERE username = ?;";
        int count = jdbcTemplate.queryForObject(
                sql, new Object[] { username }, Integer.class);
        return count > 0;
    }

    public boolean checkEmail(String email) {
        String sql = "SELECT count(*) FROM `user` WHERE `email` = ?;";
        int count = jdbcTemplate.queryForObject(
                sql, new Object[] { email }, Integer.class);
        return count > 0;
    }

    public User getByUsernameAndPassword(String username, String password) {
        try {
            String sql = "SELECT `id`, `email`, `name`, `username`, `role`, `isActive`, `partnerId`, `isRepresentative`, `profileImageId`, `creationDate` FROM `user` WHERE (`email` = ? or `username` = ?) AND password(?) = `password`;";
            User user = jdbcTemplate.queryForObject(
                    sql, new UserMapper(), username, username, password);
            return user;
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    public User loadUserByUsername(String username) {
        try {
            String sql = "SELECT `id`, `email`, `name`, `username`, `password`, `role`, `isActive`, `partnerId`, `isRepresentative`, `profileImageId`, `creationDate` FROM `user` WHERE `email` = ? or `username` = ?;";
            User user = jdbcTemplate.queryForObject(
                    sql, new UserMapper(), username, username);
            return user;
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    public void updateUserPassword(User user) {
        jdbcTemplate.update("UPDATE user set `password` = password(?) WHERE `id` = ?;",
                user.getPassword(), user.getId());
    }

    public User getById(long id) {
        try {
            String sql = "SELECT `id`, `email`, `name`, `username`, `password`, `role`, `isActive`, `partnerId`, `isRepresentative`, `profileImageId`, `creationDate` FROM `user` WHERE `id` = ?;";
            User user = jdbcTemplate.queryForObject(
                    sql, new UserMapper(), id);
            return user;
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    public User getFullProfile(long id) {
        try {
            String sql = "SELECT `id`, `email`, `name`, `username`, `password`, `role`, `isActive`, `partnerId`, `isRepresentative`, " +
                    "`profileImageId`, `countryCode`, `phone`, `whatsapp`, `viber`, `telegram`, `skype`, `creationDate` FROM `user` WHERE `id` = ?;";
            User user = jdbcTemplate.queryForObject(
                    sql, new UserMapper(), id);
            return user;
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    public User updateProfile(User user) {
        Map namedParameters = new HashMap();
        namedParameters.put("id", user.getId());
        namedParameters.put("name", user.getName());
        namedParameters.put("countryCode", user.getCountryCode());
        namedParameters.put("phone", user.getPhone());
        namedParameters.put("whatsapp", user.getWhatsapp());
        namedParameters.put("viber", user.getViber());
        namedParameters.put("telegram", user.getTelegram());
        namedParameters.put("skype", user.getSkype());
        namedJdbc.update("update `user` set name = :name, countryCode = :countryCode, phone = :phone, whatsapp = :whatsapp, " +
                "viber = :viber, telegram = :telegram, skype = :skype where `id` = :id;", namedParameters);
        return user;
    }



    public User becomeRepresentative(User user) {
        Map namedParameters = new HashMap();
        namedParameters.put("id", user.getId());
        namedParameters.put("representative", user.isRepresentative());
        namedJdbc.update("update `user` set isRepresentative = :representative where `id` = :id;", namedParameters);
        return user;
    }
}
