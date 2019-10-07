//
//  ArticlesListViewController.swift
//  OmniNews
//
//  Created by Kamil Buczel on 07/10/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import EasyPeasy
import RxCocoa
import RxSwift
import UIKit

protocol ArticlesListViewControllerDelegate: class {
    func didSelectArticle(_ selectedArticle: ArticleViewModel)
}

class ArticlesListViewController: UIViewController {
    private weak var delegate: ArticlesListViewControllerDelegate?
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none

        tableView.delegate = self
        tableView.dataSource = self

        tableView.rowHeight = 150
        tableView.register(ArticleListCell.self,
                           forCellReuseIdentifier: ArticleListCell.reuseIdentifier)

        return tableView
    }()

    private let viewModel: ArticlesListViewModel
    private let disposeBag = DisposeBag()

    init(viewModel: ArticlesListViewModel,
         delegate: ArticlesListViewControllerDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate

        super.init(nibName: nil, bundle: nil)

        viewModelOutput()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        view.backgroundColor = .white

        view.addSubview(tableView)
        tableView.easy.layout(
            Top(6).to(view.safeAreaLayoutGuide, .top),
            Left(6).to(view.safeAreaLayoutGuide, .left),
            Right(6).to(view.safeAreaLayoutGuide, .right),
            Bottom()
        )
    }

    private func viewModelOutput() {
        viewModel
            .articlesListSingle
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] _ in
                self?.tableView.reloadData()
            }, onError: { [weak self] error in
                let alert = UIAlertController(title: "Fetching data failed",
                                              message: error.localizedDescription,
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))

                self?.present(alert, animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ArticlesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return viewModel.articlesCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleListCell.reuseIdentifier,
                                                       for: indexPath as IndexPath) as? ArticleListCell else {
            return UITableViewCell()
        }

        guard let viewModel = viewModel.articleViewModel(for: indexPath.row) else {
            return UITableViewCell()
        }

        cell.setup(with: viewModel)

        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel.articleViewModel(for: indexPath.row) else {
            return
        }

        delegate?.didSelectArticle(viewModel)
    }
}
