//
//  ViewController.swift
//  challenge
//
//  Created by Jacob Chan on 10/3/24.
//

import UIKit

class ChallengeViewController: UIViewController {
    @IBOutlet private weak var examItems: UICollectionView! {
        didSet {
            examItems.isPagingEnabled = true
            examItems.delegate = self.viewModel
            examItems.dataSource = self.viewModel
            examItems.registerCell(MultipleChoiceViewCell.self)
            examItems.registerCell(RecapViewCell.self)
            examItems.isScrollEnabled = false
        }
    }
    @IBOutlet private weak var progressView: UIProgressView!
    @IBOutlet private weak var loaderView: UIView!
    
    private lazy var totalItems: Int = {
        return self.examItems.numberOfItems(inSection: 0)
    }()
    
    private let viewModel: ChallengeViewModel = ChallengeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionViewLayout()
        
        self.viewModel.fetchItems { [weak self] _ in
            self?.loaderView.isHidden = true
            self?.examItems.reloadData()
            
            self?.progressView.setProgress(1.0 / Float(self?.viewModel.totalItems ?? 1), animated: true)
        }
        
        self.viewModel.onContinuePressed = { [weak self] index in
            guard let totalItems = self?.viewModel.totalItems,
                    index < totalItems - 1 else {
                return
            }
            self?.examItems.scrollToItem(at: IndexPath(item: index + 1, section: 0), at: .centeredHorizontally, animated: true)
            
            let percent = Float(index + 2) / Float(totalItems)
            self?.progressView.setProgress(percent, animated: true)
        }
        
    }
    
    private func setupCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.itemSize = CGSize(width: view.bounds.width, height: view.frame.height)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        examItems.setCollectionViewLayout(layout, animated: true)
    }
    
    @IBAction func didPressBack() {
        guard let currentIndexPath = self.examItems.visibleCurrentCellIndexPath?.item, currentIndexPath > 0 else {
            return
        }
        self.examItems.scrollToItem(at: IndexPath(item: currentIndexPath - 1, section: 0), at: .centeredHorizontally, animated: true)
        
        let percent = Float(currentIndexPath - 1 + 1) / Float(self.totalItems) // Add a +1 because the counting is based on the number of items the user understands it
        self.progressView.setProgress(percent, animated: true)
    }
    
    @IBAction func didPressClose() {
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if let layout = examItems.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemWidth = view.bounds.width
            let itemHeight = examItems.bounds.height
            layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
            layout.invalidateLayout()
        }
    }
}

