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

//private var itemId: String?
  
  weak var delegate: UserCellDelegate?
  
  private var isOpen: Bool = false {
    didSet {
      disclosableView.isHidden = !isOpen
    }
  }
  
  //MAR: - life cycle
  override func awakeFromNib() {
    super.awakeFromNib()
    formatViews()
    disclosableView.isHidden = true
  }
  
  private func formatViews() {
    FontFormatter.format(label: primaryLabel, textStyle: (font: .bodyRegular, color: .navyBlue))
    FontFormatter.format(label: secondaryLabel, textStyle: (font: .bodySmallRegular, color: .navyBlue))
    FontFormatter.format(label: followLabel, textStyle: (font: .bodyLargeBold, color: .red))
    FontFormatter.format(button: primaryButton, textStyle: (font: .bodySmallRegular, color: .white))
    FontFormatter.format(button: secondaryButton, textStyle: (font: .bodySmallRegular, color: .white))
    primaryButton.backgroundColor = Colours.navyBlue.rawValue
    secondaryButton.backgroundColor = Colours.red.rawValue
    primaryButton.layer.cornerRadius = 2
    secondaryButton.layer.cornerRadius = 2
    mainImageView.layer.cornerRadius = 5
    mainImageView.layer.masksToBounds = true
  }
  
  func populate(with viewModel: UserCellViewModel) {
    mainImageView.setImageWithURLString(viewModel.mainImageURL, placeholder: nil)
    followLabel.text = viewModel.icon
    primaryLabel.text = viewModel.primaryLabelText
    secondaryLabel.text = viewModel.secondaryLabelText
    primaryButton.setTitle(viewModel.primaryButtonTitle, for: .normal)
    secondaryButton.setTitle(viewModel.secondayButtonTitle, for: .normal)
  }
  
  //MARK: - user actions
  func didTouch() {
    isOpen.toggle()
  }
  
  @IBAction func didTapPrimaryButton(_ sender: Any) {
    delegate?.cellDidTapPrimaryButton(self)
  }
  
  @IBAction func didTapSecondaryButton(_ sender: Any) {
    delegate?.cellDidTapSecondaryButton(self)
  }
}
