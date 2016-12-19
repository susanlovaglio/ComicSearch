//
//  ComicVineAPIClient.swift
//  ComicCon
//
//  Created by susan lovaglio on 10/30/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

class ComicVineAPIClient{
    
    class func getCharactersFromAPI(with completion: @escaping ([[String: Any]]) -> ()){
        
        let stringUrl = "http://comicvine.com/api/characters/?api_key=\(Secrets.key)&format=json&limit=10&field_list=name,image"
        let url = URL(string: stringUrl)
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            do{
                
                let results = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
                
                if let results = results{
                    
                    let dictionaries = results["results"] as? [[String: Any]]
                    
                    if let unwrappeddictionaries = dictionaries{
                        
                        completion(unwrappeddictionaries)
                    }
                }
            }catch{
                print(error)
            }
        }
        
        task.resume()
        
    }
    
}
