//
//  Choice.swift
//  challenge
//
//  Created by Jacob Chan on 10/5/24.
//

import Foundation

struct Choice: Codable {
    var id: String?
    var text: String?
    var emoji: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case text
        case emoji
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.text = try container.decodeIfPresent(String.self, forKey: .text)
        self.emoji = try container.decodeIfPresent(String.self, forKey: .emoji)
    }
}
