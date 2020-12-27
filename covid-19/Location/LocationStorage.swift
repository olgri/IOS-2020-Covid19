//
//  LocationStorage.swift
//  covid-19
//
//  Created by Oleg Gribovsky on 22.12.20.
//
import Foundation
import CoreLocation

class LocationsStorage {
  static let shared = LocationsStorage()
  
  private(set) var locations: [Location]
  private let fileManager: FileManager
  private let documentsURL: URL
  
  init() {
    let fileManager = FileManager.default
    documentsURL = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    self.fileManager = fileManager
    self.locations = []
  }
}
