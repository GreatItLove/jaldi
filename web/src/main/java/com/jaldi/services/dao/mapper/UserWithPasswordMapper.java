package com.jaldi.services.dao.mapper;

import com.jaldi.services.model.User;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 5/2/17
 * Time: 2:32 AM
 */
public class UserWithPasswordMapper implements RowMapper<User> {

    @Override
    public User mapRow(ResultSet resultSet, int i) throws SQLException {
        return null;
    }
}
