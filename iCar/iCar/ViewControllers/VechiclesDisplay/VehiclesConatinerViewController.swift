//
//  VehiclesConatinerViewController.swift
//  iCar
//
//  Created by Amr ELghadban on 7/18/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import UIKit

class VehiclesConatinerViewController: BaseViewController {

    // MARK: - IBOutlet

    @IBOutlet var listButton: UIButton!
    @IBOutlet var mapButton: UIButton!
    @IBOutlet var containerView: UIView!
    @IBOutlet var trailingContraintOfBtnHeighLightBackGround: NSLayoutConstraint!

    // MARK: - Varibles

    private var vehiclesViewModel: VehiclesViewModel?
    private var page: UIPageViewController!
    private var mapVC: MapDisplayViewController!
    private var listVC: ListDisplayViewController!

   // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        page = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        guard let map = MapDisplayViewController.instantiateFromStoryboard() as? MapDisplayViewController else {
            assertionFailure("map vc can't be nil")
            return
        }
        mapVC = map
        guard let list = ListDisplayViewController.instantiateFromStoryboard() as? ListDisplayViewController else {
            assertionFailure("list vc can't be nil")
            return
        }
        listVC = list

        addChildViewController(page)
        containerView.addSubview(page.view)
        page.view.frame = containerView.bounds
        page.didMove(toParentViewController: self)

        didTap(listButton)
    }

    // MARK: - IBAction

    @IBAction func didTap(_ sender: UIButton) {
        sender.isEnabled = false
        sender.setTitleColor(Constants.Theme.mainTiteColor, for: .disabled)
        heighLightsButtonBackground(sender)
        switch sender {
        case mapButton:
            listButton.isEnabled = true
            // listButton.setTitleColor(UIColor(hex: 0xBABABB), for: .normal)
            page.setViewControllers([mapVC], direction: .reverse, animated: true, completion: nil)
        case listButton:
            mapButton.isEnabled = true
            // mapButton.setTitleColor(UIColor(hex: 0xBABABB), for: .normal)
            page.setViewControllers([listVC], direction: .forward, animated: true, completion: nil)
        default:
            break
        }
    }
   // MARK: - Helper
    func heighLightsButtonBackground(_ sender: UIButton) {
        switch sender {
        case mapButton:
            trailingContraintOfBtnHeighLightBackGround.constant = view.frame.width / 2
        case listButton:
            trailingContraintOfBtnHeighLightBackGround.constant = 0
        default:
            break
        }

        UIView.animate(withDuration: 0.3, animations: {
            let newConstantValue = self.trailingContraintOfBtnHeighLightBackGround.constant
            self.trailingContraintOfBtnHeighLightBackGround.constant = newConstantValue
            self.view.layoutIfNeeded()
        })
    }
}

// MARK: - NavigationRouterProtocol
extension VehiclesConatinerViewController: NavigationRouterProtocol {
    static func instantiateFromStoryboard() -> BaseViewController {
        let storyboard = Storyboards.Main.instance
        let identity = self.Identity
        guard let viewController = storyboard.instantiateViewController(withIdentifier: identity) as? VehiclesConatinerViewController else {
            //            assertionFailure("can't instantiate object form storyboard for VehiclesConatinerViewController")
            return self.init()
        }
        return viewController
    }
}
