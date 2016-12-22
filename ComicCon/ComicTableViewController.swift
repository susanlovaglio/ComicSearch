//
//  ComicTableViewController.swift
//  ComicCon
//
//  Created by susan lovaglio on 10/30/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ComicTableViewController: UITableViewController {
    
    let store = DataStore.sharedInstance
    var loadingStatus = true
    @IBOutlet weak var loadingImage: UIImageView!
    let numberOfHeroImages = 8
    var heroImages: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store.getCharacters { (success) in
            if success{
                self.loadingStatus = false
                OperationQueue.main.addOperation({
                    self.tableView.reloadData()
                })
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.characters.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
        //        print("index path row: \(indexPath.row)")
        print(store.characters.count)
        cell.textLabel?.text = store.characters[indexPath.row].name
        cell.imageView?.image = store.characters[indexPath.row].image
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.textLabel?.text = nil
        cell.imageView?.image = nil
        
    }
    
    
    //    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
    //        if indexPath.row == store.characters.count - 1 && self.loadingStatus == false {
    //
    //            self.loadingStatus = true
    //
    //            store.getCharacters { (success) in
    //                if success{
    //                    OperationQueue.main.addOperation({
    //                        self.tableView.reloadData()
    //                    })
    //                    self.loadingStatus = false
    //                    self.loadingImage.isHidden = true
    //                }
    //            }
    //        }
    //    }
    
    
    
    func setUpImageViewAnimation() {
    
        self.loadingImage.image = UIImage(named: "loading")
//        for index in 1...numberOfHeroImages {
//            if let image = UIImage(named: "loacding")
//            {
//                heroImages.append(image)
//            }
//        }
//        
//        loadingImage.animationImages = heroImages
//        loadingImage.animationDuration = 1.0
//        loadingImage.startAnimating()
    }
    
    
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        self.loadingImage.isHidden = false
        
        
        setUpImageViewAnimation()
        
        
        
        if self.loadingStatus == false {
            
            self.loadingStatus = true
            
            store.getCharacters { (success) in
                if success{
                    OperationQueue.main.addOperation({
                        self.tableView.reloadData()
                        self.loadingImage.isHidden = true
                    })
                    self.loadingStatus = false
                }
            }
        }
        
    }
    //    }
    //    //
    
    //    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    //    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
