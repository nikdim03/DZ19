//
//  ViewController.swift
//  DZ19
//
//  Created by Dmitriy on 11/16/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let adapter = CatAdapter()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CatsApp"
        let flowLayout = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        flowLayout.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(flowLayout)
        NSLayoutConstraint.activate([
            flowLayout.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            flowLayout.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            flowLayout.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            flowLayout.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
        self.collectionView = flowLayout
        adapter.setup(for: collectionView)
        collectionView.reloadData()
    }
}

