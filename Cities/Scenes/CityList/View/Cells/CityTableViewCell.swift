//
//  CityTableViewCell.swift
//  Cities
//
//  Created by Cửu Long Hoàng on 14/09/2022.
//

import UIKit
import SnapKit

class CityTableViewCell: UITableViewCell {
    static let identifier: String = String(describing: CityTableViewCell.self)
    
    private let titleLabel: UILabel = {
       let lb = UILabel()
        lb.font = UIFont.boldSystemFont(ofSize: 16)
        return lb
    }()
    
    private let subTitleLabel: UILabel = {
       let lb = UILabel()
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.textColor = .lightGray
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
    }
    
    private func setUpUI() {
        selectionStyle = .none
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(contentView).offset(10)
            make.trailing.greaterThanOrEqualTo(contentView).offset(-10)
        }
        
        contentView.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.bottom.equalTo(contentView).offset(-10)
            make.trailing.greaterThanOrEqualTo(contentView).offset(-10)
        }
    }
    
    func configCell(cityModel: CityModel?) {
        guard let city = cityModel else {
            return
        }
        titleLabel.text = "\(city.name), \(city.country)"
        subTitleLabel.text = "\(city.coord.lat), \(city.coord.lon)"
    }
}
