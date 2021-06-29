//
//  RecipeCell.swift
//  Recipt App
//
//  Created by Aamir Burma on 29/06/21.
//

import UIKit

class RecipeCell: UITableViewCell {
    
    private let MyImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 40
        imageView.alpha = 0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let myLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 30.0)
        return label
    }()
    
    public let myButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right.2"), for: .normal)
        button.tintColor = .black
        button.alpha = 0
        return button
    }()
    
    
    func  setupRecipeCellWith(title name: String, index: Int, and state:Bool) {
        MyImageView.image = UIImage(named: name)
        myLabel.text = name
        myButton.tag = index
        
        
        setupUI(at: index, with: state)
        
    }
    
    private func setupUI(at index: Int, with state:Bool) {
        contentView.addSubview(MyImageView)
        contentView.addSubview(myLabel)
        contentView.addSubview(myButton)
        
        MyImageView.frame = CGRect(x:20, y: 10, width: 80, height: 80)
        
        if  state {
            myLabel.frame = CGRect(x: MyImageView.right + 20, y: 10, width: 140, height: 80)
            MyImageView.alpha = 1
            myButton.alpha = 1
            
        } else {
            myLabel.frame = CGRect(x: 20, y: 10, width: 140, height: 80)
            MyImageView.alpha = 0
            myButton.alpha = 0
        }
        
        myButton.frame = CGRect(x: contentView.width - 80, y: 10, width: 40, height: 80)
        
    }
    
    func  animateCell(at index: Int) {
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveLinear) {
            self.MyImageView.transform = self.MyImageView.transform.rotated(by: .pi)
            self.MyImageView.alpha = 0.5
            self.myButton.alpha = 0.5
            
            self.myLabel.frame.origin.x = self.MyImageView.right + 20
            
        }completion: { _ in
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveLinear ) {
                self.MyImageView.transform = self.MyImageView.transform.rotated(by: .pi)
                self.MyImageView.alpha = 1
                self.myButton.alpha = 1
            }
        }
    }
}
