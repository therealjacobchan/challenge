//
//  ChallengeNetworkManager.swift
//  challenge
//
//  Created by Jacob Chan on 10/5/24.
//

import Foundation

class ChallengeNetworkManager: BaseNetworkManager {
    public func fetchChallenge(completion: @escaping(Swift.Result<[Screen], NetError>) -> Void) {
        let url = "\(apiBaseUrl)f/f/e430ac3e-ca7a-48f9-804c-8fe9f7d4a267/174c6c45-c116-4762-8550-607cddb04270/activity-response-ios.json?table=block&id=111284a8-e7d3-80ea-a701-fad40b7b30ca&spaceId=e430ac3e-ca7a-48f9-804c-8fe9f7d4a267&expirationTimestamp=1728115200000&signature=YzcCzOBuLrg9lcwYgrUNIRZR9QioybdCizettc-IgHk&downloadName=activity-response-ios.json"
        
        self.sendRequest(for: Challenge.self, url: url, method: .get) { result in
            DispatchQueue.main.async {
                do {
                    let challenge = try result.get()
                    completion(.success(challenge.activity?.screens ?? []))
                } catch {
                    completion(.failure(.ioError("Cannot parse data")))
                }
            }
            
        }
    }
}
