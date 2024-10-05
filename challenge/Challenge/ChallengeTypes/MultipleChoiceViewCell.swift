//
//  ExamItemCollectionView.swift
//  challenge
//
//  Created by Jacob Chan on 10/3/24.
//

import Foundation
import UIKit

class MultipleChoiceViewCell: UICollectionViewCell, ReusableView, NibLoadingView {
    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private weak var pleaseSelectLabel: UILabel!
    @IBOutlet private weak var choicesStackView: UIStackView!
    @IBOutlet private weak var continueButton: UIButton! {
        didSet {
            continueButton.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                    var outgoing = incoming
                outgoing.foregroundColor = UIColor.white
                    return outgoing
                }
        }
    }
    
    private var choicesSelected: [String] = [String]()
    private var onContinuePressed: (() -> Void)? = nil
    
    func setUI(screen: Screen, onContinuePressed: (() -> Void)?) {
        self.onContinuePressed = onContinuePressed
        choicesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        questionLabel.lineBreakMode = .byWordWrapping
        questionLabel.text = screen.question
        pleaseSelectLabel.isHidden = screen.multipleChoicesAllowed == false
        
        continueButton.isHidden = screen.multipleChoicesAllowed == false
        enableButton(isEnabled: false)
        
        for choice in screen.choices ?? [] {
            let button: ChoiceButton = ChoiceButton(id: choice.id ?? "", image: self.imageWith(name: choice.emoji), title: "\(choice.text ?? "")")
            choicesStackView.addArrangedSubview(button)
            if screen.multipleChoicesAllowed == false {
                button.addTarget(self, action: #selector(self.onContinueButton), for: .touchUpInside)
            } else {
                button.addTarget(self, action: #selector(onChoiceSelected), for: .touchUpInside)
            }
        }
    }
    
    func enableButton(isEnabled: Bool) {
        continueButton.isEnabled = isEnabled
        continueButton.backgroundColor = UIColor(hex: isEnabled ? "#FF6442EF" : "#FFDDD5FB")
    }
    
    @objc func onChoiceSelected(_ sender: ChoiceButton) {
        sender.setSelected()
        if (sender.isChoiceSelected) {
            choicesSelected.append(sender.id ?? "")
        } else {
            choicesSelected.removeAll { $0 == sender.id ?? ""}
        }
        
        enableButton(isEnabled: !choicesSelected.isEmpty)
    }
    
    @IBAction func onContinueButton(_ button: UIButton) {
        self.onContinuePressed?()
    }
}

extension MultipleChoiceViewCell {
    private func imageWith(name: String?) -> UIImage? {
         let frame = CGRect(x: 0, y: 0, width: 24, height: 24)
         let nameLabel = UILabel(frame: frame)
         nameLabel.textAlignment = .center
         nameLabel.textColor = .white
         nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
         nameLabel.text = name
         UIGraphicsBeginImageContext(frame.size)
          if let currentContext = UIGraphicsGetCurrentContext() {
             nameLabel.layer.render(in: currentContext)
             let nameImage = UIGraphicsGetImageFromCurrentImageContext()
             return nameImage
          }
          return nil
    }
}
