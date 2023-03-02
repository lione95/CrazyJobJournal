//
//  JobE+CoreDataProperties.swift
//  CrazyJobJournal
//
//  Created by Mattia Golino on 02/03/23.
//
//

import Foundation
import CoreData


extension JobE {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JobE> {
        return NSFetchRequest<JobE>(entityName: "JobE")
    }

    @NSManaged public var desc: String?
    @NSManaged public var icon: String?
    @NSManaged public var id: UUID?
    @NSManaged public var imageName: String?
    @NSManaged public var isFound: Bool
    @NSManaged public var isChosen: Bool
    @NSManaged public var title: String?
    @NSManaged public var toTask: NSSet?

}

// MARK: Generated accessors for toTask
extension JobE {

    @objc(addToTaskObject:)
    @NSManaged public func addToToTask(_ value: TaskE)

    @objc(removeToTaskObject:)
    @NSManaged public func removeFromToTask(_ value: TaskE)

    @objc(addToTask:)
    @NSManaged public func addToToTask(_ values: NSSet)

    @objc(removeToTask:)
    @NSManaged public func removeFromToTask(_ values: NSSet)

}

extension JobE : Identifiable {

}
