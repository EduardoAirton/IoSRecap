//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Luan Cabral on 21/03/20.
//  Copyright © 2020 Luan Cabral. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    //MARK: Properties

    private var ratingButtons = [UIButton]()
    @IBInspectable var starsize = CGSize(width: 44.0, height: 44.0){
        didSet{
            setupButton()
        }
    }
    @IBInspectable var starCount = 5{
        didSet{
            setupButton()
        }
    }
    var rating = 0{
        didSet{
            updateButtonState()
        }
    }
    
    
    //MARK:Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupButton()
        
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.setupButton()
    }
    //MARK: Button Action
    @objc func ratingButtonTapped(button: UIButton){
        guard let index = ratingButtons.firstIndex(of: button) else{
            fatalError("Out of index buttons")
        }
        
        let selectRating = index + 1
        
        if selectRating == self.rating{
            rating = 0
        }else{
            rating = selectRating
        }
        
        
        
        
    }
    
    private func setupButton(){
        
        //remove all butons
        for button in ratingButtons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        
        
        for _ in 0..<starCount{
            let ratingButton = UIButton()
            //Set button images
            ratingButton.setImage(emptyStar, for: .normal)
            ratingButton.setImage(filledStar, for: .selected)
            ratingButton.setImage(highlightedStar, for: .highlighted)
            ratingButton.setImage(highlightedStar, for: [.highlighted,.selected])
            
            //Make auto layout defining the button size
            ratingButton.translatesAutoresizingMaskIntoConstraints = false
            ratingButton.heightAnchor.constraint(equalToConstant: starsize.height).isActive = true
            ratingButton.widthAnchor.constraint(equalToConstant: starsize.width).isActive = true
               
            //Creat a click action
            ratingButton.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            //Add button to the stack
            addArrangedSubview(ratingButton)
            
            ratingButtons.append(ratingButton)
        }
        updateButtonState()
    }
    
    private func updateButtonState(){
        for(index,button) in ratingButtons.enumerated(){
            // If the index of a button is less than the rating, that button should be selected.
            button.isSelected = index < rating
        }
    }
    
}
