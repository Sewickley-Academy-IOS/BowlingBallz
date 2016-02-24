//
//  GameViewController.swift
//  BowlingBlitz
//
//  Created by Louis Smidt on 1/12/16.
//
//

import UIKit

class GameViewController: UIViewController {
    
    
    @IBOutlet weak var ant1: UIImageView!

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var game_over_label: UILabel!
    
    @IBOutlet weak var play_again_button: UIButton!

    var collided: Bool = false
    var antX = 153
    var antY = 552
    
    var score = 0.0
    
    var BowlingBalls: [BowlingBall] = []
 
    
    
    
    @IBOutlet weak var Ball1: BowlingBall! = BowlingBall(s: 1)
    @IBOutlet weak var Ball2: BowlingBall! = BowlingBall(s: 2)
    @IBOutlet weak var Ball3: BowlingBall! = BowlingBall(s: 3)
    @IBOutlet weak var Ball4: BowlingBall! = BowlingBall(s: 4)
    @IBOutlet weak var Ball5: BowlingBall! = BowlingBall(s: 5)
    @IBOutlet weak var Ball6: BowlingBall! = BowlingBall(s: 6)
    @IBOutlet weak var Ball7: BowlingBall! = BowlingBall(s: 7)
    
    
    
    
    
    var timer = NSTimer()
    var scoreTimer = NSTimer()
    
    
    override func viewDidLoad() {
        
       // let upSwipe: UISwipeGestureRecognizer
        let upSwipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer.init(target: self, action: "moveUp")
        let downSwipe :UISwipeGestureRecognizer = UISwipeGestureRecognizer.init(target: self, action: "moveDown")
        let leftSwipe : UISwipeGestureRecognizer = UISwipeGestureRecognizer.init(target: self, action: "moveLeft")
        let rightSwipe : UISwipeGestureRecognizer = UISwipeGestureRecognizer.init(target: self, action: "moveRight")
        
        //upSwipe.direction = .Up
        upSwipe.direction = .Up
        leftSwipe.direction = .Left
        downSwipe.direction = .Down
        rightSwipe.direction = .Right
        
       // self.view.addGestureRecognizer(upSwipe)
        self.view.addGestureRecognizer(upSwipe)
        self.view.addGestureRecognizer(rightSwipe)
        self.view.addGestureRecognizer(leftSwipe)
        self.view.addGestureRecognizer(downSwipe)
        
        
        BowlingBalls.append(Ball1);
        BowlingBalls.append(Ball2);
        BowlingBalls.append(Ball3);
        BowlingBalls.append(Ball4);
        BowlingBalls.append(Ball5);
        BowlingBalls.append(Ball6);
        BowlingBalls.append(Ball7)
        
        
        BowlingBalls[6] = self.setBowlingBall(BowlingBalls[6], num: 1)
        BowlingBalls[5] = self.setBowlingBall(BowlingBalls[5], num: 2)
        BowlingBalls[4] = self.setBowlingBall(BowlingBalls[4], num: 3)
        BowlingBalls[3] = self.setBowlingBall(BowlingBalls[3], num: 4)
        BowlingBalls[2] = self.setBowlingBall(BowlingBalls[2], num: 5)
        BowlingBalls[1] = self.setBowlingBall(BowlingBalls[1], num: 6)
       BowlingBalls[0] = self.setBowlingBall(BowlingBalls[0], num: 7)
        
        
        game_over_label.hidden = true
        play_again_button.hidden = true
        play_again_button.enabled = false
        
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.03, target: self, selector: "playGame", userInfo: nil, repeats: true)
        
        
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setBowlingBall (ball: BowlingBall, num: Int) -> BowlingBall{
        
        ball.center.x = -50

        if((num != 5) && num != 7)
        {
        ball.center.y = CGFloat((num * 62))
        }
        
        if (num == 7)
        {
         ball.center.y = CGFloat(486)
        }
        if (num == 6)
        {
            ball.center.y = CGFloat(427)

        }
        if(num == 5)
        {
            ball.center.y = CGFloat(368)

        }
        
        ball.frame = CGRectMake(ball.center.x,ball.center.y,50,50)
        
    
        ball.speed = Double(num * Int(arc4random_uniform(5) + 2))
        
        return ball
        
    }
    
    
    
    func playGame(){
        ant1.center = CGPointMake(CGFloat(antX), CGFloat(antY))
        ant1.frame = CGRectMake(CGFloat(antX), CGFloat(antY), 65, 40)

        //add to the score based on time survived
        score += 0.05
        self.scoreLabel.text = "Score: \(Int(score))"
        
        
        
        self.BowlOn()

        if(collided){
            self.gameOver()
        }
        
        
    }
    

    
    func moveUp()
    {
        antY -= 59
    }
    func moveDown()
    {
        antY += 59
    }
    func moveLeft()
    {
        antX -= 60
    }
    func moveRight()
    {
        antX += 60
    }
    
    func BowlOn()
    {
        for (index, _) in BowlingBalls.enumerate()
        {
            BowlingBalls[index].center.x += CGFloat(BowlingBalls[index].speed)
            
                if(BowlingBalls[index].center.x > 400)
                {
                    BowlingBalls[index].center.x = -50
                    BowlingBalls[index].speed = Double(arc4random_uniform(5) + 1)
                }
            
                if (ant1.frame.intersects(BowlingBalls[index].frame))
                {
                    collided = true
                }
            
        }
    }
    
    
    
    func gameOver()
    {
        timer.invalidate()
        
        game_over_label.hidden = false
        play_again_button.hidden = false
        play_again_button.enabled = true
        
    }
        
    @IBAction func restart(sender: UIButton) {
        collided = false
        
        antX = 153
        antY = 552
        
        game_over_label.hidden = true
        play_again_button.enabled = false
        play_again_button.hidden = true
        
        for (index, _) in BowlingBalls.enumerate()
        {
            BowlingBalls[index] = self.setBowlingBall(BowlingBalls[index], num: (7-index))
        }
        
        self.score = 0
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.03, target: self, selector: "playGame", userInfo: nil, repeats: true)
        
        
    }
    
    

}
    
    
    

