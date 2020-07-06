import UIKit
import ObjectLibrary

final class PigViewController: UIViewController {
//     MARK: - IBOutlets
//
//    /**
//    - Connect `IBOutlet`s here
//     -
//     */
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var gameLogText: UILabel!
    @IBOutlet weak var pointsRolled: UILabel!
    @IBOutlet weak var playerOnePoints: UILabel!
    @IBOutlet weak var playerTwoPoints: UILabel!
    
    
    // MARK: - Properties

    /**
     // TODO: - Declare any properties needed here
     -
     // HINT: - You will need at least a model.
     -
     */
    private var model: PigModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = PigModel(delegate: self)
        //instansiating the pig model.
        
        /**
         // TODO: - Perform any additional setup after loading the view here
         -
         */
    }
    
    // MARK: - IBActions

    @IBAction func resetButton(_ sender: UIButton) {
     // this might need to be reconnected
        print("the reset button was pressed!")
    }
    
    @IBAction func rollButton(_ sender: UIButton) {
        print("the roll button was pressed!")
        
    }
    
    @IBAction func holdButton(_ sender: UIButton) {
        print("the hold button was pressed!")
    }
    
    // MARK: - Methods

    /**
     // TODO: - If you have any other methods, write them here
     -
     */
}

// MARK: - PigModelDelegate

/** -
 
 // HINT: -
 -
 - For the `function notifyWinner(alerTitle:,message:,actionTitle:)`, try using the`UIViewController`
 extension `func presentSingleActionAlert(alerTitle:, message:, actionTitle:, completion:)` to notify
 the user of the game's outcome.
 */

extension PigViewController: PigModelDelegate {
    func willChange(player: Player) {
        print("will change")
    }
    
    func updateUIRolled(image: String) {
        print("update the ui")
    }
    
    func update(_ pointsRolled: Int) {
        print("update")
    }
    
    func updateScore(for player: Player) {
        print("updateScore")
    }
    
    func updateGameLog(text: String) {
        print("update game log")
    }
    
    func notifyWinner(alerTitle: String, message: String, actionTitle: String) {
        print("notify winner")
    }
    
    
}
