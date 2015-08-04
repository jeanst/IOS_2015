//
//  ViewController.swift
//  MemoryGameJean
//
//  Created by Jean Steinberg on 7/10/15.
//  Copyright (c) 2015 Jean Steinberg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var ncol:Int = 4;
    var nrow:Int = 3;
    var Grade: Int = 0;
    var Number: Int = 0;
    
    var segmentedControl: UISegmentedControl!;
    var textView: UITextView?;
    var button: UIButton!;
    var button1: UIButton!;
    var board: UIView!;
    
    
    var viewController2 = ViewController2() ;
    
    func buttonIsPressed(sender: UIButton){
        println("button is pressed.");
        viewController2.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext;
        presentViewController(viewController2, animated: true, completion:  nil);
        
    }
    
    func segmentedControl(sender: UISegmentedControl){
        println("selected index: \(sender.selectedSegmentIndex)");
        
        switch (sender.selectedSegmentIndex){
        case 0:
            ncol = 4;
            nrow = 3;
            break;
        case 1:
            ncol = 4;
            nrow = 4;
            break;
        case 2:
            ncol = 4;
            nrow = 5;
            break;
        case 3:
            ncol = 4;
            nrow = 6;
            break;
        case 4:
            ncol = 6;
            nrow = 5;
            break;
        case 5:
            ncol = 6;
            nrow = 6;
            break;
        default:
            ncol = 4;
            nrow = 3;
            
        }
        
        NCOL = ncol;
        NROW = nrow;
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textView = UITextView(frame: CGRect(x: 60, y: 50, width: 250, height: 100));
        textView!.text = "MEMORY GAME \n with Score !!!";
        textView!.textColor = UIColor.yellowColor();
        textView!.textAlignment = NSTextAlignment.Center;
        textView?.backgroundColor = UIColor.brownColor();
        textView!.font = UIFont.systemFontOfSize(28);
        view.addSubview(textView!);
        
        board = UIView(frame: CGRect(x: 0, y: 0 , width: 300, height: 300));
        board.backgroundColor = UIColor.lightGrayColor();
        board.center = view.center;
        /*
        let textView1 = UITextView(frame: CGRect(x: 0, y: 0, width: 250, height: 40));
        textView1.backgroundColor = UIColor.yellowColor();
        textView1.text = "Choose a game";
        textView1.textAlignment = NSTextAlignment.Center;
        textView1.font = UIFont.systemFontOfSize(14);
        textView1.textColor = UIColor.brownColor();
        board.addSubview(textView1);
        */
        button1 = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton;
        
        button1.frame = CGRect(x: 50, y: 20, width: 200, height: 30);
        let normalImage1 = UIImage(named: "button1");
        button1.setBackgroundImage(normalImage1, forState: UIControlState.Normal);
       
        board.addSubview(button1);
        /*
        let label = UILabel(frame: CGRect(x: 0, y: 50, width: 250, height: 30));
        label.backgroundColor = UIColor.yellowColor();
        label.text = "Easy... |   Medium... |  Hard...";
        label.textAlignment = NSTextAlignment.Center;
        label.textColor = UIColor.brownColor();
        label.font = UIFont.systemFontOfSize(14);
        board.addSubview(label);
        */
        let segments = ["4x3", "4x4","4x5","4x6","6x5","6x6"];
        segmentedControl = UISegmentedControl(items: segments);
        segmentedControl.backgroundColor = UIColor.greenColor()
        segmentedControl.center = board.center;
        segmentedControl.frame = CGRect(x: 25, y: 110, width: 250, height: 40)
        segmentedControl.addTarget(self, action: "segmentedControl:", forControlEvents: UIControlEvents.ValueChanged);
        segmentedControl.momentary = false;
        board.addSubview(segmentedControl);
        
        button = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton;
        button.frame = CGRect(x: 50, y: 220, width: 200, height: 50);
        let normalImage = UIImage(named: "button2");
        button.setBackgroundImage(normalImage, forState: UIControlState.Normal);
        //button.setTitle("Click to choose the game", forState: UIControlState.Normal);
        //button.setTitleColor(UIColor.brownColor(), forState: UIControlState.Normal);
        button.addTarget(self, action: "buttonIsPressed:", forControlEvents: UIControlEvents.TouchDown);
        //button.backgroundColor = UIColor.yellowColor();
        board.addSubview(button);
        
        view.addSubview(board);
        view.backgroundColor = UIColor.brownColor();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

