package com.jaldi.services.rest;

import com.jaldi.services.dao.WorkerDaoImpl;
import com.jaldi.services.model.User;
import com.jaldi.services.model.Worker;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 3/30/17
 * Time: 2:33 PM
 */
@RestController
@RequestMapping("/rest/worker")
@PreAuthorize("hasAnyAuthority('OPERATOR', 'ADMIN')")
public class WorkerService {

    @Autowired
    private WorkerDaoImpl workerDao;

    @GetMapping
    public List<Worker> findAll() {
        return workerDao.findAll();
    }


    @RequestMapping(value="/{id}", method=RequestMethod.GET)
    public Worker findOne(@PathVariable("id") long id) {
        return workerDao.findOne(id);
    }

    @RequestMapping(method= RequestMethod.POST)
    public Worker create(@RequestBody Worker worker) {
        worker.getUser().setRole(User.Role.USER);
        worker.getUser().setType(User.Type.WORKER);
        return workerDao.create(worker);
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @RequestMapping(value="/{id}", method=RequestMethod.DELETE)
    public void delete(@PathVariable("id") long id) {
        workerDao.delete(id);
    }

    @RequestMapping(value="/{id}", method=RequestMethod.PUT)
    public Worker update(@RequestBody Worker worker) {
        return workerDao.update(worker);
    }

}
