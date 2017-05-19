package com.jaldi.services.dao;

import com.jaldi.services.dao.mapper.VerificationMapper;
import com.jaldi.services.model.Verification;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 5/19/17
 * Time: 12:27 PM
 */
@Repository
public class VerificationDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public Verification create(Verification verification) {
        KeyHolder holder = new GeneratedKeyHolder();
        jdbcTemplate.update(new PreparedStatementCreator() {

            @Override
            public PreparedStatement createPreparedStatement(Connection connection)
                    throws SQLException {
                PreparedStatement ps = connection.prepareStatement("INSERT INTO verification(`recipient`, `code`) VALUES (?, ?);", Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, verification.getRecipient());
                ps.setString(2, verification.getCode());
                return ps;
            }
        }, holder);
        verification.setId(holder.getKey().longValue());
        return verification;
    }

    public Verification getById(long id) {
        try {
            String sql = "SELECT `id`, `recipient`, `code`, `creationDate` from `verification` WHERE `id` = ?;";
            return jdbcTemplate.queryForObject(sql, new VerificationMapper(), id);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }
}
