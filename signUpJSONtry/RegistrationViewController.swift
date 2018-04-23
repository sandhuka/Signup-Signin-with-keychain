//
//  WelcomeViewController.swift
//  signUpJSONtry
//
//  Created by Kanwar Sudeep Singh Sandhu on 20/04/18.
//  Copyright © 2018 Kanwar Sudeep Singh Sandhu. All rights reserved.
//

import UIKit
import SVProgressHUD


class RegistrationViewController: UIViewController {

    @IBOutlet weak var registrationScreenLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        registrationScreenLabel.layer.masksToBounds = true
        registrationScreenLabel.layer.cornerRadius = 7
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
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
        SVProgressHUD.show()
        
        let myURL = URL(string: "http://localhost:8080/signup")
        var request = URLRequest(url: myURL!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let postString = ["firstname": firstNameTextField.text!, "lastname": lastNameTextField.text!, "emailid": emailIdTextField.text!, "password": passwordTextField.text!, "phoneno": phoneNumberTextField.text!] as [String: String]
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
        } catch let error{
            print(error.localizedDescription)
            displayMessage(userMessage: "Something went wrong")
            return
        }
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
          SVProgressHUD.dismiss()
            if error != nil {
                self.displayMessage(userMessage: "could not perform request. Please try later")
                print("error = \(String(describing: error))")
                return
        }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? Dictionary<String, String>
                
                if let parseJSON = json {
                    let userId = parseJSON["userid"] as String?
                    print("User ID: \(String(describing: userId!))")
//                    let message = parseJSON["code"] as String?
//                    print("Code : \(String(describing: message))")
                    
                    if (userId?.isEmpty)!{
                    self.displayMessage(userMessage: "user id empty")
                        return
//                    }else if (message == "200") {
//                        self.displayMessage(userMessage: "user registered successfully")
//                        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeScreenViewController") as! HomeScreenViewController
//                        self.present(homeVC, animated: true)
                        
                    }
                }else {
                    self.displayMessage(userMessage: "Could not register. try again later")
                }
                
            } catch{
                SVProgressHUD.dismiss()
                self.displayMessage(userMessage: "Could not register. try again later")
                
            }
    }
        task.resume()
        
        
        
        
        
        
        
    }
    @IBAction func terms(_ sender: Any) {
    }
   
    
    @IBAction func SignUpWithGoogleButtonPressed(_ sender: Any) {
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
        self.present(alertController, animated: true , completion: nil)
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
