<input type="hidden" template-variable="expose_tools" value="{expose_tools}" />
<input type="hidden" template-variable="topic_id" value="{topic_id}" />
<input type="hidden" template-variable="locked" value="{locked}" />
<input type="hidden" template-variable="deleted" value="{deleted}" />
<input type="hidden" template-variable="pinned" value="{pinned}" />
<input type="hidden" template-variable="topic_name" value="{topic_name}" />
<input type="hidden" template-variable="postcount" value="{postcount}" />
<input type="hidden" template-variable="twitter-intent-url" value="{twitter-intent-url}" />
<input type="hidden" template-variable="facebook-share-url" value="{facebook-share-url}" />
<input type="hidden" template-variable="google-share-url" value="{google-share-url}" />


<div class="topic">
	<ol class="breadcrumb">
		<li itemscope="itemscope" itemtype="http://data-vocabulary.org/Breadcrumb">
			<a href="{relative_path}/" itemprop="url"><span itemprop="title">[[global:home]]</span></a>
		</li>
		<li itemscope="itemscope" itemtype="http://data-vocabulary.org/Breadcrumb">
			<a href="{relative_path}/category/{category_slug}" itemprop="url"><span itemprop="title">{category_name}</span></a>
		</li>
		<li class="active" itemscope="itemscope" itemtype="http://data-vocabulary.org/Breadcrumb">
			<span itemprop="title">{topic_name} <a target="_blank" href="../{topic_id}.rss"><i class="fa fa-rss-square"></i></a></span>
		</li>

	</ol>

	<ul id="post-container" class="posts" data-tid="{topic_id}">
		<!-- BEGIN posts -->
			<li class="row post-row infiniteloaded" data-pid="{posts.pid}" data-uid="{posts.uid}" data-username="{posts.username}" data-userslug="{posts.userslug}" data-index="{posts.index}" data-deleted="{posts.deleted}" itemscope itemtype="http://schema.org/Comment">
				<a id="post_anchor_{posts.pid}" name="{posts.pid}"></a>

				<meta itemprop="datePublished" content="{posts.relativeTime}">
				<meta itemprop="dateModified" content="{posts.relativeEditTime}">

				<div class="col-md-1 profile-image-block hidden-xs hidden-sm sub-post">
					<a href="{relative_path}/user/{posts.userslug}">
						<img src="{posts.picture}" align="left" class="img-thumbnail" itemprop="image" />
						<!-- IF posts.user_banned -->
						<span class="label label-danger">[[topic:banned]]</span>
						<!-- ENDIF posts.user_banned -->
					</a>

				</div>

				<div class="col-md-11">
					<div class="post-block">
						<a class="main-post avatar" href="{relative_path}/user/{posts.userslug}">
							<img itemprop="image" src="{posts.picture}" align="left" class="img-thumbnail" width=150 height=150 />
						</a>
						<h3 class="main-post">
							<p id="topic_title_{posts.pid}" class="topic-title" itemprop="name">{topic_name}</p>
						</h3>

						<div class="topic-buttons">
							<div class="btn-group">
								<button class="btn btn-sm btn-default dropdown-toggle" data-toggle="dropdown" type="button" title="[[topic:posted_by]] {posts.username}">
									<span class="username-field" href="{relative_path}/user/{posts.userslug}" itemprop="author">{posts.username}&nbsp;</span>
									<span class="caret"></span>
								</button>

							    <ul class="dropdown-menu">
									<li><a href="{relative_path}/user/{posts.userslug}"><i class="fa fa-user"></i> [[topic:profile]]</a></li>
									<li><a href="#" class="chat"><i class="fa fa-comment"></i> [[topic:chat]]</a></li>
							    </ul>
							</div>

							<div class="btn-group">
								<!-- IF @first -->
								<button class="btn btn-sm btn-default follow" type="button" title="话题有新回复提醒我"><i class="fa fa-eye"></i></button>
								<!-- ENDIF @first -->
								<button data-favourited="{posts.favourited}" class="favourite btn btn-sm btn-default <!-- IF posts.favourited --> btn-warning <!-- ENDIF posts.favourited -->" type="button">
									<span class="favourite-text">[[topic:favourite]]</span>
									<span class="post_rep_{posts.pid}">{posts.reputation} </span>
									<!-- IF posts.favourited -->
									<i class="fa fa-star"></i>
									<!-- ELSE -->
									<i class="fa fa-star-o"></i>
									<!-- ENDIF posts.favourited -->
								</button>
							</div>
							<div class="btn-group">
								<button class="btn btn-sm btn-default quote" type="button" title="[[topic:quote]]"><i class="fa fa-quote-left"></i></button>
								<button class="btn btn-sm btn-primary btn post_reply" type="button">[[topic:reply]] <i class="fa fa-reply"></i></button>
							</div>

							<div class="pull-right">
								<div class="btn-group post-tools">
									<button class="btn btn-sm btn-default link" type="button" title="[[topic:link]]"><i class="fa fa-link"></i></button>
									<!-- IF !disableSocialButtons -->
									<button class="btn btn-sm btn-default facebook-share" type="button" title=""><i class="fa fa-facebook"></i></button>
									<button class="btn btn-sm btn-default twitter-share" type="button" title=""><i class="fa fa-twitter"></i></button>
									<button class="btn btn-sm btn-default google-share" type="button" title=""><i class="fa fa-google-plus"></i></button>
									<!-- ENDIF !disableSocialButtons -->
								</div>

								<!-- IF posts.display_moderator_tools -->
								<div class="btn-group post-tools">
									<button class="btn btn-sm btn-default edit" type="button" title="[[topic:edit]]"><i class="fa fa-pencil"></i></button>
									<button class="btn btn-sm btn-default delete" type="button" title="[[topic:delete]]"><i class="fa fa-trash-o"></i></button>
									<!-- IF !@first -->
									<button class="btn btn-sm btn-default move" type="button" title="[[topic:move]]"><i class="fa fa-arrows"></i></button>
									<!-- ENDIF !@first -->
								</div>
								<!-- ENDIF posts.display_moderator_tools -->
							</div>

							<input id="post_{posts.pid}_link" value="" class="pull-right" style="display:none;"></input>
						</div>

						<div id="content_{posts.pid}" class="post-content" itemprop="text">{posts.content}</div>
						<!-- IF posts.signature -->
						<div class="post-signature">{posts.signature}</div>
						<!-- ENDIF posts.signature -->

						<div class="post-info">
							<span class="pull-left">
								[[topic:reputation]]: <i class='fa fa-star'></i> <span class='formatted-number post_rep_{posts.uid}'>{posts.user_rep}</span>&nbsp;|&nbsp;[[topic:posts]]: <i class='fa fa-pencil'></i> <span class='formatted-number user_postcount_{posts.uid}'>{posts.user_postcount}</span>
								{posts.additional_profile_info}
							</span>
							<span class="pull-right">
								[[category:posted]] <span class="relativeTimeAgo timeago" title="{posts.relativeTime}"></span>
								<!-- IF posts.editor -->
								<span>| [[category:last_edited_by]] <strong><a href="{relative_path}/user/{posts.editorslug}">{posts.editorname}</a></strong></span>
								<span class="timeago" title="{posts.relativeEditTime}"></span>
								<!-- ENDIF posts.editor -->
							</span>
							<div style="clear:both;"></div>
						</div>
					</div>
				</div>
			</li>

			<!-- IF @first -->
			<li class="well post-bar">
				<div class="inline-block">
					<small class="topic-stats">
						<span>[[category:posts]]</span>
						<strong><span id="topic-post-count" class="human-readable-number" title="{postcount}">{postcount}</span></strong> |
						<span>[[category:views]]</span>
						<strong><span class="human-readable-number" title="{viewcount}">{viewcount}</span></strong> |
						<span>[[category:browsing]]</span>
					</small>
					<div class="thread_active_users active-users inline-block"></div>
				</div>
				<div class="topic-main-buttons pull-right inline-block">
					<button class="btn btn-primary post_reply" type="button">[[topic:reply]]</button>
					<div class="btn-group thread-tools hide">
						<button class="btn btn-default dropdown-toggle" data-toggle="dropdown" type="button">[[topic:thread_tools.title]] <span class="caret"></span></button>
						<ul class="dropdown-menu">
							<li><a href="#" class="pin_thread"><i class="fa fa-thumb-tack"></i> [[topic:thread_tools.pin]]</a></li>
							<li><a href="#" class="lock_thread"><i class="fa fa-lock"></i> [[topic:thread_tools.lock]]</a></li>
							<li class="divider"></li>
							<li><a href="#" class="move_thread"><i class="fa fa-arrows"></i> [[topic:thread_tools.move]]</a></li>
							<li><a href="#" class="fork_thread"><i class="fa fa-code-fork"></i> [[topic:thread_tools.fork]]</a></li>
							<li class="divider"></li>
							<li><a href="#" class="delete_thread"><span class="text-error"><i class="fa fa-trash-o"></i> [[topic:thread_tools.delete]]</span></a></li>
						</ul>
					</div>
				</div>
				<div style="clear:both;"></div>
			</li>
			<!-- ENDIF @first -->
		<!-- END posts -->
	</ul>

	<div class="well col-md-11 col-xs-12 pull-right hide">
		<div class="topic-main-buttons pull-right inline-block hide">
			<div class="loading-indicator" done="0" style="display:none;">
				[[topic:loading]] <span class="hidden-xs hidden-sm" style="display:inline!important;">[[topic:more_posts]]</span> <i class="fa fa-refresh fa-spin"></i>
			</div>
			<button class="btn btn-primary post_reply" type="button">[[topic:reply]]</button>
			<div class="btn-group thread-tools hide">
				<button class="btn btn-default dropdown-toggle" data-toggle="dropdown" type="button">[[topic:thread_tools.title]] <span class="caret"></span></button>
				<ul class="dropdown-menu">
					<li><a href="#" class="pin_thread"><i class="fa fa-thumb-tack"></i> [[topic:thread_tools.pin]]</a></li>
					<li><a href="#" class="lock_thread"><i class="fa fa-lock"></i> [[topic:thread_tools.lock]]</a></li>
					<li class="divider"></li>
					<li><a href="#" class="move_thread"><i class="fa fa-arrows"></i> [[topic:thread_tools.move]]</a></li>
					<li><a href="#" class="fork_thread"><i class="fa fa-code-fork"></i> [[topic:thread_tools.fork]]</a></li>
					<li class="divider"></li>
					<li><a href="#" class="delete_thread"><span class="text-error"><i class="fa fa-trash-o"></i> [[topic:thread_tools.delete]]</span></a></li>
				</ul>
			</div>
		</div>
		<div style="clear:both;"></div>
	</div>

	<div id="move_thread_modal" class="modal" tabindex="-1" role="dialog" aria-labelledby="Move Topic" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h3>[[topic:move_topic]]</h3>
				</div>
				<div class="modal-body">
					<p id="categories-loading"><i class="fa fa-spin fa-refresh"></i> [[topic:load_categories]]</p>
					<ul class="category-list"></ul>
					<p>
						[[topic:disabled_categories_note]]
					</p>
					<div id="move-confirm" style="display: none;">
						<hr />
						<div class="alert alert-info">[[topic:topic_will_be_moved_to]] <strong><span id="confirm-category-name"></span></strong></div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal" id="move_thread_cancel">[[global:buttons.close]]</button>
					<button type="button" class="btn btn-primary" id="move_thread_commit" disabled>[[topic:confirm_move]]</button>
				</div>
			</div>
		</div>
	</div>


	<div id="fork-thread-modal" class="hide" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true" data-backdrop="none">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4>[[topic:fork_topic]]</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="title">标题</label>
						<input id="fork-title" type="text" class="form-control" placeholder="输入新的话题标题..."><br/>
						<label>[[topic:fork_topic_instruction]]</label> <br/>
						<span id="fork-pids"></span>
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal" id="fork_thread_cancel">[[global:buttons.close]]</button>
					<button type="button" class="btn btn-primary" id="fork_thread_commit" disabled>[[topic:confirm_fork]]</button>
				</div>
			</div>
		</div>
	</div>

	<div id="move-post-modal" class="hide" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true" data-backdrop="none">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4>[[topic:move_post]]</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="topicId">话题 ID</label>
						<input id="topicId" type="text" class="form-control" placeholder="输入话题 ID"><br/>
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal" id="move_post_cancel">[[global:buttons.close]]</button>
					<button type="button" class="btn btn-primary" id="move_post_commit" disabled>[[topic:confirm_move]]</button>
				</div>
			</div>
		</div>
	</div>

</div>