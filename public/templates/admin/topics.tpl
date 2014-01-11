<h1><i class="fa fa-book"></i> 话题</h1>
<hr />


<ul class="topics">
	<!-- BEGIN topics -->
	<li data-tid="{topics.tid}" data-locked="{topics.locked}" data-pinned="{topics.pinned}" data-deleted="{topics.deleted}">
		<div class="btn-group pull-right">
			<button data-action="pin" class="btn"><i class="fa fa-thumb-tack"></i></button>
			<button data-action="lock" class="btn"><i class="fa fa-lock"></i></button>
			<button data-action="delete" class="btn"><i class="fa fa-trash-o"></i></button>
		</div>
		<a target="_blank" href="{relative_path}/topic/{topics.slug}">{topics.title}</a>
		<ul>
			<li><i class="fa fa-clock-o"></i> 发布于 <span class="timeago" title="{topics.relativeTime}"></span> 发布者 {topics.username}</li>
			<li><i class="fa fa-comments"></i> {topics.postcount} 个帖子</li>
		</ul>
		<div class="clear"></div>
	</li>
	<!-- END topics -->
</ul>

<!-- IF notopics -->
<div class="alert alert-warning" id="category-no-topics">
	<strong>此节点下还没有任何帖子</strong>
</div>
<!-- ELSE -->
<div class="text-center">
	<button id="topics_loadmore" class="btn btn-primary btn-lg">载入更多话题</button>
</div>
<!-- ENDIF notopics -->


