//
//  viewControllerExtensions.swift
//  BostaTask
//
//  Created by Tawfik Sweedy✌️ on 4/20/22.
//

import Foundation
import UIKit

extension UITableView {
    func RegisterNib<cell : UITableViewCell>(cell : cell.Type){
        let nibName = String(describing : cell.self)
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
    func dequeue<cell : UITableViewCell>() -> cell{
        let identifier = String(describing: cell.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier) as? cell else {
            fatalError("error in cell")
        }
        return cell
    }
}
extension UITableView {
    func setEmptyMessage(bigTitle : String , smallTitle : String) {
        let viewfromXib = NoDataView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        viewfromXib.bigTitle = bigTitle
        viewfromXib.smallTitle = smallTitle
        self.backgroundView = viewfromXib;
        self.separatorStyle = .none;
    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .none
    }
    func restoreWithSeparator() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
    func animateTable(tableView: UITableView) {
        tableView.reloadData()
        let cells = tableView.visibleCells
        
        let tableViewHeight = tableView.bounds.size.height
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 1.75,
                           delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
}
extension UICollectionView {
    func setEmptyMessage(bigTitle : String , smallTitle : String) {
        let viewfromXib = NoDataView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        viewfromXib.bigTitle = bigTitle
        viewfromXib.smallTitle = smallTitle
        self.backgroundView = viewfromXib;
    }
    func restore() {
        self.backgroundView = nil
    }
    func restoreWithSeparator() {
        self.backgroundView = nil
    }
}
extension UICollectionView {
    func RegisterNib<cell : UICollectionViewCell>(cell : cell.Type){
        let nibName = String(describing : cell.self)
        self.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }
}
