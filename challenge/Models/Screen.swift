//
//  Screen.swift
//  challenge
//
//  Created by Jacob Chan on 10/5/24.
//

import Foundation

struct Activity: Codable {
    var screens: [Screen]?
    
    private enum CodingKeys: String, CodingKey {
        case screens
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.screens = try container.decodeIfPresent([Screen].self, forKey: .screens)
    }
}

struct Screen: Codable {
    var id: String?
    var questionType: ScreenType?
    var question: String?
    var multipleChoicesAllowed: Bool?
    var choices: [Choice]?
    var eyebrow: String?
    var body: String?
    var answers: [Choice]?
    var correctAnswer: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case questionType = "type"
        case question
        case multipleChoicesAllowed
        case choices
        case eyebrow
        case body
        case answers
        case correctAnswer
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.questionType = try container.decodeIfPresent(ScreenType.self, forKey: .questionType)
        self.question = try container.decodeIfPresent(String.self, forKey: .question)
        self.multipleChoicesAllowed = try container.decodeIfPresent(Bool.self, forKey: .multipleChoicesAllowed)
        self.choices = try container.decodeIfPresent([Choice].self, forKey: .choices)
        self.eyebrow = try container.decodeIfPresent(String.self, forKey: .eyebrow)
        self.body = try container.decodeIfPresent(String.self, forKey: .body)
        self.answers = try container.decodeIfPresent([Choice].self, forKey: .answers)
        self.correctAnswer = try container.decodeIfPresent(String.self, forKey: .correctAnswer)
    }
}

enum ScreenType: String, Codable {
    case multipleChoiceModuleScreen
    case recapModuleScreen
}
