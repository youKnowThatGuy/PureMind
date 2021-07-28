//
//  PoliciesFullPresenter.swift
//  PureMind
//
//  Created by Клим on 12.07.2021.
//

import UIKit

protocol PoliciesFullPresenterProtocol{
    init(view: PoliciesFullViewProtocol)
    func prepareCell(cell: PolicyFullViewCell, index: Int)
    func getTitleText(index: Int) -> String
    func countData() -> Int
}

class PoliciesFullPresenter: PoliciesFullPresenterProtocol{
    weak var view: PoliciesFullViewProtocol?
    
    required init(view: PoliciesFullViewProtocol) {
        self.view = view
    }
    
    func prepareCell(cell: PolicyFullViewCell, index: Int) {
        cell.policyTitleLabel.text = "Правило №\(index + 1)"
        cell.descriptionLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas pharetra nisi et augue blandit cursus a id risus. Maecenas mollis tellus ut lorem vehicula, a tincidunt tellus tempor. Curabitur hendrerit dictum dolor, a gravida libero maximus nec. Donec non aliquam metus. Nunc a mi massa. Aenean dictum ligula vel lacus tristique pretium. Etiam tincidunt blandit tristique. Fusce imperdiet, dolor sit amet pulvinar dictum, mauris nibh consectetur neque, quis feugiat mi magna quis quam. Nulla aliquam, mauris ut malesuada aliquam, magna risus sagittis est, et aliquet leo orci vitae erat. Curabitur dapibus scelerisque mauris, nec porta mi convallis at. Quisque ac facilisis ligula. Suspendisse fringilla sem at ipsum eleifend volutpat. In eleifend, elit sit amet interdum porta, turpis massa aliquam sapien, nec porta lorem erat at nibh. Nulla elementum finibus ligula id molestie."
    }
    
    func getTitleText(index: Int) -> String {
        return "Правило №\(index + 1)"
    }
    
    func countData() -> Int {
        return 14
    }
    
    
}
