package com.jaldi.services.rest;

import com.jaldi.services.common.security.CustomAuthenticationToken;
import com.jaldi.services.dao.OrderDaoImpl;
import com.jaldi.services.model.Order;
import com.jaldi.services.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
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
        return orderDao.findAll(type, status);
    }

    @RequestMapping(method= RequestMethod.POST)
    public Order create(@RequestBody Order order) {
        CustomAuthenticationToken token = (CustomAuthenticationToken) SecurityContextHolder.getContext().getAuthentication();
        User currentUser = token.getUser();
        order.setStatus(Order.Status.CREATED);
        order.setUser(currentUser);
        return orderDao.create(order);
    }
}
