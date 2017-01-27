//
//  ViewController.swift
//  ComicCon
//
//  Created by susan lovaglio on 10/30/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    
    let numberOfHeroImages = 8
    var heroImages: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        setUpImageViewAnimation()
        self.image.layer.cornerRadius = 0.25 * self.image.bounds.size.width
        self.image.clipsToBounds = true
        
    }
    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//    }
}

extension ViewController {
    
    func setUpImageViewAnimation() {
        
        for index in 1...numberOfHeroImages {
            if let image = UIImage(named: "hero-\(index)") {
                heroImages.append(image)
            }
        }
        
        self.image.animationImages = heroImages
        self.image.animationDuration = 1.0
        self.image.startAnimating()
    }
}
