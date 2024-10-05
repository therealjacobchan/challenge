//
//  ViewModel.swift
//  challenge
//
//  Created by Jacob Chan on 10/3/24.
//

import Foundation
import UIKit

class ChallengeViewModel: NSObject {
    var onContinuePressed: ((Int) -> Void)?
    let challengeNetworkManager = ChallengeNetworkManager()
    
    var screens: [Screen] = [Screen]()
    
    var totalItems: Int {
        return self.screens.count
    }
    
    func fetchItems(completion: @escaping(Result<(), NetError>) -> Void) {
        challengeNetworkManager.fetchChallenge {[weak self] result in
            if let result = try? result.get() {
                self?.screens = result
                completion(.success(()))
            } else {
                completion(result.map { _ in () })
            }
        }
    }
}

extension ChallengeViewModel: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.screens.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let screen: Screen = self.screens[indexPath.item]
        
        if (screen.questionType == .multipleChoiceModuleScreen) {
            let cell: MultipleChoiceViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setUI(screen: screen) { [weak self] in
                self?.onContinuePressed?(indexPath.row)
            }
            return cell
        }
        let cell: RecapViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setUI(screen: screen) { [weak self] in
            self?.onContinuePressed?(indexPath.row)
        }
        return cell
    }
}
