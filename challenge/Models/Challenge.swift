//
//  Challenge.swift
//  challenge
//
//  Created by Jacob Chan on 10/5/24.
//

import Foundation

struct Challenge: Codable {
    var id: String?
    var state: String? // TODO: Update to enum once other states are available
    var stateChangedAt: String?
    var title: String?
    var description: String?
    var duration: String?
    var activity: Activity?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case state
        case stateChangedAt
        case title
        case description
        case duration
        case activity
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.state = try container.decodeIfPresent(String.self, forKey: .state)
        self.stateChangedAt = try container.decodeIfPresent(String.self, forKey: .stateChangedAt)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.duration = try container.decodeIfPresent(String.self, forKey: .duration)
        self.activity = try container.decodeIfPresent(Activity.self, forKey: .activity)
    }
}
