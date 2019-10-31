//
//  StoryModel.swift
//  take365-swift
//
//  Created by Evgeniy Eliseev on 30.10.2019.
//  Copyright © 2019 Evgeniy Eliseev. All rights reserved.
//

import Foundation

class StoryModel: Codable {
    var authors: [AuthorModel]
    var id: Int
    var progress: StoryProgressModel
    var status: Int
    var title: String?
    var url: String
    
    class AuthorModel: Codable {
        var id: Int
        var url: String
        var username: String
        var userpic: StoryImageThumbModel?
        var userpicLarge: StoryImageThumbModel?
    }
    
    class StoryProgressModel: Codable {
        var delayDays: Int
        var passedDays: Int
        var percentsComplete: String
        var totalImages: Int
        var totalDays: Int
        var totalImagesTitle: String
        var isOutdated: Bool
        var dateStart: String
        var dateEnd: String
    }
}
