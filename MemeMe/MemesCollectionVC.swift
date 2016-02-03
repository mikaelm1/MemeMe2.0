//
//  MemesCollectionVC.swift
//  MemeMe
//
//  Created by Mikael Mukhsikaroyan on 1/31/16.
//  Copyright © 2016 msquared. All rights reserved.
//

import UIKit

class MemesCollectionVC: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if memes.count < 1 {
            goToEditor()
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
        setLayout()
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        setLayout()
    }
    
    override func performSegueWithIdentifier(identifier: String, sender: AnyObject?) {
        if identifier == "EditorVC" {
            goToEditor()
        }
    }
    
    func goToEditor() {
        let editorVC = self.storyboard?.instantiateViewControllerWithIdentifier("EditorVC")
        self.navigationController?.pushViewController(editorVC!, animated: true)
    }
    
    func setLayout() {
        let space: CGFloat = 3.0
        let frameSize = self.view.frame.size
        print("Width \(frameSize.width)")
        print("Height \(frameSize.height)")
        let dimension = frameSize.width > frameSize.height ? (frameSize.width - 5 * space) / 4.0 : (frameSize.height - 2 * space) / 4.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Memes in collection view \(memes.count)")
        return memes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        print("In collection cell")
        print("Memes length = \(memes.count)")
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.row]
        cell.memeImageView.image = meme.memedImage


        return cell
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let detailVC = self.storyboard?.instantiateViewControllerWithIdentifier("MemeDetailVC") as! MemeDetailVC
        detailVC.meme = memes[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }




}