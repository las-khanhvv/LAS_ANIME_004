//
//  FanArtViewController.swift
//  LAS_ANIME_004
//
//  Created by Khanh Vu on 05/10/2023.
//

import UIKit

class FanArtViewController: BaseViewController {

    //MARK: - Outlet
    @IBOutlet weak var fanArtTableView: UITableView!
    
    //MARK: - Property
    let data = APIPath.FanArt.allCases
    var viewModel: FanArtViewModel!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
    
    //MARK: - Private
    private func setUpUI() {
        fanArtTableView.delegate = self
        fanArtTableView.dataSource = self
        fanArtTableView.register(FanArtTableViewCell.nibClass, forCellReuseIdentifier: FanArtTableViewCell.nibNameClass)
        fanArtTableView.contentInset = .init(top: 0, left: 0, bottom: 30, right: 0)
    }
    
    private func goToViewAll(data: FanArtModel) {
        let vc = ViewAllFanArtViewController()
        vc.fanArts.accept(data)
        push(vc)
    }
}

//MARK: Extension UITableView
extension FanArtViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if BaseService.isReachable {
            return data.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FanArtTableViewCell.cellId) as! FanArtTableViewCell
        cell.configure(viewModel: viewModel, path: data[indexPath.row])
        cell.seeAllButtonTapped = { [weak self] data in
            self?.goToViewAll(data: data)
        }
        return cell
    }
}
