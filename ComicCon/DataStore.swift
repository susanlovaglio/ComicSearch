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
    var pageNumber:Int?
    var offset: Int?{
        if let number = pageNumber{
            return number * 10
        }
        return nil
    }
    
    func getCharacters(with completion: @escaping (Bool) -> ()){
        
        //        print("going into chars: \(offset), \(pageNumber), \(characters.count)")
        
        ComicVineAPIClient.getCharactersFromAPI(offset: self.offset, with: { (dictionaries) in
            
            for each in dictionaries{
                
                guard let name = each["name"] as? String else{break}
                
                guard let eachIcon = each["image"] as? [String : Any] else{
                    let character = Character(name: name, image: nil)
                    self.characters.append(character)
                    completion(true)
                    break}
                
                guard let link = eachIcon["icon_url"] as? String else{break}
                
                link.downloadedFromLink(completion: { (image) in
                    let character = Character(name: name, image: image)
                    self.characters.append(character)
                    completion(true)
                    
                })
            }
            if let page = self.pageNumber{
                //                print("IN if let page: \(self.pageNumber) \(self.offset) \(self.characters.count)")
                self.pageNumber = page + 1
                //                print("OUT if let page: \(self.pageNumber) \(self.offset) \(self.characters.count)")
            }else{
                //                print("IN else page: \(self.pageNumber) \(self.offset) \(self.characters.count)")
                self.pageNumber = 1
                //                print("OUT else page: \(self.pageNumber) \(self.offset) \(self.characters.count)")
                
            }
            
            //            print("coming out: \(self.offset), \(self.pageNumber), \(self.characters.count)")
            
        })
    }
    
    
}

extension String {
    
    func downloadedFromLink(completion: @escaping (UIImage) -> Void){
        
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
