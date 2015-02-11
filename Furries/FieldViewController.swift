//
//  FieldViewController.swift
//  Furries
//
//  Created by yahoo on 2/10/15.
//  Copyright (c) 2015 yahoo. All rights reserved.
//

import UIKit

class FieldViewController: UIViewController {

	@IBOutlet weak var bunny: UIImageView!
	
	let MoveDuration = 0.25
	let MoveDistance: CGFloat = 20.0
	let MaxScale: CGFloat = 3
	let RotationIncrement: CGFloat = 10
	
	var bunnyScale: CGFloat = 1.0
	var bunnyRotation: CGFloat = 0
	var scaleTranform: CGAffineTransform!
	var rotationTranform: CGAffineTransform!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		scaleTranform = CGAffineTransformMakeScale(1, 1)
		rotationTranform = makeDegreeRotation(bunnyRotation)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func animateMove(x: CGFloat, y: CGFloat) {
		UIView.animateWithDuration(MoveDuration, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 20, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
			self.bunny.center.x += x * self.MoveDistance * self.bunnyScale
			self.bunny.center.y += y * self.MoveDistance * self.bunnyScale
			}, completion: nil)
	}
	
	@IBAction func onUpButton(sender: AnyObject) {
		animateMove(0, y: -1)
	}

	@IBAction func onRightButton(sender: AnyObject) {
		animateMove(1, y: 0)
	}
	
	@IBAction func onDownButton(sender: AnyObject) {
		animateMove(0, y: 1)
	}
	
	@IBAction func onLeftButton(sender: AnyObject) {
		animateMove(-1, y: 0)
	}
	
	func animateTransform(alpha: CGFloat, scale: CGFloat, rotation: CGFloat) {
		UIView.animateWithDuration(0.25, animations: { () -> Void in
			self.bunny.alpha = alpha
			self.scaleTranform = CGAffineTransformMakeScale(scale, scale)
			self.rotationTranform = makeDegreeRotation(rotation)
			self.bunny.transform = CGAffineTransformConcat(self.rotationTranform, self.scaleTranform)
		})
	}
	
	@IBAction func onShowButton(sender: AnyObject) {
		animateTransform(1, scale: bunnyScale, rotation: bunnyRotation)
	}
	
	@IBAction func onHideButton(sender: AnyObject) {
		animateTransform(0, scale: 0.1, rotation: bunnyRotation)
	}
	
	@IBAction func onLeafButton(sender: AnyObject) {
		bunnyScale = min(bunnyScale + 0.2, MaxScale)
		animateTransform(1, scale: bunnyScale, rotation: bunnyRotation)
	}
	
	@IBAction func onResetButton(sender: AnyObject) {
		bunnyScale = 1.0
		bunnyRotation = 0
		animateTransform(1, scale: bunnyScale, rotation: bunnyRotation)
	}
	
	@IBAction func onRotateLeft(sender: AnyObject) {
		bunnyRotation -= RotationIncrement
		animateTransform(1, scale: bunnyScale, rotation: bunnyRotation)
	}
	
	@IBAction func onRotateRight(sender: AnyObject) {
		bunnyRotation += RotationIncrement
		animateTransform(1, scale: bunnyScale, rotation: bunnyRotation)
	}
	
}
