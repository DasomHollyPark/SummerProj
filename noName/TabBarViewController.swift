//
//  TabBarViewController.swift
//  noName
//
//  Created by DasomPark on 7/23/15.
//  Copyright (c) 2015 Dasom. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    @IBOutlet weak var topTabBar: UITabBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        topTabBar.frame = CGRectMake(0, 20, 375, 0)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
