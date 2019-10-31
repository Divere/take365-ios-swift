//
//  FeedItem.swift
//  take365-swift
//
//  Created by Evgeniy Eliseev on 30.10.2019.
//  Copyright © 2019 Evgeniy Eliseev. All rights reserved.
//

import Foundation

class FeedItem: Codable {
    var id: Int
    var title: String?
    var description: String?
    var thumb: StoryImageThumbModel
    var thumbLarge: StoryImageThumbModel
    var story: StoryModel
    var date: String
    var timestamp: Int64
    var likesCount: Int64
    var isLiked: Bool
}
