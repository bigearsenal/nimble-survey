//
//  NSPredicate+Extensions.swift
//  nimble
//
//  Created by Chung Tran on 10/24/20.
//

import Foundation

extension NSPredicate {
    static var email: NSPredicate {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format:"SELF MATCHES %@", regex)
    }
}
