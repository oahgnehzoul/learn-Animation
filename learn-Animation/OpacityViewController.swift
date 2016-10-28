//
//  OpacityViewController.swift
//  learn-Animation
//
//  Created by oahgnehzoul on 2016/10/28.
//  Copyright © 2016年 llzzzhh. All rights reserved.
//

import UIKit

class OpacityViewController: UIViewController {

    @IBOutlet weak var orangeSquare: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1) { 
            self.orangeSquare.alpha = 0.1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
