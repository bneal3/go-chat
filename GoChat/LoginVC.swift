//
//  LoginVC.swift
//  GoChat
//
//  Created by Benjamin Neal on 1/25/17.
//  Copyright © 2017 Benjamin Neal. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class LoginVC: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {

    @IBOutlet weak var anonymousBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        anonymousBtn.layer.borderWidth = 2.0
        anonymousBtn.layer.borderColor = UIColor.white.cgColor
        
        GIDSignIn.sharedInstance().clientID = "153702067834-3u5so288oec62lmc1ajc9dkqm6vkvcmn.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(FIRAuth.auth()?.currentUser)
        
        FIRAuth.auth()?.addStateDidChangeListener({ (auth: FIRAuth, user: FIRUser?) in
            if user != nil {
                print(user)
                Helper.helper.goToChatViewController()
            } else {
                print("Unauthorized")
            }
        })
    }
    
    @IBAction func loginAnonymouslyTapped(_ sender: UIButton) {
        Helper.helper.loginAnonymously()
    }

    @IBAction func googleLoginTapped(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            print(error!.localizedDescription)
            return
        }
        
        print(user.authentication)
        Helper.helper.loginWithGoogle(authentication: user.authentication)
    }
}
