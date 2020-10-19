//
//  OtherUserViewController.swift
//  Messager
//
//  Created by Hui on 2020/10/19.
//

import UIKit
import Firebase

class OtherUserViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {

    
  // data source of activities
    var activities = ["Swimming","Video Games","KTV","Hiking","Cycling","Movies","Skiing","Eating"]
    var imageofactivities = UIImage(named:"WechatIMG1.jpg")
    var joinedactivities = ["活动1","活动2","活动3","活动4","活动5","活动6","活动7"]
    var joinedimageofactivities = UIImage(named:"avatar")
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int?
        if tableView == self.firstView{
            count = activities.count
        }
        if tableView == self.secondView{
            count = joinedactivities.count
        }
        return count!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tableCell: UITableViewCell?
        if tableView == self.firstView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CreatedCell", for: indexPath) as! CreatedCell
            cell.createdActivity.text = activities[indexPath.row]
            cell.createdDate.text = "2020-11-09"
            cell.createdImage.image = imageofactivities
            tableCell = cell
        }
        if tableView == self.secondView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "JoinedCell", for: indexPath) as! JoinedCell
            cell.joinedActivity.text = joinedactivities[indexPath.row]
            cell.joinedDate.text = "2088-11-22"
            cell.joinedImage.image = joinedimageofactivities
            tableCell = cell
        }
        return tableCell ?? UITableViewCell()
    }

    
    // change table views in personal page
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var firstView: UITableView!
    @IBOutlet weak var secondView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBAction func changePage(_ sender: UISegmentedControl) {
        
        let x = CGFloat(sender.selectedSegmentIndex) * scrollView.bounds.width
        let offset = CGPoint(x: x, y: 0)
        scrollView.setContentOffset(offset, animated: true)
    }

    //automatically update segment index
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let index = Int(scrollView.contentOffset.x / firstView.bounds.width)
            print(segmentedControl.selectedSegmentIndex)
            print(scrollView.contentOffset.x)
            segmentedControl.selectedSegmentIndex = index
            print(segmentedControl.selectedSegmentIndex)
            print(scrollView.contentOffset.x)

    }
    
    @IBOutlet weak var PhotoContainer: UIView!
    private func setUI(){
    //    PhotoContainer.layer.cornerRadius = PhotoContainer.frame.size.width / 2
    //    PhotoContainer.clipsToBounds = true
    //    firstView.layer.cornerRadius = 20
    //    firstView.clipsToBounds = true
    //    secondView.layer.cornerRadius = 20
    //    secondView.clipsToBounds = true
    }
    //  Hide First Page NavigationBar
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
          navigationController?.setNavigationBarHidden(false, animated: true)
          super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setUI()
        //Fatal error: Unexpectedly found nil while implicitly unwrapping an Optional value: file
        // Do any additional setup after loading the view.
    }
    
    }