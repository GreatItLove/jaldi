package com.jaldi.services.dao;

import com.jaldi.services.dao.mapper.DataStoreMapper;
import com.jaldi.services.model.DataStore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class DataStoreDaoImpl {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public DataStore getDataStore(String id) {
        try {
            return jdbcTemplate.queryForObject("SELECT `id`, `name`, `contentType`, `url`, `type` FROM dataStore where `id` = ?", new DataStoreMapper(), id);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    public DataStore createDataStore(final DataStore dataStore) {
        jdbcTemplate.update("INSERT INTO `dataStore` (`id`, `name`, `contentType`, `url`, `type`) VALUES (?, ?, ?, ?, ?)", dataStore.getId(), dataStore.getName(),
                dataStore.getContentType(), dataStore.getUrl(), dataStore.getType().name());
        return dataStore;
    }
}
