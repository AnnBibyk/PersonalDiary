//
//  ArticleViewController.swift
//  d09
//
//  Created by Anna BIBYK on 26.01.2019.
//  Copyright © 2019 Anna BIBYK. All rights reserved.
//

import UIKit
import abibyk2019

class ArticleViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var newPostTitle: UITextField!
    
    @IBOutlet weak var newPostImage: UIImageView!
    
    @IBOutlet weak var newPostContent: UITextView!
    
    let pickerController = UIImagePickerController()
    var articleManager : ArticleManager?
    let language = NSLocale.preferredLanguages.first
    var article: Article?
    var reloadData: Bool = false
    
    @IBAction func takePicture(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            pickerController.sourceType = .camera
            present(pickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func choosePicture(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            pickerController.sourceType = .photoLibrary
            present(pickerController, animated: true, completion: nil)
        }
    }
    
    @objc func saveButton() {
        if newPostTitle.text == nil || newPostTitle.text == "" {
            alert(message: "Can't save without a title!")
            return
        }
        if article == nil {
            article = articleManager!.newArticle()
            article!.creation_date = NSDate()
            article!.language = language
        } else {
            article!.modification_date = NSDate()
        }
        article!.title = newPostTitle.text
        article!.content = newPostContent.text
        if newPostImage.image != nil {
            article!.image = UIImagePNGRepresentation(newPostImage.image!)! as NSData
        }
        articleManager!.save()
        reloadData = true
        performSegue(withIdentifier: "Back", sender: self)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            newPostImage.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func alert (message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(ArticleViewController.saveButton))
        pickerController.delegate = self
        if article != nil {
            newPostTitle.text = article!.title
            newPostContent.text = article!.content
            if article!.image != nil {
                newPostImage.image = UIImage(data: article!.image! as Data)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Back" {
            if let vc = segue.destination as? TableViewController {
                     vc.reloadData = reloadData
                }
            }
    }

}
