//
//  Trainings+CoreDataProperties.swift
//  JustVelo
//
//  Created by Denis Svetlakov on 02.10.2021.
//
//

import Foundation
import CoreData


extension Training {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Training> {
        return NSFetchRequest<Training>(entityName: "Training")
    }

    @NSManaged public var date: Date?
    @NSManaged public var distance: String?
    @NSManaged public var pathPassed: Data?

}

extension Training : Identifiable {

}
