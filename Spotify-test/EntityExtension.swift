//
//  DayInfo+CoreDataProperties.swift
//
//
//  Created by mvitoriapereirac on 11/11/2023.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData
import UIKit

@objc(DayInfo)
class DayInfoExtension: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayInfoExtension> {
        return NSFetchRequest<DayInfoExtension>(entityName: "DayInfo")
    }

    @NSManaged public var chosenImg: UIImage?
    @NSManaged public var color: NSObject?
    @NSManaged public var current: NSObject?
    @NSManaged public var day: Int16
    @NSManaged public var dayMessage: String?
    @NSManaged public var month: Int16
    @NSManaged public var weekday: Int16

}

extension DayInfoExtension : Identifiable {

}
