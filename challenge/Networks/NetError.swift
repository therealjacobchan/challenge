//
//  NetError.swift
//  challenge
//
//  Created by Jacob Chan on 10/5/24.
//

import Foundation

enum NetError: Error, Equatable {
    case apiError(String)
    case forceUpgrade(String, URL?)
    case ioError(String)
    case validationError(String)
    case refreshTokenExpired(String)
    case serverError(String) // Handling Error 500
}
