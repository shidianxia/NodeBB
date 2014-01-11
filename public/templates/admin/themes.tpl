<h1><i class="fa fa-th"></i> 主题</h1>
<hr />

<h3>自定义主题</h3>
<p>
	以下主题已经安装就绪。
</p>
<ul class="themes" id="installed_themes">
	<li><i class="fa fa-refresh fa-spin"></i> 检查已安装的主题...</li>
</ul>

<h3>Bootswatch 主题</h3>
<p>
	NodeBB 主题基于 Bootswatch, 从Bootstrap衍生而来。
</p>
<ul class="themes" id="bootstrap_themes">
	<li><i class="fa fa-refresh fa-spin"></i> 正在载入主题</li>
</ul>

<h3>恢复默认</h3>
<p class="alert">
	<button class="btn btn-warning" id="revert_theme">还原</button> 点击此按钮将还原所有主题设置。
</p>

<script>
	var bootswatchListener = function(data) {
		require(['forum/admin/themes'], function(t) {
			t.render(data);
		});
	}
</script>