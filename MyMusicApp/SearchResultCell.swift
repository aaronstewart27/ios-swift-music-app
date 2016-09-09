//
//  SearchResultCell.swift
//  MyMusicApp
//
//  Created by Aaron Stewart on 5/2/16.
//  Copyright © 2016 Aaron Stewart. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {

    
    @IBOutlet weak var artwork: UIImageView!
    
    @IBOutlet weak var songTitle: UILabel!
    
    @IBOutlet weak var artist: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.separatorInset = UIEdgeInsetsZero
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
