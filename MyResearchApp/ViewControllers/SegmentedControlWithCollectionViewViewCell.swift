//
//  SegmentedControlWithCollectionViewViewCell.swift
//  MyResearchApp
//
//  Created by Hugo Rosado on 2/6/20.
//  Copyright © 2020 UPC. All rights reserved.
//

import UIKit

class SegmentedControlWithCollectionViewViewCell: UICollectionViewCell {
  
  @IBOutlet weak var scrollView: UIScrollView!
  var viewController: UIViewController! {
    didSet {
      guard viewController != nil else {
        return
      }
      
      let view = UIView(frame: bounds)
      view.addSubview(viewController.view)
      viewController.view.frame = bounds
      scrollView.addSubview(view)
      scrollView.contentSize = bounds.size
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    scrollView.subviews.forEach { (view) in
      view.removeFromSuperview()
    }
  }
  
}
