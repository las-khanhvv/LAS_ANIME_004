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
    
    func transform(_ input: Input, category: APIPath.FanArt) -> Output {
        let fanArt = input.loadTrigger
            .flatMapLatest { _ in
                switch category {
                case .gintama:
                    return self.service.getFanArtGintama()
                        .trackError(self.errorTracker)
                        .trackActivity(self.loading)
                        .share(replay: 1, scope: .forever)
                        .asDriverOnErrorJustComplete()
                    
                case .honkai_tag:
                    return self.service.getFanArtHonkaiTag()
                        .trackError(self.errorTracker)
                        .trackActivity(self.loading)
                        .share(replay: 1, scope: .forever)
                        .asDriverOnErrorJustComplete()
                case .jujutsu_kaisen:
                    return self.service.getFanArtJujutsuKaisen()
                        .trackError(self.errorTracker)
                        .trackActivity(self.loading)
                        .share(replay: 1, scope: .forever)
                        .asDriverOnErrorJustComplete()
                case .nisekoi:
                    return self.service.getFanArtNisekoi()
                        .trackError(self.errorTracker)
                        .trackActivity(self.loading)
                        .share(replay: 1, scope: .forever)
                        .asDriverOnErrorJustComplete()
                case .one_piece:
                    return self.service.getFanArtOnePiece()
                        .trackError(self.errorTracker)
                        .trackActivity(self.loading)
                        .share(replay: 1, scope: .forever)
                        .asDriverOnErrorJustComplete()
                case .oshi_no_ko:
                    return self.service.getFanArtOshiNoKo()
                        .trackError(self.errorTracker)
                        .trackActivity(self.loading)
                        .share(replay: 1, scope: .forever)
                        .asDriverOnErrorJustComplete()
                case .suki_na_ko_ga_Megane_wo_Wasureta:
                    return self.service.getFanArtSukiNaKoGa()
                        .trackError(self.errorTracker)
                        .trackActivity(self.loading)
                        .share(replay: 1, scope: .forever)
                        .asDriverOnErrorJustComplete()
                case .vocaloid:
                    return self.service.getFanArtVocaloid()
                        .trackError(self.errorTracker)
                        .trackActivity(self.loading)
                        .share(replay: 1, scope: .forever)
                        .asDriverOnErrorJustComplete()
                }
            }
        return Output(fanArt: fanArt)
    }
}

extension FanArtViewModel {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let fanArt: Driver<FanArtModel>
    }
}
