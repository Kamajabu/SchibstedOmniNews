//
//  TopicDetailsViewController.swift
//  OmniNews
//
//  Created by Kamil Buczel on 07/10/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import EasyPeasy
import Foundation
import RxSwift
import UIKit

class TopicDetailsViewController: UIViewController {
    private let model: Topic
    private let disposeBag = DisposeBag()
    private let margin: CGFloat = 10

    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFont(ofSize: 20)
        descriptionLabel.textAlignment = .left
        descriptionLabel.contentMode = .topLeft
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = model.type?.rawValue
        return descriptionLabel
    }()

    init(model: Topic) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        view.backgroundColor = .white
        title = model.title

        view.addSubview(descriptionLabel)
        descriptionLabel.easy.layout(
            Top(margin).to(view.safeAreaLayoutGuide, .top),
            Left(margin).to(view.safeAreaLayoutGuide, .left),
            Right(margin).to(view.safeAreaLayoutGuide, .right),
            Height(30)
        )
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
