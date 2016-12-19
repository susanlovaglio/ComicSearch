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
        
        setUpImageViewAnimation()
        self.image.layer.cornerRadius = 0.25 * self.image.bounds.size.width
        self.image.clipsToBounds = true

        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }


}

extension ViewController {
    
//    private func configureButton()
//    {
//        self.image.layer.cornerRadius = 0.5 * self.image.bounds.size.width
//        self.image.clipsToBounds = true
//    }
    
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
