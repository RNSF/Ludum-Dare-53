class_name EntityControllers
extends StateMachine

var state_machine : StateMachine;

func _process(delta: float) -> void:
	send_controls();

func send_controls() -> void:
	if(current_state is EntityController):
		state_machine.update_controls(current_state.controls);
