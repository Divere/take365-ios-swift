//
//  LoginResponse.swift
//  take365-swift
//
//  Created by Evgeniy Eliseev on 30.10.2019.
//  Copyright © 2019 Evgeniy Eliseev. All rights reserved.
//

import Foundation

class LoginResponse: BaseResponse {
    var result: Result?
    
    class Result: Decodable {
        var id: Int
        var token: String
        var tokenExpires: Int64
        var username: String
    }
}
