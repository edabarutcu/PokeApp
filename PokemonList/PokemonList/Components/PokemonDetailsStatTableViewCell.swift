//
//  PokemonDetailsStatsTableViewCell.swift
//  PokemonList
//
//  Created by Eda Barutçu on 22.03.2023.
//

import UIKit

class PokemonDetailsStatTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let valueLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(statistic: Stat) {
        if let statisticName = statistic.stat?.name, let statisticValue = statistic.baseStat {
            titleLabel.text = statisticName + ":"
            valueLabel.text = String(statisticValue)
        }
        
        //        Adding labels to UI
        titleLabel.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 2.5, height: 50)
        valueLabel.frame = CGRect(x: UIScreen.main.bounds.width / 2, y: 0, width: UIScreen.main.bounds.width / 2.5, height: 50)
        addSubview(titleLabel)
        addSubview(valueLabel)
        valueLabel.textAlignment = .right
        
    }
}
