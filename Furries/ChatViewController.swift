//
//  ChatViewController.swift
//  Furries
//
//  Created by yahoo on 2/16/15.
//  Copyright (c) 2015 yahoo. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITextFieldDelegate {

	@IBOutlet weak var messageField: UITextField!
	@IBOutlet weak var sentMessageLabel: UILabel!
	@IBOutlet weak var responseLabel: UILabel!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!

	let Responses: [String:[String]] = [
		"will you be my friend?": [
			"*rolls eyes*",
			"Ummm.... no",
			"Yeeaaaaaah..."
		],
		"what is your name?": [
			"Who's asking?!?",
			"Abrasive Bunny"
		]
	]

    override func viewDidLoad() {
        super.viewDidLoad()
		
		messageField.becomeFirstResponder()
		messageField.delegate = self
		
		activityIndicator.stopAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func onSend(sender: AnyObject) {
		sendMessage()
	}
	
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		sendMessage()
		
		return false
	}

	func sendMessage() {
		var message = messageField.text
		var response = ""
		
		sentMessageLabel.text = message
		messageField.text = ""
		responseLabel.text = ""
		
		if var responses = Responses[message.lowercaseString] {
			response = responses[Int(arc4random_uniform(UInt32(responses.count)))]
		} else {
			response = "Huh? What?"
		}

		activityIndicator.startAnimating()

		delay(1, { () -> () in
			self.responseLabel.text = response
			self.activityIndicator.stopAnimating()
		})
	}
}
