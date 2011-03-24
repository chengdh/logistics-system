jQuery(function($) {
	$('form input:visible,form select:visible,form textarea:visible').livequery("keypress", function(e) {
		/* ENTER PRESSED*/
		if (e.keyCode == 13) {

			/* FOCUS ELEMENT */
			var inputs = $(this).parents("form").eq(0).find("input:visible,select:visible,textarea:visible");
			var idx = inputs.index(this);

			if (idx == inputs.length - 1) {
				inputs[0].focus();
			} else {
				inputs[idx + 1].focus(); //  handles submit buttons
                                var tag_name = $(inputs[idx + 1]).attr('tagName').toLowerCase();
				if ( tag_name == 'input' || tag_name == 'textarea') inputs[idx + 1].select();
			}
			return false;
		}
	});
});

