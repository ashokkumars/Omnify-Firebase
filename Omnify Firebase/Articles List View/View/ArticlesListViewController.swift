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
    
    var presenter: ArticlesListViewPresenter? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = ArticlesListViewPresenter(delegate: self)
        
        if let presenter_ = presenter {
            
            presenter_.getTopStories { (articles, error) in
                debugPrint(articles ?? "No Articles found")
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        
    }

    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ArticlesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.articlesDatasource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticlesListTableViewCell, let article = presenter?.articlesDatasource?[indexPath.row] {
            
            cell.scoreLabel.text = "\(article.score)"
            cell.titleLabel.text = article.title ?? " "
            cell.commentsCountLabel.text = "\(article.descendants)"
            cell.domainLabel.text = article.url
            cell.updatedInfoLabel.text = presenter?.getUpdatedInformation(for: article)
            cell.commentsImageView.tintColor = UIColor(red: 1.0, green: 100.0/255.0, blue: 40.0/255.0, alpha: 1.0)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        performSegue(withIdentifier: "ArticleDetailView", sender: indexPath)
    }
}

extension ArticlesListViewController: ArticlesPresenterDelegate {
    
}
