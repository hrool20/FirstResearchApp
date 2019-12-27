//
//  VCWithTableViewController.swift
//  MyResearchApp
//
//  Created by Hugo Rosado on 12/20/19.
//  Copyright © 2019 UPC. All rights reserved.
//

import UIKit

class VCWithTableViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  private var array: [String]!
  private var headerView: Example1TableHeaderView!
  private var imageHeight: CGFloat!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    array = []
    imageHeight = 300
    
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    tableView.tableFooterView = UIView()
    
    headerView = Example1TableHeaderView.get(owner: self)
    headerView.frame = CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: imageHeight))
    let view = UIView(frame: headerView.frame)
    view.addSubview(headerView)
    tableView.tableHeaderView = view
    
    for i in 0..<20 {
      array.append("Title \(i + 1)")
    }
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    print("sv_y: \(scrollView.contentOffset.y)")
    headerView.frame = CGRect(x: 0, y: scrollView.contentOffset.y, width: UIScreen.main.bounds.width, height: imageHeight - scrollView.contentOffset.y)
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
extension VCWithTableViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return array.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as UITableViewCell

    cell.textLabel?.text = array[indexPath.row]

    return cell
  }
}
