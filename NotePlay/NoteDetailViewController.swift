//
//  NoteDetailViewController.swift
//  NoteLite
//
//  Created by shikaiwen on 5/9/2015.
//  Copyright (c) 2015 shikaiwen. All rights reserved.
//
import UIKit
import Spring
import AVFoundation
import CoreData

class NoteDetailViewController: UIViewController,UIScrollViewDelegate{
  var player = AVAudioPlayer()
  var article = UITextView()
  var articleScrollView = UIScrollView()
  var updateNote = UpdateButton()
  var currentArticleID:Int32!
  var actionWay:String!
  var newArticleID = Int32()
  override func viewDidLoad() {
    super.viewDidLoad()
    //指定声音文件
    player = self.loadSound("choose")
    view.backgroundColor = mainColor
      articleScrollView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
      articleScrollView.contentSize = CGSize(width: screenWidth, height: screenHeight*1.05)
      articleScrollView.delegate = self
      articleScrollView.showsVerticalScrollIndicator = false
      view.addSubview(articleScrollView)
    
      var articleWdith = screenWidth - marginSize2*2
      article.frame = CGRect(x: marginSize2, y: marginSize2, width: articleWdith, height: screenHeight)
      article.backgroundColor = mainColor
      article.font = songtiFont
      //修改光标颜色
      article.tintColor = mainGreen
      article.textColor = defaultFontColor
      article.keyboardType
      article.userInteractionEnabled=true
      article.keyboardAppearance = UIKeyboardAppearance.Dark
      var taped=UITapGestureRecognizer(target:self,action:Selector("focus"))
      article.addGestureRecognizer(taped)
      articleScrollView.addSubview(article)
    var backButton = BackButton()
      backButton.addTarget(self, action: "backTo", forControlEvents: UIControlEvents.TouchUpInside)
      view.addSubview(backButton)
    
    updateNote.addTarget(self, action:Selector(actionWay), forControlEvents: UIControlEvents.TouchUpInside)
      view.addSubview(updateNote)
  }
  func focus(){
    article.becomeFirstResponder()
  }
  func scrollViewWillBeginDragging(scrollView: UIScrollView) {
    article.endEditing(true)
  }
  func editNote(){
    //获取管理的数据上下文 对象
    let app = UIApplication.sharedApplication().delegate as! AppDelegate
    let context = app.managedObjectContext!
    
    var error:NSError?
    
    //声明数据的请求
    var fetchRequest:NSFetchRequest = NSFetchRequest()
    //fetchRequest.fetchLimit = 20 //限定查询结果的数量
    fetchRequest.fetchOffset = 0 //查询的偏移量
    
    //声明一个实体结构
    var entity:NSEntityDescription? = NSEntityDescription.entityForName("Article",
      inManagedObjectContext: context)
    //设置数据请求的实体结构
    fetchRequest.entity = entity
    
    //设置查询条件
    let predicate = NSPredicate(format: "articleID= '\(currentArticleID)' ")
    fetchRequest.predicate = predicate
    
    //查询操作
    var fetchedObjects:[AnyObject]? = context.executeFetchRequest(fetchRequest, error: &error)
    
    //遍历查询的结果
    for info:Article in fetchedObjects as! [Article]{
      //修改密码
      info.content = self.article.text
      //重新保存
      if !context.save(&error){
        println("不能保存：\(error?.localizedDescription)")
      }
    }
    
    //保存
    if !context.save(&error){
      println("不能保存：\(error?.localizedDescription)")
    }
    self.navigationController!.pushViewController(ViewController(),animated:true)
  }
  func updateYN(){
    self.player.play()
    if(article.text==""){
      var overLayView = OverLayUIView()
      view.addSubview(overLayView)
      overLayView.animation = "zoomIn"
      overLayView.animate()
    }else{
    updateNewNote()
    }
  }
  func updateNewNote(){
        //获取管理的数据上下文 对象
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext!
    
        var error:NSError?
    
        //创建User对象
        var article = NSEntityDescription.insertNewObjectForEntityForName("Article",
          inManagedObjectContext: context) as! Article
    
        //对象赋值
        article.id = 1
        article.articleID = newArticleID
        article.content = self.article.text
    
        //保存
        if !context.save(&error){
          println("不能保存：\(error?.localizedDescription)")
        }
     self.navigationController!.pushViewController(ViewController(),animated:true)
  }
  //播放声音的方法
  func loadSound(filename:NSString) -> AVAudioPlayer {
    let url = NSBundle.mainBundle().URLForResource(filename as String, withExtension: "aiff")
    var error:NSError? = nil
    let player = AVAudioPlayer(contentsOfURL: url, error: &error)
    player.prepareToPlay()
    return player
  }
  func backTo(){
    if(currentArticleID != nil){
      editNote()
    }
    self.player.play()
    BackButton().animation = "pop"
    BackButton().animate()
    self.navigationController!.popViewControllerAnimated(true)
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
