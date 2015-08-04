//
//  ViewController2.swift
//  MemoryGameJean
//
//  Created by Jean Steinberg on 7/10/15.
//  Copyright (c) 2015 Jean Steinberg. All rights reserved.
//

import UIKit


class ViewController2 : UIViewController{
    
    var cardImages:[UIImage] = [UIImage]();
    var cards:[Int] = [Int]();
    var oldcardID = 0;
    var isMatch = false;
    var isFirstTime = true;
    var counter:Int = 0;
    var cardA: Int = -1;
    var cardB: Int = -1;
    var cardImageViews: [UIImageView] = [UIImageView]();
    var imageback: UIImage!;
    var imageFinish: UIImage!;
    var matchCount = 0;
    var ncol:Int = 4;
    var nrow:Int = 3;
    var Grade: Int = 0;
    var Number: Int = 0;
    var Points: Int = 0;
    var maxPoints: Int = 0;
    var imagesNames:[String] = [String]();
    var timeStart: NSDate!;
    var Skey:String = " ";
    
    var userDefaults: NSUserDefaults!;
    
    var segmentedControl: UISegmentedControl!;
    var textView: UITextView?;
    var button: UIButton!;
    var board: UIView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        /*
        
        button = UIButton.buttonWithType(UIButtonType.System) as? UIButton;
        //let hh = view.bounds.height - 30;
        button.frame = CGRect(x: 60, y: 50, width: 250, height: 50);
        
        button.setTitle("Click to play the game", forState: UIControlState.Normal);
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        
        button.addTarget(self, action: "buttonIsPressed:", forControlEvents: UIControlEvents.TouchDown);
        button.backgroundColor = UIColor.yellowColor();
        view.addSubview(button);
       */
        //view.backgroundColor = UIColor.brownColor();
        ncol = NCOL;
        nrow = NROW;
        
        println(" IN VIEWDIDLOAD  NCOL \(NCOL)  NROW \(NROW)");
        playGame();
        
    }
    func buttonIsPressed(sender: UIButton){
        println("button is pressed.");
        println("NCOL \(NCOL)  NROW \(NROW)");
        playGame();
    }
    
    func playGame(){
        
        ncol = NCOL;
        nrow = NROW;
        
        println(" IN PLAYGAME  NCOL \(NCOL)  NROW \(NROW)");
        
        textView = UITextView(frame: CGRect(x: 60, y: 50, width: 250, height: 50));
        textView!.text = "Memory Game " + NCOL.description + "x" + NROW.description;
        textView!.textColor = UIColor.yellowColor();
        textView!.textAlignment = NSTextAlignment.Center;
        textView?.backgroundColor = UIColor.brownColor();
        
        textView!.font = UIFont.systemFontOfSize(28);
        //view.addSubview(textView!);
        
        Skey = "game" + ncol.description + nrow.description;
        
        Number = ncol * nrow;
        
        switch(Number){
        case 12:
            Grade = 100;
            break;
        case 16:
            Grade = 200;
            break;
        case 20:
            Grade = 300;
            break;
        case 24:
            Grade = 400;
            break;
        case 30:
            Grade = 500;
            break;
        case 36:
            Grade = 600;
            break;
        default:
            Grade = 100;
        }
        
        userDefaults = NSUserDefaults.standardUserDefaults();
        //userDefaults.setInteger(0, forKey: "game43");
        //userDefaults.setInteger(0, forKey: "game44");
        //userDefaults.setInteger(0, forKey: "game45");
        //userDefaults.setInteger(0, forKey: "game46");
        //userDefaults.setInteger(0, forKey: "game65");
        //userDefaults.setInteger(0, forKey: "game66");
        resetCounters();
        println(" SKEY \(Skey)  POINTS \(maxPoints) Grade \(Grade)");
        
        imagesNames.removeAll(keepCapacity: false);
        var ss:String;
        for i in 1...Number/2{
            if(i<10){
                ss = "pic0" + i.description;
            }else{
                ss = "pic" + i.description;
            }
            imagesNames.append(ss);
        }
        
        cards.removeAll(keepCapacity: false);
        for i in 1...Number/2{
            cards.append(i);
            cards.append(i);
        }
        
        shufflecards();
        
        cardImages.removeAll(keepCapacity: false);
        for imageName in imagesNames{
            var cardImage = UIImage(named: imageName)!;
            cardImages.append(cardImage);
        }
        imageback = UIImage(named: "rect-blue");
        imageFinish = UIImage(named: "rect-red");
        
        let hh = nrow * 70;
        let ww = ncol * 50;
        board = UIView(frame: CGRect(x: 0, y: 200 , width: ww, height: hh));
        
        cardImageViews.removeAll(keepCapacity: false);
        var x = 0;
        var y = 0;
        for i in 1...Number {
            var card: UIImageView!;
            card = UIImageView(frame: CGRect(x: x, y: y, width: 50, height: 70));
            x += 50;
            if(i%ncol == 0){
                x = 0;
                y += 70;
            }
            card.image = imageback;
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleCardTap:");
            card.addGestureRecognizer(tapGestureRecognizer);
            card.userInteractionEnabled = true;
            card.tag = i;
            cardImageViews.append(card);
            board.addSubview(card);
        }
        board.backgroundColor = UIColor.whiteColor();
        board.center = view.center;
        
        view.backgroundColor = UIColor.whiteColor();
        
        view.addSubview(board);
        
        timeStart =  NSDate();
    }
    func handleCardTap(sender: UITapGestureRecognizer){
        var card = sender.view as! UIImageView;
        let cardId = sender.view!.tag;
        println("   +++++>   card \(cardId)");
        counter++;
        if(counter > 1) {
            if(counter%2 == 0){ //cardB
                if(cardId == cardA ){
                    counter--;
                    return;
                }
                cardB = cardId;
                if(cards[cardB-1] == cards[cardA-1] ){
                    println(" MATCH card \(cardA) and card \(cardB)");
                    cardImageViews[cardA-1].userInteractionEnabled = false;
                    cardImageViews[cardB-1].userInteractionEnabled = false;
                    isMatch = true;
                    matchCount++;
                }else{
                    isMatch = false;
                }
            }else{  //cardA
                println("      card \(cardA) and card \(cardB) MATCH \(isMatch)");
                if(cardA != -1 && !isMatch) {
                    //cardImageViews[cardA-1].image = imageback;
                    //cardImageViews[cardB-1].image = imageback;
                    
                    UIView.transitionWithView(cardImageViews[cardA-1], duration: 0.5, options: UIViewAnimationOptions.TransitionFlipFromLeft, animations: { [unowned self]() -> Void in
                        self.cardImageViews[self.cardA-1].image = self.imageback;
                        }, completion: nil);
                    UIView.transitionWithView(cardImageViews[cardB-1], duration: 0.5, options: UIViewAnimationOptions.TransitionFlipFromLeft, animations: { [unowned self]() -> Void in
                        self.cardImageViews[self.cardB-1].image = self.imageback;
                        }, completion: nil);
                    
                }
                cardA = cardId;            }
        }else{
            cardA = cardId;
            
        }
        //card.image = cardImages[cards[cardId-1]-1];
        
        UIView.transitionWithView(cardImageViews[cardId-1], duration: 0.5, options: UIViewAnimationOptions.TransitionFlipFromLeft, animations: { [unowned self]() -> Void in
            self.cardImageViews[cardId-1].image = self.cardImages[self.cards[cardId-1]-1];
            }, completion: nil);
        
        if(matchCount == Number/2){
            println("End of Game");
            let timeEnd = NSDate();
            let timeInterval: Double = timeEnd.timeIntervalSinceDate(timeStart); // <<<<< Difference in seconds (double)
            let minutes = floor(timeInterval/60);
            let seconds = round((timeInterval/60 - minutes) * 60);
            let min = (Int)(minutes);
            let sec = (Int)(seconds);
            let pointD = (Double)(Number * Grade ) / (Double)(counter) * 100 / timeInterval;
            Points = (Int)(pointD);
            var verb:String = "is";
            if ( Points > maxPoints){
                userDefaults.setInteger(Points, forKey: Skey);
                verb = "was";
            }
            
            println(" TIME  \(timeInterval)  \(min):\(sec)  POINTS: \(Points) MaxPOINTS \(maxPoints)");
            let controller = UIAlertController(title: "End of the GAME\(ncol)x\(nrow)!!!", message: "Using: \(counter) clicks!!! \n Elapse time:  \(min):\(sec) \n You won \(Points) points \n Your best score \(verb) \(maxPoints)", preferredStyle: UIAlertControllerStyle.Alert);
            let actionGO = UIAlertAction(title: "Play again the GAME\(ncol)x\(nrow)", style: UIAlertActionStyle.Default, handler: { [weak self] (action: UIAlertAction! ) -> Void in
                
                self!.shufflecards();
                for cardImageView in self!.cardImageViews{
                    cardImageView.image = self!.imageback;
                    let tapGestureRecognizer = UITapGestureRecognizer(target: self!, action: "handleCardTap:");
                    cardImageView.addGestureRecognizer(tapGestureRecognizer);
                    cardImageView.userInteractionEnabled = true;
                    
                }
                self!.resetCounters();
                });
            controller.addAction(actionGO);
            let actionNOGO = UIAlertAction(title: "Finish", style: UIAlertActionStyle.Default, handler: { [weak self] (action: UIAlertAction! ) -> Void in
                //for cardImageView in self!.cardImageViews{
                //    cardImageView.image = self!.imageFinish;
                //}
                self!.skipControllers();
                
                });
            controller.addAction(actionNOGO)
            
            presentViewController(controller, animated: true, completion: nil);
        }
        
    }
    func skipControllers(){
        //self.board.removeFromSuperview();
        //self.textView?.removeFromSuperview();
        
        //self!.dismissViewControllerAnimated(true, completion: nil);
        let VC = ViewController();
        VC.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext;
        presentViewController(ViewController(), animated: true, completion:  nil);
        
    }
    
    func resetCounters(){
        counter = 0;
        cardA = -1;
        cardB = -1;
        isMatch = false;
        matchCount = 0;
        maxPoints = userDefaults.integerForKey(Skey);
        timeStart =  NSDate();
    }
    
    func shufflecards(){
        let nrand = (UInt32)(Number);
        for i in 0..<Number{
            let randomPosition = Int(arc4random_uniform(nrand));
            let temp = cards[i];
            cards[i] = cards[randomPosition];
            cards[randomPosition] = temp;
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}