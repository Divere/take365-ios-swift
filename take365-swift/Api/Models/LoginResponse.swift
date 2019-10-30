//
//  LoginResponse.swift
//  take365-swift
//
//  Created by Evgeniy Eliseev on 30.10.2019.
//  Copyright © 2019 Evgeniy Eliseev. All rights reserved.
//

import Foundation

class LoginResponse: Codable {
    var result: Result?
    
    class Result: Codable {
        var id: Int
        var token: String
        var tokenExpires: Int64
        var username: String
    }
}
