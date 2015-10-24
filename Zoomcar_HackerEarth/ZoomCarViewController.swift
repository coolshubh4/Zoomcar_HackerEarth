//
//  ViewController.swift
//  Zoomcar_HackerEarth
//
//  Created by Shubham Tripathi on 19/09/15.
//  Copyright © 2015 coolshubh4. All rights reserved.
//

import UIKit

class ZoomCarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var carTableView: UITableView!
    @IBOutlet weak var totalCars: UILabel!
    //var cars = [Car]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carTableView.delegate = self
        carTableView.dataSource = self
        
        ZHEClient.sharedInstance().getCarsDetails() { success, errorString in
            if errorString != nil {
                print(errorString)
            } else {
                print("inside viewDidLoad - \(ZHEClient.sharedInstance().carData.count)")
                dispatch_async(dispatch_get_main_queue()) {
                    self.carTableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("inside numberOfRowsInSection rows - \(ZHEClient.sharedInstance().carData.count)")
        return ZHEClient.sharedInstance().carData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("inside cellForRowAtIndexPath")
        let cell = tableView.dequeueReusableCellWithIdentifier("CarListingsTableViewCell") as! CarListingsTableViewCell
        let car = ZHEClient.sharedInstance().carData[indexPath.row]
        print("inside cellForRowAtIndexPath, car - \(car)")
        cell.carName?.text = car.name
        cell.hourlyRate?.text = "\(car.hourlyRate!) per hr"
        cell.rating?.text = "Rating: \(car.rating!)"
        cell.carImage.image = UIImage(named: "car")
        totalCars.text = String(ZHEClient.sharedInstance().carData.count)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let controller = storyboard?.instantiateViewControllerWithIdentifier("BookingDetailViewController") as! BookingDetailViewController
        controller.carToBeBooked = ZHEClient.sharedInstance().carData[indexPath.row]
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

