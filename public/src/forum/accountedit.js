define(['forum/accountheader', 'uploader'], function(header, uploader) {
	var AccountEdit = {},
		gravatarPicture = '',
		uploadedPicture = '';

	AccountEdit.init = function() {
		header.init();

		gravatarPicture = templates.get('gravatarpicture');
		uploadedPicture = templates.get('uploadedpicture');

		var selectedImageType = '';

		$('#submitBtn').on('click', function() {

			var userData = {
				uid: $('#inputUID').val(),
				username: $('#inputUsername').val(),
				email: $('#inputEmail').val(),
				fullname: $('#inputFullname').val(),
				website: $('#inputWebsite').val(),
				birthday: $('#inputBirthday').val(),
				location: $('#inputLocation').val(),
				signature: $('#inputSignature').val()
			};

			socket.emit('api:user.updateProfile', userData, function(err, data) {
				if (data.success) {
					app.alertSuccess('您的个人资料已编辑成功！');
					if (data.picture) {
						$('#user-current-picture').attr('src', data.picture);
						$('#user_label img').attr('src', data.picture);
					}
					if (data.gravatarpicture) {
						$('#user-gravatar-picture').attr('src', data.gravatarpicture);
						gravatarPicture = data.gravatarpicture;
					}
				} else {
					app.alertError('保存时发生了一些错误，请重试 ' + err.error);
				}
			});
			return false;
		});


		function getSignatureCharsLeft() {
			if($('#inputSignature').length) {
				return '(' + $('#inputSignature').val().length + '/' + config.maximumSignatureLength + ')';
			} else {
				return '';
			}
		}

		$('#signatureCharCountLeft').html(getSignatureCharsLeft());

		$('#inputSignature').on('keyup change', function(ev) {
			$('#signatureCharCountLeft').html(getSignatureCharsLeft());
		});

		$('#changePictureBtn').on('click', function() {
			selectedImageType = '';
			AccountEdit.updateImages();

			$('#change-picture-modal').modal('show');
			$('#change-picture-modal').removeClass('hide');

			return false;
		});

		$('#gravatar-box').on('click', function() {
			$('#gravatar-box .fa-check').show();
			$('#uploaded-box .fa-check').hide();
			selectedImageType = 'gravatar';
		});

		$('#uploaded-box').on('click', function() {
			$('#gravatar-box .fa-check').hide();
			$('#uploaded-box .fa-check').show();
			selectedImageType = 'uploaded';
		});

		$('#savePictureChangesBtn').on('click', function() {
			$('#change-picture-modal').modal('hide');

			if (selectedImageType) {
				AccountEdit.changeUserPicture(selectedImageType);

				if (selectedImageType == 'gravatar')
					$('#user-current-picture').attr('src', gravatarPicture);
				else if (selectedImageType == 'uploaded')
					$('#user-current-picture').attr('src', uploadedPicture);
			}

		});

		$('#upload-picture-modal').on('hide', function() {
			$('#userPhotoInput').val('');
		});

		$('#uploadPictureBtn').on('click', function() {

			$('#change-picture-modal').modal('hide');
			uploader.open(RELATIVE_PATH + '/user/uploadpicture', {}, function(imageUrlOnServer) {
				imageUrlOnServer = imageUrlOnServer + '?' + new Date().getTime();

				$('#user-current-picture').attr('src', imageUrlOnServer);
				$('#user-uploaded-picture').attr('src', imageUrlOnServer);

				uploadedPicture = imageUrlOnServer;

				socket.emit('api:updateHeader', {
					fields: ['username', 'picture', 'userslug']
				});
			});


			return false;
		});

		function showError(element, msg) {
			element.html(msg);
			element.parent()
				.removeClass('alert-success')
				.addClass('alert-danger');
			element.show();
			validationError = true;
		}

		function showSuccess(element, msg) {
			element.html(msg);
			element.parent()
				.removeClass('alert-danger')
				.addClass('alert-success');
			element.show();
		}

		(function handlePasswordChange() {
			var currentPassword = $('#inputCurrentPassword');
			var password_notify = $('#password-notify');
			var password_confirm_notify = $('#password-confirm-notify');
			var password = $('#inputNewPassword');
			var password_confirm = $('#inputNewPasswordAgain');
			var passwordvalid = false;
			var passwordsmatch = false;
			var successIcon = '<i class="fa fa-check"></i>';


			function onPasswordChanged() {
				passwordvalid = utils.isPasswordValid(password.val());
				if (password.val().length < config.minimumPasswordLength) {
					showError(password_notify, 'Password too short!');
				} else if (!passwordvalid) {
					showError(password_notify, 'Invalid password!');
				} else {
					showSuccess(password_notify, successIcon);
				}
			}

			function onPasswordConfirmChanged() {
				if(password.val()) {
					if (password.val() !== password_confirm.val()) {
						showError(password_confirm_notify, 'Passwords must match!')
						passwordsmatch = false;
					} else {
						showSuccess(password_confirm_notify, successIcon);
						passwordsmatch = true;
					}
				}
			}

			password.on('blur', onPasswordChanged);
			password_confirm.on('blur', onPasswordConfirmChanged);

			$('#changePasswordBtn').on('click', function() {

				if (passwordvalid && passwordsmatch && currentPassword.val()) {
					socket.emit('api:user.changePassword', {
						'currentPassword': currentPassword.val(),
						'newPassword': password.val()
					}, function(err) {

						currentPassword.val('');
						password.val('');
						password_confirm.val('');
						passwordsmatch = false;
						passwordvalid = false;

						if (err) {
							app.alertError(err.error);
							return;
						}

						app.alertSuccess('Your password is updated!');

					});
				}
				return false;
			});

		}());
	};


	AccountEdit.changeUserPicture = function(type) {
		var userData = {
			type: type
		};

		socket.emit('api:user.changePicture', userData, function(success) {
			if (!success) {
				app.alertError('There was an error changing picture!');
			}
		});
	}

	AccountEdit.updateImages = function() {
		var currentPicture = $('#user-current-picture').attr('src');

		if (gravatarPicture) {
			$('#user-gravatar-picture').attr('src', gravatarPicture);
			$('#gravatar-box').show();
		} else {
			$('#gravatar-box').hide();
		}

		if (uploadedPicture) {
			$('#user-uploaded-picture').attr('src', uploadedPicture);
			$('#uploaded-box').show();
		} else {
			$('#uploaded-box').hide();
		}


		if (currentPicture == gravatarPicture) {
			$('#gravatar-box .fa-check').show();
		} else {
			$('#gravatar-box .fa-check').hide();
		}

		if (currentPicture == uploadedPicture) {
			$('#uploaded-box .fa-check').show();
		} else {
			$('#uploaded-box .fa-check').hide();
		}
	}

	return AccountEdit;
});