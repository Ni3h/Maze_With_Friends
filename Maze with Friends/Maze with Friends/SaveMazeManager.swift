//
//  SaveMazeManager.swift
//  Maze with Friends
//
//  Created by Ethan on 7/13/17.
//  Copyright © 2017 Ethan. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseDatabase
import SpriteKit

class SaveMazeManager {
    let mazeObject = Maze()
    
    // Get a reference to the storage service using the default Firebase App
    let storage = Storage.storage()
    let database = Database.database()
    

    init(width: Int, yOffset: CGFloat) {

        //scene off
        mazeObject.generateGrid(rows: 25, columns: 25, width: width, yOffset: yOffset)
        //loadFromFirebase(completion: {
        //
        //})
        //scene on
    }
    
    func loadFromPlist(completion: @escaping () -> Void) {
        
        // load existing high scores or set up an empty array
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0] as String
        
        let path = URL(fileURLWithPath: documentsDirectory).appendingPathComponent("WallSaves.plist")

    
        let fileManager = FileManager.default
        
        // check if file exists
        if !fileManager.fileExists(atPath: path.path) {
            // create an empty file if it doesn't exist
            if let bundle = Bundle.main.path(forResource: "DefaultFile", ofType: "plist") {
                do {
                    try fileManager.copyItem(atPath: bundle, toPath: path.path)
                } catch {
                    
                }
            }
        }
        
        do {
            let rawData = try Data(contentsOf: path)
            // do we get serialized data back from the attempted path?
            // if so, unarchive it into an AnyObject, and then convert to an array of HighScores, if possible
            let wallArray: Any? = NSKeyedUnarchiver.unarchiveObject(with: rawData as Data)
            
            self.mazeObject.wallArray = wallArray as! [[Wall]]
            
            for wall1d in mazeObject.wallArray {
                for wall in wall1d{
                    
                    mazeObject.addChild(wall)
                }
            }
            completion()
        } catch {
            print("this occured")
            //whoops
        }
        
    }
    
    
    
    func save() {
        // find the save directory our app has permission to use, and save the serialized version of self.scores - the HighScores array.

        let saveData = NSKeyedArchiver.archivedData(withRootObject: self.mazeObject.wallArray);
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray;
        let documentsDirectory = paths.object(at: 0) as! NSString;
        let path = URL(fileURLWithPath: documentsDirectory.appendingPathComponent("WallSaves.plist"))
        
        do {
            try saveData.write(to: path)
            print("Save occured")

        } catch {
            
        }

    }
    
    
    func saveToFirebase(completion: @escaping () -> Void) {
        // Create a storage reference from our storage service
        let mazeName = mazeObject.mazeName
        let storageRef = storage.reference()
        let uid = Auth.auth().currentUser!.uid
        let dataRef = database.reference()
        
        
//        let nameRef = storageRef.child("mazes/\(mazeName)")
        let nameRef = storageRef.child("\(uid)/mazes/\(mazeName)")
        let saveData = NSKeyedArchiver.archivedData(withRootObject: self.mazeObject.wallArray);

        // Upload the file to the path "images/rivers.jpg"
    
        let uploadTask = nameRef.putData(saveData, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
            // Metadata contains file metadata such as size, content-type, and download URL.
            let downloadURL = metadata.downloadURL()
            let dataNameRef = dataRef.child("mazes").child(uid)
            dataNameRef.updateChildValues(["\(mazeName)" : "\(downloadURL!)"], withCompletionBlock: { (error, ref) in
                if error != nil {
                    print(error?.localizedDescription as Any)
                }
                completion()
            })
            
        }
        
        
    }
    
    /*finish this at future date */
//    func deleteFromFireBase() {
//    
//    }
    
    func loadMazeArrayFromDatabase() {
        let dataRef = database.reference()
        let uid = Auth.auth().currentUser!.uid
        
        dataRef.child("mazes").child(uid).observe(.value, with: { (snapshot) in
        })
    
    }
    
//    func loadMazeArrayFromDatabaseGlobal() {
//        let dataRef = database.reference()
//        let uid = "JwrgQHpedAh8UEAWylf2hKIGu572"
//        
//        dataRef.child("mazes").child(uid).observe(.value, with: { (snapshot)
//        })
//    }
    
    func loadFromFirebase(mazeName: String, completion: @escaping () -> Void) {
        // Create a storage reference from our storage service
        let storageRef = storage.reference()
        let uid = Auth.auth().currentUser!.uid

        
        //        let nameRef = storageRef.child("mazes/\(mazeName)")
        let nameRef = storageRef.child("\(uid)/mazes/\(mazeName)")
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        nameRef.getData(maxSize: 10 * 1024 * 1024) { rawData, error in
            if error != nil {
                // Uh-oh, an error occurred!
            } else {
                // Data for "mazes/.." is returned
                let wallArray: Any? = NSKeyedUnarchiver.unarchiveObject(with: rawData!)
                self.mazeObject.wallArray = wallArray as! [[Wall]]
                
                for wall1d in self.mazeObject.wallArray {
                    for wall in wall1d{
                        
                        self.mazeObject.addChild(wall)
                    }
                }
            }
            completion()
        }
        
        
    }
    
    func loadFromFireBaseGlobal(mazeName: String, completion: @escaping () -> Void) {
        // Create a storage reference from our storage service
        let storageRef = storage.reference()
        let uid = "JwrgQHpedAh8UEAWylf2hKIGu572"
        
        
        //        let nameRef = storageRef.child("mazes/\(mazeName)")
        let nameRef = storageRef.child("\(uid)/mazes/\(mazeName)")
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        nameRef.getData(maxSize: 10 * 1024 * 1024) { rawData, error in
            if error != nil {
                // Uh-oh, an error occurred!
            } else {
                // Data for "mazes/.." is returned
                let wallArray: Any? = NSKeyedUnarchiver.unarchiveObject(with: rawData!)
                self.mazeObject.wallArray = wallArray as! [[Wall]]
                
                for wall1d in self.mazeObject.wallArray {
                    for wall in wall1d{
                        
                        self.mazeObject.addChild(wall)
                    }
                }
            }
            completion()
        }
        
        
    }
    
    
    
    
    
    
}


