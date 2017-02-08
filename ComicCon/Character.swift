//
//  Character.swift
//  ComicCon
//
//  Created by susan lovaglio on 10/30/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import UIKit

class Character{
    
    let name: String
    var image: UIImage?
    var imageUrlString: String?
    var delegate: UpdateColectionView?
    
    init(name:String, image: UIImage?) {
        
        self.name =  name
        self.image = image
        self.imageUrlString = nil
    }
    
    convenience init(name: String, imageUrlString: String){
        
        self.init(name:name, image: nil)
        self.imageUrlString = imageUrlString
        imageUrlString.downloadedFromURLString { (image) in
            
            self.image = image
            
            self.delegate?.updateCollectionView()
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

protocol UpdateColectionView {
    
    func updateCollectionView()
    
}






