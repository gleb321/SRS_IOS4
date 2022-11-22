import UIKit
import Foundation

final class NoteCell: UITableViewCell {
    static let reuseIdentifier = "NoteCell"
    private var labelOfText = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupView()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupView() {
        labelOfText.font = .systemFont(ofSize: 16, weight: .regular)
        labelOfText.textColor = .label
        labelOfText.numberOfLines = 0
        labelOfText.backgroundColor = .clear
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(labelOfText)
        labelOfText.pin(to: contentView, [.left: 16, .top: 16, .right: 16, .bottom: 16])
    }
    
    public func configure(_ note: ShortNote) {
        labelOfText.text = note.text
    }
}
