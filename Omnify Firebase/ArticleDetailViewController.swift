//
//  ArticleDetailViewController.swift
//  Omnify Firebase
//
//  Created by Ashok Kumar on 2018-10-11.
//  Copyright © 2018 Omnify. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 1.0, green: 100.0/255.0, blue: 40.0/255.0, alpha: 1.0)
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
