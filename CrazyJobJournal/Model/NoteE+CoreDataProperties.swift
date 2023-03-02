//
//  NoteE+CoreDataProperties.swift
//  CrazyJobJournal
//
//  Created by Mattia Golino on 02/03/23.
//
//

import Foundation
import CoreData


extension NoteE {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteE> {
        return NSFetchRequest<NoteE>(entityName: "NoteE")
    }

    @NSManaged public var date: Date?
    @NSManaged public var desc: String?
    @NSManaged public var id: UUID?
    @NSManaged public var noteForTask: TaskE?

}

extension NoteE : Identifiable {

}
