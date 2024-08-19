extends ProgressBar



func _process(delta: float) -> void:
	if GameInfo.expedition.expedition == null:
		return
	if !GameInfo.expedition.expedition.is_active:
		return
	
	var elapsed_time = GameInfo.expedition.expedition.timer.time_left - GameInfo.expedition.expedition.timer.wait_time
	var percentage_passed = -(elapsed_time / GameInfo.expedition.expedition.timer.wait_time) * 100.0 + .1
	
	self.value = percentage_passed
