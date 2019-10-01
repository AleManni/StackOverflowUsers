//
//  ErrorBannerView.swift
//  SharedComponents
//
//  Created by Alessandro Manni on 20/08/2018.
//  Copyright © 2018 Alessandro Manni. All rights reserved.
//

import Foundation
import UIKit

/**
 This class provides a warning/error banner to be displayed as a non-removable element of the view
 */
public final class ErrorBannerView: UIView {

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.numberOfLines = 0
    FontFormatter.format(label: label, textStyle: (.bodyVerySmallBold, .white))
    return label
  }()

  public override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  private func setupView() {
    backgroundColor = Colours.red.rawValue
    addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
    titleLabel.topAnchor.constraint(equalTo: topAnchor),
    titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
    titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
    titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func setWarning(text: String?) {
    titleLabel.text = text
  }
}
