//
//  ListBusinessViewController.swift
//  BusinessEnamDua
//
//  Created by yxgg on 20/05/23.
//

import UIKit
import RxSwift

class ListBusinessViewController: UIViewController {
    @IBOutlet weak var containerHeaderView: UIView!
    @IBOutlet weak var searchBusinessTextField: UITextField!
    @IBOutlet weak var listBusinessTableView: UITableView!
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .black
        return refreshControl
    }()
    
    private let disposeBag = DisposeBag()
    var viewModel: ListBusinessViewModel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureTableView()
        initObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Helpers
    private func configureViews() {
        containerHeaderView.layer.masksToBounds = true
        containerHeaderView.layer.cornerRadius = 20
        containerHeaderView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        searchBusinessTextField.layer.masksToBounds = true
        searchBusinessTextField.layer.cornerRadius = 8
        searchBusinessTextField.delegate = self
    }
    
    private func configureTableView() {
        listBusinessTableView.register(UINib(nibName: "BusinessTableViewCell", bundle: nil), forCellReuseIdentifier: "BusinessTableViewCell")
        listBusinessTableView.dataSource = self
        listBusinessTableView.delegate = self
        listBusinessTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
    }
    
    private func initObserver() {
        viewModel.isLoading.drive(onNext: { [weak self] isLoading in
            self?.manageLoadingActivity(isLoading: isLoading)
        }).disposed(by: disposeBag)
        
        viewModel.listBusiness.drive(onNext: { [weak self] listBusiness in
            if let listBusiness = listBusiness, !listBusiness.isEmpty {
                self?.listBusinessTableView.clearBackground()
            } else {
                self?.listBusinessTableView.setBackground(imageName: "", imageMessage: "Not Found")
            }
            self?.listBusinessTableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    // MARK: - Actions
    @objc
    private func refreshData() {
        self.refreshControl.endRefreshing()
        self.viewModel.refresh()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ListBusinessViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listBusinessCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessTableViewCell", for: indexPath) as? BusinessTableViewCell else { return UITableViewCell() }
        let business = viewModel.listBusiness(at: indexPath.row)
        cell.configureContent(business: business)
        viewModel.loadListBusinessNextPage(index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailBusinessViewController()
        let id = viewModel.listBusiness(at: indexPath.row)?.id
        vc.id = id
        let viewModel = DetailBusinessViewModel(detailBusinessUseCase: Injection().provideDetailBusinessUseCase())
        vc.viewModel = viewModel
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension ListBusinessViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let vc = SearchBusinessViewController()
        let viewModel = SearchBusinessViewModel(searchBusinessUseCase: Injection().provideSearchBusiness())
        vc.viewModel = viewModel
        navigationController?.pushViewController(vc, animated: true)
        textField.resignFirstResponder()
        return true
    }
}
