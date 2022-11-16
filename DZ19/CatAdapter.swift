//
//  CatAdapter.swift
//  DZ19
//
//  Created by Dmitriy on 11/16/22.
//

import UIKit

protocol CatAdapterProtocol {
    func setup(for collection: UICollectionView)
}

class CatAdapter: NSObject, CatAdapterProtocol {
    var cats = [Cat]()
    func setup(for collection: UICollectionView) {
        initCats()
        collection.register(for: CatCell.self)
        collection.dataSource = self
        collection.delegate = self
        
        collection.dragInteractionEnabled = true
        collection.reorderingCadence = .fast
        collection.dropDelegate = self
        collection.dragDelegate = self
    }
    
    func initCats() {
        cats.append(Cat(name: "Beluga", imageName: "beluga"))
        cats.append(Cat(name: "Crier", imageName: "crier"))
        cats.append(Cat(name: "Flyer", imageName: "flyer"))
        cats.append(Cat(name: "Greg", imageName: "greg"))
        cats.append(Cat(name: "Hava", imageName: "hava"))
        cats.append(Cat(name: "Hecker", imageName: "hecker"))
        cats.append(Cat(name: "Heher", imageName: "heher"))
        cats.append(Cat(name: "Licker", imageName: "licker"))
        cats.append(Cat(name: "Nugget", imageName: "nugget"))
        cats.append(Cat(name: "Potato", imageName: "potato"))
        cats.append(Cat(name: "Scemer", imageName: "scemer"))
        cats.append(Cat(name: "Shitten", imageName: "shitten"))
        cats.append(Cat(name: "Smiler", imageName: "smiler"))
        cats.append(Cat(name: "Spatula", imageName: "spatula"))
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension CatAdapter: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(for: CatCell.self, for: indexPath)
        cell.update(with: cats[indexPath.item])
        return cell
    }
}

//MARK: - UICollectionViewDragDelegate
extension CatAdapter: UICollectionViewDragDelegate {
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let itemProvider = NSItemProvider(object: "\(indexPath)" as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        let itemProvider = NSItemProvider(object: "\(indexPath)" as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        return [dragItem]
    }
    
}

//MARK: - UICollectionViewDropDelegate
extension CatAdapter: UICollectionViewDropDelegate {
    
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if collectionView.hasActiveDrag, destinationIndexPath != nil {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        else {
            return UICollectionViewDropProposal(operation: .forbidden)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = collectionView.numberOfSections - 1
            let row = collectionView.numberOfItems(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        switch coordinator.proposal.operation {
        case .move:
            reorderItems(coordinator: coordinator, destinationIndexPath:destinationIndexPath, collectionView: collectionView)
        default:
            break
        }
    }
    
    func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
        let items = coordinator.items
        if items.count == 1, let item = items.first,
           let sourceIndexPath = item.sourceIndexPath {
            collectionView.performBatchUpdates ({
                let source = cats[sourceIndexPath.item]
                cats.remove(at: sourceIndexPath.item)
                cats.insert(source, at: destinationIndexPath.item)
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [destinationIndexPath])
            })
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CatAdapter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: size)
    }
}
