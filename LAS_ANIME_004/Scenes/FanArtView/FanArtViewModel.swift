//
//  FanArtViewModel.swift
//  LAS_ANIME_004
//
//  Created by Khanh Vu on 05/10/2023.
//

import Foundation
import RxSwift
import RxCocoa

class FanArtViewModel: BaseViewModel {
    private var service: FanArtUseCase
    init(useCase: FanArtUseCase) {
        self.service = useCase
    }
    
//    func transform(_ input: Input) -> Output {
//        let quoteDay = input.loadTrigger
//            .flatMapLatest { _ in
//                return self.service.getQuoteOfDay()
//                    .trackError(self.errorTracker)
//                    .trackActivity(self.loading)
//                    .asDriverOnErrorJustComplete()
//            }
//        return Output(quoteDay: quoteDay)
//    }
}

extension FanArtViewModel {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let quoteDay: Driver<AnimeQuoteDayModel>
    }
}
