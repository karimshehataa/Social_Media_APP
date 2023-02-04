//
//  CommentCell.swift
//  Networking
//
//  Created by karim  on 10/08/2022.
//

import UIKit

protocol configureCommentCell {
    func displayUserImage(image: String)
    func displayUserName(text: String)
    func displayCommentText(text: String)
}

class CommentCell: UITableViewCell,configureCommentCell {
    
    func displayUserImage(image: String) {
        userImageView.setImageFromStringrlL(stringUrl: image)
        userImageView.makeImagrCircle()
    }
    
    func displayUserName(text: String) {
        userNameLabel.text = text
    }
    
    func displayCommentText(text: String) {
        commentLabel.text = text
    }
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
