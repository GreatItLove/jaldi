package com.jaldi.services.dao;

import com.jaldi.services.common.Util;
import com.jaldi.services.dao.mapper.WorkerMapper;
import com.jaldi.services.model.Worker;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

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
public class WorkerDaoImpl {

    @Autowired
    private JdbcTemplate jdbc;

    @Autowired
    private UserDaoImpl userDao;

    @Autowired
    private NamedParameterJdbcTemplate namedJdbc;

    public List<Worker> findAll() {
        try {
            String sql = "SELECT `id`, `email`, `name`, `phone`, `role`, `type`, `profileImageId`, `latitude`, `longitude`, `isActive`, `isDeleted`, `creationDate`, `isCleaner`, `isCarpenter`, `isElectrician`, `isMason`, `isPainter`, `isPlumber`, `isAcTechnical`, `rating`, `totalOrders` FROM `user` inner join workerDetails on `user`.id = workerDetails.userId where `type` = 'WORKER' AND isDeleted = 0;";
            return jdbc.query(
                    sql, new WorkerMapper());
        } catch (EmptyResultDataAccessException e) {
            return Collections.emptyList();
        }
    }

    @Transactional
    public Worker create(Worker worker) {
        worker.setUser(userDao.create(worker.getUser()));
        jdbc.update("INSERT INTO `workerDetails` (userId, isCleaner, isCarpenter, " +
                "isElectrician, isMason, isPainter, isPlumber, isAcTechnical, `rating`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);",
                worker.getUser().getId(), worker.isCleaner(), worker.isCarpenter(), worker.isElectrician(),
                worker.isMason(), worker.isPainter(), worker.isPlumber(), worker.isAcTechnical(), worker.getRating());
        return worker;
    }

    public Worker findOne(long id) {
        try {
            String sql = "SELECT `id`, `email`, `name`, `phone`, `role`, `type`, `profileImageId`, `latitude`, `longitude`, `isActive`, `isDeleted`, `creationDate`, `isCleaner`, `isCarpenter`, `isElectrician`, `isMason`, `isPainter`, `isPlumber`, `isAcTechnical`, `rating`, `totalOrders` FROM `user` inner join workerDetails on `user`.id = workerDetails.userId where `type` = 'WORKER' AND `user`.id = ?;";
            return jdbc.queryForObject(
                    sql, new WorkerMapper(), id);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    public void delete(long id) {
        jdbc.update("UPDATE `user` SET isDeleted = 1 WHERE id = ?;", id);
    }

    @Transactional
    public Worker update(Worker worker) {
        Map namedParameters = new HashMap();
        namedParameters.put("id", worker.getUser().getId());
        namedParameters.put("cleaner", worker.isCleaner());
        namedParameters.put("carpenter", worker.isCarpenter());
        namedParameters.put("electrician", worker.isElectrician());
        namedParameters.put("mason", worker.isMason());
        namedParameters.put("painter", worker.isPainter());
        namedParameters.put("plumber", worker.isPlumber());
        namedParameters.put("acTechnical", worker.isAcTechnical());
        namedParameters.put("rating", worker.getRating());
        namedJdbc.update("UPDATE workerDetails SET isCleaner = :cleaner, isCarpenter = :carpenter, isElectrician = :electrician, " +
                "isMason = :mason, isPainter = :painter, isPlumber = :plumber, isAcTechnical = :acTechnical, rating = :rating WHERE userId = :id", namedParameters);
        namedParameters.put("name", worker.getUser().getName());
        namedParameters.put("phone", Util.formatPhone(worker.getUser().getPhone()));
        namedParameters.put("email", worker.getUser().getEmail());
        namedParameters.put("isActive", worker.getUser().isActive());
        namedJdbc.update("UPDATE `user` SET `name` = :name, `phone` = :phone, `email` = :email, isActive = :isActive WHERE id = :id;", namedParameters);
        return worker;
    }

    public Worker updateRating(Worker worker) {
        Map namedParameters = new HashMap();
        namedParameters.put("id", worker.getUser().getId());
        namedParameters.put("rating", worker.getRating());
        namedParameters.put("totalOrders", worker.getTotalOrders());
        namedJdbc.update("UPDATE workerDetails SET rating = :rating, totalOrders = :totalOrders WHERE userId = :id", namedParameters);
        return worker;
    }
}
