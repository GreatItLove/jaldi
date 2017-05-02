package com.jaldi.services.dao;

import com.jaldi.services.dao.mapper.UserMapper;
import com.jaldi.services.model.DataStore;
import com.jaldi.services.model.User;
import com.jaldi.services.model.request.UpdateProfileRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
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

    @Autowired
    private DataStoreDaoImpl dataStoreDao;

    public User getById(long id) {
        try {
            String sql = "SELECT `id`, `email`, `name`, `phone`, `password`, `role`, `type`, `profileImageId`, `isActive`, `isDeleted`, `creationDate` FROM `user` WHERE `id` = ?;";
            User user = jdbcTemplate.queryForObject(
                    sql, new UserMapper(), id);
            return user;
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    public User getByUsernameAndPassword(String username, String password) {
        try {
            String sql = "SELECT `id`, `email`, `name`, `phone`, `password`, `role`, `type`, `profileImageId`, `isActive`, `isDeleted`, `creationDate` FROM `user` WHERE `email` = ? AND password(?) = `password`;";
            User user = jdbcTemplate.queryForObject(
                    sql, new UserMapper(), username, password);
            return user;
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    public User loadUserByUsername(String username) {
        try {
            String sql = "SELECT `id`, `email`, `name`, `phone`, `password`, `role`, `type`, `profileImageId`, `isActive`, `isDeleted`, `creationDate` FROM `user` WHERE `email` = ?;";
            User user = jdbcTemplate.queryForObject(
                    sql, new UserMapper(), username, username);
            return user;
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Transactional
    public String updateProfilePicture(UpdateProfileRequest request, DataStore ds) {
        final DataStore dataStore = dataStoreDao.createDataStore(ds);
        Map namedParameters = new HashMap();
        namedParameters.put("id", request.getId());
        namedParameters.put("profileImageId", dataStore.getId());
        namedJdbc.update("update `user` set `profileImageId` = :profileImageId where `id` = :id;", namedParameters);
        return dataStore.getId();
    }

    public User updateProfile(User user) {
        Map namedParameters = new HashMap();
        namedParameters.put("id", user.getId());
        namedParameters.put("name", user.getName());
        namedParameters.put("phone", user.getPhone());
        namedJdbc.update("update `user` set `name` = :name, phone = :phone where `id` = :id;", namedParameters);
        return user;
    }

    public boolean updatePassword(UpdateProfileRequest request) {
        Map namedParameters = new HashMap();
        namedParameters.put("id", request.getId());
        namedParameters.put("oldPassword", request.getOldPassword());
        namedParameters.put("newPassword", request.getNewPassword());
        int count = namedJdbc.update("update `user` set `password` = password(:newPassword) where `id` = :id AND `password` = password(:oldPassword);", namedParameters);
        return count > 0;
    }
}
