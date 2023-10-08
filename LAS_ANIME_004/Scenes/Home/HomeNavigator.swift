//
//  HomeNavigator.swift
//  BaseRxswift_MVVM
//
//  Created by Khanh Vu on 02/10/2023.
//

import Foundation
import UIKit

protocol HomeNavigatorType {
    func toQuoteDayDetail(animeQuoteDay: AnimeQuoteDayModel)
}

struct HomeNavigator: HomeNavigatorType {
    unowned let navigationController: UINavigationController
    
    func toQuoteDayDetail(animeQuoteDay: AnimeQuoteDayModel) {
        
    }
}
