//
//  SurveyVC.swift
//  nimble
//
//  Created by Chung Tran on 10/25/20.
//

import Foundation

class SurveyVC: BaseViewController {
    override var preferredNavigationBarStype: BEViewController.NavigationBarStyle {.hidden}
    // MARK: - Subviews
    lazy var bgImageView = UIImageView(contentMode: .scaleAspectFill)
    lazy var fullDatelabel = UILabel(textSize: 13, textColor: .white)
    lazy var shortDateLabel = UILabel(textSize: 34, weight: .semibold, textColor: .white)
    lazy var avatarImageView = UIImageView(width: 36, height: 36, cornerRadius: 18)
    
    override func setUp() {
        super.setUp()
        view.addSubview(bgImageView)
        bgImageView.autoPinEdgesToSuperviewEdges()
        
        // configure header
        configureHeader()
    }
    
    func setUpWithSurvey(_ survey: ResponseSurvey) {
        bgImageView.sd_setImage(with: URL(string: survey.cover_image_url ?? ""))
        avatarImageView.sd_setImage(with: URL(string: survey.cover_image_url ?? ""))
        
        if let date = Date.ISO8601(string: survey.created_at) {
            let fullDateFormatter = DateFormatter()
            fullDateFormatter.dateFormat = "EEEE, MMM d"
            fullDatelabel.text = fullDateFormatter.string(from: date)
            
            shortDateLabel.text = date.dayDifference()
        }
    }
    
    private func configureHeader() {
        // header stackView
        let headerStackView: UIStackView = {
            let stackView = UIStackView(axis: .horizontal, spacing: 10, alignment: .center, distribution: .fill)
            let labelsStackView = UIStackView(axis: .vertical, spacing: 4, alignment: .leading, distribution: .fill)
            labelsStackView.addArrangedSubview(fullDatelabel)
            labelsStackView.addArrangedSubview(shortDateLabel)
            stackView.addArrangedSubview(labelsStackView)
            stackView.addArrangedSubview(UIView(forAutoLayout: ()))
            stackView.addArrangedSubview(avatarImageView)
            return stackView
        }()
        
        view.addSubview(headerStackView)
        headerStackView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 16)
        headerStackView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        headerStackView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
    }
}
