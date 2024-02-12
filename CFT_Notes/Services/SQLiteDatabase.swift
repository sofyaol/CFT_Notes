//
//  SQLiteDatabase.swift
//  CFT_Notes
//
//  Created by Sofya Olekhnovich on 11.02.2024.
//
import SQLite

class SQLiteDatabase {
    static let shared = SQLiteDatabase()
    var database: Connection?
    
    private var table = Table("notes")
    
    private let id = Expression<Int64>("id")
    private let title = Expression<String>("title")
    private let text = Expression<String>("text")
    private let creationDate = Expression<Date>("creationDate")

    private init() {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory,
                                                                in: .userDomainMask,
                                                                appropriateFor: nil,
                                                                create: true)
            let fileUrl = documentDirectory
                .appendingPathComponent("Notes")
                .appendingPathExtension("sqlite3")

            database = try Connection(fileUrl.path)

        } catch {
            print("Connection to database failed: \(error)")
        }
    }
    
    func createTable() {
        guard let database = SQLiteDatabase.shared.database else {
            print("Connection to database failed while create table")
            return
        }
        
        do {
            try database.run(table.create(ifNotExists: true) {table in
                table.column(id, primaryKey: true)
                table.column(title)
                table.column(text)
                table.column(creationDate)
            })
        } catch {
            print("Table already exists: \(error)")
        }
    }
    
    func insertRow(_ note: Note) -> Int64? {
        guard let database = SQLiteDatabase.shared.database else {
            print("Connection to database failed while insert row")
            return nil
        }
        
        do {
             return try database.run(table.insert(
                title <- note.title,
                text <- note.text,
                creationDate <- note.creationDate))
        } catch {
            print("Insert row failed \(error)")
            return nil
        }
    }
    
    func getRows() -> [Note]? {
        guard let database = SQLiteDatabase.shared.database else {
            print("Connection to database failed while get rows")
            return nil
        }
        
        var notes = [Note]()
        
        table = table.order(id.asc)
        
        do {
            for note in try database.prepare(table) {
                let noteObject = Note(id: note[id], title: note[title], text: note[text], creationDate: note[creationDate])
                notes.append(noteObject)
            }
        } catch {
            print("Get row failed \(error)")
            return nil
        }
        
        return notes
    }
    
    func updateRow(_ note: Note) -> Bool? {
        guard let database = SQLiteDatabase.shared.database else {
            print("Connection to database failed while update row")
            return nil
        }
        
        let noteObject = table.filter(id == note.id).limit(1)
        
        do {
            if try database.run(noteObject.update(
                title <- note.title,
                text <- note.text,
                creationDate <- note.creationDate)) > 0 {
                return true
               } else { return false }
        } catch {
            print("Update row failed \(error)")
            return false
        }
    }
    
    func deleteRow(id: Int64) {
        guard let database = SQLiteDatabase.shared.database else {
            print("Connection to database failed while delete row")
            return
        }
        
        do {
            let noteObject = table.filter(self.id == id).limit(1)
            try database.run(noteObject.delete())
        } catch {
            print("Delete row failed \(error)")
        }
    }

}
