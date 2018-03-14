//
//  UIAlertExtension.swift
//  Share
//
//  Created by ChingHoi on 2018/3/11.
//  Copyright © 2018年 MOB. All rights reserved.
//

import UIKit

//每次要弹出提示框都要创建一个 UIAlertController，然后添加 action 按钮，最后再通过对应的视图控制器 present 出来
//可以把 UIAlertController 进行扩展，把这些操作做个封装，方便使用

extension UIAlertController {
    //在指定视图控制器上弹出普通消息提示框
    static func showAlert(message: String, in viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .cancel))
        viewController.present(alert, animated: true)
    }
    //在根视图控制器上弹出普通消息提示框
    static func showAlert(message: String) {
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            showAlert(message: message, in: vc)
        }
    }
}
