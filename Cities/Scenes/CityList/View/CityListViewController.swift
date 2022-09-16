//
//  CityListViewController.swift
//  Cities
//
//  Created by Cửu Long Hoàng on 14/09/2022.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class CityListViewController: UIViewController, UITableViewDelegate {
    
    let searchController: UISearchController = UISearchController(searchResultsController: nil)
    var onViewCityOnMap: ((CityModel) -> Void)
    init(onViewCityOnMap: @escaping ((CityModel) -> Void), nibName nibNameOrNil: String? = nil,
         bundle nibBundleOrNil: Bundle? = nil) {
        self.onViewCityOnMap = onViewCityOnMap
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let tableView: UITableView = UITableView()
    private let viewModel: CityViewModel = CityViewModel()
    private let bag = DisposeBag()
    private var list: CitiesResponse = CitiesResponse()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBarAndTitle()
        setUpTableView()
        viewModel.getCityList()
    }
    
    
    private func setUpSearchBarAndTitle() {
        navigationItem.title = "City"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        navigationItem.searchController = searchController
        navigationController?.navigationBar.backgroundColor = UIColor.white
        searchController.searchBar
            .rx
            .text
            .orEmpty
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe { text in
                self.viewModel.searchBy(prefix: text)
            }.disposed(by: bag)
    }
    
    private func setUpTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
        }
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40   
        
        tableView.rx.modelSelected(CityModel.self).subscribe { [weak self] selectedItem in
            guard let city = selectedItem.element else { return }
            self?.onViewCityOnMap(city)
        }.disposed(by: bag)

        viewModel.list
            .bind(to: tableView.rx.items(cellIdentifier: CityTableViewCell.identifier, cellType: CityTableViewCell.self)) {  (row, item, cell) in
                cell.configCell(cityModel: item)
            }
            .disposed(by: bag)
    }
}
