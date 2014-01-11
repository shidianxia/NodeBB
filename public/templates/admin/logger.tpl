<h1><i class="fa fa-th"></i> 日志</h1>
<hr />

<h3>日志设置</h3>
<div class="alert alert-warning">

    <p>
        通过勾选您想记录的日志项目，您可以方便地记录任何人访问论坛的信息。
    </p>
	<br/>
	<p>
		只需简短地选中或取消勾选项目，此修改无需重启
	</p>
	<br/>

	<form>

		<label>
			<input type="checkbox" data-field="loggerStatus"> <strong>启用 HTTP logging 日志</strong>
		</label>
		<br/>
		<br/>

		<label>
			<input type="checkbox" data-field="loggerIOStatus"> <strong>启用 socket.io event logging 日志</strong>
		</label>
		<br/>
		<br/>


		<label>Path to log file</label>
		<input class="form-control" type="text" placeholder="/path/to/log/file.log ::: leave blank to log to your terminal" data-field="loggerPath" />
		<br />
		<br/>
		<br/>

	</form>
</div>

<button class="btn btn-lg btn-primary" id="save">保存</button>

<script>
	require(['forum/admin/settings'], function(Settings) {
		Settings.prepare();
	});
</script>
