//
//  ViewController.swift
//  Scrollert
//
//  Created by Supervisor on 03-10-16.
//  Copyright © 2016 Nerdvana. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet var horizontalCollectionView: UICollectionView!
    @IBOutlet var verticalCollectionView: UICollectionView!
    
    var horizontal = ["1","2","3","4","5","6","7","8","9","10","1","2","3","4","5","6","7","8","9","10"]
    var horizontalCellSize = CGSize(width: 50, height: 50)
    var horizontalLargeCellSize = CGSize(width: 80, height: 80)

    
    var centerCell = UICollectionViewCell()
    var cellIsInCenter = false
    var myIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // When the main view's dimensions change this will re-layout the collection view
    override func viewWillLayoutSubviews() {
        verticalCollectionView.collectionViewLayout.invalidateLayout()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return horizontal.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == horizontalCollectionView {
            let horizontalCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalCell", for: indexPath) as! HorizontalCell
            horizontalCell.backgroundColor = UIColor.blue
            horizontalCell.textLabel.text = horizontal[indexPath.row]
            return horizontalCell
        }
            
       else {
            
            let verticalCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VerticalCell", for: indexPath) as! VerticalCell
            verticalCell.backgroundColor = UIColor.red
            verticalCell.textLabel.text = horizontal[indexPath.row]
            return verticalCell
        }
    }
    
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.horizontalCollectionView {
            let horizontalScrollPosition = scrollView.contentOffset.x * 35
            self.verticalCollectionView.delegate = nil
            self.verticalCollectionView.contentOffset = CGPoint(x: 0, y: horizontalScrollPosition)
            self.verticalCollectionView.delegate = self
        }
        
        if scrollView == self.verticalCollectionView {
            let verticalScrollPosition = scrollView.contentOffset.y
            self.horizontalCollectionView.delegate = nil
            self.horizontalCollectionView.contentOffset = CGPoint(x: verticalScrollPosition, y: 0)
            self.horizontalCollectionView.delegate = self
            
            
        }
        print("scrolling")
    }
    

    // MARK: CollectionViewLayout
    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        if collectionView == verticalCollectionView {
//            let size = CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
//            
//            return size
//        }
//        
//        if indexPath.item == 3 {
//            return CGSize(width: 70, height: 70)
//        }
//        return CGSize(width: 50, height: 50)
//
//    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if collectionView == verticalCollectionView {
            let size = CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
            return size
        }
//        let centerIndex = self.collectionView.indexPathForItemAtPoint(self.collectionView.center)
//        let centerIndex = self.verticalCollectionView.indexPathForItem(at: self.verticalCollectionView.center)
//        if indexPath.item == centerIndex?.item {
//            print(indexPath)
//            return CGSize(width: 20, height: 70)
//        }
        
        
        if indexPath.item == self.myIndexPath?.item {
            return CGSize(width: 70, height: 70)
        }
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.verticalCollectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
        print("\(indexPath)")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var closestCell: UICollectionViewCell = self.horizontalCollectionView.visibleCells[0]
        for cell in self.horizontalCollectionView.visibleCells as [UICollectionViewCell] {
            let closestCellDelta = abs(closestCell.center.x - self.horizontalCollectionView.bounds.size.width / 2.0 - self.horizontalCollectionView.contentOffset.x)
            let cellDelta = abs(cell.center.x - self.horizontalCollectionView.bounds.size.width/2.0 - self.horizontalCollectionView.contentOffset.x)
            if (cellDelta < closestCellDelta){
                closestCell = cell
                self.centerCell = cell
                self.cellIsInCenter = true
                horizontalCellSize = CGSize(width: 80, height: 50)
            }
        }
        let indexPath = self.horizontalCollectionView.indexPath(for: closestCell)
        self.horizontalCollectionView.scrollToItem(at: indexPath!, at: .centeredHorizontally , animated: true)
        if closestCell.backgroundColor == UIColor.black {
            closestCell.backgroundColor = UIColor.blue
        }
        horizontalCollectionView.reloadItems(at: [self.horizontalCollectionView.indexPath(for: closestCell)!])
        closestCell.backgroundColor = UIColor.black
        
        // Get the center cell
        var visibleRect = CGRect()
        
        visibleRect.origin = horizontalCollectionView.contentOffset
        visibleRect.size = horizontalCollectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        let visibleIndexPath: IndexPath = horizontalCollectionView.indexPathForItem(at: visiblePoint)!
        
        print(visibleIndexPath)
        
        self.myIndexPath = visibleIndexPath
        self.horizontalCollectionView.reloadData()

    
    }
}

