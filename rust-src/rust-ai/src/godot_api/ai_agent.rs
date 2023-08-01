use godot::prelude::*;
use godot::engine::Node;
use godot::engine::NodeVirtual;

use bitflags::bitflags;


bitflags! {
    /// A struct keeping information about current game state available to the agent
    #[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
    pub struct GameState: u32 {
        const SeeEnemy = 0b00000001;
        const EnemyInRange = 0b00000010;
    }
}


#[derive(GodotClass)]
#[class(base=Node)]
struct AiAgent {
    pub game_state: GameState,
    base: Base<Node>
}


#[godot_api]
impl NodeVirtual for AiAgent {

    fn init(node: Base<Node>) -> Self {
        godot_print!("Hello, world!"); // Prints to the Godot console

        Self {
            game_state: GameState::empty(),
            base: node
        }
    }

    fn ready(&mut self) {}
    fn physics_process(&mut self, _delta: f64) {}
}

#[godot_api]
impl AiAgent {
    #[signal]
    fn plan_invalidated();

    #[signal]
    fn new_plan_formulated();

    #[func]
    fn update_working_memory(&mut self) {}

    #[func]
    fn get_current_plan(&self) {}

    #[func]
    fn update_world_state(&mut self) {}

    #[func]
    fn finish_action(&mut self) {}
}
