//
//  LoginViewController.swift
//  signUpJSONtry
//
//  Created by Kanwar Sudeep Singh Sandhu on 20/04/18.
//  Copyright © 2018 Kanwar Sudeep Singh Sandhu. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginViewController: UIViewController {

   
    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
       
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
    
        SVProgressHUD.show()
        
        let myUrl = URL(string: "http://192.168.7.92:8080/login")
        var request = URLRequest(url: myUrl!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // create params to send to web services
        let postParams = ["emailid": emailIdTextField.text!, "password": passwordTextField.text!]
        
        // change params to json format
        do {
            try request.httpBody = try JSONSerialization.data(withJSONObject: postParams, options: .prettyPrinted)
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
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                    print(json)
                    if (json["code"] as! String == "1"){
                      let userId = json["userid"] as! Int
                        UserDefaults.standard.set(userId, forKey: "userid")
                        let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeScreenViewController") as! HomeScreenViewController
                        self.navigationController?.pushViewController(homeViewController, animated: true)
                        
                    } else if (json["code"] as! String == "0"){
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
    
    @IBAction func signInWithGoogleButtonPressed(_ sender: Any) {
    }
    @IBAction func signUpButtonPressed(_ sender: Any) {
        let registrationVC = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        self.navigationController?.pushViewController(registrationVC, animated: true)
    }
    
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
    
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
