define(['forum/accountheader'], function(header) {
	var Account = {};

	Account.init = function() {
		header.init();

		var yourid = templates.get('yourid'),
			theirid = templates.get('theirid'),
			isFollowing = templates.get('isFollowing');

		$(document).ready(function() {
			var username = $('.account-username a').html();
			app.enterRoom('user/' + theirid);

			app.addCommasToNumbers();
			$('.user-recent-posts img').addClass('img-responsive');

			var followBtn = $('#follow-btn');
			var unfollowBtn = $('#unfollow-btn');
			var chatBtn = $('#chat-btn');

			if (yourid !== theirid && yourid !== "0") {
				if (isFollowing) {
					followBtn.addClass('hide');
					unfollowBtn.removeClass('hide');
				} else {
					followBtn.removeClass('hide');
					unfollowBtn.addClass('hide');
				}
				chatBtn.removeClass('hide');
			} else {
				followBtn.addClass('hide');
				unfollowBtn.addClass('hide');
				chatBtn.addClass('hide');
			}

			followBtn.on('click', function() {
				socket.emit('api:user.follow', {
					uid: theirid
				}, function(success) {
					if (success) {
						followBtn.addClass('hide');
						unfollowBtn.removeClass('hide');
						app.alertSuccess('您已关注 ' + username + '!');
					} else {
						app.alertError('无法关注' + username + '!');
					}
				});
				return false;
			});

			unfollowBtn.on('click', function() {
				socket.emit('api:user.unfollow', {
					uid: theirid
				}, function(success) {
					if (success) {
						followBtn.removeClass('hide');
						unfollowBtn.addClass('hide');
						app.alertSuccess('您已不再关注 ' + username + '!');
					} else {
						app.alertError('无法取消关注 ' + username + '!');
					}
				});
				return false;
			});

			chatBtn.on('click', function() {
				app.openChat(username, theirid);
			});

			$('.user-recent-posts .topic-row').on('click', function() {
				ajaxify.go($(this).attr('topic-url'));
			});

			socket.on('api:user.isOnline', Account.handleUserOnline);

			socket.emit('api:user.isOnline', theirid, Account.handleUserOnline);

			socket.on('event:new_post', function(data) {
				var html = templates.prepare(templates['account'].blocks['posts']).parse(data);
				$('.user-recent-posts').prepend(html);
				$('.user-recent-posts span.timeago').timeago();
			});

		});
	};

	Account.handleUserOnline = function(data) {
		var onlineStatus = $('.account-online-status');

		if (data.online) {
			onlineStatus.find('span span').text('online');
			onlineStatus.find('i').attr('class', 'fa fa-circle');
		} else {
			onlineStatus.find('span span').text('offline');
			onlineStatus.find('i').attr('class', 'fa fa-circle-o');
		}
	};

	return Account;
});
