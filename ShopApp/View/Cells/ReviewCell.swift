//
//  MessageCell.swift
//  ChatApp
//
//  Created by Ainura private on 05.05.2021.
//

import UIKit
import Firebase

class ReviewCell: UITableViewCell {
    
    public static let identifier = "ReviewCell"

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var senderLabel: UILabel!
    @IBOutlet private weak var reviewLabel: UILabel!
    
    public var review: ReviewEntity? = nil{
        didSet{
            if let review = review {
                senderLabel.text = review.sender
                reviewLabel.text = review.review
                
                if CoreDataManager.shared.findUser(with: 1)?.email == review.sender{
                    containerView.backgroundColor = .systemBlue
                }else{
                    containerView.backgroundColor = .systemGreen
                }
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        containerView.layer.cornerRadius = 4
        containerView.layer.masksToBounds = true
    }

    
}
