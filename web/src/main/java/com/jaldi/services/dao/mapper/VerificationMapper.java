package com.jaldi.services.dao.mapper;

import com.jaldi.services.model.Verification;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;


/**
 * Created by: Sedrak Dalaloyan
 * Date: 5/19/17
 * Time: 12:32 PM
 */
public class VerificationMapper implements RowMapper<Verification> {

    @Override
    public Verification mapRow(ResultSet resultSet, int i) throws SQLException {
        Verification verification = new Verification();
        verification.setId(resultSet.getLong("id"));
        verification.setRecipient(resultSet.getString("recipient"));
        verification.setCode(resultSet.getString("code"));
        verification.setCreationDate(resultSet.getTimestamp("creationDate"));
        return verification;
    }
}
