//
//  ReturnAndWarrantyTableViewCell.swift
//  Stuffy
//
//  Created by Adam on 19/07/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class ReturnAndWarrantyTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func getUpCommingReturnDates() -> (date1: String,date2: String,date3: String){
        var date1 = ""
        var date2 = ""
        var date3 = ""
        if CoreDataController.shared.items.count > 0 {
            let items = CoreDataController.shared.items
            let closestDateItemArray = items.sorted { $0.returnDate! < $1.returnDate! }
            let df = DateFormatter()
            df.dateFormat = "MM/dd/yyyy"
            
            if items.count == 1 {
                date1 =  df.string(from: closestDateItemArray[0].returnDate ?? Date())
            }
            if items.count == 2 {
                date1 = df.string(from: closestDateItemArray[0].returnDate ?? Date())
                date2 = df.string(from: closestDateItemArray[1].returnDate ?? Date())
            }
            if items.count > 2 {
                date1 = df.string(from: closestDateItemArray[0].returnDate ?? Date())
                date2 = df.string(from: closestDateItemArray[1].returnDate ?? Date())
                date3 = df.string(from: closestDateItemArray[2].returnDate ?? Date())
                
            }
        }
        return (date1,date2,date3)
    }
    func getUpCommingReturnItemNames() -> (item1Name: String, item2Name: String, item3Name: String){
        var item1Name = ""
        var item2Name = ""
        var item3Name = ""
        
        if CoreDataController.shared.items.count > 0 {
            let items = CoreDataController.shared.items
            let closestDateItemArray = items.sorted { $0.returnDate! < $1.returnDate! }
            
            if items.count == 1 {
                item1Name =  closestDateItemArray[0].name ?? "None"
            }
            if items.count == 2 {
                item1Name =  closestDateItemArray[0].name ?? "None"
                item2Name = closestDateItemArray[1].name ?? "None"
            }
            if items.count > 2 {
                item1Name =  closestDateItemArray[0].name ?? "None"
                item2Name = closestDateItemArray[1].name ?? "None"
                item3Name = closestDateItemArray[2].name ?? "None"
            }
            
        }
        
        return (item1Name, item2Name, item3Name)
        
    }
    
    func getUpCommingWarrantyDates() -> (date1: String,date2: String,date3: String){
        var date1 = ""
        var date2 = ""
        var date3 = ""
        if CoreDataController.shared.items.count > 0 {
            let items = CoreDataController.shared.items
            let closestDateItemArray = items.sorted { $0.warrantyDate! < $1.warrantyDate! }
            let df = DateFormatter()
            df.dateFormat = "MM/dd/yyyy"
            
            if items.count == 1 {
                date1 = df.string(from: closestDateItemArray[0].warrantyDate ?? Date())
            }
            if items.count == 2 {
                date1 =  df.string(from: closestDateItemArray[0].warrantyDate ?? Date())
                date2 = df.string(from: closestDateItemArray[1].warrantyDate ?? Date())
            }
            if items.count > 2 {
                date1 = df.string(from: closestDateItemArray[0].warrantyDate ?? Date())
                date2 = df.string(from: closestDateItemArray[1].warrantyDate ?? Date())
                date3 = df.string(from: closestDateItemArray[2].warrantyDate ?? Date())
                
            }
        }
        return (date1,date2,date3)
    }
    
    func getUpComingWarrantyTitles()-> (item1Name: String, item2Name: String, item3Name: String){
        var item1Name = ""
        var item2Name = ""
        var item3Name = ""
        if CoreDataController.shared.items.count > 0 {
            let items = CoreDataController.shared.items
            let closestDateItemArray = items.sorted { $0.warrantyDate! < $1.warrantyDate! }
            
            if items.count == 1 {
                item1Name =  closestDateItemArray[0].name ?? "None"
            }
            if items.count == 2 {
                item1Name =  closestDateItemArray[0].name ?? "None"
                item2Name = closestDateItemArray[1].name ?? "None"
            }
            if items.count > 2 {
                item1Name =  closestDateItemArray[0].name ?? "None"
                item2Name = closestDateItemArray[1].name ?? "None"
                item3Name = closestDateItemArray[2].name ?? "None"
            }
        }
        return (item1Name, item2Name, item3Name)
    
    }
        

}
    

