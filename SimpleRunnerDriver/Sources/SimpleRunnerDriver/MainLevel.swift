import SwiftGodot

@Godot
class MainLevel: Node2D {

  // Define some properties
  @Export(.nodeType, "PlayerController")
  var player: PlayerController?
  @Export(.nodeType, "Node2D")
  var spawnpoint: Node2D?
  @Export(.nodeType, "Area2D")
  var teleportArea: Area2D?

  // Define signal
  #signal("player_entry_teleport", arguments: ["new_player_positon": Vector2.self])

  override func _ready() {
    teleportArea?.bodyEntered.connect { [self] enteredBody in
      if enteredBody.isClass("\(PlayerController.self)") {
        teleportPlayerToTop()
      }
    }
    super._ready()
  }

  private func teleportPlayerToTop() {
    guard let player, let spawnpoint else {
      GD.pushWarning("Player or spawnpoint is missing.")
      return
    }

    player.position = Vector2(x: player.position.x, y: spawnpoint.position.y)
    emit(signal: MainLevel.playerEntryTeleport, player.position)
  }
}
