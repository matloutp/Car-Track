//
//  SQLiteCommands.swift
//  Car Track
//
//  Created by Thapelo on 2021/12/23.
//

import Foundation
import SQLite

class SQLiteCommands {
    
    static var loginVC: LoginViewController?
    
    static var table = Table("users")
    
    static let id = Expression<Int>("id")
    static let fullName = Expression<String>("fullName")
    static let email = Expression<String>("email")
    static let password = Expression<String>("password")
    static let country = Expression<String>("country")
    static let photo = Expression<Data>("photo")
    
    static func createTable(){
        
        guard let database = SQLiteDatabase.sharedInstance.database else {
            
            print("Datastore connection error")
            
            return
            
        }
        
        do {
            
            try database.run(table.create(ifNotExists: true) { table in
                
                table.column(id, primaryKey: true)
                table.column(fullName)
                table.column(email, unique: true)
                table.column(password)
                table.column(country)
                table.column(photo)
                
            })
            
        } catch {
            
            print("Table already exists: \(error)")
            
        }
    }
    
    static func insertRow(_ userValues: User, passedLoginVC: LoginViewController) -> Bool? {
        
        loginVC = passedLoginVC
        
        guard let database = SQLiteDatabase.sharedInstance.database else {
            
            print("Datastore connection error")
            
            return nil
            
        }
        
        do {
            
            try database.run(table.insert(fullName <- userValues.fullName, email <- userValues.email, password <- userValues.password, country <- userValues.country, photo <- userValues.photo))
            
            return true
            
        } catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
            
            if message.contains("UNIQUE constraint") {
                
                loginVC?.existingUserAlertF()
                
            }
            
            print("Insert row failed: \(message), in \(String(describing: statement))")
            
            return false
            
        } catch let error {
            
            print("Insertion failed: \(error)")
            
            return false
        }
        
    }
    
    static func presentRows() -> [User]? {
        
        guard let database = SQLiteDatabase.sharedInstance.database else {
            
            print("Datastore connection error")
            
            return nil
        }
        
        var userArray = [User]()
        
        table = table.order(id.desc)
        
        do {
            
            for user in try database.prepare(table) {
                
                let idValue = user[id]
                let fullNameValue = user[fullName]
                let emailValue = user[email]
                let passswordValue = user[password]
                let countryValue = user[country]
                let photoValue = user[photo]
                
                let userObject = User(id: idValue, fullName: fullNameValue, email: emailValue, password: passswordValue, country: countryValue, photo: photoValue)
                
                userArray.append(userObject)
                
                print("id: \(user[id]), name: \(user[fullName]), email: \(user[email]), password: \(user[password]), country: \(user[country]), photo: \(user[photo])")
                
            }
            
        }catch {
            
            print("Present row error: \(error)")
        }
        
        return userArray
        
    }
            
    
}
