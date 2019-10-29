//
//  Response.swift
//  take365-swift
//
//  Created by Evgeniy Eliseev on 30.10.2019.
//  Copyright © 2019 Evgeniy Eliseev. All rights reserved.
//

import Foundation

class BaseResponse: Decodable {
    
    var errors: [Error]?
    
    class Error: Decodable {
        var value: String
        var field: String
    }
}
