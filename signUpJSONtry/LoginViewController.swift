//
//  LoginViewController.swift
//  signUpJSONtry
//
//  Created by Kanwar Sudeep Singh Sandhu on 20/04/18.
//  Copyright © 2018 Kanwar Sudeep Singh Sandhu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginScreenLabel: UILabel!
    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginScreenLabel.layer.masksToBounds = true
        loginScreenLabel.layer.cornerRadius = 7
        // Do any additional setup after loading the view.
        
        
        setupNavigationBar()
    }

    //MARK:- Setup navigation bar
    func setupNavigationBar() {
        
        self.navigationItem.title = "Login"
        
        self.navigationItem.hidesBackButton = true
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
    }
    
    @IBAction func signInWithGoogleButtonPressed(_ sender: Any) {
    }
    @IBAction func signUpButtonPressed(_ sender: Any) {
        let registrationVC = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        self.navigationController?.pushViewController(registrationVC, animated: true)
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
