//
//  SearchBusinessViewController.swift
//  BusinessEnamDua
//
//  Created by yxgg on 20/05/23.
//

import UIKit
import RxSwift

class SearchBusinessViewController: UIViewController {
    @IBOutlet weak var searchBusinessTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var listBusinessTableView: UITableView!
    
    private let disposeBag = DisposeBag()
    var viewModel: SearchBusinessViewModel!
    
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
        searchBusinessTextField.layer.masksToBounds = true
        searchBusinessTextField.layer.cornerRadius = 8
        searchBusinessTextField.createShadow()
        searchBusinessTextField.clearButtonMode = .whileEditing
        searchBusinessTextField.rx.text.debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(onNext: { value in
                let query = value?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                self.viewModel.setLocation(location: query)
            }).disposed(by: disposeBag)
        cancelButton.addTarget(self, action: #selector(self.cancelButtonTapped), for: .touchUpInside)
    }
    
    private func configureTableView() {
        listBusinessTableView.register(UINib(nibName: "BusinessTableViewCell", bundle: nil), forCellReuseIdentifier: "BusinessTableViewCell")
        listBusinessTableView.dataSource = self
        listBusinessTableView.delegate = self
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
    
    @objc
    private func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension SearchBusinessViewController: UITableViewDataSource, UITableViewDelegate {
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
