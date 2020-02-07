//
//  SegmentedControlWithCollectionViewViewController.swift
//  MyResearchApp
//
//  Created by Hugo Rosado on 2/6/20.
//  Copyright © 2020 UPC. All rights reserved.
//

import UIKit

class SegmentedControlWithCollectionViewViewController: UIViewController {
  
  @IBOutlet weak var tabsView: UIView!
  @IBOutlet weak var collectionView: UICollectionView!
  private var viewControllers: [UIViewController]!
  private var secondSegmentedControl: SecondSegmentedControl!
  @IBOutlet weak var tabsViewHeightContraint: NSLayoutConstraint!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let vc = UIViewController()
    vc.view.backgroundColor = .red
    viewControllers = [
      vc,
      UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "VCWithTableViewController")
    ]
    secondSegmentedControl = SecondSegmentedControl.get(owner: self)
    secondSegmentedControl.delegate = self
    secondSegmentedControl.tabs = [
      "1st VC",
      "2nd VC"
    ]
    tabsViewHeightContraint.constant = secondSegmentedControl.bounds.height
    tabsView.addSubview(secondSegmentedControl)
    
    collectionView.delegate = self
    collectionView.dataSource = self
    if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      flowLayout.scrollDirection = .horizontal
      flowLayout.minimumLineSpacing = 0.0
      flowLayout.minimumInteritemSpacing = 0.0
      flowLayout.itemSize = collectionView.bounds.size
      flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    collectionView.reloadData()
  }
  
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
  }
  
}
extension SegmentedControlWithCollectionViewViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewControllers.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "firstCell", for: indexPath) as! SegmentedControlWithCollectionViewViewCell
    cell.viewController = viewControllers[indexPath.row]
    
    return cell
  }
}
extension SegmentedControlWithCollectionViewViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return collectionView.bounds.size
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0.0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0.0
  }
}
extension SegmentedControlWithCollectionViewViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    secondSegmentedControl.moveTabContent(scrollView: scrollView)
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    secondSegmentedControl.moveTabContent(scrollView: scrollView, didEndDecelerating: true)
  }
}
extension SegmentedControlWithCollectionViewViewController: SecondSegmentedControlDelegate {
  func didChangeTab(toIndex index: Int, isPageShowed: Bool) {
    if !isPageShowed {
      collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
    }
  }
}
