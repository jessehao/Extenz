//
//  UIViewControllerExtensions.swift
//  Extenz
//
//  Created by Jesse Hao on 2019/6/4.
//

import Foundation

public extension UIViewController {
    static func currentViewController() -> UIViewController? {
        var controller = UIApplication.shared.keyWindow?.rootViewController
        while true {
            if controller is UITabBarController {
                let tabController = controller as! UITabBarController
                controller = tabController.selectedViewController
                continue
            } else if controller is UINavigationController {
                let navController = controller as! UINavigationController
                controller = navController.visibleViewController
                continue
            } else if controller?.presentedViewController != nil{
                controller = controller?.presentedViewController
                continue
            } else {
                break
            }
        }
        return controller
    }
    
    var keyWindow:UIWindow? { return UIApplication.shared.keyWindow }
    
    var canPopFromNavigationController:Bool {
        return self.navigationController != nil && self.navigationController?.rootViewController != self
    }
    
    func removeFromNotificationCenter() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func withNavigationController() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
    
    func close(completion:(() -> Void)? = nil) {
        self.view.endEditing(true)
        if self.canPopFromNavigationController {
            self.navigationController?.popViewController(animated: true)
            completion?()
        } else {
            self.dismiss(animated: true) {
                completion?()
            }
        }
    }
}

public extension UIViewController {
    @discardableResult
    func presentBy(_ presenting:UIViewController, animated: Bool = true, completion:(() -> Void)? = nil) -> Self {
        presenting.present(self, animated: animated, completion: completion)
        return self
    }
}

public extension UINavigationController {
    var rootViewController:UIViewController? { return self.viewControllers.first }
    
    @discardableResult
    func popToViewControllerType<C>(_ type:C.Type, animated:Bool = true) -> Bool {
        guard let destination = self.viewControllers.first(where: { $0 is C }) else { return false }
        self.popToViewController(destination, animated: animated)
        return true
    }
}

public extension UIAlertController {
    static func notice(title:String? = nil, message:String?, buttonTitle:String, handler:((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let retval = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .cancel, handler: handler)
        retval.addAction(action)
        return retval
    }
    
    static func confirmationAlert(title:String? = nil,
                                  message:String?,
                                  confirmButtonTitle:String,
                                  confirmButtonStyle:UIAlertAction.Style = .default,
                                  cancelButtonTitle:String,
                                  confirmationHandler:@escaping (UIAlertAction) -> Void) -> UIAlertController {
        let retval = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: cancelButtonTitle, style: .cancel)
        let confirm = UIAlertAction(title: confirmButtonTitle, style: confirmButtonStyle, handler: confirmationHandler)
        retval.addAction(cancel)
        retval.addAction(confirm)
        return retval
    }
}
