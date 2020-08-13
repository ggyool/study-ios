import UIKit

class RootView: UIView{
    
    let pushButton: UIButton = {
        let button = UIButton()
        button.setTitle("Push Next View", for: .normal)
        button.isUserInteractionEnabled = true
        let r = CGFloat(Double(arc4random()%256)/255.0)
        let g = CGFloat(Double(arc4random()%256)/255.0)
        let b = CGFloat(Double(arc4random()%256)/255.0)
        button.backgroundColor = UIColor.init(red: r, green: g, blue: b, alpha: 1.0)
        button.titleLabel?.textColor = UIColor.white
        return button
    }()
    
    func makeConstraint(){
        pushButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pushButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            pushButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            pushButton.widthAnchor.constraint(equalTo: widthAnchor, constant: 0),
            pushButton.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(pushButton)
        makeConstraint()
        backgroundColor = UIColor.white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
