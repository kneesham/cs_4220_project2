import UIKit
import ObjectLibrary
import AVFoundation

final class PigViewController: UIViewController {

    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var gameLogText: UILabel!
    @IBOutlet weak var pointsRolled: UILabel!
    @IBOutlet weak var playerOnePoints: UILabel!
    @IBOutlet weak var playerTwoPoints: UILabel!
    @IBOutlet weak var playerOneLabel: UILabel!
    @IBOutlet weak var playerTwoLabel: UILabel!
    
    private let systemSoundID: SystemSoundID = 1116
    private var model: PigModel!
    private var images: [UIImage] = [UIImage(named: "one")!, UIImage(named: "four")!, UIImage(named: "three")!,
                                     UIImage(named: "two")!, UIImage(named: "five")!, UIImage(named: "six")! ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        model = PigModel(delegate: self)
        model.beginNewGame()
        //instansiating the pig model.
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
     // this might need to be reconnected
        sender.pulsate()
        model?.beginNewGame()
        model?.resetPointsRolled()
        AudioServicesPlaySystemSound(1152)
        
    }
    
    @IBAction func rollButton(_ sender: UIButton) {
        sender.pulsate()
        AudioServicesPlaySystemSound(1109)
        model?.roll()
    }
    
    @IBAction func holdButton(_ sender: UIButton) {
        sender.pulsate()
        if self.pointsRolled.text != "0" {
            model?.hold()
            AudioServicesPlaySystemSound(1150)
        }
    }
    
    func disableActions() {
        self.view.isUserInteractionEnabled = false
    }
    func enableActions() {
        self.view.isUserInteractionEnabled = true
    }
}

extension PigViewController: PigModelDelegate {
    
    func willChange(player: Player) {
        if player.id == .one {
             self.playerOneLabel.textColor = UIColor(displayP3Red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
             self.playerTwoLabel.textColor = UIColor(named: "black")
        } else {
             self.playerTwoLabel.textColor = UIColor(displayP3Red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
             self.playerOneLabel.textColor = UIColor(named: "black")
        }
    }
    
    func updateUIRolled(image: String) {
        disableActions()
        gameImage.animationRepeatCount = 2
        gameImage.animationImages = images
        gameImage.animationDuration = 1
        gameImage.startAnimating()
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
            self.gameImage.image = UIImage(named: image)
            
        }
        
    }
    
    func update(_ pointsRolled: Int) {
        self.pointsRolled.text = "\(pointsRolled)"
        self.enableActions()
    }
    
    func updateScore(for player: Player) {
        
        self.pointsRolled.text = "0"
        // NOTE: set the points rolled to 0 if the player's score is updated.
        if player.id == .one {
            playerOnePoints.text = "\(player.totalPoints)"
            
        } else {
            playerTwoPoints.text = "\(player.totalPoints)"
        }
    }
    
    func updateGameLog(text: String) {
        gameLogText.text = text
    }
    
    func notifyWinner(alerTitle: String, message: String, actionTitle: String) {
        AudioServicesPlaySystemSound(1036)
        presentSingleActionAlert(alerTitle: alerTitle, message: message, actionTitle: actionTitle, completion: { self.model?.beginNewGame() })
    }
    
}
