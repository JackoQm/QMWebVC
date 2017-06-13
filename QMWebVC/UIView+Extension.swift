//
//  UIView+Extension.swift
//  红满堂
//
//  Created by Jacko Qm on 23/02/2017.
//  Copyright © 2017 欧阳铨. All rights reserved.
//

import UIKit

extension UIView
{
    var frameHeight: CGFloat {
        get {
            return self.frame.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
    
    var frameWidth: CGFloat {
        get {
            return self.frame.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
    
    var frameX: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }
    
    var frameY: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }
    
    var boundsHeight: CGFloat {
        get {
            return self.bounds.height
        }
        set {
            self.bounds.size.height = newValue
        }
    }
    
    var boundsWidth: CGFloat {
        get {
            return self.bounds.width
        }
        set {
            self.bounds.size.width = newValue
        }
    }
    
    var boundsX: CGFloat {
        get {
            return self.bounds.origin.x
        }
        set {
            self.bounds.origin.x = newValue
        }
    }
    
    var boundsY: CGFloat {
        get {
            return self.bounds.origin.y
        }
        set {
            self.bounds.origin.y = newValue
        }
    }
}
