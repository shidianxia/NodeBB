<h1><i class="fa fa-cogs"></i> 设置</h1>
<hr />

<ul id="settings-tab" class="nav nav-tabs">
	<li class="active"><a href="#general" data-toggle="tab">通用</a></li>
	<li><a href="#privilege-thresholds" data-toggle="tab">权限阀值</a></li>
	<li><a href="#email" data-toggle="tab">邮件</a></li>
	<li><a href="#user" data-toggle="tab">用户</a></li>
	<li><a href="#post" data-toggle="tab">帖子</a></li>
	<li><a href="#web-crawler" data-toggle="tab">搜索引擎索引</a></li>
</ul>

<div class="tab-content">
	<div class="tab-pane active" id="general">
		<div class="alert alert-warning">
			<form>
				<label>论坛标题</label>
				<input class="form-control" type="text" placeholder="论坛标题" data-field="title" /><br />
				<label>论坛描述</label>
				<input type="text" class="form-control" placeholder="关于论坛的简短描述" data-field="description" /><br />
				<label>网站关键词</label>
				<input type="text" class="form-control" placeholder="关键词为英文逗号分割" data-field="keywords" /><br />
				<label>站点 Logo</label>
				<input id="logoUrl" type="text" class="form-control" placeholder="文件路径" data-field="brand:logo" /><br />
				<input id="uploadLogoBtn" type="button" class="btn btn-default" value="上传 Logo"></input> <br /> <br/>
				<label>Imgur Client ID</label>
				<input type="text" class="form-control" placeholder="Imgur ClientID for image uploads" data-field="imgurClientID" /><br />
				<label>Favicon</label><br />
				<input id="faviconUrl" type="text" class="form-control" placeholder="favicon.ico" data-field="brand:favicon" /><br />
				<input id="uploadFaviconBtn" type="button" class="btn btn-default" value="上传 Favicon"></input> <br />
			</form>
		</div>
	</div>

	<div class="tab-pane" id="privilege-thresholds">
		<form>
			<div class="alert alert-warning">
				<p>使用 <strong>权限阀值</strong> 来确定多少声望值时用户可以获得节点主持人身份。</p><br />
				<strong>管理帖子</strong><br /> <input type="text" class="form-control" value="1000" data-field="privileges:manage_topic"><br />
				<strong>管理内容</strong><br /> <input type="text" class="form-control" value="1000" data-field="privileges:manage_content"><br />
				<div class="checkbox">
					<label>
						<input type="checkbox" data-field="privileges:disabled"> <strong>禁用权限系统</strong>
					</label>
				</div>
			</div>
		</form>
	</div>
	<div class="tab-pane" id="email">
		<form>
			<div class="alert alert-warning">
				<div>
					<p>
						请确保您已安装了第三方邮件服务 (e.g. PostageApp, Mailgun, Mandrill, SendGrid, etc), 否则可能无法通过论坛发送邮件
					</p>
					<p>
						<strong>邮件地址</strong><br />
						此邮件地址将作为收件人看到的发件人地址。
					</p>
					<input type="text" class="form-control input-lg" data-field="email:from" placeholder="info@example.org" /><br />
				</div>
			</div>
		</form>
	</div>

	<div class="tab-pane" id="user">
		<form>
			<div class="alert alert-warning">
				<div class="checkbox">
					<label>
						<input type="checkbox" data-field="allowRegistration" checked> <strong>开放注册</strong>
					</label>
				</div>
				<div class="checkbox">
					<label>
						<input type="checkbox" data-field="disableSignatures"> <strong>关闭签名功能</strong>
					</label>
				</div>
				<div class="checkbox">
					<label>
						<input type="checkbox" data-field="profile:convertProfileImageToPNG"> <strong>转换图片为 PNG 格式</strong>
					</label>
				</div>
				<label>用户上传的最大文件大小</label>
				<input type="text" class="form-control" placeholder="设置最大值" data-field="maximumProfileImageSize" /><br />
				<strong>用户名最小长度</strong><br />
				<input type="text" class="form-control" value="2" data-field="minimumUsernameLength"><br />
				<strong>用户名最大长度</strong><br />
				<input type="text" class="form-control" value="16" data-field="maximumUsernameLength"><br />
				<strong>密码最小长度</strong><br />
				<input type="text" class="form-control" value="6" data-field="minimumPasswordLength"><br />
				<strong>签名最大长度</strong><br />
				<input type="text" class="form-control" value="255" data-field="maximumSignatureLength"><br />
			</div>
		</form>
	</div>

	<div class="tab-pane" id="post">
		<form>
			<div class="alert alert-warning">
				<strong>发布延迟</strong><br /> <input type="text" class="form-control" value="10000" data-field="postDelay"><br />
				<strong>最小标题长度</strong><br /> <input type="text" class="form-control" value="3" data-field="minimumTitleLength"><br />
				<strong>最大标题长度</strong><br /> <input type="text" class="form-control" value="255" data-field="maximumTitleLength"><br />
				<strong>最小帖子内容长度</strong><br /> <input type="text" class="form-control" value="8" data-field="minimumPostLength"><br />
				<strong>聊天室显示的信息</strong><br /> <input type="text" class="form-control" value="50" data-field="chatMessagesToDisplay"><br />
				<div class="checkbox">
					<label>
						<input type="checkbox" data-field="allowGuestPosting"> <strong>允许游客发表帖子</strong>
					</label>
				</div>
				<div class="checkbox">
					<label>
						<input type="checkbox" data-field="allowGuestSearching"> <strong>允许游客搜索</strong>
					</label>
				</div>
				<div class="checkbox">
					<label>
						<input type="checkbox" data-field="useOutgoingLinksPage"> <strong>使用出站链接提示</strong>
					</label>
				</div>
				<div class="checkbox">
					<label>
						<input type="checkbox" data-field="disableSocialButtons"> <strong>禁用社交网站按钮</strong>
					</label>
				</div>
				<div class="checkbox">
					<label>
						<input type="checkbox" data-field="allowFileUploads"> <strong>允许用户上传文件</strong>
					</label>
				</div>
				<strong>最大文件大小</strong><br /> <input type="text" class="form-control" value="2048" data-field="maximumFileSize"><br />
			</div>
		</form>
	</div>

	<div class="tab-pane" id="web-crawler">
		<form>
			<div class="alert alert-warning">
				<strong>自定义 Robots.txt <small>默认留空</small></strong><br />
				<textarea class="form-control" data-field="robots.txt"></textarea>
			</div>
		</form>
	</div>
</div>


<button class="btn btn-lg btn-primary" id="save">保存</button>

<script>
	require(['forum/admin/settings'], function(Settings) {
		Settings.prepare();
	});
</script>