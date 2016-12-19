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
    let image: UIImage?
    
    init(name:String, image: UIImage?) {
        
        self.name =  name
        self.image = image
    }
}
