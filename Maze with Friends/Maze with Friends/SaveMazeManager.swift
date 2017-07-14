//
//  SaveMazeManager.swift
//  Maze with Friends
//
//  Created by Ethan on 7/13/17.
//  Copyright © 2017 Ethan. All rights reserved.
//

import Foundation

class SaveMazeManager {
    var wallSaves: [[Wall]] = [[]]
    
    init() {
        // load existing high scores or set up an empty array
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0] as String
        let path = NSURL(fileURLWithPath: documentsDirectory).appendingPathComponent("WallSaves.plist")
        
        let fileManager = FileManager.default
        
        // check if file exists
        if !fileManager.fileExists(atPath: path!.absoluteString) {
            // create an empty file if it doesn't exist
            if let bundle = Bundle.main.path(forResource: "DefaultFile", ofType: "plist") {
                do {
                    try fileManager.copyItem(atPath: bundle, toPath: path!.absoluteString)
                } catch {
                    
                }
            }
        }
        
        if let rawData = NSData(contentsOfFile: path!.absoluteString) {
            // do we get serialized data back from the attempted path?
            // if so, unarchive it into an AnyObject, and then convert to an array of HighScores, if possible
            let wallArray: Any? = NSKeyedUnarchiver.unarchiveObject(with: rawData as Data)
            self.wallSaves = wallArray as? [[Wall]] ?? [[]]
        }
    }
    
    func save() {
        // find the save directory our app has permission to use, and save the serialized version of self.scores - the HighScores array.
        let saveData = NSKeyedArchiver.archivedData(withRootObject: self.wallSaves);
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray;
        let documentsDirectory = paths.object(at: 0) as! NSString;
        let path = NSURL(fileURLWithPath: documentsDirectory.appendingPathComponent("WallSaves.plist"))
        
        do {
            try saveData.write(to: path as URL)
        } catch {
            
        }
    }
    
    
}


