//
//  SurveyCell.swift
//  nimble
//
//  Created by Chung Tran on 10/25/20.
//

import Foundation

class SurveyCell: BaseCollectionViewCell {
    // MARK: - Subviews
    lazy var fullDatelabel = UILabel(textSize: 13, weight: .medium, textColor: .white)
    lazy var shortDateLabel = UILabel(textSize: 34, weight: .semibold, textColor: .white)
    
    lazy var titleLabel = UILabel(textSize: 28, weight: .semibold, textColor: .white, numberOfLines: 2)
    lazy var descriptionLabel = UILabel(textSize: 17, textColor: .white, numberOfLines: 2)
    lazy var nextButton: UIView = {
        let view = UIView(width: 56, height: 56, backgroundColor: .white, cornerRadius: 28)
        let imageView = UIImageView(width: 12, height: 20, imageNamed: "next-arrow")
        view.addSubview(imageView)
        imageView.autoCenterInSuperview()
        return view
    }()
    
    override func commonInit() {
        super.commonInit()
        
        // configure header
        configureHeader()
        
        // configure footer
        configureFooter()
    }
    
    func setUpWithSurvey(_ survey: ResponseSurvey) {
//        bgImageView.sd_setImage(with: URL(string: survey.cover_image_url ?? ""))
        
        if let date = Date.ISO8601(string: survey.created_at) {
            let fullDateFormatter = DateFormatter()
            fullDateFormatter.dateFormat = "EEEE, MMM d"
            fullDatelabel.text = fullDateFormatter.string(from: date).uppercased()
            
            shortDateLabel.text = date.dayDifference()
        }
        titleLabel.text = survey.title
        descriptionLabel.text = survey.description
    }
    
    private func configureHeader() {
        // header stackView
        let headerStackView: UIStackView = {
            let labelsStackView = UIStackView(axis: .vertical, spacing: 4, alignment: .leading, distribution: .fill)
            labelsStackView.addArrangedSubview(fullDatelabel)
            labelsStackView.addArrangedSubview(shortDateLabel)
            return labelsStackView
        }()
        
        contentView.addSubview(headerStackView)
        headerStackView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 16)
        headerStackView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        headerStackView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 76)
    }
    
    private func configureFooter() {
        let footerStackView: UIStackView = {
            let stackView = UIStackView(axis: .vertical, spacing: 16, alignment: .fill, distribution: .fill)
            stackView.addArrangedSubview(titleLabel)
            
            let hStackView: UIStackView = {
                let stackView = UIStackView(axis: .horizontal, spacing: 20, alignment: .center, distribution: .fill)
                stackView.addArrangedSubview(descriptionLabel)
                stackView.addArrangedSubview(nextButton)
                return stackView
            }()
            stackView.addArrangedSubview(hStackView)
            return stackView
        }()
        
        contentView.addSubview(footerStackView)
        footerStackView.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 20)
        footerStackView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        footerStackView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 33)
    }
}
