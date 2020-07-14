import Foundation
import class ObjectLibrary.Player
import enum ObjectLibrary.Die

protocol PigModelDelegate: class {
    func updateUIRolled(image: String)
    func update(_ pointsRolled: Int)
    func updateScore(for player: Player)
    func willChange(player: Player)
    func updateGameLog(text: String)
    func notifyWinner(alerTitle: String, message: String, actionTitle: String)
}

final class PigModel {
    private let players: [Player]
    private weak var delegate: PigModelDelegate?
    private var isPlayerTwosTurn: Bool = false { didSet { delegate?.willChange(player: currentPlayer) }}
    private var pointsRolled: Int = 0
    private var currentPlayer: Player { players[Int(truncating: isPlayerTwosTurn as NSNumber)] }
        
    init(delegate: PigModelDelegate) {
        self.delegate = delegate
        players = Player.Identifier.allCases.map { Player(id: $0) }
    }
        
    func beginNewGame() {
        pointsRolled = 0
        players.forEach {
            $0.resetTotalPoints()
            delegate?.updateScore(for: $0)
        }
        isPlayerTwosTurn = false
        let newGameText = "Welcome to pig, player ONE please press 'Roll' to begin playing the game!"
        delegate?.updateGameLog(text: newGameText)
        delegate?.willChange(player: currentPlayer)
    }
    
    func roll() {
        if let rolledNumber = Die.allCases.randomElement() {
            delegate?.updateUIRolled(image: rolledNumber.rawValue)
            
             DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                var gameMessage = "Player \(self.currentPlayer.id.rawValue.uppercased()) rolled a \(rolledNumber)"
            
            if rolledNumber.value == 1 {
                self.isPlayerTwosTurn.toggle()
                self.pointsRolled = 0
                
                gameMessage.append(" Player \(self.currentPlayer.id.rawValue.uppercased()) your turn!!")
            } else {
                self.pointsRolled += rolledNumber.value
                
            }
                
                self.delegate?.updateGameLog(text: gameMessage)
                self.delegate?.update(self.pointsRolled)
            }
        }
    }
    
    func hold() {
        
        var gameMessage = "Player \(currentPlayer.id) held their points of \(pointsRolled) points!"
        currentPlayer.updateScore(byAdding: pointsRolled)
        
        if currentPlayer.totalPoints >= 100 {
            delegate?.notifyWinner(alerTitle: "Game Over", message: "Congratulations player \(currentPlayer.id.rawValue.uppercased()) you WIN!", actionTitle: "close")
        } else {
            if pointsRolled == 0 {
                return
            }
            
            delegate?.updateScore(for: currentPlayer)
            isPlayerTwosTurn.toggle()
            delegate?.willChange(player: currentPlayer)
            
            gameMessage.append(" Player \(currentPlayer.id.rawValue.uppercased()) it's your turn!")
            
            delegate?.updateGameLog(text: gameMessage)
            pointsRolled = 0
        }
    }
    
    func resetPointsRolled() {
        delegate?.update(0)
    }
}
