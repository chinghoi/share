//
//  ViewController.swift
//
//  Created by chinghoi on 18/3/10.
//  Copyright (c) 2018年 chinghoi. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //隐藏键盘
        textView.delegate = self
        
        //加载的网页页面比较大的话 是无法的完全显示在webView上，这个时候我们需要调节webView的scalesPageToFit属性来实现页面适应webView区域的效果
        webView.scalesPageToFit = true
        //在软件 web view 中要显示的网页
        webView.loadRequest(NSURLRequest(url:NSURL.init(string:"http://www.qdaily.com/")! as URL) as URLRequest)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //隐藏键盘
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

//    //定一个按钮用来获取视频播放需要覆盖的区域(勿删)
//    @IBOutlet weak var playVideoView: UIButton!
    @IBAction func play(_ sender: UIButton) {
        
        //定义一个视频播放器，通过本地文件路径初始化
        let player = AVPlayer(url: NSURL(string:"http://images.all-free-download.com/footage_preview/mp4/tibet_lake_nepal_ladakh_himalaya_366.mp4") as URL!)
//        //此注释表示在原来按钮上播放视频,以备后用(可删)
//        //设置大小和位置（全屏）
//        let playerLayer = AVPlayerLayer(player: player)
//        //将按钮大小属性传给播放器
//        playerLayer.frame = playVideoView.frame
//        //添加到界面上
//        playVideoView.layer.addSublayer(playerLayer)
        
        //控制播放
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
    //定义一个文本视图接口,用来读取输入的文字或者隐藏键盘的作用
    @IBOutlet weak var textView: UITextView!
    @IBAction func textShareMenu(sender: UIButton) {
        //1.创建分享参数
        let shareParames = NSMutableDictionary()
        shareParames.ssdkSetupShareParams(byText: textView.text,
                                         images : nil,
                                            url : nil,
                                          title : nil,
                                           type : SSDKContentType.auto)
        //分享菜单显示效果
        SSUIShareActionSheetStyle.setShareActionSheetStyle(.system)
        
        //2.进行分享
        let sheet = ShareSDK.showShareActionSheet(sender, items: nil, shareParams: shareParames) { (state : SSDKResponseState, platformType : SSDKPlatformType, userdata : [AnyHashable : Any]?, contentEnity : SSDKContentEntity?, error : Error?, end) in

            switch state{
            
            case SSDKResponseState.success: UIAlertController.showAlert(message: "分享成功!")
            case SSDKResponseState.fail:    UIAlertController.showAlert(message: "分享错误:\(String(describing: error))")
            case SSDKResponseState.cancel:  UIAlertController.showAlert(message: "分享取消")
            
            default:
                break
            }
        }
        //添加跳过编辑直接分享的平台
        sheet?.directSharePlatforms.add(SSDKPlatformType.typeSinaWeibo.rawValue)
    }
    @IBAction func imageShareMenu(sender: UIButton) {
        
        //1.创建分享参数
        let shareParames = NSMutableDictionary()
        shareParames.ssdkSetupShareParams(byText: nil,
                                          images : UIImage(named: "coast.png"),
                                          url : nil,
                                          title : nil,
                                          type : SSDKContentType.auto)
        //分享菜单显示效果
        SSUIShareActionSheetStyle.setShareActionSheetStyle(.system)
        
        //2.进行分享
        let sheet = ShareSDK.showShareActionSheet(sender, items: nil, shareParams: shareParames) { (state : SSDKResponseState, platformType : SSDKPlatformType, userdata : [AnyHashable : Any]?, contentEnity : SSDKContentEntity?, error : Error?, end) in
            
            switch state{
                
            case SSDKResponseState.success: UIAlertController.showAlert(message: "分享成功!")
            case SSDKResponseState.fail:    UIAlertController.showAlert(message: "分享错误:\(String(describing: error))")
            case SSDKResponseState.cancel:  UIAlertController.showAlert(message: "分享取消")
                
            default:
                break
            }
        }
        //添加跳过编辑直接分享的平台
        sheet?.directSharePlatforms.add(SSDKPlatformType.typeSinaWeibo.rawValue)
    }
    
    @IBAction func videoShareMenu(sender: UIButton) {
        
        //1.创建分享参数
        let shareParames = NSMutableDictionary()
        shareParames.ssdkSetupShareParams(byText: "分享内容 Big Buck Bunny",
                                          images : UIImage(named: "bird.jpg"),
                                          url : NSURL(string:"http://images.all-free-download.com/footage_preview/mp4/tibet_lake_nepal_ladakh_himalaya_366.mp4") as URL!,
                                          title : "Big Buck Bunny",
                                          type : SSDKContentType.video)

        //分享菜单显示效果
        SSUIShareActionSheetStyle.setShareActionSheetStyle(.system)

        //2.进行分享,在items里填入微信分享平台,为nil的话默认全部
        ShareSDK.showShareActionSheet(sender, items: [SSDKPlatformType.typeWechat.rawValue], shareParams: shareParames) { (state : SSDKResponseState, platformType : SSDKPlatformType, userdata : [AnyHashable : Any]?, contentEnity : SSDKContentEntity?, error : Error?, end) in

            switch state{

            case SSDKResponseState.success: UIAlertController.showAlert(message: "分享成功!")
            case SSDKResponseState.fail:    UIAlertController.showAlert(message: "分享错误:\(String(describing: error))")
            case SSDKResponseState.cancel:  UIAlertController.showAlert(message: "分享取消")
            default:
                break
            }
        }
    }
    @IBOutlet weak var webView: UIWebView!
    @IBAction func urlShareMenu(sender: UIButton) {
        //1.创建分享参数
        let shareParames = NSMutableDictionary()
        shareParames.ssdkSetupShareParams(byText: "分享内容 http://www.qdaily.com/",
                                          images : UIImage(named: "shareImg.png"),
                                          url : NSURL(string:"http://www.qdaily.com/") as URL!,
                                          title : "好奇心日报",
                                          type : SSDKContentType.webPage)
        
        //分享菜单显示效果
        SSUIShareActionSheetStyle.setShareActionSheetStyle(.system)
        
        //2.进行分享
        let sheet = ShareSDK.showShareActionSheet(sender, items: nil, shareParams: shareParames) { (state : SSDKResponseState, platformType : SSDKPlatformType, userdata : [AnyHashable : Any]?, contentEnity : SSDKContentEntity?, error : Error?, end) in
            
            switch state{
                
            case SSDKResponseState.success: UIAlertController.showAlert(message: "分享成功!")
            case SSDKResponseState.fail:    UIAlertController.showAlert(message: "分享错误:\(String(describing: error))")
            case SSDKResponseState.cancel:  UIAlertController.showAlert(message: "分享取消")
                
            default:
                break
            }
        }
        //添加跳过编辑直接分享的平台
        sheet?.directSharePlatforms.add(SSDKPlatformType.typeSinaWeibo.rawValue)
    }
}
