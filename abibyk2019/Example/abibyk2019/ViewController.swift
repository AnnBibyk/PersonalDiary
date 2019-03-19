//
//  ViewController.swift
//  abibyk2019
//
//  Created by AnnBibyk on 01/24/2019.
//  Copyright (c) 2019 AnnBibyk. All rights reserved.
//

import UIKit
import CoreData
import abibyk2019

class ViewController: UIViewController {
    
    let articleManager = ArticleManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let article1 = articleManager.newArticle()
//        article1.title = "Article 1"
//        article1.content = "Content of Article 1"
//        article1.creation_date = NSDate()
//        article1.modification_date = NSDate()
//        article1.language = "en"
//        articleManager.save()
//
//        let article2 = articleManager.newArticle()
//        article2.title = "Article 2"
//        article2.content = "Content of Article 2"
//        article2.creation_date = NSDate()
//        article2.modification_date = NSDate()
//        article2.language = "en"
//        articleManager.save()
//
        let article3 = articleManager.newArticle()
        article3.title = "Article 3"
        article3.content = "Content of Article 3"
        article3.creation_date = NSDate()
        article3.modification_date = NSDate()
        article3.language = "en"
        articleManager.save()
        
        print(articleManager.getAllArticles())
    }
}

