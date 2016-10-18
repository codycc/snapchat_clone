//
//  UserCell.swift
//  devchatClone
//
//  Created by Cody Condon on 2016-10-18.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    @IBOutlet weak var firstNameLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setCheckmark(selected: false)
    }
    
    func updateUI(user: User) {
        firstNameLbl.text = user.firstName
    }
    
    
    // when selected, add checkmark
    func setCheckmark(selected: Bool) {
        // if checked, use checked image, if not use unchecked image
        let imageStr = selected ? "messageindicatorchecked1" : "messageindicator1"
        // setting the imageStr to the accessoryView in the cell
        self.accessoryView = UIImageView(image: UIImage(named: imageStr))
    }

}
