//
//  AppError.swift
//  BaseRxswift_MVVM
//
//  Created by Khanh Vu on 27/09/2023.
//

import Foundation

enum NetworkErrorType: Int, Error {
    case UNAUTHORIZED = 401
    case INVALID_TOKEN = 403
}

//enum ErrorType: Int {
//    case network = 1
//    case firebase = 2
//    case app = 3
//}

struct AppError: Error {
    let code: Int
    let message: String
}
