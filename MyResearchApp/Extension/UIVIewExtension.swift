//
//  UIVIewExtension.swift
//  MyResearchApp
//
//  Created by Hugo Rosado on 12/19/19.
//  Copyright © 2019 UPC. All rights reserved.
//

import Foundation
import UIKit

protocol NIBNameDelegate: class {
}
extension NIBNameDelegate {
  static var NIBName: String {
    return String(describing: self)
  }
}

extension UIView: NIBNameDelegate {
  static func get<T: UIView>(owner: Any? = nil) -> T {
    guard let view = Bundle.main.loadNibNamed(T.NIBName, owner: owner, options: nil)?[0] as? T else {
      fatalError("This never should happen.")
    }
    
    return view
  }
  
  static func getNIB() -> UINib {
    return UINib(nibName: NIBName, bundle: .main)
  }
}
