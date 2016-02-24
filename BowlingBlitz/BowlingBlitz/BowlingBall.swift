//
//  BowlingBall.swift
//  BowlingBlitz
//
//  Created by Louis Smidt on 1/29/16.
//
//

import Foundation
import UIKit

class BowlingBall:UIImageView {
    
    let pic = UIImage(named: "Ball")
     var speed:Double = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(image: pic)
    }
    
    init (sp:Double)
    {
        super.init(image: pic)
        self.speed = sp
    }
    
   
    
    
    init (s:Double)
    {
        super.init(image: pic)
        self.speed = s;
        self.center = CGPointMake(100, 100)
  }

    
    func reset()
    {
        self.center.x = CGFloat (Int(arc4random_uniform(50) + 50) * -1)
    }
   
    
    func move()
    {
        self.center.x += CGFloat(speed)
    }
}
