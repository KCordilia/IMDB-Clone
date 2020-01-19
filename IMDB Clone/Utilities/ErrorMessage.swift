//
//  ErrorMessage.swift
//  IMDB Clone
//
//  Created by Karim Cordilia on 19/01/2020.
//  Copyright © 2020 Karim Cordilia. All rights reserved.
//

import Foundation

enum ErrorMessage: String, Error {
    case invalidRequest = "The request made is invalid. Please try again."
    case unableToComplete = "Unable to complete your reqeust, Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case inavlidData = "The data received from the server was invalid, Please try again."
}

