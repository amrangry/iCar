//
//  VehiclesTableViewCell.swift
//  iCar
//
//  Created by Amr ELghadban on 7/18/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import Kingfisher
import UIKit

class VehiclesTableViewCell: UITableViewCell {

    // MARK: IBoutlets

    @IBOutlet var activityThumbnilLoader: UIActivityIndicatorView!
    @IBOutlet var thumbnilImageView: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var model: UILabel!
    @IBOutlet var transmation: UILabel!
    @IBOutlet var fuel: UILabel!
    @IBOutlet var cleanliness: UILabel!

    // MARK: LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: Helpers

    func bindData(object: Displayable) {
        guard let vehicle = object as? Vehicle else {
            return
        }
        model.text = vehicle.modelName
        name.text = vehicle.name
        fuel.text = "\(fuel.text ?? "Fuel: ")\(vehicle.fuelType?.rawValue ?? "N/A")"
        transmation.text = "\(transmation.text ?? "Transmation: ")\(vehicle.transmission?.displayValue ?? "N/A")"
        cleanliness.text = "\(cleanliness.text ?? "Clean: ")\(vehicle.innerCleanliness?.displayValue ?? "N/A")"
        guard let imageURLString = vehicle.carImageURL, let imageURL = URL(string: imageURLString) else {
            return
        }
        displayImageLoader()
        thumbnilImageView.kf.setImage(with: imageURL, placeholder: UIImage(named: Constants.Theme.defultCellImageName), options: [.transition(.fade(1))], progressBlock: nil) { _, _, _, _ in
            self.dimissImageLoader()
        }
    }

    func dimissImageLoader() {
        DispatchQueue.main.async { () -> Void in
            self.activityThumbnilLoader.stopAnimating()
            self.activityThumbnilLoader.isHidden = true
        }
    }

    func displayImageLoader() {
        DispatchQueue.main.async { () -> Void in
            self.activityThumbnilLoader.startAnimating()
            self.activityThumbnilLoader.isHidden = false
        }
    }
}
