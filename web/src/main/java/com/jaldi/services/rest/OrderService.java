package com.jaldi.services.rest;

import com.jaldi.services.common.Constants;
import com.jaldi.services.common.security.CustomAuthenticationToken;
import com.jaldi.services.dao.OrderDaoImpl;
import com.jaldi.services.model.Order;
import com.jaldi.services.model.User;
import com.jaldi.services.model.Worker;
import com.jaldi.services.model.request.AssignWorkerRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 5/16/17
 * Time: 3:55 PM
 */
@RestController
@RequestMapping("/rest/order")
public class OrderService {

    @Autowired
    private OrderDaoImpl orderDao;

    @GetMapping
    @PreAuthorize("hasAnyAuthority('OPERATOR', 'ADMIN')")
    public List<Order> findAll(@RequestParam(value = "type", required = false) String type, @RequestParam(value = "status", required = false) String status) {
        List<Order> orders = orderDao.findAll(type, status);
        return orders;
    }

    @RequestMapping(value="/{id}", method=RequestMethod.GET)
    public ResponseEntity findOne(@PathVariable("id") long id) {
        CustomAuthenticationToken token = (CustomAuthenticationToken) SecurityContextHolder.getContext().getAuthentication();
        User currentUser = token.getUser();
        Order result = orderDao.findOne(id);
        //TODO
        if(result != null && (token.getAuthorities().contains(Constants.OPERATOR_PERMISSION_NAME) ||
                token.getAuthorities().contains(Constants.ADMIN_PERMISSION_NAME) ||
                        result.getUser().getId() == currentUser.getId())) {
            return ResponseEntity.ok(result);
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);

    }

    @GetMapping("/my")
    public List<Order> getMy() {
        CustomAuthenticationToken token = (CustomAuthenticationToken) SecurityContextHolder.getContext().getAuthentication();
        User currentUser = token.getUser();
        return orderDao.findForUser(currentUser.getId());
    }

    @RequestMapping(method= RequestMethod.POST)
    public Order create(@RequestBody Order order) {
        CustomAuthenticationToken token = (CustomAuthenticationToken) SecurityContextHolder.getContext().getAuthentication();
        User currentUser = token.getUser();
        order.setStatus(Order.Status.CREATED);
        order.setUser(currentUser);
        Order newolder = orderDao.create(order);
        return newolder;
    }

    @RequestMapping(value="/cancel/{id}", method=RequestMethod.PUT)
    public ResponseEntity cancelOrder(@PathVariable("id") long id) {
        CustomAuthenticationToken token = (CustomAuthenticationToken) SecurityContextHolder.getContext().getAuthentication();
        User currentUser = token.getUser();
        Order result = orderDao.findOne(id);
        if(result != null && result.getStatus().ordinal() > Order.Status.EN_ROUTE.ordinal()) {
            return ResponseEntity.status(HttpStatus.NOT_ACCEPTABLE).body(null);
        }
        orderDao.cancelOrder(currentUser.getId(), id);
        return ResponseEntity.ok(null);
    }

    @RequestMapping(value="/rate", method=RequestMethod.PUT)
    public void updateRating(@RequestBody Order order) {
        CustomAuthenticationToken token = (CustomAuthenticationToken) SecurityContextHolder.getContext().getAuthentication();
        User currentUser = token.getUser();
        orderDao.updateWorkerRating(currentUser.getId(), order);
    }

    @RequestMapping(value="/feedback", method=RequestMethod.PUT)
    public void updateFeedback(@RequestBody Order order) {
        CustomAuthenticationToken token = (CustomAuthenticationToken) SecurityContextHolder.getContext().getAuthentication();
        User currentUser = token.getUser();
        orderDao.updateFeedback(currentUser.getId(), order);
    }

    @PreAuthorize("hasAnyAuthority('OPERATOR', 'ADMIN')")
    @RequestMapping(value = "/assignWorker", method = RequestMethod.POST)
    public ResponseEntity assignWorker(@RequestBody AssignWorkerRequest assignWorkerRequest) {
        boolean created = orderDao.assignWorker(assignWorkerRequest);
        if(!created){
            return ResponseEntity.status(HttpStatus.CONFLICT).body(null);
        }
        return ResponseEntity.ok(null);
    }

    @RequestMapping(value = "/workers/{id}", method = RequestMethod.GET)
    public List<Worker> getWorkers(@PathVariable("id") long id){
        return orderDao.getWorkers(id);
    }

}
