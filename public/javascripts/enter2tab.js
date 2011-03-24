jQuery(function($) {
	$('form input:visible,form select:visible,form textarea:visible').live("keypress", function(e) {
		/* ENTER PRESSED*/
		if (e.keyCode == 13) {

			/* FOCUS ELEMENT */
			var inputs = $(this).parents("form").eq(0).find("input:visible,select:visible,textarea:visible");
			var idx = inputs.index(this);

			if (idx == inputs.length - 1) {
				inputs[0].focus();
			} else {
				inputs[idx + 1].focus(); //  handles submit buttons
				if ($(inputs[idx + 1]).attr('tagName') == 'input' || $(inputs[idx + 1]).attr('tagName') == 'textarea') inputs[idx + 1].select();
			}
			return false;
		}
	});
});

