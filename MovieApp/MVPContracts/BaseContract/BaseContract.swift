//
//  BaseContract.swift
//  MovieApp
//
//  Created by azab on 2/27/20.
//  Copyright © 2020 azab. All rights reserved.
//

import Foundation

protocol IBaseView {
    
    func showLoading()
    func hideLoading()
    func showErrorMessage(errorMessage : String)
}
