//
//  HomeUseCase.swift
//  BaseRxswift_MVVM
//
//  Created by Khanh Vu on 02/10/2023.
//

import Foundation
import RxSwift

protocol HomeUseCaseType {
    func getAnimeQuotes() -> Single<AnimeQuoteModel>
}

struct HomeUseCase: HomeUseCaseType {
    
    func getAnimeQuotes() -> Single<AnimeQuoteModel> {
        return GithubService.shared.getAnimeQuote()
    }
}
