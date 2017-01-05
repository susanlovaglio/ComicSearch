//
//  CharacterCell.swift
//  ComicCon
//
//  Created by susan lovaglio on 12/22/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class CharacterCell: UICollectionViewCell {
    
    var characterImageView: UIImageView!
    var characterNameLabel: UILabel!
    var character: Character!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        characterImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height*2/3))
        characterImageView.contentMode = UIViewContentMode.scaleAspectFit
        contentView.addSubview(characterImageView)
        
        characterNameLabel = UILabel(frame: CGRect(x: 0, y: characterImageView.frame.size.height, width: frame.size.width, height: frame.size.height/3))
        characterNameLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        characterNameLabel.textAlignment = .center
        contentView.addSubview(characterNameLabel)
    }
    
    func setCharacter(character: Character) {
        
        self.character = character
        characterImageView.image = self.character.image
        characterNameLabel.text = self.character.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
