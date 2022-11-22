import UIKit

final class ColorPaletteView: UIControl {
    private var stackView = UIStackView()
    private var currentColor = UIColor.systemGray6
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    @available(*, unavailable)
    required init? (coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func getCurrentColor() -> UIColor {
        return currentColor
    }
    
    private func setupView() {
        let components = currentColor.cgColor.components
        let redSlider = makeSubView(color: .red, colorName: "R", value: components?[0] ?? 0, tag: 0)
        let greenSlider = makeSubView(color: .systemGreen, colorName: "G", value: components?[1] ?? 0, tag: 1)
        let blueSlider = makeSubView(color: .blue, colorName: "B", value: components?[2] ?? 0, tag: 2)
        stackView = UIStackView(arrangedSubviews: [redSlider, greenSlider, blueSlider])
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        self.addSubview(stackView)
        stackView.pinCenter(to: self)
        stackView.pinLeft(to: self.leadingAnchor)
        stackView.pinBottom(to: self.bottomAnchor)
    }
    
    private func makeSubView(color: UIColor, colorName: String, value: CGFloat, tag: Int) -> UIStackView {
        let slider = UISlider()
        let label = UILabel()
        let subStackView = UIStackView(arrangedSubviews: [label, slider])
        subStackView.addSubview(label)
        subStackView.addSubview(slider)
        subStackView.spacing = 30
        subStackView.axis = NSLayoutConstraint.Axis.horizontal
        label.text = colorName
        label.textColor = color
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.pinLeft(to: subStackView.leadingAnchor, 30)
        slider.minimumTrackTintColor = color
        slider.minimumValue = 0.0
        slider.maximumValue = 1.0
        slider.value = Float(value)
        slider.tag = tag
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .touchDragInside)
        return subStackView
    }
    
    @objc
    private func sliderValueChanged(slider: UISlider) {
        let components = currentColor.cgColor.components
        switch slider.tag {
        case 0:
            currentColor = UIColor(
                red: CGFloat(slider.value),
                green: components?[1] ?? 0,
                blue: components?[2] ?? 0,
                alpha: components?[3] ?? 0
            )
        case 1:
            currentColor = UIColor(
                red: components?[0] ?? 0,
                green: CGFloat(slider.value),
                blue: components?[2] ?? 0,
                alpha: components?[3] ?? 0
            )
        default:
            currentColor = UIColor(
                red: components?[0] ?? 0,
                green: components?[1] ?? 0,
                blue: CGFloat(slider.value),
                alpha: components?[3] ?? 0
            )
        }
        
        sendActions(for: .touchDragInside)
    }
}
