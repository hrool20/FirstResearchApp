//
//  UIScrollViewExtension.swift
//  MyResearchApp
//
//  Created by Hugo Rosado on 2/6/20.
//  Copyright © 2020 UPC. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
  final var currentPage: Int {
    let currentX = contentOffset.x
    let width = frame.width
    
    let page = Int((currentX + width) / width) - 1
    
    return (page < 0) ? 0 : page
  }
  
  final var currentProgress: CGFloat {
    let currentX = contentOffset.x
    let width = frame.width
    
    let page = ((currentX + width) / width) - 1
    
    return page
  }
}
