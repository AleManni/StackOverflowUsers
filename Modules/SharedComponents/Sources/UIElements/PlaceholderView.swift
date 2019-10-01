//
//  PlaceholderView.swift
//  SharedComponents
//
//  Created by Alessandro Manni on 20/08/2018.
//  Copyright © 2018 Alessandro Manni. All rights reserved.
//

import Foundation
import UIKit

/**
 This class provides a placeholder when there are not elements to be displayed on screen.
 It needs to be initilised using the provided build function
 */
public final class PlaceHolderView: UIView {

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.numberOfLines = 0
    FontFormatter.format(label: label, textStyle: (.titleVeryLargeHeavy, .navyBlue))
    return label
  }()

  private lazy var subtitleLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.numberOfLines = 0
    FontFormatter.format(label: label, textStyle: (.bodyVerySmallRegular, .navyBlue))
    return label
  }()

  // MARK: Constructors

  override public init(frame: CGRect) {
    fatalError("This class accepts only the initializer (title: String, subtitle: String)")
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  public init() {
    super.init(frame: .zero)
    setSubviews()
    setConstraints()
  }

  private func setSubviews() {
    backgroundColor = .white

    addSubview(titleLabel)
    addSubview(subtitleLabel)
  }

  private func setConstraints() {
    let kMargin: CGFloat = 16

    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
    titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: kMargin),
    titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -kMargin),
    titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -kMargin),

    subtitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
    subtitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
    subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: kMargin),
    subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -kMargin),
    subtitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -kMargin)])
  }

  // MARK: Content setter
  func populate(with viewModel: PlaceholderViewModel) {
    titleLabel.text = viewModel.primaryText
    subtitleLabel.text = viewModel.secondaryText
  }
}
