//
//  ArticlesListViewController.swift
//  Omnify Firebase
//
//  Created by Ashok Kumar S on 10/10/18.
//  Copyright © 2018 Omnify. All rights reserved.
//

import UIKit

class ArticlesListViewController: UIViewController {

    @IBOutlet weak var updatedDateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        NetworkManager.getTopStories()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ArticlesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticlesListTableViewCell {
            
            cell.commentsImageView.tintColor = UIColor(red: 1.0, green: 100.0/255.0, blue: 40.0/255.0, alpha: 1.0)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
