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
    
    func getCharacters(with completion: @escaping (Bool) -> ()){
        
        ComicVineAPIClient.getCharactersFromAPI { (dictionaries) in
            
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
                                
                                
                            }catch{
                                let character = Character.init(name: name, image: nil)
                                self.characters.append(character)
                                print("image download error")
                                
                            }
                        }
                    }
                }
            }
            completion(true)
        }
    }
    
    
}
