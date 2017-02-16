//
//  RepoResultCel.swift
//  GithubDemo
//
//  Created by Calvin Chu on 2/13/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class RepoResultCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var forkImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    
    var repo: GithubRepo! {
        didSet {
            avatarImageView.setImageWith(URL(string: repo.ownerAvatarURL!)!)
            descriptionLabel.text = repo.repoDescription
            forksLabel.text = "\(repo.forks!)"
            nameLabel.text = repo.name
            ownerLabel.text = repo.ownerHandle
            starsLabel.text = "\(repo.stars!)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatarImageView.layer.cornerRadius = 3
        avatarImageView.clipsToBounds = true
        forkImageView.image = UIImage(named: "fork")
        starImageView.image = UIImage(named: "star")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
