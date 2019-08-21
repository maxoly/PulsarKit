//
//  UIView.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 25/08/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

internal extension UIView {
    private static weak var _currentFirstResponder: UIView?
    
    var firstResponder: UIView? {
        guard !isFirstResponder else { return self }
        
        for subview in subviews {
            if let firstResponder = subview.firstResponder {
                return firstResponder
            }
        }
        
        return nil
    }
    
    class func currentFirstResponder() -> UIView? {
        UIView._currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(findFirstResponder), to: nil, from: nil, for: nil)
        return UIView._currentFirstResponder
    }
    
    @objc
    func findFirstResponder(sender: AnyObject) {
        UIView._currentFirstResponder = self
    }
}

internal extension UIView.AnimationCurve {
    var toAnimationOptions: UIView.AnimationOptions {
        switch self {
        case .easeIn:
            return .curveEaseIn
        case .easeInOut:
            return .curveEaseInOut
        case .easeOut:
            return .curveEaseOut
        case .linear:
            return .curveLinear
        @unknown default:
            return .curveLinear
        }
    }
}
