//
//  GithubService.swift
//  BaseRxswift_MVVM
//
//  Created by Khanh Vu on 02/10/2023.
//

import Foundation
import RxSwift

enum APIPath: String {
    case animeQuote = "/khanhVu-ops/TestJsonData/main/anime_data/anime_quote.json"
    case animeShort = "/khanhVu-ops/TestJsonData/main/anime_data/anime_short.json"
    case animeQuoteDay = "/khanhVu-ops/TestJsonData/main/anime_data/anime_quote_day.json"
}

class GithubService: BaseService {
    static let shared = GithubService()
    
    private override init() {
        super.init()
    }
    
    func getAnimeQuote() -> Single<AnimeQuoteModel>{
        return rxRequest(APIPath.animeQuote.rawValue, .get, of: AnimeQuoteModel.self)
    }
    
    func getAnimeQuoteDay() -> Single<AnimeQuoteDayModel> {
        return rxRequest(APIPath.animeQuoteDay.rawValue, .get, of: AnimeQuoteDayModel.self)
    }
    
    func getAnimeShort() -> Single<AnimeShortsModel> {
        return rxRequest(APIPath.animeShort.rawValue, .get, of: AnimeShortsModel.self)
    }
}
