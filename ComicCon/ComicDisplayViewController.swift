//
//  ComicDisplayViewController.swift
//  ComicCon
//
//  Created by susan lovaglio on 12/22/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//


import UIKit

class ComicDisplayViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UpdateColectionView {
    
    var counter = 0
    var comicCollectionView: UICollectionView!
    let store = DataStore.sharedInstance
    var topView: UIView!
    var searchBar = UISearchBar()
    var activityIndicator: UIActivityIndicatorView!
    let layout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.addImage()
        self.addSearchBar()
        self.setUpCollectionView()
        self.setUpActivityIndicator()
        
        self.store.characters.removeAll()
        store.getCharacters { (success) in
            if success {
                
                OperationQueue.main.addOperation( {
                    self.comicCollectionView.reloadData()
                    self.activityIndicator.stopAnimating()
                })
            }
        }
    }
    
    func updateCollectionView() {
        
        OperationQueue.main.addOperation( {
            self.comicCollectionView.reloadData()
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: CharacterCell = collectionView.dequeueReusableCell(withReuseIdentifier: "comicCell", for: indexPath) as! CharacterCell
        
        let character = store.characters[indexPath.item]
        character.delegate = self
        cell.character = character
        cell.characterImageView.image = character.image
        cell.characterNameLabel.text = character.name
        
        return cell
    }
    
    func addImage(){
        
        topView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height * 0.25))
        topView.backgroundColor = UIColor.white
        view.addSubview(topView)
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: self.view.frame.size.height * 0.25).isActive = true
        
        let image =  UIImage(named: "powPic")
        let imageView = UIImageView(image: image)
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        self.topView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: self.topView.frame.size.height * 0.80).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: self.topView.frame.size.width * 0.80).isActive = true
        
    }
    
    func addSearchBar() {
        
        searchBar.delegate = self
        
        view.addSubview(searchBar)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.topAnchor.constraint(equalTo: self.topView.bottomAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: self.view.frame.size.height * 0.06).isActive = true
        searchBar.placeholder = "Search"
        
    }
    
    func setUpCollectionView() {
        
        
        self.comicCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: self.layout)
        self.view.addSubview(self.comicCollectionView)
        self.comicCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.comicCollectionView.delegate = self
        self.comicCollectionView.dataSource = self
        
        self.comicCollectionView.backgroundColor = UIColor.clear
        
        self.comicCollectionView.register(CharacterCell.self, forCellWithReuseIdentifier: "comicCell")
        
        self.comicCollectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor).isActive = true
        self.comicCollectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.comicCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.comicCollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10.0, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.width / 2, height: self.view.frame.height / 4)
        layout.minimumInteritemSpacing = 0.0
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ComicDisplayViewController.keyBoardDismiss))
        self.comicCollectionView.addGestureRecognizer(tapGesture)
    }
    
    func keyBoardDismiss(){
        
        searchBar.endEditing(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
     
        return 0.0
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
    
//    func handleScrollDuringLoad(){
//    
//        let scrollSize = CGSize(width: view.frame.size.height, height: 1.0)
//        comicCollectionView.contentSize = scrollSize
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        searchBar.endEditing(true)

        
        if store.fillingStore{
            
            comicCollectionView.isScrollEnabled = false
            return
            
        }else {
            
            comicCollectionView.isScrollEnabled = true
        }
        

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
        
        store.pageNumber = nil
        self.activityIndicator.startAnimating()
        
        if searchText.characters.count == 0{
            self.store.characters.removeAll()
            store.getCharacters(with: { (success) in
                
                OperationQueue.main.addOperation {
                    
                    self.comicCollectionView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            })
         
        } else {
            
            store.getCharacters(with: searchText) { (success) in
                
                OperationQueue.main.addOperation {
                    
                    self.comicCollectionView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
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
