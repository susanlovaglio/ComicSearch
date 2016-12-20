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
            
            //            for each in self.characters{
            //                print("api call name: \(each.name)")
            //            }
            
            for each in dictionaries{
                
                guard let name = each["name"] as? String else{break}
                
                if let unwrappedImages = each["image"] as? [String: Any]{
                    if let iconImage = unwrappedImages["icon_url"] as? String{
                        if let iconUrl = URL(string: iconImage){
                            
                            do{
                                let imagedata = try Data.init(contentsOf: iconUrl)
                                let image = UIImage.init(data: imagedata)
                                let character = Character.init(name: name, image: image)
                                self.characters.append(character)
                                //                                print("name: \(character.name)")
                                //                                print("count: \(self.characters.count)")
                                
                            }catch{
                                let character = Character.init(name: name, image: nil)
                                self.characters.append(character)
                                print("image download error")
                                
                            }
                        }
                    }
                }
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
            completion(true)
            
//            print("coming out: \(self.offset), \(self.pageNumber), \(self.characters.count)")
            
        })
        
    }
    
    
}
