
<div class="languages">
	<h1><i class="fa fa-comments-o"></i> 语言</h1>
	<hr />
	<p>
		通过以下设置修改 Nodebb 的默认语言，所有用户访问论坛时将显示默认语言，用户也可以选择使用任何我们支持的语言。
	</p>

	<form class="row">
		<div class="form-group col-sm-6">
			<label for="defaultLang">默认语言</label>
			<select data-field="defaultLang" class="form-control">
				<!-- BEGIN languages -->
				<option value="{languages.code}">{languages.name}</option>
				<!-- END languages -->
			</select>
		</div>
	</form>
</div>

<button class="btn btn-lg btn-primary" id="save">保存</button>