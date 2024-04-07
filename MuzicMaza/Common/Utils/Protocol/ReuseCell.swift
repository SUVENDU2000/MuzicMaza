//
//  ReuseCell.swift
//  MuzicMaza
//
//  Created by Suvendu Kumar on 04/04/24.
//

import UIKit

protocol ReusableCell {
    static var nib: UINib { get }
    static var reuseIdentifier: String { get }
}

extension ReusableCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
}


extension UITableView {
    func registerCell<T: UITableViewCell>(_: T.Type) where T: ReusableCell {
        register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(ofType cellType: T.Type, for indexPath: IndexPath) -> T {
        let identifier = String(describing: cellType)
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue cell with identifier: \(identifier)")
        }
        return cell
    }
}

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(_: T.Type) where T: ReusableCell {
        register(T.nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(ofType cellType: T.Type, for indexPath: IndexPath) -> T {
        let identifier = String(describing: cellType)
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue cell with identifier: \(identifier)")
        }
        return cell
    }
    
    func registerSupplementaryView<T: UICollectionReusableView>(_: T.Type, ofKind kind: String) where T: ReusableCell {
        register(T.nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofType viewType: T.Type, ofKind kind: String, for indexPath: IndexPath) -> T {
        let identifier = String(describing: viewType)
        guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue supplementary view with identifier: \(identifier)")
        }
        return view
    }
}
