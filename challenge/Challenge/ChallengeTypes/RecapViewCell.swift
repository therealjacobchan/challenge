//
//  RecapViewCell.swift
//  challenge
//
//  Created by Jacob Chan on 10/4/24.
//

import Foundation
import UIKit
import TagListView

// TODO: Implement drag and drop feature and animation while loading

class RecapViewCell: UICollectionViewCell, NibLoadingView, ReusableView, TagListViewDelegate {
    @IBOutlet private weak var questionTagListView: TagListView!
    @IBOutlet private weak var tagListView: TagListView!
    @IBOutlet private weak var feedbackContainer: UIStackView!
    @IBOutlet private weak var feedbackView: UIView!
    @IBOutlet private weak var feedbackLabel: UILabel!
    @IBOutlet private weak var checkButton: UIButton! {
        didSet {
            checkButton.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                    var outgoing = incoming
                outgoing.foregroundColor = UIColor.white
                    return outgoing
                }
        }
    }
    
    private lazy var answers: [Choice] = {
        return self.screen?.answers ?? []
    }()
    private lazy var correctAnswer: String = {
        return screen?.correctAnswer ?? ""
    }()
    
    private var onContinuePressed: (() -> Void)? = nil
    private var screen: Screen?

    func setUI(screen: Screen, onContinuePressed: (() -> Void)?) {
        self.onContinuePressed = onContinuePressed
        self.answers = screen.answers ?? []
        self.correctAnswer = screen.correctAnswer ?? ""
        self.screen = screen
        
        self.resetScreen()
    }
    
    func enableButton(isEnabled: Bool) {
        checkButton.isEnabled = isEnabled
        checkButton.backgroundColor = UIColor(hex: isEnabled ? "#FF6442EF" : "#FFDDD5FB")
    }
    
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        let textList = questionTagListView.tagViews.map { $0.currentTitle?.trimmingCharacters(in: .whitespacesAndNewlines) }
        questionTagListView.removeAllTags()
        
        let choices = tagListView.tagViews.map { $0.currentTitle }
        tagListView.tagViews.forEach { tag in
            tag.isSelected = false
        }
        for text in textList {
            if (text == "________" ||
                choices.contains(text)) {
                let questionTagView = questionTagListView.addTag(title)
                questionTagView.paddingX = 8
                questionTagView.paddingY = 8
                questionTagView.cornerRadius = 8
                questionTagView.borderWidth = 1
                questionTagView.tagBackgroundColor = .white
                
                if let color = UIColor(hex: "#212121") {
                    questionTagView.textColor = color
                }
                
                questionTagView.borderColor = .black.withAlphaComponent(0.06)
                
                questionTagView.backgroundColor = .white
                questionTagView.contentVerticalAlignment = .center
                questionTagView.textFont = .systemFont(ofSize: 16, weight: .medium)
                
                questionTagView.layer.shadowColor = UIColor.black.withAlphaComponent(0.8).cgColor
                questionTagView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                questionTagView.layer.shadowOpacity = 0.32
                questionTagView.layer.shadowRadius = 6
                
                tagView.isSelected = true
            } else {
                questionTagListView.addTag((text ?? "") + " ")
            }
        }
        
        enableButton(isEnabled: true)
    }
    
    @IBAction func onCheckClicked(_ sender: UIButton) {
        self.feedbackContainer.show(animate: true)
        self.checkButton.isHidden = true
        
        self.feedbackLabel.text = isCorrectAnswer() ? "You're correct!" : "Try again"
        
        self.feedbackView.backgroundColor = UIColor(hex: isCorrectAnswer() ? "#FF3AB27D" : "#FFFC3021" )
        
        self.tagListView.tagViews.forEach { $0.isEnabled = false }
    }
    
    @IBAction func onContinueClicked(_ sender: UIButton) {
        if isCorrectAnswer() {
            self.onContinuePressed?()
        } else {
            resetScreen()
        }
    }
    
    private func resetScreen() {
        tagListView.removeAllTags()
        questionTagListView.removeAllTags()
        
        self.feedbackContainer.hide(animate: false)
        self.checkButton.isHidden = false
        
        tagListView.textFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        tagListView.alignment = .left
        let answers = self.answers.map { $0.text ?? "" }
        
        tagListView.addTags(answers)
        tagListView.delegate = self

        questionTagListView.textFont = .systemFont(ofSize: 20, weight: .regular)
        
        let text = (self.screen?.body ?? "")
            .replacingOccurrences(of: "%  RECAP  %", with: "________")
            .split(separator: " ")
        
        for item in text {
            questionTagListView.addTag(String(item).trimmingCharacters(in: .whitespacesAndNewlines) + " ")
        }
        
        enableButton(isEnabled: false)
    }
    
    private func isCorrectAnswer() -> Bool {
        if let selectedTag = tagListView.selectedTags().first {
            let index = tagListView.tagViews.firstIndex(of: selectedTag) ?? 0
            return self.answers[index].id == self.correctAnswer
        }
        return false
    }
}
