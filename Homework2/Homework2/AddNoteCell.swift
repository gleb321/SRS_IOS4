import UIKit

final class AddNoteCell: UITableViewCell {
    static let reuseIdentifier = "AddNoteCell"
    private var textView = UITextView()
    public var addButton = UIButton()
    public var delegate: AddNoteDelegate?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        textView.textColor = .tertiaryLabel
        textView.backgroundColor = .clear
        textView.text = ""
        textView.textColor = UIColor.black
        textView.setHeight(160)
        textView.delegate = self
        
        addButton.setTitle("Add new note", for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        addButton.setTitleColor(.systemBackground, for: .normal)
        addButton.backgroundColor = UIColor.black
        addButton.layer.cornerRadius = 8
        addButton.setHeight(44)
        addButton.addTarget(self, action: #selector(addButtonPressed(_:)), for: .touchUpInside)
        addButton.isEnabled = true
        addButton.alpha = 1
        
        let stackView = UIStackView(arrangedSubviews: [textView, addButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        
        contentView.addSubview(stackView)
        stackView.pin(to: contentView, [.left: 16, .top: 16, .right: 16, .bottom: 16])
        contentView.backgroundColor = .systemGray6
    }
    
    @objc
    func addButtonPressed(_ sender: UIButton) {
        delegate?.newNoteAdded(note: ShortNote(text: textView.text))
        textView.text = ""
    }
}

extension AddNoteCell: UITextViewDelegate { }
