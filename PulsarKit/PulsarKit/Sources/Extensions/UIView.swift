//
//  UIView.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 25/08/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

public extension UIView {
    private static weak var _currentFirstResponder: UIView?
    
    public class func currentFirstResponder() -> UIView? {
        UIView._currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(findFirstResponder), to: nil, from: nil, for: nil)
        return UIView._currentFirstResponder
    }
    
    @objc
    internal func findFirstResponder(sender: AnyObject) {
        UIView._currentFirstResponder = self
    }
}
