//
//  TaskListCell.swift
//  ToDoEveryday
//
//  Created by Rahul Singh on 24/03/24.
//

import UIKit

class TaskListCell: UITableViewCell {
    
    var valueLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Create and configure the label
        valueLabel = UILabel(frame: CGRect(x: 20, y: 10, width: contentView.frame.width - 40, height: contentView.frame.height - 20))
        valueLabel.numberOfLines = 0
        contentView.addSubview(valueLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
