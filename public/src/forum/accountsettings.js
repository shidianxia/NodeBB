define(['forum/accountheader'], function(header) {
	var	AccountSettings = {};

	AccountSettings.init = function() {
		header.init();

		$('#submitBtn').on('click', function() {

			var settings = {
				showemail: $('#showemailCheckBox').is(':checked') ? 1 : 0
			};

			socket.emit('api:user.saveSettings', settings, function(err) {
				if (!err) {
					app.alertSuccess('设置已生效');
				} else {
					app.alertError('无法保存设置');
				}
			});
			return false;
		});
	};

	return AccountSettings;
});
