//
//  NavOptionsMenu.swift
//  Maze with Friends
//
//  Created by Ethan on 8/7/17.
//  Copyright © 2017 Ethan. All rights reserved.
//

import SpriteKit
import Firebase
import FirebaseAuthUI
import FirebaseAuth

class NavOptionsMenu: SKNode {
    
    var navOptionsBackground: ToolBarNode!
    var logoutButton: MSButtonNode!
    var returnButton: MSButtonNode!

    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func addChildren() {
        navOptionsBackground = self.childNode(withName: "//navOptionsBackground") as! ToolBarNode
        logoutButton = self.childNode(withName: "//logoutButton") as! MSButtonNode
        returnButton = self.childNode(withName: "//returnButton") as! MSButtonNode
        
        returnButton.selectedHandler = {  [unowned self] in
            self.alpha = 0
        }
        
        logoutButton.selectedHandler = { [unowned self] in
            do {
                try Auth.auth().signOut()
                let initialViewController = UIStoryboard.initialViewController(for: .login)
                self.scene?.view?.window?.rootViewController = initialViewController
                self.scene?.view?.window?.makeKeyAndVisible()
            } catch let error as NSError {
                assertionFailure("Error signing out: \(error.localizedDescription)")
            }
            }
        }

        
}
    
    

