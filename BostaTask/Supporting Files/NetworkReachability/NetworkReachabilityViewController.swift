//
//  NetworkReachabilityViewController.swift
//  TemplateMVVM
//
//

import UIKit
import Reachability

class NetworkReachabilityViewController: UIViewController {

    // MARK: - private valriables
    private var reachability: Reachability!
    
    // MARK:- IBActions
    @IBAction func checkConnection(_ sender: Any) {
        do {
           reachability = try Reachability()
       } catch {
           print("Unable to create Reachability")
           return
       }
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
            // MARK:- Developer should Change
            // navigate to root AuthVC
            // should be like
            
            //let main = R.storyboard.splash.splashViewController()!
            //BGNavigator.rootNavigation(newViewController: main)
        }
        reachability.whenUnreachable = { _ in
            print("Not reachable")
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
}
