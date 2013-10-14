(function($) {
	$(document).ready(function() {
		if($.query.get('invalid_password') == '1' || $.query.get('account_unavailable') == '1') {
			$("#chaos-signin").effect("shake", {distance: 6, times: 3}, 35);
		}
		if($.fn.placeholder) {
			$('[placeholder]').placeholder();
		}
	});
}) (jQuery);