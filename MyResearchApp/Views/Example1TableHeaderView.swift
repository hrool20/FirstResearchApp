//
//  Example1TableHeaderView.swift
//  MyResearchApp
//
//  Created by Hugo Rosado on 12/18/19.
//  Copyright © 2019 UPC. All rights reserved.
//

import UIKit

class Example1TableHeaderView: UIView {

  @IBOutlet weak var posterView: UIView!
  @IBOutlet weak var posterImageView: UIImageView!
  var posterImage: UIImage! {
    didSet {
      guard posterImage != nil else {
        return
      }
      posterImageView.image = posterImage
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
      self.posterImage = #imageLiteral(resourceName: "liger_background.jpg")
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    posterView.backgroundColor = .red
    posterImageView.backgroundColor = .purple
  }
  
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
