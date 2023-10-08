//
//  HomeViewController.swift
//  BaseRxswift_MVVM
//
//  Created by Khanh Vu on 02/10/2023.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: BaseViewController {

    @IBOutlet weak var homeTableView: UITableView!
    
    //MARK:  - Property
    var viewModel: HomeViewModel!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        bindViewModel()
    }
    
    
    // MARK: - Private
    private func setUpUI() {
        homeTableView.register(HomeItemCell.nibClass, forCellReuseIdentifier: HomeItemCell.nibNameClass)
        homeTableView.rowHeight = 80
    }
    
    private func bindViewModel() {
        let input = HomeViewModel.Input(loadTrigger: Driver.just(()),
                                        itemSelectedTrigger: homeTableView.rx.itemSelected.asDriver())
        
        let output = viewModel.transfrom(input)
        
        output.quotes
            .drive(homeTableView.rx.items) { tableView, index, item in
                let indexPath = IndexPath(row: index, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: HomeItemCell.nibNameClass, for: indexPath) as! HomeItemCell
                cell.configure(item)
                return cell
            }
            .disposed(by: disposeBag)
        
        output.selected
            .drive()
            .disposed(by: disposeBag)
    }
}
