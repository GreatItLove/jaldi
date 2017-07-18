//
//  JaldiPointAnnotation.swift
//  Jaldi
//
//  Created by Sedrak Dalaloyan on 6/6/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
import MapKit

class JaldiPointAnnotation: MKPointAnnotation
{
    var type : String = "image"
    var url : String?
    var image : UIImage?
}
