//
//  ViewController.swift
//  d09
//
//  Created by Anna BIBYK on 26.01.2019.
//  Copyright © 2019 Anna BIBYK. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Loaded")
        authenticateUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func alert (message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func authenticateUser() {
        let context = LAContext()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: NSLocalizedString("Identify yourself!", comment: ""), reply: { (success, error) in
                if success {
                    print("Success")
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "Diary", sender: nil)
                    }
                } else {
                    print("Fail")
                    DispatchQueue.main.async {
                        self.alert(message: NSLocalizedString("Authentification failed!", comment: ""))
                        self.authenticateUser()
                    }
                }
            })
        }
    }
}

