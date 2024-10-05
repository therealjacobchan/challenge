//
//  ChoiceButton.swift
//  challenge
//
//  Created by Jacob Chan on 10/3/24.
//

import UIKit

class ChoiceButton: UIButton {
    var isChoiceSelected = false
    
    var id: String?
    
    init(id: String, image: UIImage?, title: String) {
        super.init(frame: .zero)
        self.id = id
        self.setChoice(image: image, title: title)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setSelected() {
        self.isHighlighted = true
        isChoiceSelected = !isChoiceSelected
        self.layer.borderWidth = isChoiceSelected ? 2 : 1
        self.layer.borderColor = isChoiceSelected ?
                                    UIColor(hex: "#FF6442EF")?.cgColor :
                                    UIColor.black.withAlphaComponent(0.12).cgColor
    }

    private func setChoice(image: UIImage?, title: String) {
        self.configuration = .plain()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 55).isActive = true
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.12).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
        self.setImage(image, for: .normal)
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        self.contentHorizontalAlignment = .left
        self.configuration?.imagePadding = 5
        self.setTitleColor(UIColor(hex: "#212121"), for: .normal)
        self.setTitleColor(UIColor(hex: "#212121"), for: .highlighted)
    }
}
