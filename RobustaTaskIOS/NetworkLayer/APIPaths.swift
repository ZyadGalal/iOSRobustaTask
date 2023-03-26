//
//  APIPaths.swift
//  RobustaTaskIOS
//
//  Created by Zyad Galal on 26/03/2023.
//

import Foundation

enum APIPaths: String {
    case repositoryList
    
    var path: String {
        switch self {
        case .repositoryList:
            return "repositories"
        }
    }
}
