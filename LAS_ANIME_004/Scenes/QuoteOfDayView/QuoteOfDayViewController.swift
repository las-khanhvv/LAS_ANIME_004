//
//  QuoteOfDayViewController.swift
//  LAS_ANIME_004
//
//  Created by Khanh Vu on 05/10/2023.
//

import UIKit
import RxSwift
import RxCocoa

class QuoteOfDayViewController: BaseViewController {

    //MARK: - Outlet
    @IBOutlet weak var quoteImaeView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var animeNameLabel: UILabel!
    @IBOutlet weak var animeCharacterLabel: UILabel!
    @IBOutlet weak var quotesLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    //MAKR: - Property
    var viewModel: QuoteOfDayViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        bindViewModel()
    }
    
    //MARK: - Private
    private func setUpUI() {
        titleLabel.textColor = .colorFF4E2F
        animeNameLabel.textColor = .color242833
        animeCharacterLabel.textColor = .color8B8B8B
        quotesLabel.textColor = .color2E2E2E
        contentView.layer.cornerRadius = 20
        contentView.setShadow(offset: CGSize(width: 0, height: 6), radius: 14, color: .black, opacity: 0.14)
        contentView.alpha = 0
    }
    
    private func bindViewModel() {
        let input = QuoteOfDayViewModel.Input(loadTrigger: rx.viewWillAppear.take(1).asDriverOnErrorJustComplete())
        
        let output = viewModel.transform(input)
        
        output.quoteDay
            .drive(onNext: { [weak self] item in
                self?.animeNameLabel.text = item.animeName
                self?.animeCharacterLabel.text = item.animeCharacter
                self?.quotesLabel.text = item.quote
                self?.quoteImaeView.setImage(item.quoteURL, nil)
                self?.contentView.alpha = 1
            })
            .disposed(by: disposeBag)
    }

}
