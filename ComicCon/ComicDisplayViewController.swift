//
//  ComicDisplayViewController.swift
//  ComicCon
//
//  Created by susan lovaglio on 12/22/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ComicDisplayViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var counter = 0
    var comicCollectionView: UICollectionView!
    let store = DataStore.sharedInstance
    var imageView = UIImageView()
    var searchBar = UISearchBar()
    var searchActive = false
    var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addImage()
        self.addSearchBar()
        self.setUpCollectionView()
        self.setUpActivityIndicator()
        
        store.getCharacters { (success) in
            if success{
                OperationQueue.main.addOperation( {
                    self.comicCollectionView.reloadData()
                    self.activityIndicator.stopAnimating()
                })
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: CharacterCell = collectionView.dequeueReusableCell(withReuseIdentifier: "comicCell", for: indexPath) as! CharacterCell
        
        cell.setCharacter(character: store.characters[indexPath.item])
        
        return cell
    }
    
    func addImage(){
        
        
        let image =  UIImage(named: "powPic")
        imageView = UIImageView(image: image)
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        self.view.addSubview(imageView)
        
        imageView.backgroundColor = UIColor.white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: self.view.frame.size.height * 0.25).isActive = true
    }
    
    func addSearchBar(){
        
        searchBar.delegate = self
        
        view.addSubview(searchBar)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.topAnchor.constraint(equalTo: self.imageView.bottomAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: self.view.frame.size.height * 0.06).isActive = true
        searchBar.placeholder = "Search"
        
    }
    
    func setUpCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: self.view.bounds.width * 0.45, height: self.view.bounds.height * 0.25)
//        layout.footerReferenceSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height * 0.25)
        
        self.comicCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        self.view.addSubview(self.comicCollectionView)
        self.comicCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.comicCollectionView.delegate = self
        self.comicCollectionView.dataSource = self
        self.comicCollectionView.backgroundColor = UIColor.clear
        
        self.comicCollectionView.register(CharacterCell.self, forCellWithReuseIdentifier: "comicCell")
        
        self.comicCollectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor).isActive = true
        self.comicCollectionView.heightAnchor.constraint(equalToConstant: self.view.frame.height / 1.40).isActive = true
        self.comicCollectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.95).isActive = true
        self.comicCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.comicCollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    func setUpActivityIndicator() {
        
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
        
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator.leadingAnchor.constraint(equalTo:self.view.leadingAnchor ).isActive = true
        self.activityIndicator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.activityIndicator.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.06).isActive = true
        self.activityIndicator.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor).isActive = true

        self.activityIndicator.backgroundColor = UIColor.white
        self.activityIndicator.color = UIColor.black
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.startAnimating()
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 1.0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
            
            if searchBar.text!.characters.count == 0 {
                self.activityIndicator.startAnimating()
                store.getCharacters { (success) in
                    
                    if success{
                        OperationQueue.main.addOperation( {
                            
                            self.comicCollectionView.reloadData()
                            self.activityIndicator.stopAnimating()
                        })
                    }
                }
            }else {

                let query = searchBar.text!
                self.activityIndicator.startAnimating()
                store.getAdditionalCharacters(with: query, with: { (success) in
                    
                    if success{
                        
                        OperationQueue.main.addOperation {
                            
                            self.comicCollectionView.reloadData()
                            self.activityIndicator.stopAnimating()
                        }
                    }
                    
                })
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        store.characters.removeAll()
        self.comicCollectionView.reloadData()
        store.pageNumber = nil
        self.activityIndicator.startAnimating()
        store.getCharacters(with: searchText) { (success) in
//            print(searchText, success)
            OperationQueue.main.addOperation {
                
                self.comicCollectionView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    

    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
