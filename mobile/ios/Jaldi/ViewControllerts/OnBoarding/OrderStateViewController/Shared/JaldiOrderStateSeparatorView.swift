//
//  JaldiOrderStateSeparatorView.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/25/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiOrderStateSeparatorView: UIView {
    enum DotView: Int {
        // handyMan
        case dot1
        case dot2
        case dot3
        case dot4
      static let allStates = [DotView.dot1,
                              DotView.dot2,
                              DotView.dot3,
                              DotView.dot4,
                              ]
    }
    @IBOutlet weak var dotView1: UIView!
    @IBOutlet weak var dotView2: UIView!
    @IBOutlet weak var dotView3: UIView!
    @IBOutlet weak var dotView4: UIView!
    override func awakeFromNib() {
        for state in DotView.allStates {
          let view = dotViewFor(dotView: state)
          self.setBorderTo(dotView: view)
        }
    }
    func configureState(selected:Bool) {
        for state in DotView.allStates {
            let view = dotViewFor(dotView: state)
            view.backgroundColor =  selected ? AppColors.GreenColor : AppColors.GrayColor
//            self.setBorderTo(dotView: view)
        }
    }
    private func dotViewFor(dotView:DotView ) -> UIView {
        switch dotView {
        case .dot1:
            return dotView1
        case .dot2:
            return dotView2
        case .dot3:
            return dotView3
        case .dot4:
            return dotView4
        }
    }
    
    private func setBorderTo(dotView:UIView) {
        dotView.layer.borderWidth = 1
        dotView.layer.cornerRadius = dotView.frame.size.height/2
        dotView.layer.borderColor = UIColor.clear.cgColor
    }
    
    
}
