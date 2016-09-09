//
//  SearchInput.swift
//  MyMusicApp
//
//  Created by Aaron Stewart on 5/2/16.
//  Copyright © 2016 Aaron Stewart. All rights reserved.
//

import UIKit

class SearchInput: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 5);
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
}
