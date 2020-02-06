//
//  SegmentedControlWithTableViewCollectionViewCell.swift
//  MyResearchApp
//
//  Created by Hugo Rosado on 2/5/20.
//  Copyright © 2020 UPC. All rights reserved.
//

import UIKit

class SegmentedControlWithTableViewCollectionViewCell: UICollectionViewCell {
    
  @IBOutlet weak var scrollView: UIScrollView!
  var selectedViewController: UIViewController! {
    didSet {
      guard selectedViewController != nil else {
        return
      }
      print("---------------------")
      print("##selectedVC: \(selectedViewController.view.bounds)")
      print("##UIScreen: \(UIScreen.main.bounds)")
      print("##self: \(bounds)")
      print("##scrollView: \(self.scrollView.bounds)")
      print("##SVContentSize: \(self.scrollView.contentSize)")
      
//      self.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 100)
      self.scrollView.addSubview(selectedViewController.view)
//      selectedViewController.view.translatesAutoresizingMaskIntoConstraints = false
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    
  }
  
}
