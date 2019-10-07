//
//  TopicsListViewController.swift
//  OmniNews
//
//  Created by Kamil Buczel on 07/10/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import EasyPeasy
import RxCocoa
import RxSwift
import UIKit

protocol TopicsListViewControllerDelegate: class {
    func didSelectTopic(_ selectedTopic: Topic)
}

class TopicsListViewController: UIViewController {
    private weak var delegate: TopicsListViewControllerDelegate?
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none

        tableView.delegate = self
        tableView.dataSource = self

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)

        return tableView
    }()

    private let viewModel: TopicsListViewModel
    private let disposeBag = DisposeBag()
    private let cellIdentifier = "BasicTopicCell"

    init(viewModel: TopicsListViewModel,
         delegate: TopicsListViewControllerDelegate) {
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
            .topicsListSingle
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

extension TopicsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return viewModel.topicsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath)

        let title = viewModel.topicTitle(for: indexPath.row)
        cell.textLabel?.text = "\(title)"
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let topic = viewModel.topic(for: indexPath.row) else {
            return
        }

        delegate?.didSelectTopic(topic)
    }
}
