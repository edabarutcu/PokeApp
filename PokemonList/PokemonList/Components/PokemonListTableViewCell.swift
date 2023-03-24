//
//  PokemonListTableViewCell.swift
//  PokemonList
//
//  Created by Eda Barutçu on 22.03.2023.
//

import UIKit

class PokemonListTableViewCell: UITableViewCell {
    
    let nameLabel = UILabel()
    let myImage = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setup(_ pokemonName : String, imageURL: URL) {
        nameLabel.frame = CGRect(x: 100, y: contentView.frame.midY, width: 300, height: 30)
        nameLabel.text = pokemonName
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 20.0)
        myImage.frame = CGRect(x: 0, y: contentView.frame.midY / 2, width: 50, height: 50)
        myImage.load(url: imageURL)
        addSubview(myImage)
        addSubview(nameLabel)
        selectionStyle = .none
    }
    
}

//Extension of UIImageView to load images from URL
extension UIImageView {
    func load(url : URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
            
        }
    }
}
