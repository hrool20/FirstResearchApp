//
//  SegmentedControlWithTableViewCollectionViewController.swift
//  MyResearchApp
//
//  Created by Hugo Rosado on 1/2/20.
//  Copyright © 2020 UPC. All rights reserved.
//

import UIKit

private let reuseIdentifier = "firstCell"

class SegmentedControlWithTableViewCollectionViewController: UICollectionViewController {
  
  private var viewControllers: [UIViewController]!
  private var secondSegmentedControl: SecondSegmentedControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewControllers = [
      UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "VCWithTableViewController"),
      UIViewController()
    ]
    secondSegmentedControl = SecondSegmentedControl.get(owner: self)
    
    if let flowLayout = self.collectionViewLayout as? UICollectionViewFlowLayout {
      flowLayout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    self.collectionView.register(SecondSegmentedControl.getNIB(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
    
    // Do any additional setup after loading the view.
  }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
  }
  
  // MARK: UICollectionViewDataSource
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewControllers.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SegmentedControlWithTableViewCollectionViewCell
    cell.backgroundColor = .orange
    cell.selectedViewController = viewControllers[indexPath.row]
    
    return cell
  }
  
}
extension SegmentedControlWithTableViewCollectionViewController: UICollectionViewDelegateFlowLayout {
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    switch kind {
    case UICollectionView.elementKindSectionHeader:
      let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath) as! SecondSegmentedControl
      headerView.delegate = self
      headerView.tabs = [
        "1st VC",
        "2nd VC"/*,
        "3rd VC"*/
      ]
      
      return headerView
    default:
      return UICollectionReusableView(frame: .zero)
    }
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return secondSegmentedControl.bounds.size
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: UIScreen.main.bounds.width, height: collectionView.bounds.height - self.navigationController!.navigationBar.bounds.height - secondSegmentedControl.bounds.height)
  }
}
extension SegmentedControlWithTableViewCollectionViewController: SecondSegmentedControlDelegate {
  func didChangeTab(toIndex index: Int, isPageShowed: Bool) {
    collectionView.reloadData()
  }
}
