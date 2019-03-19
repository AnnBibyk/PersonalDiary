//
//  TableViewController.swift
//  d09
//
//  Created by Anna BIBYK on 26.01.2019.
//  Copyright © 2019 Anna BIBYK. All rights reserved.
//

import UIKit
import abibyk2019

class TableViewController: UITableViewController {

    let articleManager = ArticleManager()
    var articles: [Article] = []
    var reloadData: Bool = false
    let language = NSLocale.preferredLanguages.first
    var articleDel: Article? = nil
    
    @IBOutlet var tabArticle: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadArticles()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
         return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return articles.count
    }
    
    func loadArticles() {
        articles = []
        articles = articleManager.getArticles(withLang: language!)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.postTitle.text = articles[indexPath.row].title
        if articles[indexPath.row].image != nil {
            let image = UIImage(data: articles[indexPath.row].image! as Data)
            cell.postImage.image = image
            cell.postImage.isHidden = false
        } else {
            cell.postImage.isHidden = true
        }
        cell.content.text = articles[indexPath.row].content
        let date = DateFormatter()
        date.locale = Locale(identifier: language!)
        date.setLocalizedDateFormatFromTemplate("MMM dd, YYYY 'at' HH:mm")
        cell.createdAt.text = "Creation: \(date.string(from: articles[indexPath.row].creation_date! as Date))"
        if articles[indexPath.row].modification_date != nil {
            cell.updatedAt.text = "Modification: \(date.string(from: articles[indexPath.row].modification_date! as Date))"
            cell.updatedAt.isHidden = false
        } else {
            cell.updatedAt.isHidden = true
        }
        return cell
    }
    
    internal override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Modify", sender: indexPath.row)
    }

      @IBAction func unWindsegue(segue: UIStoryboardSegue) {
        if reloadData {
            print("reloaded")
            loadArticles()
            tabArticle.reloadData()
        }
     }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Modify" {
            if let vc = segue.destination as? ArticleViewController {
                let row = sender as! Int
                vc.articleManager = articleManager
                print(articles[row].title!)
                vc.article = articles[row]
            }
        } else if segue.identifier == "Creation" {
            if let vc = segue.destination as? ArticleViewController {
                vc.articleManager = articleManager
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            articleDel = articles[indexPath.row]
            confirmDelete(article: articleDel!.title!)
        }
    }
    
    func confirmDelete(article: String) {
        let alert = UIAlertController(title: "Delete article", message: "Are you sure you want to delete \(article)?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: handleDeleteArticle)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelDeleteArticle)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func handleDeleteArticle(alertAction: UIAlertAction!) -> Void {
        articleManager.removeArticle(article: articleDel!)
        loadArticles()
        tabArticle.reloadData()
        articleDel = nil
    }
    
    func cancelDeleteArticle(alertAction: UIAlertAction!) {
        articleDel = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
