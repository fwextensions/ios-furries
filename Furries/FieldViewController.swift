//
//  FieldViewController.swift
//  Furries
//
//  Created by yahoo on 2/10/15.
//  Copyright (c) 2015 yahoo. All rights reserved.
//

import UIKit

class FieldViewController: UIViewController, UIScrollViewDelegate {

	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var bunny: UIImageView!
	@IBOutlet weak var field: UIImageView!
	
	let MoveDuration = 0.25
	let MoveDistance: CGFloat = 20.0
	let MaxScale: CGFloat = 3
	let MinScale: CGFloat = 0.5
	let ScaleIncrement: CGFloat = 0.2
	let RotationIncrement: CGFloat = 10
	let MoveButtonDirections: [Int:[CGFloat]] = [
			1: [0, -1],
			2: [1, 0],
			3: [0, 1],
			4: [-1, 0],
		]
	
	var bunnyScale: CGFloat = 1.0
	var bunnyRotation: CGFloat = 0
	var scaleTranform: CGAffineTransform!
	var rotationTranform: CGAffineTransform!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		scaleTranform = CGAffineTransformMakeScale(1, 1)
		rotationTranform = makeDegreeRotation(bunnyRotation)
		scrollView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	@IBAction func onMoveButton(sender: AnyObject) {
		animateMove(MoveButtonDirections[sender.tag]!)
	}
	
	@IBAction func onShowButton(sender: AnyObject) {
		animateTransform(1, scale: bunnyScale, rotation: bunnyRotation)
	}
	
	@IBAction func onHideButton(sender: AnyObject) {
		animateTransform(0, scale: 0.1, rotation: bunnyRotation)
	}
	
	@IBAction func onLeafButton(sender: AnyObject) {
		scaleBunny(ScaleIncrement)
	}
	
	@IBAction func onTearButton(sender: AnyObject) {
		scaleBunny(-ScaleIncrement)
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
	
	@IBAction func onFieldTap(sender: UITapGestureRecognizer) {
		var moveTo:CGPoint = sender.locationInView(view)
		UIView.animateWithDuration(0.25, animations: { () -> Void in
			self.bunny.center = moveTo
		})
	}
	
	@IBAction func onBunnyPan(sender: UIPanGestureRecognizer) {
		bunny.center = sender.locationInView(view)
	}
	
	func scrollViewDidScroll(scrollView: UIScrollView) {
		field.frame.origin.y = scrollView.contentOffset.y / 5
	}
	
	func animateMove(directions: [CGFloat]) {
		UIView.animateWithDuration(MoveDuration, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 20, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
			self.bunny.center.x += directions[0] * self.MoveDistance * self.bunnyScale
			self.bunny.center.y += directions[1] * self.MoveDistance * self.bunnyScale
			}, completion: nil)
	}
	
	func animateTransform(alpha: CGFloat, scale: CGFloat, rotation: CGFloat) {
		UIView.animateWithDuration(0.25, animations: { () -> Void in
			self.bunny.alpha = alpha
			self.scaleTranform = CGAffineTransformMakeScale(scale, scale)
			self.rotationTranform = makeDegreeRotation(rotation)
			self.bunny.transform = CGAffineTransformConcat(self.rotationTranform, self.scaleTranform)
		})
	}
	
	func scaleBunny(amount: CGFloat) {
		bunnyScale = max(min(bunnyScale + amount, MaxScale), MinScale)
		animateTransform(1, scale: bunnyScale, rotation: bunnyRotation)
	}
}
