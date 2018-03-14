//
//  AppDelegate.swift
//  Share
//
//  Created by chinghoi on 18/3/10.
//  Copyright (c) 2018年 chinghoi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    
        /**
        *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
        *  在将生成的AppKey传入到此方法中。我们Demo提供的appKey为内部测试使用，可能会修改配置信息，请不要使用。
        *  方法中的第二个参数用于指定要使用哪些社交平台，以数组形式传入。第三个参数为需要连接社交平台SDK时触发，
        *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
        *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
        */
        
        ShareSDK.registerActivePlatforms( [], onImport: { (platform : SSDKPlatformType) in
            
        }) { (platform : SSDKPlatformType, appInfo : NSMutableDictionary?) in
            
        };
        ShareSDK.registerActivePlatforms(
            [
                SSDKPlatformType.typeSinaWeibo.rawValue,
                SSDKPlatformType.typeTencentWeibo.rawValue,
                SSDKPlatformType.typeFacebook.rawValue,
                SSDKPlatformType.typeTwitter.rawValue,
                SSDKPlatformType.typeMail.rawValue,
                SSDKPlatformType.typeSMS.rawValue,
                SSDKPlatformType.typeWechat.rawValue,
                SSDKPlatformType.typeQQ.rawValue,
            ],
            // onImport 里的代码,需要连接社交平台SDK时触发
            onImport: {(platform : SSDKPlatformType) -> Void in
                switch platform
                {
                    case SSDKPlatformType.typeSinaWeibo:
                            ShareSDKConnector.connectWeibo(WeiboSDK.classForCoder())
                    case SSDKPlatformType.typeWechat:
                            ShareSDKConnector.connectWeChat(WXApi.classForCoder())
                    case SSDKPlatformType.typeQQ:
                            ShareSDKConnector.connectQQ(QQApiInterface.classForCoder(), tencentOAuthClass: TencentOAuth.classForCoder())
                    case SSDKPlatformType.typeRenren:
                            ShareSDKConnector.connectRenren(RennClient.classForCoder())
                    default:
                        break
                    }
                 },
            onConfiguration: {(platform : SSDKPlatformType , appInfo : NSMutableDictionary?) -> Void in
                switch platform
                {
                    case SSDKPlatformType.typeSinaWeibo:
                        //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                        appInfo?.ssdkSetupSinaWeibo(byAppKey: "568898243",
                                                    appSecret: "38a4f8204cc784f81f9f0daaf31e02e3",
                                                    redirectUri: "http://www.sharesdk.cn",
                                                    authType: SSDKAuthTypeBoth)
                  
                    case SSDKPlatformType.typeWechat:
                        //设置微信应用信息
                        appInfo?.ssdkSetupWeChat(byAppId: "wx4868b35061f87885",
                                                 appSecret: "64020361b8ec4c99936c0e3999a9f249")
                        
                    case SSDKPlatformType.typeTencentWeibo:
                        //设置腾讯微博应用信息，其中authType设置为只用Web形式授权
                        appInfo?.ssdkSetupTencentWeibo(byAppKey: "801307650",
                                                       appSecret: "ae36f4ee3946e1cbb98d6965b0b2ff5c",
                                                       redirectUri: "http://www.sharesdk.cn")
                   
                        
                    case SSDKPlatformType.typeFacebook:
                        //设置Facebook应用信息，其中authType设置为只用SSO形式授权
                        appInfo?.ssdkSetupFacebook(byApiKey: "107704292745179",
                                                   appSecret: "38053202e1a5fe26c80c753071f0b573",
                                                   displayName: "ShareSDK",
                                                   authType: SSDKAuthTypeBoth)
                    
                    case SSDKPlatformType.typeTwitter:
                        //设置Twitter应用信息
                        appInfo?.ssdkSetupTwitter(byConsumerKey: "LRBM0H75rWrU9gNHvlEAA2aOy",
                                                  consumerSecret: "gbeWsZvA9ELJSdoBzJ5oLKX0TU09UOwrzdGfo9Tg7DjyGuMe8G",
                                                  redirectUri: "http://mob.com")
                   
                    case SSDKPlatformType.typeQQ:
                        //设置QQ应用信息
                        appInfo?.ssdkSetupQQ(byAppId: "100371282",
                                             appKey: "aed9b0303e3ed1e27bae87c33761161d",
                                             authType: SSDKAuthTypeWeb)
                    
                    default:
                        break
                        }
        })
        return true
    }
}

