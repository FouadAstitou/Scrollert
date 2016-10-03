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
    
    var horizontal = [1,2,3,4,5,6,7,8,9,10]
    var vertical = [1,2,3,4,5,6,7,8,9,10]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        horizontalCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "HorizontalCell")
        verticalCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "VerticalCell")

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == horizontalCollectionView {
            return horizontal.count
        }
        else {
            return vertical.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == horizontalCollectionView {
            let horizontalCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalCell", for: indexPath)
            horizontalCell.backgroundColor = UIColor.green
            return horizontalCell
        }
            
       else {
            
            let verticalCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VerticalCell", for: indexPath)
            verticalCell.backgroundColor = UIColor.orange
            return verticalCell
        }
    }
    
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.horizontalCollectionView {
            let horizontalScrollPosition = scrollView.contentOffset.x
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
    }


}

