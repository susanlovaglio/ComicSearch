//
//  ComicDisplayViewController.swift
//  ComicCon
//
//  Created by susan lovaglio on 12/22/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ComicDisplayViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var comicCollectionView: UICollectionView!
    let store = DataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpCollectionView()
        
        store.getCharacters { (success) in
            if success{
//                self.loadingStatus = false
                OperationQueue.main.addOperation({

                    self.comicCollectionView.reloadData()
                })
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return store.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: CharacterCell = collectionView.dequeueReusableCell(withReuseIdentifier: "comicCell", for: indexPath) as! CharacterCell
        
        cell.setCharacter(character: store.characters[indexPath.row])

        cell.backgroundColor = UIColor.purple
        
        return cell
    }

    func setUpCollectionView(){
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.bounds.width * 0.45, height: self.view.bounds.height * 0.25)
        
        self.comicCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        self.view.addSubview(self.comicCollectionView)
        
        self.comicCollectionView.translatesAutoresizingMaskIntoConstraints = false

        self.comicCollectionView.delegate = self
        self.comicCollectionView.dataSource = self
        
        self.comicCollectionView.backgroundColor = UIColor.white
        
        self.comicCollectionView.register(CharacterCell.self, forCellWithReuseIdentifier: "comicCell")
        
        self.comicCollectionView.heightAnchor.constraint(equalToConstant: self.view.frame.height / 1.25).isActive = true
        self.comicCollectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.95).isActive = true
        self.comicCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.comicCollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
   // func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, //targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        //print(#function)
//        print(targetContentOffset.advanced(by: store.characters.coun)
        //store.getCharacters { (success) in
            //if success{
                //                self.loadingStatus = false
             //   OperationQueue.main.addOperation({
                    
           //         self.comicCollectionView.reloadData()
         //       })
       //     }
     //   }
   // }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
