<div class="unread">
	<ol class="breadcrumb">
		<li><a href="{relative_path}/">[[global:home]]</a></li>
		<li class="active">{category_name}</li>
	</ol>

	<div class="alert alert-warning {no_topics_message}" id="category-no-topics">
		<strong>[[unread:no_unread_topics]]</strong>
	</div>

	<button id="mark-allread-btn" class="btn btn-primary {show_markallread_button}">[[unread:mark_all_read]]</button>

	<a href="{relative_path}/unread">
		<div class="alert alert-warning hide" id="new-topics-alert"></div>
	</a>

	<div class="category row">
		<div class="{topic_row_size}">
			<ul id="topics-container" data-next-start="{nextStart}">
			<!-- BEGIN topics -->
			<li class="category-item {topics.deleted-class}">
				<div class="row">
					<div class="col-md-12 topic-row">
						<a href="{relative_path}/topic/{topics.slug}">
							<h3><span class="topic-title"><strong><i class="fa {topics.pin-icon}"></i> <i class="fa {topics.lock-icon}"></i></strong> {topics.title}</span></h3>
						</a>
						<small>
							<span class="topic-stats">
								<strong class="human-readable-number" title="{topics.postcount}">{topics.postcount}</strong>
								个回复
							</span>
							|
							<span class="topic-stats">
								<strong class="human-readable-number" title="{topics.viewcount}">{topics.viewcount}</strong>
								次浏览
							</span>
							|
							<span>
								<a href="{relative_path}/user/{topics.userslug}">
									<img class="teaser-pic" src="{topics.picture}" title="{topics.username}"/>
								</a>
								发布于
								<a href="{relative_path}/category/{topics.categorySlug}">
									<i class="fa {topics.categoryIcon}"></i> {topics.categoryName}
								</a>
								<span class="timeago" title="{topics.relativeTime}"></span>
								</span>
							</span>

							<span class="pull-right hidden-xs">
								<!-- IF topics.unreplied -->
								还没有人回复
								<!-- ELSE -->
								<a href="{relative_path}/user/{topics.teaser_userslug}">
									<img class="teaser-pic" src="{topics.teaser_userpicture}" title="{topics.teaser_username}"/>
								</a>
								<a href="{relative_path}/topic/{topics.slug}#{topics.teaser_pid}">
									回复于
								</a>
								<span class="timeago" title="{topics.teaser_timestamp}"></span>
								<!-- ENDIF topics.unreplied -->
							</span>
						</small>
					</div>
				</div>
			</li>
			<!-- END topics -->
			</ul>
			<button id="load-more-btn" class="btn btn-primary hide">[[unread:load_more]]</button>
		</div>
	</div>
</div>
