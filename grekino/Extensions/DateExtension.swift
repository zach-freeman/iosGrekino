//
//  DateExtension.swift
//  grekino
//
//  Created by Zach Freeman on 7/21/25.
//

import Foundation

extension Date {

   func today(format : String = "yyyy-MM-dd") -> String{
      let date = Date()
      let formatter = DateFormatter()
      formatter.dateFormat = format
      return formatter.string(from: date)
   }
}
