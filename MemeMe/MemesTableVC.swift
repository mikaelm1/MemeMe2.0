//
//  MemesTableVC.swift
//  MemeMe
//
//  Created by Mikael Mukhsikaroyan on 2/1/16.
//  Copyright © 2016 msquared. All rights reserved.
//

import UIKit

class MemesTableVC: UITableViewController {
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorInset.bottom = 100
        if memes.count < 1 {
            goToEditor()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell", forIndexPath: indexPath) as! MemeTableViewCell
        let meme = memes[indexPath.row]
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = "\(meme.topText)...\(meme.bottomText)"

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detailVC = self.storyboard?.instantiateViewControllerWithIdentifier("MemeDetailVC") as! MemeDetailVC
        detailVC.meme = memes[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.memes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    override func performSegueWithIdentifier(identifier: String, sender: AnyObject?) {
        if identifier == "editorView" {
            goToEditor()
        }
    }
    
    func goToEditor() {
        let editorVC = self.storyboard?.instantiateViewControllerWithIdentifier("EditorVC")
        self.navigationController?.pushViewController(editorVC!, animated: true)
    }


}
