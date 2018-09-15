var dpad2 = new DPad("dpad-2", {
	"directionchange": function (key, pressed) {
		airconsole.message(AirConsole.SCREEN, {
			"dpad2": {
				"directionchange": {
					"key": key,
					"pressed": pressed
				}
			}
		});
	},
	"touchstart": function () {
		airconsole.message(AirConsole.SCREEN, {
			"dpad2": {
				"touch": true
			}
		});
	},w
	"touchend": function (had_direction) {
		airconsole.message(AirConsole.SCREEN, {
			"dpad2": {
				"touch": false,
				"had_direction": had_direction
			}
		});
	}
});
