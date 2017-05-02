package com.jaldi.services.dao.mapper;


import com.jaldi.services.model.DataStore;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class DataStoreMapper implements RowMapper<DataStore> {

    @Override
    public DataStore mapRow(ResultSet rs, int i) throws SQLException {
        DataStore ds = new DataStore();
        ds.setId(rs.getString("id"));
        ds.setName(rs.getString("name"));
        ds.setType(DataStore.Type.valueOf(rs.getString("type")));
        ds.setContentType(rs.getString("contentType"));
        ds.setUrl(rs.getString("url"));
        return ds;
    }
}