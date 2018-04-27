//
//  WelcomeViewController.swift
//  signUpJSONtry
//
//  Created by Kanwar Sudeep Singh Sandhu on 20/04/18.
//  Copyright © 2018 Kanwar Sudeep Singh Sandhu. All rights reserved.
//

import UIKit
import SVProgressHUD
import GoogleSignIn

class RegistrationViewController: UIViewController {

    //MARK:- declaration & outlets
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        // Do any additional setup after loading the view.
        
        setupNavigationBar()
    }

    
    //MARK:- Setup navigation bar and navigation title
    func setupNavigationBar() {
    self.navigationItem.title = "Registration"
        
      //  self.navigationItem.hidesBackButton = true
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
       // dismiss the registration screen and send to last screen which in this case is login view controller
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK:- Signup with Google
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error{
            print("\(error.localizedDescription)")
        }else{
            print(user.profile.email)
            print(user.userID)
            print(user.profile.familyName)
            print(user.profile.givenName)
            print(user.authentication.idToken)
            
            // call performJSOn method and pass postPARAM parameters in form of dictionary filled with  detail from google
            performJSON(postParam : ["firstname": user.profile.givenName, "lastname": user.profile.familyName, "emailid": user.profile.email, "googleId": user.userID, "type": "google", "tokeid":user.authentication.idToken])
            
            // signout of google after taing the parameters
            GIDSignIn.sharedInstance().signOut()
            

        }
    }
    //MARK:- sign up button pressed
    @IBAction func SignUpAcceptTermsButtonPressed(_ sender: Any) {
        
        if (firstNameTextField.text?.isEmpty)! ||
        (lastNameTextField.text?.isEmpty)! ||
        (phoneNumberTextField.text?.isEmpty)! ||
        (emailIdTextField.text?.isEmpty)! ||
            (passwordTextField.text?.isEmpty)! {
            // return a error message
            displayMessage(userMessage: "All fields must be filled")
            return
        }
        if
            ((passwordTextField.text?.elementsEqual(passwordCheckTextField.text!))! != true)
        {
            // return a error message
            displayMessage(userMessage: "Passwords should match")
            return
        }
       
// call performJSOn method and pass postPARAM parameters in form of dictionary filled manually
        performJSON(postParam : ["firstname": firstNameTextField.text!, "lastname": lastNameTextField.text!, "emailid": emailIdTextField.text!, "password": passwordTextField.text!, "phoneno": phoneNumberTextField.text!, "type": "manual"])
        
        
        
        
    }
    @IBAction func terms(_ sender: Any) {
    }
   
    
    @IBAction func SignUpWithGoogleButtonPressed(_ sender: Any) {
        
        GIDSignIn.sharedInstance().signIn()
        
        
    }
    
    
    
    func displayMessage(userMessage : String) -> Void {
        let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            print("ok button pressed")
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
        alertController.addAction(OKAction)
        
        DispatchQueue.main.async {
            
            self.present(alertController, animated: true , completion: nil)
        }
        
        
    }
    
    func performJSON(postParam: NSDictionary){
        SVProgressHUD.show()
        
        let myURL = URL(string: "http://192.168.7.92:8080/signup")
        var request = URLRequest(url: myURL!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: postParam, options: .prettyPrinted)
        } catch let error{
            print(error.localizedDescription)
            displayMessage(userMessage: "Something went wrong")
            return
        }
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            
            DispatchQueue.main.async {
                
                SVProgressHUD.dismiss()
                if error != nil {
                    self.displayMessage(userMessage: "could not perform request. Please try later")
                    print("error = \(String(describing: error))")
                    return
                }
             do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                    print(json)
                    
                    if(json["messageCode"] as! Int == 1){ // Signup done
                        
                        let userId = json["userid"] as! Int
                        
                        UserDefaults.standard.set(userId, forKey: "userid")
                        
                        
                        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeScreenViewController") as! HomeScreenViewController
                        
                        self.navigationController?.pushViewController(homeVC, animated: true)
                        
                        //  self.present(homeVC, animated: true)
                        
                    }
                    else if(json["messageCode"] as! Int == 0){   // user already exists
                        
                        self.displayMessage(userMessage: "User is already exist")
                    }
                    else{
                        
                        self.displayMessage(userMessage: "Could not register. try again later")
                        
                    }
                    
                } catch{
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

