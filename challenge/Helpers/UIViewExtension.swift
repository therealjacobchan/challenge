//
//  UIViewExtension.swift
//  challenge
//
//  Created by Jacob Chan on 10/5/24.
//

import Foundation
import UIKit

extension UIView{
    func show(animate: Bool){
        UIView.animate(withDuration: animate ? 0.5 : 0, delay: 0, options: [.curveEaseIn],
                       animations: {
                        self.center.y -= self.bounds.height
                        self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    
    func hide(animate: Bool){
        UIView.animate(withDuration: animate ? 1 : 0, delay: 0, options: [.curveLinear],
                       animations: {
                        self.center.y += self.bounds.height
                        self.layoutIfNeeded()

        }, completion: {(_ completed: Bool) -> Void in
            self.isHidden = true
        })
    }
}
