//
//  TableViewCell.swift
//  Networking
//
//  Created by karim  on 09/08/2022.
//

import UIKit

protocol ConfigureCell:AnyObject {
    
    func displayUserImage(image: String)
    func displayUserNameText(text: String)
    func displayPostText(text:String)
    func displayPostImage(image: String)
    func displayLike(text: Int)
}

class PostCell: UITableViewCell,ConfigureCell {
    
    func displayUserImage(image: String) {
        userImageView.setImageFromStringrlL(stringUrl: image)
        userImageView.makeImagrCircle()
    }
    
    func displayUserNameText(text: String) {
        userNameLabel.text = text
    }
    
    func displayPostText(text: String) {
        postTextLabel.text = text
    }
    func displayPostImage(image: String) {
        postImageView.setImageFromStringrlL(stringUrl: image)
        
    }
    
    func displayLike(text: Int) {
        likesLabel.text = String(text)
    }
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
