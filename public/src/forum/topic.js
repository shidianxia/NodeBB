define(['composer'], function(composer) {
	var	Topic = {},
		infiniteLoaderActive = false,
		pagination;

	function showBottomPostBar() {
		if($('#post-container .post-row').length > 1) {
			$('.topic-main-buttons').removeClass('hide').parent().removeClass('hide');
		}
	}

	Topic.init = function() {
		var expose_tools = templates.get('expose_tools'),
			tid = templates.get('topic_id'),
			thread_state = {
				locked: templates.get('locked'),
				deleted: templates.get('deleted'),
				pinned: templates.get('pinned')
			},
			topic_name = templates.get('topic_name');


		function fixDeleteStateForPosts() {
			var postEls = document.querySelectorAll('#post-container li[data-deleted]');
			for (var x = 0, numPosts = postEls.length; x < numPosts; x++) {
				if (postEls[x].getAttribute('data-deleted') === '1') {
					toggle_post_delete_state(postEls[x].getAttribute('data-pid'));
				}
				postEls[x].removeAttribute('data-deleted');
			}
		}

		jQuery('document').ready(function() {

			app.addCommasToNumbers();

			app.enterRoom('topic_' + tid);

			showBottomPostBar();

			// Resetting thread state
			if (thread_state.locked === '1') set_locked_state(true);
			if (thread_state.deleted === '1') set_delete_state(true);
			if (thread_state.pinned === '1') set_pinned_state(true);

			if (expose_tools === '1') {
				var moveThreadModal = $('#move_thread_modal');
				$('.thread-tools').removeClass('hide');

				// Add events to the thread tools
				$('.delete_thread').on('click', function(e) {
					if (thread_state.deleted !== '1') {
						bootbox.confirm('Are you sure you want to delete this thread?', function(confirm) {
							if (confirm) {
								socket.emit('api:topic.delete', {
									tid: tid
								});
							}
						});
					} else {
						bootbox.confirm('Are you sure you want to restore this thread?', function(confirm) {
							if (confirm) socket.emit('api:topic.restore', {
								tid: tid
							});
						});
					}
					return false;
				});

				$('.lock_thread').on('click', function(e) {
					if (thread_state.locked !== '1') {
						socket.emit('api:topic.lock', {
							tid: tid
						});
					} else {
						socket.emit('api:topic.unlock', {
							tid: tid
						});
					}
					return false;
				});

				$('.pin_thread').on('click', function(e) {
					if (thread_state.pinned !== '1') {
						socket.emit('api:topic.pin', {
							tid: tid
						});
					} else {
						socket.emit('api:topic.unpin', {
							tid: tid
						});
					}
					return false;
				});

				$('.move_thread').on('click', function(e) {
					moveThreadModal.modal('show');
					return false;
				});

				moveThreadModal.on('shown.bs.modal', function() {

					var loadingEl = document.getElementById('categories-loading');
					if (loadingEl) {
						socket.emit('api:categories.get', function(data) {
							// Render categories
							var categoriesFrag = document.createDocumentFragment(),
								categoryEl = document.createElement('li'),
								numCategories = data.categories.length,
								modalBody = moveThreadModal.find('.modal-body'),
								categoriesEl = modalBody[0].getElementsByTagName('ul')[0],
								confirmDiv = document.getElementById('move-confirm'),
								confirmCat = confirmDiv.getElementsByTagName('span')[0],
								commitEl = document.getElementById('move_thread_commit'),
								cancelEl = document.getElementById('move_thread_cancel'),
								x, info, targetCid, targetCatLabel;

							categoriesEl.className = 'category-list';
							for (x = 0; x < numCategories; x++) {
								info = data.categories[x];
								categoryEl.style.background = info.bgColor;
								categoryEl.style.color = info.color || '#fff';
								categoryEl.className = info.disabled === '1' ? ' disabled' : '';
								categoryEl.innerHTML = '<i class="fa ' + info.icon + '"></i> ' + info.name;
								categoryEl.setAttribute('data-cid', info.cid);
								categoriesFrag.appendChild(categoryEl.cloneNode(true));
							}
							categoriesEl.appendChild(categoriesFrag);
							modalBody[0].removeChild(loadingEl);

							categoriesEl.addEventListener('click', function(e) {
								if (e.target.nodeName === 'LI') {
									confirmCat.innerHTML = e.target.innerHTML;
									confirmDiv.style.display = 'block';
									targetCid = e.target.getAttribute('data-cid');
									targetCatLabel = e.target.innerHTML;
									commitEl.disabled = false;
								}
							}, false);

							commitEl.addEventListener('click', function() {
								if (!commitEl.disabled && targetCid) {
									commitEl.disabled = true;
									$(cancelEl).fadeOut(250);
									$(moveThreadModal).find('.modal-header button').fadeOut(250);
									commitEl.innerHTML = 'Moving <i class="fa-spin fa-refresh"></i>';

									socket.once('api:topic.move', function(data) {
										moveThreadModal.modal('hide');
										if (data.status === 'ok') {
											app.alert({
												'alert_id': 'thread_move',
												type: 'success',
												title: '话题移动成功',
												message: '此话题已经成功移动到节点：' + targetCatLabel,
												timeout: 5000
											});
										} else {
											app.alert({
												'alert_id': 'thread_move',
												type: 'danger',
												title: '无法移动话题',
												message: '此话题无法移动到： ' + targetCatLabel + '.<br />请确认是否有操作。',
												timeout: 5000
											});
										}
									});
									socket.emit('api:topic.move', {
										tid: tid,
										cid: targetCid
									});
								}
							});
						});
					}
				});

				$('.fork_thread').on('click', function() {
					var pids = [];
					var forkModal = $('#fork-thread-modal'),
						forkCommit = forkModal.find('#fork_thread_commit');
					forkModal.removeClass('hide');
					forkModal.css("position", "fixed")
						.css("left", Math.max(0, (($(window).width() - $(forkModal).outerWidth()) / 2) + $(window).scrollLeft()) + "px")
						.css("top", "0px")
						.css("z-index", "2000");

					showNoPostsSelected();

					forkModal.find('.close,#fork_thread_cancel').on('click', closeForkModal);
					forkModal.find('#fork-title').on('change', checkForkButtonEnable);
					$('#post-container').on('click', 'li', togglePostSelection);
					forkCommit.on('click', createTopicFromPosts);

					function createTopicFromPosts() {
						socket.emit('api:topic.createTopicFromPosts', {
							title: forkModal.find('#fork-title').val(),
							pids: pids
						}, function(err) {
							if(err) {
								return app.alertError(err.message);
							}

							translator.get('topic:fork_success', function(translated) {
								app.alertSuccess(translated);
							});

							for(var i=0; i<pids.length; ++i) {
								$('#post-container li[data-pid="' + pids[i] + '"]').fadeOut(500, function() {
									$(this).remove();
								});
							}
							closeForkModal();
						});
					}

					function togglePostSelection() {

						var newPid = $(this).attr('data-pid');

						if($(this).attr('data-index') === '0') {
							return;
						}

						if(newPid) {
							var index = pids.indexOf(newPid);
							if(index === -1) {
								pids.push(newPid);
								$(this).css('opacity', '0.5');
							} else {
								pids.splice(index, 1);
								$(this).css('opacity', '1.0');
							}

							if(pids.length) {
								pids.sort();
								forkModal.find('#fork-pids').html(pids.toString());
							} else {
								showNoPostsSelected();
							}
							checkForkButtonEnable();
						}
					}

					function closeForkModal() {
						for(var i=0; i<pids.length; ++i) {
							$('#post-container li[data-pid="' + pids[i] + '"]').css('opacity', 1.0);
						}
						forkModal.addClass('hide');
						$('#post-container').off('click', 'li');
					}

					function checkForkButtonEnable() {
						if(forkModal.find('#fork-title').length && pids.length) {
							forkCommit.removeAttr('disabled');
						} else {
							forkCommit.attr('disabled', true);
						}
					}

					function showNoPostsSelected() {
						translator.get('topic:fork_no_pids', function(translated) {
							forkModal.find('#fork-pids').html(translated);
						});
					}
				});
			}

			fixDeleteStateForPosts();


			// Follow Thread State
			var followEl = $('.posts .follow'),
				set_follow_state = function(state, quiet) {
					if (state && !followEl.hasClass('btn-success')) {
						followEl.addClass('btn-success');
						followEl[0].title = 'You are currently receiving updates to this topic';
						if (!quiet) {
							app.alert({
								alert_id: 'topic_follow',
								timeout: 2500,
								title: '已关注帖子',
								message: '您将会随时收到帖子的最新进展。',
								type: 'success'
							});
						}
					} else if (!state && followEl.hasClass('btn-success')) {
						followEl.removeClass('btn-success');
						followEl[0].title = 'Be notified of new replies in this topic';
						if (!quiet) {
							app.alert({
								alert_id: 'topic_follow',
								timeout: 2500,
								title: '已取消关注帖子',
								message: '不再提醒您关于本帖子的最新进展。',
								type: 'success'
							});
						}
					}
				};
			socket.on('api:topic.followCheck', function(state) {
				set_follow_state(state, true);
			});
			socket.on('api:topic.follow', function(data) {
				if (data.status && data.status === 'ok') set_follow_state(data.follow);
				else {
					app.alert({
						type: 'danger',
						alert_id: 'topic_follow',
						title: '请先登录',
						message: '登录后您才能关注帖子。',
						timeout: 5000
					});
				}
			});

			socket.emit('api:topic.followCheck', tid);
			if (followEl[0]) {
				followEl[0].addEventListener('click', function() {
					socket.emit('api:topic.follow', tid);
				}, false);
			}

			enableInfiniteLoading();

			var bookmark = localStorage.getItem('topic:' + tid + ':bookmark');

			if(bookmark) {
				Topic.scrollToPost(parseInt(bookmark, 10));
			}

			$('#post-container').on('click', '.deleted', function(ev) {
				$(this).toggleClass('deleted-expanded');
			});
		});

		function enableInfiniteLoading() {
			$(window).off('scroll').on('scroll', function() {
				var bottom = ($(document).height() - $(window).height()) * 0.9;

				if ($(window).scrollTop() > bottom && !infiniteLoaderActive && $('#post-container').children().length) {
					loadMorePosts(tid, function(posts) {
						fixDeleteStateForPosts();
					});
				}
			});
		}

		$('.topic').on('click', '.post_reply', function() {
			var selectionText = '',
				selection = window.getSelection() || document.getSelection();

			if ($(selection.baseNode).parents('.post-content').length > 0) {
				var snippet = selection.toString();
				if (snippet.length > 0) {
					selectionText = '> ' + snippet.replace(/\n/g, '\n> ');
				}
			}

			var username = '',
				post = $(this).parents('li[data-pid]');
			if (post.length) {
				username = '@' + post.attr('data-username') + ' ';
			}

			if (thread_state.locked !== '1') {
				composer.newReply(tid, topic_name, selectionText.length > 0 ? selectionText + '\n\n' + username : '' + username);
			}
		});

		$('#post-container').on('click', '.quote', function() {
			if (thread_state.locked !== '1') {
				var username = '',
					post = $(this).parents('li[data-pid]'),
					pid = $(this).parents('li').attr('data-pid');

				if (post.length) {
					username = '@' + post.attr('data-username');
				}

				socket.emit('api:posts.getRawPost', {pid: pid}, function(data) {

					quoted = '> ' + data.post.replace(/\n/g, '\n> ') + '\n\n';

					composer.newReply(tid, topic_name, username + ' 说：' + quoted);
				});
			}
		});

		$('#post-container').on('click', '.favourite', function() {
			var pid = $(this).parents('li').attr('data-pid');
			var uid = $(this).parents('li').attr('data-uid');

			if ($(this).attr('data-favourited') == 'false') {
				socket.emit('api:posts.favourite', {
					pid: pid,
					room_id: app.currentRoom
				});
			} else {
				socket.emit('api:posts.unfavourite', {
					pid: pid,
					room_id: app.currentRoom
				});
			}
		});

		$('#post-container').on('click', '.link', function() {
			var pid = $(this).parents('li').attr('data-pid');
			$('#post_' + pid + '_link').val(window.location.href + "#" + pid).stop(true, false).fadeIn().select();
			$('#post_' + pid + '_link').off('blur').on('blur', function() {
				$(this).fadeOut();
			});
		});

		$('#post-container').on('click', '.twitter-share', function () {
			var pid = $(this).parents('li').attr('data-pid');
			window.open('https://twitter.com/intent/tweet?url=' + encodeURIComponent(window.location.href + '#' + pid) + '&text=' + topic_name, '_blank', 'width=550,height=420,scrollbars=no,status=no');
			return false;
		});

		$('#post-container').on('click', '.facebook-share', function () {
			var pid = $(this).parents('li').attr('data-pid');
			window.open('https://www.facebook.com/sharer/sharer.php?u=' + encodeURIComponent(window.location.href + '#' + pid), '_blank', 'width=626,height=436,scrollbars=no,status=no');
			return false;
		});

		$('#post-container').on('click', '.google-share', function () {
			var pid = $(this).parents('li').attr('data-pid');
			window.open('https://plus.google.com/share?url=' + encodeURIComponent(window.location.href + '#' + pid), '_blank', 'width=500,height=570,scrollbars=no,status=no');
			return false;
		});

		$('#post-container').on('click', '.edit', function(e) {
			var pid = $(this).parents('li').attr('data-pid');

			composer.editPost(pid);
		});

		$('#post-container').on('click', '.delete', function(e) {
			var pid = $(this).parents('li').attr('data-pid'),
				postEl = $(document.querySelector('#post-container li[data-pid="' + pid + '"]')),
				deleteAction = !postEl.hasClass('deleted') ? true : false,
				confirmDel = confirm((deleteAction ? '删除' : '恢复') + ' 这个帖子吗？');

			if (confirmDel) {
				if(deleteAction) {
					socket.emit('api:posts.delete', {
						pid: pid,
						tid: tid
					}, function(err) {
						if(err) {
							return app.alertError('无法删除帖子');
						}
					});
				} else {
					socket.emit('api:posts.restore', {
						pid: pid,
						tid: tid
					}, function(err) {
						if(err) {
							return app.alertError('无法恢复帖子');
						}
					});
				}
			}
		});

		$('#post-container').on('click', '.move', function(e) {
			var moveModal = $('#move-post-modal'),
				moveBtn = moveModal.find('#move_post_commit'),
				topicId = moveModal.find('#topicId'),
				post = $(this).parents('li'),
				pid = $(this).parents('li').attr('data-pid');

			moveModal.removeClass('hide');
			moveModal.css("position", "fixed")
				.css("left", Math.max(0, (($(window).width() - $(moveModal).outerWidth()) / 2) + $(window).scrollLeft()) + "px")
				.css("top", "0px")
				.css("z-index", "2000");

			moveModal.find('.close,#move_post_cancel').on('click', function() {
				moveModal.addClass('hide');
			});

			topicId.on('change', function() {
				if(topicId.val().length) {
					moveBtn.removeAttr('disabled');
				} else {
					moveBtn.attr('disabled', true);
				}
			});

			moveBtn.on('click', function() {
				socket.emit('api:topic.movePost', {pid: pid, tid: topicId.val()}, function(err) {
					if(err) {
						return app.alertError(err.message);
					}

					post.fadeOut(500, function() {
						post.remove();
					});

					moveModal.addClass('hide');
					$('#topicId').val('');

					app.alertSuccess('成功移动帖子！');
				});
			});
		});


		$('#post-container').on('click', '.chat', function(e) {
			var username = $(this).parents('li.row').attr('data-username');
			var touid = $(this).parents('li.row').attr('data-uid');
			app.openChat(username, touid);
			$(this).parents('.btn-group').find('.dropdown-toggle').click();
			return false;
		});

		ajaxify.register_events([
			'event:rep_up', 'event:rep_down', 'event:new_post', 'api:get_users_in_room',
			'event:topic_deleted', 'event:topic_restored', 'event:topic:locked',
			'event:topic_unlocked', 'event:topic_pinned', 'event:topic_unpinned',
			'event:topic_moved', 'event:post_edited', 'event:post_deleted', 'event:post_restored',
			'api:posts.favourite'
		]);


		socket.on('api:get_users_in_room', function(data) {
			if(data) {
				var activeEl = $('.thread_active_users');

				function createUserIcon(uid, picture, userslug, username) {
					if(!activeEl.find('[href="'+ RELATIVE_PATH +'/user/' + data.users[i].userslug + '"]').length) {
						var userIcon = $('<img src="'+ picture +'"/>');

						var userLink = $('<a href="' + RELATIVE_PATH + '/user/' + userslug + '"></a>').append(userIcon);
						userLink.attr('data-uid', uid);

						var div = $('<div class="inline-block"></div>');
						div.append(userLink);

						userLink.tooltip({
							placement: 'top',
							title: username
						});

						return div;
					}
				}

				// remove users that are no longer here
				activeEl.children().each(function(index, element) {
					if(element) {
						var uid = $(element).attr('data-uid');
						for(var i=0; i<data.users.length; ++i) {
							if(data.users[i].uid == uid) {
								return;
							}
						}
						$(element).remove();
					}
				});

				var i=0;
				// add self
				for(i = 0; i<data.users.length; ++i) {
					if(data.users[i].uid == app.uid) {
						var icon = createUserIcon(data.users[i].uid, data.users[i].picture, data.users[i].userslug, data.users[i].username);
						activeEl.prepend(icon);
						data.users.splice(i, 1);
						break;
					}
				}
				// add other users
				for(i=0; i<data.users.length; ++i) {
					icon = createUserIcon(data.users[i].uid, data.users[i].picture, data.users[i].userslug, data.users[i].username)
					activeEl.append(icon);
					if(activeEl.children().length > 8) {
						break;
					}
				}

				var remainingUsers = data.users.length - 9;
				remainingUsers = remainingUsers < 0 ? 0 : remainingUsers;
				var anonymousCount = parseInt(data.anonymousCount, 10);
				activeEl.find('.anonymous-box').remove();
				if(anonymousCount || remainingUsers) {

					var anonLink = $('<div class="anonymous-box inline-block"><i class="fa fa-user"></i></div>');
					activeEl.append(anonLink);

					var title = '';
					if(remainingUsers && anonymousCount)
						title = remainingUsers + ' 等成员和 ' + anonymousCount + ' 位游客';
					else if(remainingUsers)
						title = remainingUsers + ' 等成员';
					else
						title = anonymousCount + ' 位游客';

					anonLink.tooltip({
						placement: 'top',
						title: title
					});
				}
			}
			app.populateOnlineUsers();
		});

		socket.on('event:rep_up', function(data) {
			adjust_rep(1, data.pid, data.uid);
		});

		socket.on('event:rep_down', function(data) {
			adjust_rep(-1, data.pid, data.uid);
		});

		socket.on('event:new_post', function(data) {
			var posts = data.posts;
			for (var p in posts) {
				if (posts.hasOwnProperty(p)) {
					var post = posts[p],
						postcount = jQuery('.user_postcount_' + post.uid),
						ptotal = parseInt(postcount.html(), 10);

					ptotal += 1;
					postcount.html(ptotal);
				}
			}

			createNewPosts(data);
		});

		socket.on('event:topic_deleted', function(data) {
			if (data.tid === tid && data.status === 'ok') {
				set_locked_state(true);
				set_delete_state(true);
			}
		});

		socket.on('event:topic_restored', function(data) {
			if (data.tid === tid && data.status === 'ok') {
				set_locked_state(false);
				set_delete_state(false);
			}
		});

		socket.on('event:topic_locked', function(data) {
			if (data.tid === tid && data.status === 'ok') {
				set_locked_state(true, 1);
			}
		});

		socket.on('event:topic_unlocked', function(data) {
			if (data.tid === tid && data.status === 'ok') {
				set_locked_state(false, 1);
			}
		});

		socket.on('event:topic_pinned', function(data) {
			if (data.tid === tid && data.status === 'ok') {
				set_pinned_state(true, 1);
			}
		});

		socket.on('event:topic_unpinned', function(data) {
			if (data.tid === tid && data.status === 'ok') {
				set_pinned_state(false, 1);
			}
		});

		socket.on('event:topic_moved', function(data) {
			if (data && data.tid > 0) ajaxify.go('topic/' + data.tid);
		});

		socket.on('event:post_edited', function(data) {
			var editedPostEl = document.getElementById('content_' + data.pid);

			var editedPostTitle = $('#topic_title_' + data.pid);

			if (editedPostTitle.length > 0) {
				editedPostTitle.fadeOut(250, function() {
					editedPostTitle.html(data.title);
					editedPostTitle.fadeIn(250);
				});
			}

			$(editedPostEl).fadeOut(250, function() {
				this.innerHTML = data.content;
				$(this).fadeIn(250);
			});

		});

		socket.on('api:posts.favourite', function(data) {
			if (data.status === 'ok' && data.pid) {
				var favBtn = $('li[data-pid="' + data.pid + '"] .favourite');
				if(favBtn.length) {
					favBtn.addClass('btn-warning')
						.attr('data-favourited', true)
						.find('i').attr('class', 'fa fa-star');
				}
			}
		});

		socket.on('api:posts.unfavourite', function(data) {
			if (data.status === 'ok' && data.pid) {
				var favBtn = $('li[data-pid="' + data.pid + '"] .favourite');
				if(favBtn.length) {
					favBtn.removeClass('btn-warning')
						.attr('data-favourited', false)
						.find('i').attr('class', 'fa fa-star-o');
				}
			}
		});

		socket.on('event:post_deleted', function(data) {
			if (data.pid) {
				 toggle_post_delete_state(data.pid);
			}
		});

		socket.on('event:post_restored', function(data) {
			if (data.pid) {
				toggle_post_delete_state(data.pid);
			}
		});

		socket.on('api:post.privileges', function(privileges) {
			toggle_mod_tools(privileges.pid, privileges.editable);
		});

		function adjust_rep(value, pid, uid) {
			var post_rep = jQuery('.post_rep_' + pid),
				user_rep = jQuery('.user_rep_' + uid);

			var ptotal = parseInt(post_rep.html(), 10),
				utotal = parseInt(user_rep.html(), 10);

			ptotal += value;
			utotal += value;

			post_rep.html(ptotal + ' ');
			user_rep.html(utotal + ' ');
		}

		function set_locked_state(locked, alert) {
			var threadReplyBtn = $('.topic-main-buttons .post_reply'),
				postReplyBtns = document.querySelectorAll('#post-container .post_reply'),
				quoteBtns = document.querySelectorAll('#post-container .quote'),
				editBtns = document.querySelectorAll('#post-container .edit'),
				deleteBtns = document.querySelectorAll('#post-container .delete'),
				numPosts = document.querySelectorAll('#post_container li[data-pid]').length,
				lockThreadEl = $('.lock_thread'),
				x;

			if (locked === true) {
				lockThreadEl.html('<i class="fa fa-unlock"></i> 解锁帖子');
				threadReplyBtn.attr('disabled', true);
				threadReplyBtn.html('已锁定 <i class="fa fa-lock"></i>');
				for (x = 0; x < numPosts; x++) {
					postReplyBtns[x].innerHTML = '已锁定 <i class="fa fa-lock"></i>';
					quoteBtns[x].style.display = 'none';
					editBtns[x].style.display = 'none';
					deleteBtns[x].style.display = 'none';
				}

				if (alert) {
					app.alert({
						'alert_id': 'thread_lock',
						type: 'success',
						title: '帖子已被锁定',
						message: '帖子已经成功锁定了。',
						timeout: 5000
					});
				}

				thread_state.locked = '1';
			} else {
				lockThreadEl.html('<i class="fa fa-lock"></i> 锁定帖子');
				threadReplyBtn.attr('disabled', false);
				threadReplyBtn.html('Reply');
				for (x = 0; x < numPosts; x++) {
					postReplyBtns[x].innerHTML = 'Reply <i class="fa fa-reply"></i>';
					quoteBtns[x].style.display = 'inline-block';
					editBtns[x].style.display = 'inline-block';
					deleteBtns[x].style.display = 'inline-block';
				}

				if (alert) {
					app.alert({
						'alert_id': 'thread_lock',
						type: 'success',
						title: '帖子已解锁',
						message: '解锁后帖子可以继续更新。',
						timeout: 5000
					});
				}

				thread_state.locked = '0';
			}
		}

		function set_delete_state(deleted) {
			var deleteThreadEl = $('.delete_thread'),
				deleteTextEl = $('.delete_thread span'),
				//deleteThreadEl.getElementsByTagName('span')[0],
				threadEl = $('#post-container'),
				deleteNotice = document.getElementById('thread-deleted') || document.createElement('div');

			if (deleted) {
				deleteTextEl.html('<i class="fa fa-comment"></i> 恢复帖子');
				threadEl.addClass('deleted');

				// Spawn a 'deleted' notice at the top of the page
				deleteNotice.setAttribute('id', 'thread-deleted');
				deleteNotice.className = 'alert alert-warning';
				deleteNotice.innerHTML = '这个帖子已经被删除，只有帖子作者和管理员才能查看。';
				threadEl.before(deleteNotice);

				thread_state.deleted = '1';
			} else {
				deleteTextEl.html('<i class="fa fa-trash-o"></i> 删除帖子');
				threadEl.removeClass('deleted');
				deleteNotice.parentNode.removeChild(deleteNotice);

				thread_state.deleted = '0';
			}
		}

		function set_pinned_state(pinned, alert) {
			var pinEl = $('.pin_thread');

			if (pinned) {
				pinEl.html('<i class="fa fa-thumb-tack"></i> 不钉住帖子');
				if (alert) {
					app.alert({
						'alert_id': 'thread_pin',
						type: 'success',
						title: '帖子成功钉上',
						message: '帖子已经成功被钉上。',
						timeout: 5000
					});
				}

				thread_state.pinned = '1';
			} else {
				pinEl.html('<i class="fa fa-thumb-tack"></i> 钉住帖子');
				if (alert) {
					app.alert({
						'alert_id': 'thread_pin',
						type: 'success',
						title: '帖子不再钉上',
						message: '帖子成功解除钉上状态。',
						timeout: 5000
					});
				}

				thread_state.pinned = '0';
			}
		}

		function toggle_post_delete_state(pid) {
			var postEl = $(document.querySelector('#post-container li[data-pid="' + pid + '"]'));

			if (postEl[0]) {
				quoteEl = $(postEl[0].querySelector('.quote')),
				favEl = $(postEl[0].querySelector('.favourite')),
				replyEl = $(postEl[0].querySelector('.post_reply'));

				socket.once('api:post.privileges', function(privileges) {
					if (privileges.editable) {
						if (!postEl.hasClass('deleted')) {
							toggle_post_tools(pid, false);
						} else {
							toggle_post_tools(pid, true);
						}
					}

					if (privileges.view_deleted) {
						postEl.toggleClass('deleted');
					} else {
						postEl.toggleClass('none');
					}
					updatePostCount();
				});
				socket.emit('api:post.privileges', pid);
			}
		}

		function toggle_post_tools(pid, state) {
			var postEl = $(document.querySelector('#post-container li[data-pid="' + pid + '"]')),
				quoteEl = $(postEl[0].querySelector('.quote')),
				favEl = $(postEl[0].querySelector('.favourite')),
				replyEl = $(postEl[0].querySelector('.post_reply'));

			if (state) {
				quoteEl.removeClass('none');
				favEl.removeClass('none');
				replyEl.removeClass('none');
			} else {
				quoteEl.addClass('none');
				favEl.addClass('none');
				replyEl.addClass('none');
			}
		}

		function toggle_mod_tools(pid, state) {
			var postEl = $(document.querySelector('#post-container li[data-pid="' + pid + '"]')),
				editEl = postEl.find('.edit'),
				deleteEl = postEl.find('.delete');

			if (state) {
				editEl.removeClass('none');
				deleteEl.removeClass('none');
			} else {
				editEl.addClass('none');
				deleteEl.addClass('none');
			}
		}




		Topic.postCount = templates.get('postcount');

		window.onscroll = updateHeader;
		window.onload = updateHeader;
	};

	function updateHeader() {
		if (pagination == null) {
			jQuery('.pagination-block i:first').on('click', function() {
				app.scrollToTop();
			});
			jQuery('.pagination-block i:last').on('click', function() {
				app.scrollToBottom();
			});
		}
		pagination = pagination || document.getElementById('pagination');

		var windowHeight = jQuery(window).height();
		var scrollTop = jQuery(window).scrollTop();
		var scrollBottom = scrollTop + windowHeight;
		var progressBar = $('.progress-bar');
		var	progressBarContainer = $('.progress-container');
		var tid = templates.get('topic_id');

		pagination.parentNode.style.display = 'block';
		progressBarContainer.css('display', '');

		if (scrollTop < jQuery('.posts > .post-row:first-child').height() && Topic.postCount > 1) {
			localStorage.removeItem("topic:" + tid + ":bookmark");
			pagination.innerHTML = ' 第 1 楼，共 ' + Topic.postCount + ' 楼 ';
			progressBar.width(0);
			return;
		}


		var count = 0, smallestNonNegative = 0;

		jQuery('.posts > .post-row:not(".deleted")').each(function() {
			count++;
			this.postnumber = count;


			var el = jQuery(this);
			var elTop = el.offset().top;
			var height = Math.floor(el.height());
			var elBottom = elTop + (height < 300 ? height : 300);

			var inView = ((elBottom >= scrollTop) && (elTop <= scrollBottom) && (elBottom <= scrollBottom) && (elTop >= scrollTop));


			if (inView) {
				if(elTop - scrollTop > smallestNonNegative) {
					localStorage.setItem("topic:" + tid + ":bookmark", el.attr('data-pid'));
					smallestNonNegative = Number.MAX_VALUE;
				}

				pagination.innerHTML = ' 第 ' + (this.postnumber-1) + ' 楼，共 ' + Topic.postCount + ' 楼 ';
				progressBar.width(((this.postnumber-1) / Topic.postCount * 100) + '%');
			}
		});

		setTimeout(function() {
			if (scrollTop + windowHeight == jQuery(document).height()) {
				pagination.innerHTML = ' 第 ' + Topic.postCount + ' 楼，共 ' + Topic.postCount + ' 楼 ';
				progressBar.width('100%');
			}
		}, 100);
	}

	Topic.scrollToPost = function(pid) {
		if (!pid) {
			return;
		}

		var container = $(window),
			scrollTo = $('#post_anchor_' + pid),
			tid = $('#post-container').attr('data-tid');

		function animateScroll() {
			$('window,html').animate({
				scrollTop: scrollTo.offset().top + container.scrollTop() - $('#header-menu').height()
			}, 400);
		}

		if (!scrollTo.length && tid) {

			var intervalID = setInterval(function () {
				loadMorePosts(tid, function (posts) {
					scrollTo = $('#post_anchor_' + pid);

					if (tid && scrollTo.length) {
						animateScroll();
					}

					if (!posts.length || scrollTo.length)
						clearInterval(intervalID);
				});
			}, 100);

		} else if (tid) {
			animateScroll();
		}
	}

	function createNewPosts(data, infiniteLoaded) {
		if(!data || (data.posts && !data.posts.length)) {
			return;
		}

		function removeAlreadyAddedPosts() {
			data.posts = data.posts.filter(function(post) {
				return $('#post-container li[data-pid="' + post.pid +'"]').length === 0;
			});
		}

		function findInsertionPoint() {
			var after = null,
				firstPid = data.posts[0].pid;
			$('#post-container li[data-pid]').each(function() {
				if(parseInt(firstPid, 10) > parseInt($(this).attr('data-pid'), 10)) {
					after = $(this);
					if(after.next().length && after.next().hasClass('post-bar')) {
						after = after.next();
					}
				} else {
					return false;
				}
			});
			return after;
		}

		removeAlreadyAddedPosts();
		if(!data.posts.length) {
			return;
		}

		var insertAfter = findInsertionPoint();

		var html = templates.prepare(templates['topic'].blocks['posts']).parse(data);
		var regexp = new RegExp("<!--[\\s]*IF @first[\\s]*-->([\\s\\S]*?)<!--[\\s]*ENDIF @first[\\s]*-->", 'g');
		html = html.replace(regexp, '');

		translator.translate(html, function(translatedHTML) {
			var translated = $(translatedHTML);

			if(!infiniteLoaded) {
				translated.removeClass('infiniteloaded');
			}

			translated.insertAfter(insertAfter)
				.hide()
				.fadeIn('slow');

			for (var x = 0, numPosts = data.posts.length; x < numPosts; x++) {
				socket.emit('api:post.privileges', data.posts[x].pid);
			}

			infiniteLoaderActive = false;

			app.populateOnlineUsers();
			app.addCommasToNumbers();
			$('span.timeago').timeago();
			$('.post-content img').addClass('img-responsive');
			updatePostCount();
			showBottomPostBar();
		});
	}

	function updatePostCount() {
		socket.emit('api:topics.postcount', templates.get('topic_id'), function(err, postcount) {
			if(!err) {
				Topic.postCount = postcount;
				$('#topic-post-count').html(Topic.postCount);
				updateHeader();
			}
		})
	}

	function loadMorePosts(tid, callback) {
		var indicatorEl = $('.loading-indicator');

		if (infiniteLoaderActive) {
			return;
		}

		infiniteLoaderActive = true;

		if (indicatorEl.attr('done') === '0') {
			indicatorEl.fadeIn();
		}

		socket.emit('api:topic.loadMore', {
			tid: tid,
			after: parseInt($('#post-container .post-row.infiniteloaded').last().attr('data-index'), 10) + 1
		}, function (data) {
			infiniteLoaderActive = false;
			if (data.posts.length) {
				indicatorEl.attr('done', '0');
				createNewPosts(data, true);
			} else {
				indicatorEl.attr('done', '1');
			}
			indicatorEl.fadeOut();
			if (callback) {
				callback(data.posts);
			}
		});
	}

	return Topic;
});