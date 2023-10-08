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
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        bindViewModel()
    }
    
    //MARK: - Private
    private func setUpUI() {
        fanArtTableView.delegate = self
        fanArtTableView.dataSource = self
    }
    
    private func bindViewModel() {
        
    }
}

//MARK: Extension UITableView
extension FanArtViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
