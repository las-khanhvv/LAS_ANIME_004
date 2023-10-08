//
//  FanArtUseCase.swift
//  LAS_ANIME_004
//
//  Created by Khanh Vu on 05/10/2023.
//

import Foundation
import RxSwift

protocol FanArtUseCaseType {
    func getQuoteOfDay() -> Single<AnimeQuoteDayModel>
}

struct FanArtUseCase: FanArtUseCaseType {
    
    func getQuoteOfDay() -> Single<AnimeQuoteDayModel> {
        return GithubService.shared.getAnimeQuoteDay()
    }
}
