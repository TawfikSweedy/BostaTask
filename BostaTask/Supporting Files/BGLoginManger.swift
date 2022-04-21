//
//  BGLoginManger.swift
//  BGApp
//
//  Created by TawfiqSweedy on 10/08/2021.
//

import Foundation

//struct BGLoginManger {
//    
//    static let key = "user"
//    
//    static func saveUser(_ value: LoginData!) {
//        setUserLogedin()
//        setUserToken(token: value.jwt_token ?? "")
//        UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: key)
//    }
//    
//    static func getUser() -> LoginData? {
//        if let data = UserDefaults.standard.value(forKey: key) as? Data {
//            do {
//                let userData = try PropertyListDecoder().decode(LoginData.self, from: data)
//                return userData
//            }catch{
//                return nil
//            }
//            
//        }else{return nil}
//    }
//    
//    static private func removeUser() {
//        UserDefaults.standard.removeObject(forKey: "auth_token")
//        UserDefaults.standard.setValue(false, forKey: "isLogin")
//        UserDefaults.standard.removeObject(forKey: key)
//    }
//    static func logout() {
//        removeUser()
//        // MARK:- Developer should ADD
//        // navigate to root AuthVC
//        // should be like
//        
//        //let main = R.storyboard.auth.authRootViewController()!
//        //BGNavigator.rootNavigation(newViewController: main)
//        
//    }
//    static func setUserLogedin() {
//        UserDefaults.standard.setValue(true, forKey: "isLogin")
//    }
//    static func setUserToken(token: String) {
//        UserDefaults.standard.setValue(token, forKey: "auth_token")
//    }
//    static func checkUser() -> Bool {
//        return UserDefaults.standard.bool(forKey: "isLogin")
//    }
//}
