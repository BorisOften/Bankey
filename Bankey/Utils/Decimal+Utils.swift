//
//  Decimal+Utils.swift
//  Bankey
//
//  Created by Boris Ofon on 11/13/22.
//

import Foundation


extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}
