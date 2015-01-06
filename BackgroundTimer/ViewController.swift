//
//  ViewController.swift
//  BackgroundTimer
//
//  Created by aora on 15-1-4.
//  Copyright (c) 2015年 Erik. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController , AVAudioPlayerDelegate {

    
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblCurrentTime: UILabel!
    @IBOutlet weak var lblCounter: UILabel!
    @IBOutlet weak var lblInterval: UILabel!
    @IBOutlet weak var btnTimer: UIButton!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var swPlaySound: UISwitch!
    
    
    var counter : Int = 0
    
    var counterTimer : NSTimer?
    var refreshTimer : NSTimer?
    
    var startDate : NSDate!
    var df : NSDateFormatter!
    
    var session : AVAudioSession!
    var audioPlayer : AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        df = NSDateFormatter();
        df.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        session = AVAudioSession.sharedInstance();
        session.setActive(true, error: nil)
        session.setCategory(AVAudioSessionCategoryPlayback, error: nil)
        
        let musicFile = NSBundle.mainBundle().URLForResource("918", withExtension: "mp3");
        audioPlayer = AVAudioPlayer(contentsOfURL: musicFile, error: nil)
        audioPlayer.delegate = self
        audioPlayer.numberOfLoops = -1;
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        refreshTimer?.invalidate();
        refreshTimer = NSTimer.scheduledTimerWithTimeInterval( 1, target: self, selector: "refresh", userInfo: nil, repeats: true)

    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated);
        refreshTimer?.invalidate();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnTimerClick(sender: AnyObject) {
        var btn = sender as UIButton;
        switch(btn.tag){
        case 0:
            startDate = NSDate()
            counter = 0;
            lblStartDate?.text = "开始时间:\(df.stringFromDate(startDate))"
            counterTimer?.invalidate();
            
            counterTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "countSecount", userInfo: nil, repeats: true);
  
            
            btn.setTitle("Stop", forState: UIControlState.Normal)
            
            btn.tag = 1;
            if swPlaySound.on {
                audioPlayer.play()
            }
            
        default:
            btn.tag = 0;
            //btn.titleLabel?.text = "Start"
            btn.setTitle("Start", forState: UIControlState.Normal)
            counterTimer?.invalidate();
            
             audioPlayer.stop()
        }
    }
    
    func countSecount(){
        println("countSecount")
        counter++;
        lblCounter.text = "计数数值:\(counter)"
        let currentDate = NSDate()
        lblCurrentTime.text = "当前时间:\(df.stringFromDate(currentDate))"
        lblInterval.text = "流逝时间:\(Int(currentDate.timeIntervalSinceDate(startDate)))秒"
    }
    
    func refresh(){
        let currentDate = NSDate()
        lblCurrentTime.text = "当前时间:\(df.stringFromDate(currentDate))"
        if(btnTimer.tag == 1){
            lblInterval.text = "流逝时间:\(Int(currentDate.timeIntervalSinceDate(startDate)))秒"
        }
    }
    
    func audioPlayerBeginInterruption(player: AVAudioPlayer!) {
        lblStatus.text = "audioPlayerBeginInterruption"
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        lblStatus.text = "audioPlayerDidFinishPlaying"
    }
    
    func audioPlayerEndInterruption(player: AVAudioPlayer!) {
        lblStatus.text = "audioPlayerEndInterruption"
    }

}

