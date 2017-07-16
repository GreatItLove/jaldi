package com.jaldi.services.common.tasks;

import com.jaldi.services.dao.OrderDaoImpl;
import com.jaldi.services.dao.WorkerDaoImpl;
import com.jaldi.services.model.Order;
import com.jaldi.services.model.Worker;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

import java.math.BigDecimal;
import java.util.List;

/**
 * Created by ArtStyle on 15.07.2017.
 */

@Configuration
@EnableAsync
@EnableScheduling
public class RatingBackgroundTask {

    @Autowired
    private WorkerDaoImpl workerDao;

    @Autowired
    private OrderDaoImpl orderDao;

    @Async
    @Scheduled(fixedDelay=60000)
    public void everyMinuteTrigger(){
        List<Worker> workers = workerDao.findAll();
        for (Worker worker : workers) {
            List<Order> orders = orderDao.ordersByWorkerId(worker.getUser().getId());
            if(!orders.isEmpty()){
                worker.setRating(orders.stream().mapToInt(Order::getUserRating).sum()/orders.size());
                workerDao.update(worker);
            }
        }
    }
}
