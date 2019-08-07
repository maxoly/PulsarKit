//
//  KeyboardHandlerPlugin.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 25/08/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import UIKit

open class KeyboardHandlerPlugin: SourcePlugin {
    public var filter: SourcePluginFilter? { return nil }
    public var events: SourcePluginEvents? { return nil }
    public var lifecycle: SourcePluginLifecycle? { return self }
    
    private weak var container: UIScrollView?
    private var keyboardSize: CGSize = .zero
    
    public init() {}
}

extension KeyboardHandlerPlugin: SourcePluginLifecycle {
    public func activate(in container: UIScrollView) {
        self.container = container
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    public func deactivate() {
        NotificationCenter.default.removeObserver(self)
    }
}

extension KeyboardHandlerPlugin {
    @objc
    func keyboardWillShow(_ notification: Foundation.Notification) {
        guard let container = container else { return }
        guard keyboardSize == .zero else { return }
        guard container.window != nil else { return }
        guard let firstResponder = UIView.currentFirstResponder() else { return }
        guard let superview = container.superview else { return }
        guard firstResponder.isDescendant(of: superview) else { return }
        guard let info = notification.userInfo else { return }
        guard let keyboardRectValue = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        guard let animationCurveValue = info[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber else { return }
        guard let animationDurationValue = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        
        let keyboardRect = keyboardRectValue.cgRectValue
        let animationCurve = animationCurveValue.intValue
        let animationDuration = animationDurationValue.doubleValue
        
        guard let animation = UIView.AnimationCurve(rawValue: animationCurve) else { return }
        keyboardSize = keyboardRect.size
        
        if let responder = firstResponder as? UITextField, let view = responder.inputAccessoryView {
            keyboardSize.height += view.frame.height
        }
        
        if let responder = firstResponder as? UITextView, let view = responder.inputAccessoryView {
            keyboardSize.height += view.frame.height
        }
        
        DispatchQueue.main.async {
            var inset = container.contentInset
            inset.bottom += self.keyboardSize.height
            
            let options: UIView.AnimationOptions = [.beginFromCurrentState, animation.toAnimationOptions]
            UIView.animate(withDuration: animationDuration, delay: 0, options: options, animations: {
                container.contentInset = inset
                container.scrollIndicatorInsets = inset
            }, completion: { _ in })
        }
    }
    
    @objc
    func keyboardWillHide(_ notification: Foundation.Notification) {
        guard let container = container else { return }
        guard keyboardSize != .zero else { return }
        guard container.window != nil else { return }
        if container.contentInset.bottom == 0 { return }
        guard let info = notification.userInfo else { return }
        guard let animationCurveValue = info[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber else { return }
        guard let animationDurationValue = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        
        let animationCurve = animationCurveValue.intValue
        let animationDuration = animationDurationValue.doubleValue
        
        guard let animation = UIView.AnimationCurve(rawValue: animationCurve) else { return }
        
        DispatchQueue.main.async {
            var inset = container.contentInset
            inset.bottom -= self.keyboardSize.height
            self.keyboardSize = .zero
            
            let options: UIView.AnimationOptions = [.beginFromCurrentState, animation.toAnimationOptions]
            UIView.animate(withDuration: animationDuration, delay: 0, options: options, animations: {
                container.contentInset = inset
                container.scrollIndicatorInsets = inset
            }, completion: { _ in })
        }
    }
}
