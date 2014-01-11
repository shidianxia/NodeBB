<h1><i class="fa fa-comment"></i> 每日提示</h1>
<hr />
<div class="alert alert-warning motd">
	<p>
		<strong>每日提示</strong> (MOTD) 将会在用户登录或进入聊天时显示。
		每日提示可以在论坛的头部显示自定义信息。
	</p>
	<p>
		可以使用HTML代码或者Markdown语言。
	</p>
	<br />
	<textarea class="form-control" placeholder="欢迎回来" data-field="motd" rows="10"></textarea>
	<br />
	<form class="form-inline">
		<div class="checkbox">
			<label for="show_motd">
				<input type="checkbox" id="show_motd" data-field="show_motd" /> 显示每日提示
			</label>
		</div>
	</form>
</div>

<button class="btn btn-lg btn-primary" id="save" checked>保存</button>

<script>
	require(['forum/admin/settings'], function(Settings) {
		Settings.prepare();
	});
</script>