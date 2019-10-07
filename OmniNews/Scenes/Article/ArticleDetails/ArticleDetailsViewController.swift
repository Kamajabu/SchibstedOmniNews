//
//  ArticleDetailsViewController.swift
//  OmniNews
//
//  Created by Kamil Buczel on 07/10/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import EasyPeasy
import Foundation
import RxSwift
import UIKit

class ArticlesDetailsViewController: UIViewController {
    private lazy var thumbnailImage: UIImageView = {
        let thumbnail = UIImageView()
        thumbnail.image = UIImage(named: SharedImages.placeholder)
        thumbnail.contentMode = .scaleAspectFill
        thumbnail.clipsToBounds = true
        return thumbnail
    }()

    private lazy var descriptionText: UITextView = {
        let description = UITextView()
        description.font = UIFont.systemFont(ofSize: 20)
        description.textAlignment = .left
        description.contentMode = .topLeft
        description.text = viewModel.details
        return description
    }()

    private let viewModel: ArticleViewModel
    private let disposeBag = DisposeBag()
    private let margin: CGFloat = 10

    init(viewModel: ArticleViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        viewModel.articleThumbnailSingle
            .map { imageData in
                UIImage(data: imageData)
            }
            .asDriver(onErrorJustReturn: UIImage(named: SharedImages.unexpectedErrorImage))
            .drive(thumbnailImage.rx.image)
            .disposed(by: disposeBag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        view.backgroundColor = .white
        title = viewModel.title
        view.addSubview(thumbnailImage)
        thumbnailImage.easy.layout(
            Top().to(view.safeAreaLayoutGuide, .top),
            Left(),
            Right(),
            Height(200)
        )

        view.addSubview(descriptionText)
        descriptionText.easy.layout(
            Top(margin).to(thumbnailImage),
            Left(margin).to(view.safeAreaLayoutGuide, .left),
            Right(margin).to(view.safeAreaLayoutGuide, .right),
            Bottom(margin)
        )
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
