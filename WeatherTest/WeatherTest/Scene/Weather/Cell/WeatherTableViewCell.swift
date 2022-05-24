//
//  WeatherTableViewCell.swift
//  WeatherTest


import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var cellLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var imgCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(with ville: String, temperature: Float, picto: String) {
        self.cellLbl.text = ville
        let temp = String(format: "%.01f", temperature - 273)

        self.tempLbl.text = "\(temperature) en Kelvin soit \(temp) Degrés"
        self.imgCell.image = UIImage(systemName: self.checkPicto(picto: picto))
    }
    
    func checkPicto(picto: String) -> String{
        switch picto {
        case "Clouds":
            return "cloud"
        case "Clear" :
            return "sun.max"
        case "Rain":
            return "cloud.rain"
        case "Snow":
            return "snow"
        default :
            return ""
        }
    }
}
