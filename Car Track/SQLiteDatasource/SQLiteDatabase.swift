//
//  SQLiteDatabase.swift
//  Car Track
//
//  Created by Thapelo on 2021/12/23.
//

import Foundation
import SQLite

class SQLiteDatabase {
    
    static let sharedInstance = SQLiteDatabase()
    var database: Connection?
    
    private init() {
        
        do {
            
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            let fileUrl = documentDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
            
            database = try Connection(fileUrl.path)
            
            print("table created")
            
        } catch {
            
            print("Creating connection to database error: \(error)")
            
        }
    }
    
    func createTable(){
        
        SQLiteCommands.createTable()
        
    }
    
    
}
