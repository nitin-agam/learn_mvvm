//
//  Toaster.swift
//  HotCoffee
//
//  Created by Nitin A on 23/01/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import UIKit

let kSharedAppDelegate = UIApplication.shared.delegate as! AppDelegate
let kScreenWidth       = UIScreen.main.bounds.size.width

class CommonUtils {
    
    static func textRect(width: CGFloat, font: UIFont, text: String) -> CGRect {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        return text.boundingRect(with: constraintRect,
                                 options: .usesLineFragmentOrigin,
                                 attributes: [.font: font],
                                 context: nil)
    }
}

class Toaster {
    
    static let shared: Toaster = {
        return Toaster()
    }()
    
    var backView: UIView = {
        let backView = UIView(frame: .zero)
        backView.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        backView.layer.cornerRadius = 5
        backView.layer.shadowColor = UIColor.gray.cgColor
        backView.layer.shadowOffset = CGSize(width: 4, height: 3)
        backView.layer.shadowOpacity = 0.1
        return backView
    }()
    
    var messageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
    }()
    
    var swipeGesture: UISwipeGestureRecognizer?
    
    func showToast(message: String, font: UIFont? = UIFont.systemFont(ofSize: 17)) {
        
        let width: CGFloat = kScreenWidth - 2 * 10
        
        var height = CommonUtils.textRect(width: width - 15, font: font!, text: message).height
        if height < 30 { height = 35 }
        backView.frame = CGRect(x: 10.0, y: -height, width: width, height: height + 16)
        backView.alpha = 1
        kSharedAppDelegate.window!.addSubview(backView)
        
        self.messageLabel.frame = CGRect(x: 10.0, y: 8.0, width: width - 15, height: height)
        self.messageLabel.text = message
        self.messageLabel.font = font
        backView.addSubview(self.messageLabel)
        
        var basketTopFrame: CGRect = backView.frame
        basketTopFrame.origin.y = 40
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.1,
                       options: .curveEaseOut,
                       animations: { () -> Void in
                        self.backView.frame = basketTopFrame
        }, completion: {
            (value: Bool) in
            self.removeToast(delay: 2.0)
        })
    }
    
    func removeToast(delay: CGFloat = 0.0) {
        UIView.animate(withDuration: 1.0,
                       delay: TimeInterval(delay),
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.1,
                       options: .curveEaseIn,
                       animations: { () -> Void in
                        self.backView.alpha = 0
        }, completion: {
            (value: Bool) in
            self.backView.removeFromSuperview()
        })
    }
}

