//
//  HomeViewModel.swift
//  BaseRxswift_MVVM
//
//  Created by Khanh Vu on 02/10/2023.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: BaseViewModel {
    private var navigator: HomeNavigator
    private var service: HomeUseCase
    
    init(navigator: HomeNavigator, useCase: HomeUseCase) {
        self.navigator = navigator
        self.service = useCase
    }
    
    func transfrom(_ input: Input) -> Output {
        let quotes = input.loadTrigger
            .flatMapLatest { _ in
                return self.service.getAnimeQuotes()
                    .trackError(self.errorTracker)
                    .map({ animeQuote in
                        return animeQuote.data
                    })
                    .asDriverOnErrorJustComplete()
            }
    
        let selected = input.itemSelectedTrigger
            .withLatestFrom(quotes) { indexPath, quotes in
                return quotes[indexPath.row]
            }
            .do(onNext: { quote in
                self.navigator.toQuoteDayDetail(animeQuoteDay: quote)
            })
            .mapToVoid()
                
        return Output(quotes: quotes, selected: selected)
    }
}

extension HomeViewModel {
    struct Input {
        let loadTrigger: Driver<Void>
        let itemSelectedTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let quotes: Driver<[AnimeQuoteDayModel]>
        let selected: Driver<Void>
    }
}
