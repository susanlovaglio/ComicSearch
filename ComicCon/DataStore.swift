//
//  DataStore.swift
//  ComicCon
//
//  Created by susan lovaglio on 10/30/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import UIKit

class DataStore{
    
    static let sharedInstance = DataStore()
    var characters = [Character]()
    var fillingStore = false
    var task: URLSessionDataTask?
    var pageNumber:Int?
    var offset: Int {
        if let number = pageNumber{
            return number * 14
            //number must match limit number in url
        }
        return 0
    }
    
    func getCharacters(with completion: @escaping (Bool) -> ()) {
        
        let notFillingStore = fillingStore == false
        
        if notFillingStore{
            fillingStore = true
            ComicVineAPIClient.getCharactersFromAPI(offset: self.offset, with: { (dictionaries) in
                for each in dictionaries{
                    
                    guard let name = each["name"] as? String else {break}
                    
                    guard let eachIcon = each["image"] as? [String : Any] else{
                        let character = Character(name: name, image: UIImage(named: "noimage"))
                        self.characters.append(character)
                        completion(true)
                        continue}
                    
                    guard let link = eachIcon["icon_url"] as? String else {
                        let character = Character(name: name, image: UIImage(named: "noimage"))
                        self.characters.append(character)
                        completion(true)
                        continue}
                    
                    link.downloadedFromURLString(completion: { (image) in
                        let character = Character(name: name, image: image)
                        self.characters.append(character)
                        completion(true)
                        
                    })
                }
                
                if let page = self.pageNumber {
                    self.pageNumber = page + 1
                    self.fillingStore = false
                }else{
                    self.pageNumber = 1
                    self.fillingStore = false
                }
            })
        }
    }
    
    func getCharacters(with query: String, with completion: @escaping (Bool) -> ()) {
        
        self.characters.removeAll()
        let notFillingStore = fillingStore == false
        
        if notFillingStore {
            if let task = task{
                print("old task in if \(task)")
                task.cancel()
            }
            self.characters.removeAll()
            fillingStore = true
            task = ComicVineAPIClient.getCharacters(with: query, offset: self.offset, with: { (dictionaries) in
                
                for each in dictionaries {
                    
                    guard let name = each["name"] as? String else {break}
                    
                    guard let eachIcon = each["image"] as? [String : Any] else {
                        let character = Character(name: name, image: UIImage(named: "noimage"))
                        self.characters.append(character)
                        completion(true)
                        continue}
                    
                    guard let link = eachIcon["icon_url"] as? String else {
                        let character = Character(name: name, image: UIImage(named: "noimage"))
                        self.characters.append(character)
                        completion(true)
                        continue}
                    
                    link.downloadedFromURLString(completion: { (image) in
                        let character = Character(name: name, image: image)
                        self.characters.append(character)
                        completion(true)
                    })
                    
                }
                if let page = self.pageNumber {
                    self.pageNumber = page + 1
                    self.fillingStore = false
                } else {
                    self.pageNumber = 1
                    self.fillingStore = false
                }
            })
            print("new task in if: \(query) \(task)")
            
        } else {
            print("task cancelled: \(query) \(task)")
            task!.cancel()
            pageNumber = nil
            
            task = ComicVineAPIClient.getCharacters(with: query, offset: self.offset, with: { (dictionaries) in
                
                for each in dictionaries {
                    guard let name = each["name"] as? String else {break}
                    
                    guard let eachIcon = each["image"] as? [String : Any] else {
                        let character = Character(name: name, image: UIImage(named: "noimage"))
                        self.characters.append(character)
                        completion(true)
                        continue}
                    
                    guard let link = eachIcon["icon_url"] as? String else {
                        let character = Character(name: name, image: UIImage(named: "noimage"))
                        self.characters.append(character)
                        completion(true)
                        continue}
                    
                    link.downloadedFromURLString(completion: { (image) in
                        let character = Character(name: name, image: image)
                        self.characters.append(character)
                        completion(true)
                    })
                    
                }
                if let page = self.pageNumber {
                    self.pageNumber = page + 1
                    self.fillingStore = false
                } else {
                    self.pageNumber = 1
                    self.fillingStore = false
                }
            })
            print("new task in else: \(query) \(task)")
        
        }
    }
    
    func getAdditionalCharacters(with query: String, with completion: @escaping (Bool) -> ()) {
        
        let notFillingStore = fillingStore == false
        
        if notFillingStore {
            
            fillingStore = true
            
            if let unwrappedPageNumber = self.pageNumber {
                
                task = ComicVineAPIClient.getCharacters(with: query, offset: unwrappedPageNumber + 1, with: { (dictionaries) in
                    
                    for each in dictionaries {
                        
                        guard let name = each["name"] as? String else {break}
                        
                        guard let eachIcon = each["image"] as? [String : Any] else {
                            let character = Character(name: name, image: UIImage(named: "noimage"))
                            self.characters.append(character)
                            completion(true)
                            continue}
                        
                        guard let link = eachIcon["icon_url"] as? String else {
                            let character = Character(name: name, image: UIImage(named: "noimage"))
                            self.characters.append(character)
                            completion(true)
                            continue}
                        
                        link.downloadedFromURLString(completion: { (image) in
                            let character = Character(name: name, image: image)
                            self.characters.append(character)
                            completion(true)
                        })
                        
                    }
                    if let page = self.pageNumber {
                        self.pageNumber = page + 1
                        self.fillingStore = false
                    } else {
                        self.pageNumber = 1
                        self.fillingStore = false
                    }
                })
            }
        }
    }
}

extension String {
    
    func downloadedFromURLString(completion: @escaping (UIImage) -> Void){
        
        guard let url = URL(string: self) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let result = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                completion(result)
            }
            }.resume()
    }
}
