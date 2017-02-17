//
//  RepoCell.swift
//  GithubDemo
//
//  Created by Edwin Young on 2/15/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class RepoCell: UITableViewCell {
	
	
	@IBOutlet weak var userAvatar: UIImageView!
	@IBOutlet weak var repoName: UILabel!
	@IBOutlet weak var ownerName: UILabel!
	@IBOutlet weak var repoDescription: UILabel!
	@IBOutlet weak var stars: UILabel!
	@IBOutlet weak var forks: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
}
