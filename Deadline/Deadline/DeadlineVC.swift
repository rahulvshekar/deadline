//
//  DeadlineVC.swift
//  Deadline
//
//  Created by Rahul V. Shekar on 10/07/17.
//  Copyright © 2017 Rahul V. Shekar. All rights reserved.
//

import UIKit

class DeadlineVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newDeadlineButton: UIButton!
    @IBOutlet weak var newDeadlineView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNewDeadlineView()
    }
    
    func setupNewDeadlineView() {
        setupNormalShadow()
    
    }
    
    func setupNormalShadow() {
        newDeadlineView.layer.shadowColor = UIColor.black.cgColor
        newDeadlineView.layer.shadowOffset = CGSize(width: 0, height: -2)
        newDeadlineView.layer.shadowOpacity = 0.5
        newDeadlineView.layer.shadowRadius = 6
    }
    
    func setupDepressedShadow() {
        newDeadlineView.layer.shadowColor = UIColor.black.cgColor
        newDeadlineView.layer.shadowOffset = CGSize(width: 0, height: 0)
        newDeadlineView.layer.shadowOpacity = 0.8
        newDeadlineView.layer.shadowRadius = 3
    }
    
    
    func getOpacity(_ forIndexPath: IndexPath) -> Double {
        let maxOpacity = 1.0
        let leastOpacity = 0.2
        let range = maxOpacity - leastOpacity
        let numberOfRows = tableView.numberOfRows(inSection: 0)
        let incrementOpacity = range/Double(numberOfRows)
        let presentRowOpacity = 1.0 - (Double(forIndexPath.row)*(incrementOpacity))
        return presentRowOpacity
    }
    
    @IBAction func newDeadlineButtonClicked(_ sender: Any) {
        setupNormalShadow()
        UIView.animate(withDuration: 0.25, animations: {
            self.newDeadlineView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    @IBAction func newDeadlineButtonTouchDown(_ sender: Any) {
        setupDepressedShadow()
        UIView.animate(withDuration: 0.25, animations: { 
            self.newDeadlineView.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
        }, completion: nil)
    }
    
    @IBAction func newDeadlineButtonTouchDragExit(_ sender: Any) {
        setupNormalShadow()
        UIView.animate(withDuration: 0.25, animations: {
            self.newDeadlineView.transform = CGAffineTransform.identity
        }, completion: nil)
    }

}

extension DeadlineVC: UITableViewDataSource, UITableViewDelegate {
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "DeadlineCell", bundle: nil), forCellReuseIdentifier: "DeadlineCell")
        tableView.rowHeight = 64
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 20
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeadlineCell", for: indexPath)
        if let deadlineCell = cell as? DeadlineCell {
            deadlineCell.nameLabel.text = "Rahul"
            deadlineCell.dateLabel.text = "6th September, 1999"
            let alpha = CGFloat(getOpacity(indexPath))
            print(alpha)
            deadlineCell.colorView.alpha = alpha
        }
        return cell
    }
    
    
}

extension DeadlineVC {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
