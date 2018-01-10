//
//  ViewController.swift
//  AppStore
//
//  Created by Anirudh Bandi on 1/8/18.
//  Copyright © 2018 Anirudh Bandi. All rights reserved.
//

import UIKit

class FeaturedAppsController: UICollectionViewController  , UICollectionViewDelegateFlowLayout{
    
    private let cellId = "cellId"
    
    var appCategories : [AppCategory]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //appCategories = AppCategory.sampleAppCategories()
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
        //print(CategoryCell.self)
        
        AppCategory.fetchFeaturedApps(completionHandler: {(appCategories) in
            
        self.appCategories = appCategories
        self.collectionView?.reloadData()
            }
        )
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count =  appCategories?.count {
            return count
        }
        else{
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell
        cell.appCategory = appCategories?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 230)
    }


}


