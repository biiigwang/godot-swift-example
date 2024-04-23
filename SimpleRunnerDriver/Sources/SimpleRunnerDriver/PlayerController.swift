import SwiftGodot

@Godot
class PlayerController: CharacterBody2D {
  @Export(.range, "0,300,0.5")
  var acceleration: Float = 100.0
  @Export(.range, "0,300,0.5")
  var friction: Double = 100.0
  @Export(.range, "100,500,0.5")
  var speed: Double = 200.0
  @Export(.range, "0, 5, 0.1")
  var verticalSpeed: Float = 1.0

  // 只读计算属性 computed property
  var movementVector: Vector2 {
    var movement = Vector2.zero
    movement.x = Float(
      Input.getActionStrength(action: "move_right")
        - Input.getActionRawStrength(action: "move_left"))
    movement.y = verticalSpeed
    // return movement.normalized()
    return movement
  }

  override func _physicsProcess(delta: Double) {
    if Engine.isEditorHint() { return }
    if movementVector != .zero {
      let acceleratedVector = Vector2(x: acceleration, y: acceleration)
      let acceleratedMovement = movementVector * acceleratedVector
      self.velocity = acceleratedMovement.limitLength(speed)
    } else {
      velocity = velocity.moveToward(to: .zero, delta: friction)
    }

    self.moveAndSlide()
    super._physicsProcess(delta: delta)
  }
}
