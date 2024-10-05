//
//  UICollectionViewExtensions.swift
//  challenge
//
//  Created by Jacob Chan on 10/3/24.
//

import Foundation
import UIKit

public protocol ReusableView {
    static var defaultReuseIdentifier: String {
        get
    }
}

extension ReusableView where Self: UIView {
    public static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

public protocol NibLoadingView {
    static var nibName: String {
        get
    }
}

extension NibLoadingView where Self: UIView {
    public static var nibName: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    public func registerCell<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }

    public func registerCell<T: UICollectionViewCell>(_: T.Type) where T: ReusableView, T: NibLoadingView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }

    public func register<T: UICollectionReusableView>(_: T.Type, forSupplementaryViewOfKind: String) where T: ReusableView, T: NibLoadingView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forSupplementaryViewOfKind: forSupplementaryViewOfKind, withReuseIdentifier: T.defaultReuseIdentifier)
    }

    public func register<T: UICollectionReusableView>(_: T.Type, forSupplementaryViewOfKind: String) where T: ReusableView {
        register(T.self, forSupplementaryViewOfKind: forSupplementaryViewOfKind, withReuseIdentifier: T.defaultReuseIdentifier)
    }

    public func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }

    public func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind: String, for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableSupplementaryView(ofKind: ofKind, withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue reusable supplementary view with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
    
    var visibleCurrentCellIndexPath: IndexPath? {
        for cell in self.visibleCells {
          let indexPath = self.indexPath(for: cell)
          return indexPath
        }
        
        return nil
      }
}
