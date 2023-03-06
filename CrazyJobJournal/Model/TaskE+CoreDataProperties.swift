//
//  TaskE+CoreDataProperties.swift
//  CrazyJobJournal
//
//  Created by Mattia Golino on 02/03/23.
//
//

import Foundation
import CoreData


extension TaskE {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskE> {
        return NSFetchRequest<TaskE>(entityName: "TaskE")
    }

    @NSManaged public var desc: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isDone: Bool
    @NSManaged public var title: String?
    @NSManaged public var taskForNote: NoteE?
    @NSManaged public var toJob: JobE?

}

extension TaskE : Identifiable {

}
