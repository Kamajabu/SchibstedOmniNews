//
//  ArticleListCell.swift
//  OmniNews
//
//  Created by Kamil Buczel on 07/10/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import EasyPeasy
import Foundation
import RxSwift
import UIKit

class ArticleListCell: UITableViewCell {
    private var viewModel: ArticleViewModel?
    private var disposeBag = DisposeBag()
    
    private lazy var thumbnailImage: UIImageView = {
        let thumbnail = UIImageView()
        thumbnail.image = UIImage(named: SharedImages.placeholder)
        thumbnail.contentMode = .scaleAspectFill
        return thumbnail
    }()

    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.backgroundColor = titleBackground
        return titleLabel
    }()
    
    private let margin: CGFloat = 10
    private let titleBackground = UIColor(white: 240/255, alpha: 0.7)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        translatesAutoresizingMaskIntoConstraints = false
        configure()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 0, left: margin, bottom: margin, right: margin)
        contentView.frame = contentView.frame.inset(by: margins)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        disposeBag = DisposeBag()
        thumbnailImage.image = UIImage(named: SharedImages.placeholder)
    }

    func setup(with viewModel: ArticleViewModel) {
        self.viewModel = viewModel

        titleLabel.text = viewModel.title

        updateState(from: viewModel)
    }

    private func configure() {
        contentView.layer.borderWidth = 1
        contentView.clipsToBounds = true
        selectionStyle = .none

        contentView.addSubview(thumbnailImage)
        thumbnailImage.easy.layout(Top(),
                                   Left(),
                                   Bottom(),
                                   Right())

        thumbnailImage.addSubview(titleLabel)
        titleLabel.easy.layout(
            Left(),
            Right(),
            Bottom().to(thumbnailImage, .bottom)
        )
    }

    private func updateState(from viewModel: ArticleViewModel) {
        viewModel.articleThumbnailSingle
            .map { imageData in
                UIImage(data: imageData)
            }.asDriver(onErrorJustReturn: UIImage(named: SharedImages.unexpectedErrorImage))
            .drive(thumbnailImage.rx.image)
            .disposed(by: disposeBag)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
