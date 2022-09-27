//
//  LoggedCollectionViewDataSource.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 27/09/22.
//

import UIKit

protocol LoggedCollectionViewDataSourceProtocol: AnyObject {
}

final class LoggedCollectionViewDataSource: NSObject {
    private var collectionView: UICollectionView
    private let delegate: LoggedCollectionViewDataSourceProtocol

    init(collectionView: UICollectionView, delegate: LoggedCollectionViewDataSourceProtocol) {
        self.collectionView = collectionView
        self.delegate = delegate
        super.init()
        setupDelegate()
        registerTableView()
    }

    private func setupDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func registerTableView() {
        collectionView.register(LoggedCell.self, forCellWithReuseIdentifier: LoggedCell.description())
    }

    func setup() {
        collectionView.reloadData()
    }

}

extension LoggedCollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoggedCell.description(),
                                                            for: indexPath) as? LoggedCell
        else { return UICollectionViewCell() }
        cell.setupCell()
        return cell
    }
}

extension LoggedCollectionViewDataSource: UICollectionViewDelegate {

}
