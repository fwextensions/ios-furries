//
//  utils.swift
//  Furries
//
//  Created by yahoo on 2/10/15.
//  Copyright (c) 2015 yahoo. All rights reserved.
//

import UIKit

func makeDegreeRotation(rotation: CGFloat) -> CGAffineTransform {
	return CGAffineTransformMakeRotation(rotation * CGFloat(M_PI / 180))
}
