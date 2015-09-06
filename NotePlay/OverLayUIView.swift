import UIKit
import Spring
import AVFoundation

class OverLayUIView:SpringView{
  var player = AVAudioPlayer()
  override init(frame:CGRect){
    var frame = CGRect(x: 50, y: (screenHeight-400)/2, width: screenWidth-100, height: 360)
    super.init(frame:frame)
    //指定声音文件
    player = self.loadSound("choose")
    self.backgroundColor = mainGreen
    self.layer.cornerRadius = 15

    var alertText = UILabel()
    alertText.text = "You Forget Type Content Just Now So Write Something"
    alertText.font = titleFont
    alertText.numberOfLines = 3
    alertText.frame = CGRect(x: 25, y: 0, width: screenWidth-150, height: 300)
    alertText.textAlignment = NSTextAlignment.Center
    alertText.textColor = UIColor.whiteColor()
    self.addSubview(alertText)
    
    var backUpdateButton = UIButton()
    backUpdateButton.backgroundColor = UIColor.clearColor()
    backUpdateButton.layer.borderWidth = 3
    backUpdateButton.layer.borderColor = UIColor.whiteColor().CGColor
    backUpdateButton.frame = CGRect(x: (screenWidth-250)/2, y: 260, width: 150, height: 50)
    backUpdateButton.layer.cornerRadius = 25
    backUpdateButton.titleLabel!.font = titleFont
    backUpdateButton.setTitle("Got It", forState: UIControlState.Normal)
    backUpdateButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    backUpdateButton.addTarget(self, action: "removeSelf", forControlEvents: UIControlEvents.TouchUpInside)
    self.addSubview(backUpdateButton)
  }
  func removeSelf(){
    self.player.play()
    self.animation = "zoomOut"
    self.animateToNext({ () -> () in
      self.removeFromSuperview()
    })
  }
  //播放声音的方法
  func loadSound(filename:NSString) -> AVAudioPlayer {
    let url = NSBundle.mainBundle().URLForResource(filename as String, withExtension: "aiff")
    var error:NSError? = nil
    let player = AVAudioPlayer(contentsOfURL: url, error: &error)
    player.prepareToPlay()
    return player
  }
  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
}