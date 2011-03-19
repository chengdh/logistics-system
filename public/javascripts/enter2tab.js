jQuery(function($) {
	$('input:visible,select:visible,textarea:visible').livequery("keypress", function(e) {
		/* ENTER PRESSED*/
		if (e.keyCode == 13) {
			/* FOCUS ELEMENT */
			var inputs = $(this).parents("form").eq(0).find("input:visible,select:visible,textarea:visible");
			var idx = inputs.index(this);

			if (idx == inputs.length - 1) {
				inputs[0].focus();
			} else {
				inputs[idx + 1].focus(); //  handles submit buttons
				inputs[idx + 1].select();
			}
			return false;
		}
	});

});

