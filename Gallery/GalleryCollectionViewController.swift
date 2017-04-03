//
//  GalleryCollectionViewController.swift
//  Gallery
//
//  Created by Apple on 24/03/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

private let reuseIdentifier = "imageCell"

class GalleryCollectionViewController: UICollectionViewController {
    
//    var fs: FlickrService!
    var imagesList: [PhotoFromURL] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = SearchViewController.urlSearch
//        self.imagesList = FlickrService.generateURLs(url: urlString!)
        
//        fs.getURLs(url: (urlString)!)
        
        FlickrService.getJSONData(url: urlString!) { (returnVal) -> Void in
            
            self.imagesList = returnVal!
            
        }

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = falseÒ

        // Register cell classes
        // self.collectionView!.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation
    */

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imageShowSegue" {
            if let cell = sender as? ImageCollectionViewCell,
                let showImageVC = segue.destination as? ImageShowViewController {
                
//                let urlOgr = PhotoFromURL(photoId: self.imagesList[cell.imageView.tag].photoId,
//                                          farm: self.imagesList[cell.imageView.tag].farm,
//                                          secret: self.imagesList[cell.imageView.tag].secret,
//                                          server: self.imagesList[cell.imageView.tag].server,
//                                          title: self.imagesList[cell.imageView.tag].title,
//                                          size: "c")
//                
//                FlickrService.getDataFromUrl(url: urlOgr.photoUrl as URL) {
//                    (imgData) -> Void in
//                    
//                    let imageData = imgData
//                    
//                    DispatchQueue.main.async {
//                        showImageVC.image = UIImage(data: imageData!)
//                    }
//                }
                
                showImageVC.image = cell.imageView.image
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 100
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        
        if self.imagesList.count != 0 {
            
            FlickrService.getDataFromUrl(url: self.imagesList[indexPath.row].photoUrl as URL) {
                (imgData) -> Void in
                
                let imageData = imgData
                    
                DispatchQueue.main.async {
                    cell.imageView.image = UIImage(data: imageData!)
                    cell.imageView.tag = indexPath.row
                }
            }
            
        }
        
        cell.imageView.reloadInputViews()
        
        return cell
        
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
