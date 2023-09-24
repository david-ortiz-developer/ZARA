//
//  CommonExtensions.swift
//  ZARAfit
//
//  Created by Davit on 24/09/23.
//

import Foundation
extension BinaryFloatingPoint {
    var radians : Self {
        return self * .pi / 180
    }
}
