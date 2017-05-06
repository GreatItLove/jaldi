package com.jaldi.services.dao.mapper;

import com.jaldi.services.model.User;
import com.jaldi.services.model.Worker;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 5/3/17
 * Time: 6:54 PM
 */
public class WorkerMapper implements RowMapper<Worker> {

    @Override
    public Worker mapRow(ResultSet rs, int i) throws SQLException {
        UserMapper userMapper = new UserMapper();
        User user = userMapper.mapRow(rs, i);
        Worker worker = new Worker();
        worker.setUser(user);
        worker.setCleaner(rs.getBoolean("isCleaner"));
        worker.setCarpenter(rs.getBoolean("isCarpenter"));
        worker.setElectrician(rs.getBoolean("isElectrician"));
        worker.setMason(rs.getBoolean("isMason"));
        worker.setPainter(rs.getBoolean("isPainter"));
        worker.setPlumber(rs.getBoolean("isPlumber"));
        worker.setAcTechnical(rs.getBoolean("isAcTechnical"));
        return worker;
    }
}
