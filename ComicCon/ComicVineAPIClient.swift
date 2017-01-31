//
//  ComicVineAPIClient.swift
//  ComicCon
//
//  Created by susan lovaglio on 10/30/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

class ComicVineAPIClient{
    
    
    class func getCharactersFromAPI(offset: Int, with completion: @escaping ([[String: Any]]) -> ()) {
        
        let stringUrl = "http://comicvine.com/api/characters/?api_key=\(Secrets.key)&format=json&limit=14&offset=\(offset)&field_list=name,image"
        let url = URL(string: stringUrl)
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            do{
                
                let results = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
                if let results = results {
                    
                    let dictionaries = results["results"] as? [[String: Any]]
                    
                    if let unwrappeddictionaries = dictionaries{
                        
                        completion(unwrappeddictionaries)
                    }
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
    
    class func getCharacters(with query: String, offset: Int, with completion: @escaping ([[String: Any]]) -> ()) -> URLSessionDataTask{

        let preparedQuery = query.replacingOccurrences(of: " ", with: "")
        
        let stringUrl = "http://comicvine.com/api/search/?api_key=\(Secrets.key)&format=json&field_list=name,image&limit=14&page=\(offset)&query=\(preparedQuery)&resources=character"
        
        let url = URL(string: stringUrl)
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            do{
                guard let unwrappedata = data else{return}
                let results = try JSONSerialization.jsonObject(with: unwrappedata, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
                
                if let unwrappedresults = results {

                    let dictionaries = unwrappedresults["results"] as? [[String: Any]]

                    if let unwrappeddictionaries = dictionaries{
                        
                        completion(unwrappeddictionaries)
                    }
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
        return task
    }
    
}

