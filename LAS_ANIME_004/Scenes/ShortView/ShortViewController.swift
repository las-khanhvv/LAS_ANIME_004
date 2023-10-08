//
//  ShortViewController.swift
//  LAS_ANIME_004
//
//  Created by Khanh Vu on 05/10/2023.
//

import UIKit
import RxSwift
import RxCocoa

class ShortViewController: BaseViewController {

    //MARK: - Outlet
    @IBOutlet weak var shortCollectionView: UICollectionView!
    
    //MARK: - Property
    var viewModel: ShortViewModel!
    var animeShorts = BehaviorRelay<[AnimeShortModel]>(value: [])
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        bindViewModel()
    }
    
    //MARK: - Private
    private func setUpUI() {
        shortCollectionView.dataSource = self
        shortCollectionView.delegate = self
        shortCollectionView.register(ShortItemCell.nibClass, forCellWithReuseIdentifier: ShortItemCell.nibNameClass)
    }
    
    private func bindViewModel() {
        let input = ShortViewModel.Input(loadTrigger: rx.viewWillAppear.take(1).asDriverOnErrorJustComplete())
        
        let output = viewModel.transform(input)
        
        output.animeShorts
            .drive(onNext: { [weak self] data in
                self?.animeShorts.accept(data)
            })
            .disposed(by: disposeBag)
        
        animeShorts.asDriver()
            .drive(onNext: { [weak self] _ in
                self?.shortCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

//MARK: - Extension UICollectionViewDataSource
extension ShortViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animeShorts.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = shortCollectionView.dequeueReusableCell(withReuseIdentifier: ShortItemCell.nibNameClass, for: indexPath) as! ShortItemCell
        cell.configure(animeShorts.value[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let url = animeShorts.value[indexPath.row].video
        let webViewVC = WebViewController()
        let newURL = "https://youtu.be/\(GithubJsonService.shared.getId(url: url))"
        webViewVC.urlString = url
//        let navi = UINavigationController(rootViewController: webViewVC)
        webViewVC.modalPresentationStyle = .overFullScreen
        self.present(webViewVC, animated: true)
    }
}

//MARK: - Extension UICollectionViewDelegate
extension ShortViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 16, bottom: 20, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 16 * columns - 14) / 2
        let height = width * 322 / 175
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
}
