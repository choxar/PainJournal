//
//  UINavigationController.swift
//  PainJournal
//
//  Created by elina.zambere on 21/04/2021.
//

import UIKit

extension UINavigationController {
    
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
}
