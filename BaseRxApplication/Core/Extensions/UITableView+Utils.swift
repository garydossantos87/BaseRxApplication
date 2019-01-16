//
//  UITableViewController.swift
//  BaseRxApplication
//
//  Created by Gary  Dos Santos on 08/03/2018.
//  Copyright © 2018. All rights reserved.
//

import UIKit

extension UITableView {

    public func dequeueReusableBaseCell(withIdentifier identifier: String, for indexPath: IndexPath, viewModel: BaseCellViewModel) -> UITableViewCell {
        if let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? BaseCellView {
            cell.set(viewModel: viewModel)
            return cell
        }
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }

}
