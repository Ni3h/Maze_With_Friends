//
//  SaveMazeManager.swift
//  Maze with Friends
//
//  Created by Ethan on 7/13/17.
//  Copyright © 2017 Ethan. All rights reserved.
//

import Foundation

class SaveMazeManager {
    let mazeObject = Maze()
    
    init() {
        // load existing high scores or set up an empty array
        print("This Happened")
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0] as String
        let path = URL(fileURLWithPath: documentsDirectory).appendingPathComponent("WallSaves.plist")
        //let path = NSURL(fileURLWithPath: documentsDirectory).appendingPathComponent("WallSaves.plist")
        
        //JUST FOR TESTING
        mazeObject.generateGrid(rows: 25, columns: 25, width: Int(800), yOffset: 150)
        
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
        } catch {
            //whoops
        }
    }
    
    func save() {
        // find the save directory our app has permission to use, and save the serialized version of self.scores - the HighScores array.
        print("Save occured")

        let saveData = NSKeyedArchiver.archivedData(withRootObject: self.mazeObject.wallArray);
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray;
        let documentsDirectory = paths.object(at: 0) as! NSString;
        let path = URL(fileURLWithPath: documentsDirectory.appendingPathComponent("WallSaves.plist"))
        
        do {
            try saveData.write(to: path)
        } catch {
            
        }
    }
    
    
}


