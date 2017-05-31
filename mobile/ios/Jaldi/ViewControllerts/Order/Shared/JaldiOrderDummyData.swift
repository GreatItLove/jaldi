//
//  JaldiOrderDummyData.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/27/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
import ObjectMapper
enum OrderListType: Int {
    case past
    case upcoming
    case inProgress
}
struct JaldiOrderDummyData {
    static func ordersFor(orderListType: OrderListType) -> [JaldiOrder] {
       let orderDummyData =  JaldiOrderDummyData()
        switch orderListType {
        case .past:
           return orderDummyData.pastOrders()
        case .upcoming:
            return orderDummyData.upComingOrders()
        case .inProgress:
            return orderDummyData.inProgressOrders()
        }
    }
    private func pastOrders() -> [JaldiOrder] {
        
        let date1 = Date().add(hours: -20)
        let date2 = Date().add(hours: -24)
        let date3 = Date().add(hours: 2)
        
        let date1Str = date1.dateStringWith(format: AppDateFormats.appDateFormat)
        let date2Str = date2.dateStringWith(format: AppDateFormats.appDateFormat)
        let date3Str = date3.dateStringWith(format: AppDateFormats.appDateFormat)
   
        let order1 = [ "address" : "Paronyan street",
            "cost" : Float(300),
            "formattedOrderDate" : date1Str,
            "hours" : 3,
            "id" : 53,
            "latitude" : 40.17773703872351,
            "longitude" : 44.50301790316016,
            "orderDate" : 1495895400000,
            "paymentType" : "CASH",
            "status" : "CREATED",
            "type" : "CLEANER",
            "workers" : 1,
              "user" : [
                "active" : 1,
                "creationDate" : 1495288330000,
                "deleted" : 0,
                "email" : "test@gmail.com",
                "formattedCreationDate" : "20/05/2017 13:52",
                "id": 37,
                "name" : "Test",
                "password" : "",
                "phone" : "1111111111",
                "profileImageId" : "<null>",
                "role" : "USER",
                "type" : "CUSTOMER"]
            ] as [String : Any]
        
        let order2 = [ "address" : "Spartak stadium",
                       "cost" : Float(200),
                       "formattedOrderDate" :date2Str,
                       "hours" : 2,
                       "id" : 53,
                       "latitude" : 40.17064426191766,
                       "longitude" : 44.51086966085126,
                       "orderDate" : 1495895400000,
                       "paymentType" : "CASH",
                       "status" : "CREATED",
                       "type" : "CLEANER",
                       "workers" : 1,
                       "user" : [
                            "active" : 1,
                            "creationDate" : 1495288330000,
                            "deleted" : 0,
                            "email" : "test@gmail.com",
                            "formattedCreationDate" : "20/05/2017 13:52",
                            "id": 37,
                            "name" : "Test",
                            "password" : "",
                            "phone" : "1111111111",
                            "profileImageId" : "<null>",
                            "role" : "USER",
                            "type" : "CUSTOMER"]
            ] as [String : Any]
        let order3 = [ "address" : "Armenia",
                       "cost" : Float(500),
                       "formattedOrderDate" : date3Str,
                       "hours" : 5,
                       "id" : 53,
                       "latitude" : 40.14528999999999,
                       "longitude" : 45.07690400000002,
                       "orderDate" : 1495895400000,
                       "paymentType" : "CASH",
                       "status" : "CREATED",
                       "type" : "CLEANER",
                       "workers" : 1,
                       "user" : [
                        "active" : 1,
                        "creationDate" : 1495288330000,
                        "deleted" : 0,
                        "email" : "test@gmail.com",
                        "formattedCreationDate" : "20/05/2017 13:52",
                        "id": 37,
                        "name" : "Test",
                        "password" : "",
                        "phone" : "1111111111",
                        "profileImageId" : "<null>",
                        "role" : "USER",
                        "type" : "CUSTOMER"]
            ] as [String : Any]
        let order4 = [ "address" : "Armenia",
                       "cost" : Float(300),
                       "formattedOrderDate" : "20/05/2017 13:52",
                       "hours" : 3,
                       "id" : 53,
                       "latitude" : 40.14528999999999,
                       "longitude" : 45.07690400000002,
                       "orderDate" : 1495895400000,
                       "paymentType" : "CASH",
                       "status" : "CREATED",
                       "type" : "CLEANER",
                       "workers" : 1,
                       "user" : [
                        "active" : 1,
                        "creationDate" : 1495288330000,
                        "deleted" : 0,
                        "email" : "test@gmail.com",
                        "formattedCreationDate" : "20/05/2017 13:52",
                        "id": 37,
                        "name" : "Test",
                        "password" : "",
                        "phone" : "1111111111",
                        "profileImageId" : "<null>",
                        "role" : "USER",
                        "type" : "CUSTOMER"]
            ] as [String : Any]
        let orderlist = [order1,order2,order3,order4]
        guard let orders  = Mapper<JaldiOrder>().mapArray(JSONArray: orderlist) else{
            return [JaldiOrder]()
        }
        return orders
    }
    
    private func upComingOrders() -> [JaldiOrder] {
        let order1 = [ "address" : "Paronyan street",
                       "cost" : Float(300),
                       "formattedOrderDate" : "20/05/2017 13:52",
                       "hours" : 3,
                       "id" : 43,
                       "latitude" : 40.17773703872351,
                       "longitude" : 44.50301790316016,
                       "orderDate" : 1495895400000,
                       "paymentType" : "CASH",
                       "status" : "CREATED",
                       "type" : "CLEANER",
                       "workers" : 1,
                       "user" : [
                            "active" : 1,
                            "creationDate" : 1495288330000,
                            "deleted" : 0,
                            "email" : "test@gmail.com",
                            "formattedCreationDate" : "20/05/2017 13:52",
                            "id": 37,
                            "name" : "Test",
                            "password" : "",
                            "phone" : "1111111111",
                            "profileImageId" : "<null>",
                            "role" : "USER",
                            "type" : "CUSTOMER"]
            ] as [String : Any]
        
        let order2 = [ "address" : "Spartak stadium",
                       "cost" : Float(200),
                       "formattedOrderDate" : "20/05/2017 13:52",
                       "hours" : 2,
                       "id" : 43,
                       "latitude" : 40.17064426191766,
                       "longitude" : 44.51086966085126,
                       "orderDate" : 1495895400000,
                       "paymentType" : "CASH",
                       "status" : "CREATED",
                       "type" : "CLEANER",
                       "workers" : 1,
                       "user" : [
                        "active" : 1,
                        "creationDate" : 1495288330000,
                        "deleted" : 0,
                        "email" : "test@gmail.com",
                        "formattedCreationDate" : "20/05/2017 13:52",
                        "id": 37,
                        "name" : "Test",
                        "password" : "",
                        "phone" : "1111111111",
                        "profileImageId" : "<null>",
                        "role" : "USER",
                        "type" : "CUSTOMER"]
            ] as [String : Any]

        let order3 = [ "address" : "Armenia",
                       "cost" : Float(200),
                       "formattedOrderDate" : "27/05/2017 14:30",
                       "hours" : 2,
                       "id" : 43,
                       "latitude" : 40.14528999999999,
                       "longitude" : 45.07690400000002,
                       "orderDate" : 1495895400000,
                       "paymentType" : "CASH",
                       "status" : "CREATED",
                       "type" : "CLEANER",
                       "workers" : 1,
                       "user" : [
                        "active" : 1,
                        "creationDate" : 1495288330000,
                        "deleted" : 0,
                        "email" : "test@gmail.com",
                        "formattedCreationDate" : "27/05/2017 14:30",
                        "id": 37,
                        "name" : "Test",
                        "password" : "",
                        "phone" : "1111111111",
                        "profileImageId" : "<null>",
                        "role" : "USER",
                        "type" : "CUSTOMER"]
            ] as [String : Any]
        let orderlist = [order1,order2,order3]
        guard let orders  = Mapper<JaldiOrder>().mapArray(JSONArray: orderlist) else{
            return [JaldiOrder]()
        }
        return orders
    }
    
    private func inProgressOrders() -> [JaldiOrder] {
        let order1 = [ "address" : "Paronyan street",
                       "cost" : Float(400),
                       "formattedOrderDate" : "20/05/2017 13:52",
                       "hours" : 4,
                       "id" : 13,
                       "latitude" : 40.17773703872351,
                       "longitude" : 44.50301790316016,
                       "orderDate" : 1495895400000,
                       "paymentType" : "CASH",
                       "status" : "CREATED",
                       "type" : "CLEANER",
                       "workers" : 1,
                       "user" : [
                        "active" : 1,
                        "creationDate" : 1495288330000,
                        "deleted" : 0,
                        "email" : "test@gmail.com",
                        "formattedCreationDate" : "20/05/2017 13:52",
                        "id": 37,
                        "name" : "Test",
                        "password" : "",
                        "phone" : "1111111111",
                        "profileImageId" : "<null>",
                        "role" : "USER",
                        "type" : "CUSTOMER"]
            ] as [String : Any]
        
        let order2 = [ "address" : "Spartak stadium",
                       "cost" : Float(300),
                       "formattedOrderDate" : "20/05/2017 13:52",
                       "hours" : 3,
                       "id" : 23,
                       "latitude" : 40.17064426191766,
                       "longitude" : 44.51086966085126,
                       "orderDate" : 1495895400000,
                       "paymentType" : "CASH",
                       "status" : "CREATED",
                       "type" : "CLEANER",
                       "workers" : 1,
                       "user" : [
                        "active" : 1,
                        "creationDate" : 1495288330000,
                        "deleted" : 0,
                        "email" : "test@gmail.com",
                        "formattedCreationDate" : "20/05/2017 13:52",
                        "id": 37,
                        "name" : "Test",
                        "password" : "",
                        "phone" : "1111111111",
                        "profileImageId" : "<null>",
                        "role" : "USER",
                        "type" : "CUSTOMER"]
            ] as [String : Any]
        let orderlist = [order1,order2]
        guard let orders  = Mapper<JaldiOrder>().mapArray(JSONArray: orderlist) else{
            return [JaldiOrder]()
        }
        return orders
    }
}
