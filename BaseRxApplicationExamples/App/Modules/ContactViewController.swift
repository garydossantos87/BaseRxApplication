//
//  ContactViewController.swift
//  Seat
//
//  Created by Gary Dos Santos on 02/10/2017.
//  Copyright © 2017. All rights reserved.
//

import UIKit
import BaseRxApplication

final class ContactViewController: BaseViewController<ContactViewModel>, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let clusterListFlowLayout = CenterCellCollectionViewFlowLayout()
    
    //MARK: lifecycle
    override func createViewModel() -> ContactViewModel {
        return ContactViewModel()
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        setupTableView()
        setupFlowLayout()
        setupCollectionView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        HeaderCell.register(tableView: tableView, cellClass: HeaderCell.self)
    }
    
    private func setupFlowLayout() {
        clusterListFlowLayout.sectionInset = UIEdgeInsets.zero
        clusterListFlowLayout.minimumLineSpacing = 0.0
        clusterListFlowLayout.minimumInteritemSpacing = 0.0
        clusterListFlowLayout.headerReferenceSize = CGSize.zero
        clusterListFlowLayout.footerReferenceSize = CGSize.zero
        clusterListFlowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width * 1.0).rounded(), height: 48.0)
        clusterListFlowLayout.scrollDirection = .horizontal
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.setCollectionViewLayout(clusterListFlowLayout, animated: true)
        
        ClusterMapDetailCell.register(collectionView: collectionView, cellClass: ClusterMapDetailCell.self)
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BaseCollectionCellView<ClusterMapDetailCellViewModel> = collectionView.dequeueReusableBaseCell(withReuseIdentifier: viewModel.collectionCellIdentifier(indexPath: indexPath), for: indexPath, viewModel: viewModel.collectionCellViewModel(forIndexPath: indexPath))
        return cell
    }
    
    //MARK: UITableViewDelegate methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(atIndexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.height(forIndexPath: indexPath)
    }
    
    //MARK: UITableViewDataSource methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: BaseCellView<HeaderCellModel> = tableView.dequeueReusableBaseCell(withIdentifier: viewModel.cellIdentifier(forIndexPath: indexPath), for: indexPath, viewModel: viewModel.cellViewModel(forIndexPath: indexPath))
//        return cell
//
//
//
//        let cell = tableView.dequeueReusableBaseCell(withIdentifier: viewModel.cellIdentifier(forIndexPath: indexPath), for: indexPath)
//        cell.set(viewModel: viewModel.cellViewModel(forIndexPath: indexPath))
//        return cell
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
}
