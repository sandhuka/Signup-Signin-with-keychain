//
//  LoginViewController.swift
//  signUpJSONtry
//
//  Created by Kanwar Sudeep Singh Sandhu on 20/04/18.
//  Copyright © 2018 Kanwar Sudeep Singh Sandhu. All rights reserved.
//

import UIKit
import SVProgressHUD
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
   
    // google signin func
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error{
            print("\(error.localizedDescription)")
        }else
        {
            print(user.profile.email)
            print(user.userID)
            print(user.profile.familyName)
            print(user.profile.givenName)
            print(user.authentication.idToken)
            
            performjson(postParams: ["emailId": user.profile.email, "googleId": user.userID, "type": "google"])
            
            
            GIDSignIn.sharedInstance().signOut()
        }
    }

    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        self.hideKeyboard()
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
    
    
    
    //MARK:- Submit button pressed for login
    @IBAction func submitButtonPressed(_ sender: Any) {
        
        if (emailIdTextField.text?.isEmpty)! ||
            (passwordTextField.text?.isEmpty)!{
            displayMessage(userMessage: "Please fill all the fields")
            return
        }
 // call perform json func
        performjson(postParams: ["emailId": emailIdTextField.text!, "password": passwordTextField.text!, "type": "manual"])
        
    }
    
    //MARK:- sign up button pressed
    @IBAction func signUpButtonPressed(_ sender: Any) {
        let registrationVC = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        self.navigationController?.pushViewController(registrationVC, animated: true)
    }
    
    //MARK:- method to display alert message
    func displayMessage(userMessage: String) -> Void  {
        
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default) { (action : UIAlertAction) in
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
        alert.addAction(alertAction)
        
        DispatchQueue.main.async {
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    //MARK:- sign in with google button
    
    @IBAction func signInWithGoogle(_ sender: Any) {
       // call google sign method declared above
        GIDSignIn.sharedInstance().signIn()
    }
    //MARK:- Perform JSON paring (POST)
    func performjson(postParams: NSDictionary) {
       // Pgrogress bar initiallized
        SVProgressHUD.show()
        
        let myUrl = URL(string: "http://192.168.7.92:8080/login")
        var request = URLRequest(url: myUrl!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // change params to json format
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: postParams, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            displayMessage(userMessage: "Error in serialization of data to be sent")
            return
        }
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                if error != nil {
                    self.displayMessage(userMessage: "Something wrong in fetching the data")
                    print("Error: \(String(describing:error)) ")
                    return
                }
                do{
                    // Json serialization to change format of data from JSON file to dictionary
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                    //print(json)
                    if (json["messageCode"] as! String == "1"){
                        let userId = json["userid"] as! Int
                        UserDefaults.standard.set(userId, forKey: "userid")
                        print(userId)
                        let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeScreenViewController") as! HomeScreenViewController
                        self.navigationController?.pushViewController(homeViewController, animated: true)
                        
                    } else if (json["messageCode"] as! String == "0"){
                        self.displayMessage(userMessage: "Login not successful")
                      }
                    
                }
                catch{
                    // SVProgressHUD.dismiss()
                    self.displayMessage(userMessage: "Could not register. try again later")
                    
                }
                
            }
        }
        task.resume()
        
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
