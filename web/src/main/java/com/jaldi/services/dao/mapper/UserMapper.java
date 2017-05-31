package com.jaldi.services.dao.mapper;

import com.jaldi.services.model.User;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 3/29/17
 * Time: 4:20 AM
 */
public class UserMapper implements RowMapper<User> {

    @Override
    public User mapRow(ResultSet rs, int i) throws SQLException {
        User user = new User();
        user.setId(rs.getLong("id"));
        user.setEmail(rs.getString("email"));
        user.setName(rs.getString("name"));
        user.setPhone(rs.getString("phone"));
        user.setRole(User.Role.valueOf(rs.getString("role")));
        user.setType(User.Type.valueOf(rs.getString("type")));
        user.setProfileImageId(rs.getString("profileImageId"));
        double latitude = rs.getDouble("latitude");
        if (!rs.wasNull()) {
            user.setLatitude(latitude);
        }
        double longitude = rs.getDouble("longitude");
        if (!rs.wasNull()) {
            user.setLongitude(longitude);
        }
        user.setActive(rs.getBoolean("isActive"));
        user.setDeleted(rs.getBoolean("isDeleted"));
        user.setCreationDate(rs.getTimestamp("creationDate"));
        return user;
    }
}
