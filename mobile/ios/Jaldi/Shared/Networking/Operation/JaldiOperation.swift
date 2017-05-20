//
//  JaldiOperation.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/19/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
protocol JaldiOperation {
    associatedtype Output
    
    /// Request to execute
    var request: JaldiRequest { get }
    
    
    /// Execute request in passed dispatcher
    ///
    /// - Parameter dispatcher: dispatcher
    /// - Returns: a promise
    func execute(in dispatcher: Dispatcher, taskCompletion: ((_ result:Output?)->Void)!,completionError: ((_ error:Error?, _ statusCode:Int?)->Void)!)
    
}
