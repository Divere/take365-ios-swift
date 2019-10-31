//
//  GetFeedResponse.swift
//  take365-swift
//
//  Created by Evgeniy Eliseev on 30.10.2019.
//  Copyright © 2019 Evgeniy Eliseev. All rights reserved.
//

import Foundation

class GetFeedResponse: Codable {
    
    var result: FeedResult
    
    class FeedResult: Codable {
        var list: [FeedItem]
        var isEmpty: Bool
    }
}
