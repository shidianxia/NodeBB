define(function() {
	var	AccountHeader = {};

	AccountHeader.init = function() {
		var yourid = templates.get('yourid'),
			theirid = templates.get('theirid');

		AccountHeader.createMenu();

		var editLink = $('#editLink');
		var settingsLink = $('#settingsLink');
		var favouritesLink = $('#favouritesLink');

		if (yourid === "0" || yourid !== theirid) {
			editLink.hide();
			settingsLink.hide();
			favouritesLink.hide();
		}

		jQuery('.account-sub-links span a').removeClass('bold').each(function() {
			var href = this.getAttribute('href');
			if (window.location.href.indexOf(href) !== -1) {
				jQuery(this).addClass('bold');
				return false;
			}
		});
	}

	AccountHeader.createMenu = function() {
		var userslug = $('.account-username-box').attr('data-userslug');
		var links = $('<div class="account-sub-links inline-block pull-right">\
			<span id="settingsLink" class="pull-right"><a href="' + RELATIVE_PATH + '/user/' + userslug + '/settings">隐私设置</a></span>\
			<span id="favouritesLink" class="pull-right"><a href="' + RELATIVE_PATH + '/user/' + userslug + '/favourites">收藏</a></span>\
			<span class="pull-right"><a href="' + RELATIVE_PATH + '/user/' + userslug + '/followers">粉丝</a></span>\
			<span class="pull-right"><a href="' + RELATIVE_PATH + '/user/' + userslug + '/following">关注</a></span>\
			<span id="editLink" class="pull-right"><a href="' + RELATIVE_PATH + '/user/' + userslug + '/edit">帐号设置</a></span>\
		</div>');

		$('.account-username-box').append(links);
	}

	return AccountHeader;
});