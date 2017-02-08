//
//  CharacterCell.swift
//  ComicCon
//
//  Created by susan lovaglio on 12/22/16.
//  Copyright © 2016 Flatiron School. All rights reserved.


import UIKit

class CharacterCell: UICollectionViewCell {
    
    var characterImageView: UIImageView!
    var characterNameLabel: UILabel!
    var character: Character!

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        characterImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        characterImageView.contentMode = UIViewContentMode.scaleAspectFit
        self.addSubview(characterImageView)
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        characterImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        characterImageView.heightAnchor.constraint(equalToConstant: self.frame.size.height * 0.70).isActive = true
        characterImageView.widthAnchor.constraint(equalToConstant: self.frame.size.width * 0.70).isActive = true
        
        characterNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        characterNameLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        characterNameLabel.textAlignment = .center
        self.addSubview(characterNameLabel)
        characterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        characterNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        characterNameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor).isActive = true
        characterNameLabel.heightAnchor.constraint(equalToConstant: self.frame.height * 0.15).isActive = true
        characterNameLabel.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.50
        
//        setCharacter(character: self.character)
    }
    
//    func setCharacter(character: Character) {
//        print("*****************")
//        print(character.name)
//        print(character.image)
//        print(character.imageUrlString)
//        print("*****************")
//
//        self.character = character
//        self.characterNameLabel.text = self.character.name
//        self.characterImageView.image = self.character.image
//
//        if self.character.image == nil && self.character.imageUrlString != nil && self.character.gettingImages == false{
//           print("about to get \(self.character.name)'s image")
//            self.character.gettingImages = true
//            self.character.imageUrlString!.downloadedFromURLString(completion: { (image) in
//                print("coming back with \(self.character.name)'s image")
//                self.character.image = image
//                self.characterImageView.image = image
//                self.character.gettingImages = false
//
//            })
//            
//        }
    
//        else {
//            
//            self.characterImageView.image = self.character.image
//        }
        
       
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
