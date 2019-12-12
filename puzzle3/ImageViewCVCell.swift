
//
//  ImageView.swift
//  PuzzleR
//
//  Created by Romeel Chaudhari on 11/15/19.
//  Copyright © 2019 Romeel Chaudhari. All rights reserved.
//
import UIKit

class ImageViewCVCell: UICollectionViewCell {                 //got to know about this class from stackoverflow.
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                border.isHidden = false
            } else {
                border.isHidden = true
            }
        }
    }
    
    func setupViews() {                     // google how to setuo the views #swift docs
        self.addSubview(imgV)
        imgV.leftAnchor.constraint(equalTo: self.leftAnchor).isActive=true
        imgV.topAnchor.constraint(equalTo: self.topAnchor).isActive=true
        imgV.rightAnchor.constraint(equalTo: self.rightAnchor).isActive=true
        imgV.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive=true
        
        self.addSubview(border)
        border.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive=true
        border.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive=true
        border.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive=true
        border.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive=true
        border.isHidden=true
    }
    
    let imgV: UIImageView = {
        let v=UIImageView()
        v.image = #imageLiteral(resourceName: "Layer 3")
        v.contentMode = .scaleAspectFit
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let border: UIView = {              //stackoverflow.
        let v=UIView()
        v.backgroundColor = UIColor.clear
        v.layer.borderColor = UIColor(red: 230/255, green: 249/255, blue: 250/255, alpha: 0.7).cgColor
        v.layer.borderWidth  = 5
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) implementation is not active")
    }
}

