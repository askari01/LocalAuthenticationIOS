//
//  ViewController.swift
//  LocalAuthenticationIOS
//
//  Created by Syed Askari on 27/12/2016.
//  Copyright © 2016 Syed Askari. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        authenticateUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func authenticateUser() {
        print ("hello")
        let context = LAContext()
        
        var error: NSError?
        
        let reasonString = "Authentication is needed to login"
        
        if (context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error)) {
            context .evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success, error) in
                print ("result")
                if (success) {
                    print("Auth was OK")
                    self.performSegue(withIdentifier: "Pass", sender: self)
                }
                else
                {
                    //You should do better handling of error here but I'm being lazy
                    print("Error received: %d", error!)
                }
            })
        } else{
            // If the security policy cannot be evaluated then show a short message depending on the error.
            
            // Show the custom alert view to allow users to enter the password.
            self.showPasswordAlert()
        }
    }
    
    func showPasswordAlert() {
        let alertController = UIAlertController(title: "Auth Status", message: "Auth is not activated", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }

}

