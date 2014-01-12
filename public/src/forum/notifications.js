define(function() {
	var Notifications = {};

	Notifications.init = function() {
		var listEl = $('.notifications-list'),
			markAllReadEl = document.getElementById('mark-all-notifs-read');

		$('span.timeago').timeago();

		// Allow the user to click anywhere in the LI
		listEl.on('click', 'li', function(e) {
			this.querySelector('a').click();
		});

		// Mark all as read button
		$(markAllReadEl).click(function() {
			socket.emit('api:notifications.mark_all_read', {}, function() {
				ajaxify.go('notifications');
				app.alert({
					alert_id: "notifications:mark_all_read",
					title: "已阅读所有提醒",
					message: "已经将所有提醒标记为已读。",
					type: 'success',
					timeout: 2500
				})
			});
		});
	}

	return Notifications;
});