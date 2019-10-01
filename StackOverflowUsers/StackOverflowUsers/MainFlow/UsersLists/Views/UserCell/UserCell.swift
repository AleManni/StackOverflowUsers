//
//  UserCell.swift
//  StackOverflowUsers
//
//  Created by Alessandro Manni on 30/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

import UIKit
import SharedComponents


protocol UserCellDelegate: class {
  func cellDidTapPrimaryButton(_ cell: UserCell)
  func cellDidTapSecondaryButton(_ cell: UserCell)
}

final class  UserCell: UITableViewCell {
  
  @IBOutlet weak var mainImageView: UIImageView!
  @IBOutlet weak var followLabel: UILabel!
  @IBOutlet weak var primaryLabel: UILabel!
  @IBOutlet weak var secondaryLabel: UILabel!
  @IBOutlet weak var primaryButton: UIButton!
  @IBOutlet weak var secondaryButton: UIButton!
  @IBOutlet weak var disclosableView: UIView!
  static let identifier = "userCellIdentifier"
  
  weak var delegate: UserCellDelegate?
  
  //MAR: - life cycle
  override func awakeFromNib() {
    super.awakeFromNib()
    formatViews()
    disclosableView.isHidden = true
  }
  
  private func formatViews() {
    FontFormatter.format(label: followLabel, textStyle: (font: .bodyLargeBold, color: .red))
    FontFormatter.format(button: primaryButton, textStyle: (font: .bodySmallRegular, color: .white))
    FontFormatter.format(button: secondaryButton, textStyle: (font: .bodySmallRegular, color: .white))
    primaryButton.backgroundColor = Colours.navyBlue.rawValue
    secondaryButton.backgroundColor = Colours.red.rawValue
    primaryButton.layer.cornerRadius = 8
    secondaryButton.layer.cornerRadius = 8
    mainImageView.layer.cornerRadius = 5
    mainImageView.layer.masksToBounds = true
    separatorInset.left = mainImageView.frame.minX
  }
  
  func populate(with viewModel: UserCellViewModel) {
    disclosableView.isHidden = !viewModel.isDisclosed
    mainImageView.setImageWithURLString(viewModel.mainImageURL, placeholder: nil)
    followLabel.text = viewModel.icon
    primaryLabel.text = viewModel.primaryLabelText
    secondaryLabel.text = viewModel.secondaryLabelText
    primaryButton.setTitle(viewModel.primaryButtonTitle, for: .normal)
    secondaryButton.setTitle(viewModel.secondayButtonTitle, for: .normal)
    let textColor = viewModel.isDisabled ? Colours.custom(.gray) : Colours.navyBlue
    let alpha: CGFloat = viewModel.isDisabled ? 0.5 : 1
    FontFormatter.format(label: primaryLabel, textStyle: (font: .bodyRegular, color: textColor))
    FontFormatter.format(label: secondaryLabel, textStyle: (font: .bodySmallRegular, color: textColor))
    followLabel.alpha = alpha
    mainImageView.alpha = alpha
    }
  
  //MARK: - user actions
  
  @IBAction func didTapPrimaryButton(_ sender: Any) {
    delegate?.cellDidTapPrimaryButton(self)
  }
  
  @IBAction func didTapSecondaryButton(_ sender: Any) {
    delegate?.cellDidTapSecondaryButton(self)
  }
}
