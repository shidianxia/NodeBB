<h1><i class="fa fa-user"></i> 成员</h1>

<button id="createUser" class="btn btn-primary">创建成员</button>
<a target="_blank" href="/admin/users/csv" class="btn btn-primary">下载 CSV</a>
<hr />
<ul class="nav nav-pills">
	<li class='active'><a href='{relative_path}/admin/users/latest'>最新成员</a></li>
	<li class=''><a href='{relative_path}/admin/users/sort-posts'>话题王</a></li>
	<li class=''><a href='{relative_path}/admin/users/sort-reputation'>最高声望</a></li>
	<li class=''><a href='{relative_path}/admin/users/search'>搜索</a></li>
</ul>

<br />
<div class="search {search_display} well">
	<input class="form-control" id="search-user" type="text" placeholder="输入成员名字搜索"/><br />
	<i class="fa fa-spinner fa-spin none"></i>
	<span id="user-notfound-notify" class="label label-danger hide">找不到用户</span><br/>
</div>

<ul id="users-container" class="users admin">
	<!-- BEGIN users -->
	<div class="users-box" data-uid="{users.uid}" data-admin="{users.administrator}" data-username="{users.username}" data-banned="{users.banned}">
		<a href="{relative_path}/user/{users.userslug}">
			<img src="{users.picture}" class="img-thumbnail"/>
		</a>
		<br/>
		<a href="{relative_path}/user/{users.userslug}">{users.username}</a>
		<br/>
		<div title="reputation">
			<i class='fa fa-star'></i>
			<span id='reputation'>{users.reputation}</span>
		</div>
		<div title="post count">
			<i class='fa fa-pencil'></i>
			<span id='postcount'>{users.postcount}</span>
		</div>
	    <div>
			<a href="#" class="btn btn-default admin-btn">赋予管理员权限</a>
		</div>
		<div>
			<a href="#" class="btn btn-default ban-btn">禁止</a>
		</div>
	</div>
	<!-- END users -->
</ul>

<div class="modal fade" id="create-modal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">创建成员</h4>
			</div>
			<div class="modal-body">
				<div class="alert alert-danger hide" id="create-modal-error"></div>
				<form>
					<div class="form-group">
						<label for="group-name">用户名</label>
						<input type="text" class="form-control" id="create-user-name" placeholder="输入用户名" />
					</div>
					<div class="form-group">
						<label for="group-name">Email</label>
						<input type="text" class="form-control" id="create-user-email" placeholder="该成员的邮件地址" />
					</div>

					<div class="form-group">
						<label for="group-name">密码</label>
						<input type="password" class="form-control" id="create-user-password" placeholder="设定密码" />
					</div>

					<div class="form-group">
						<label for="group-name">确认密码</label>
						<input type="password" class="form-control" id="create-user-password-again" placeholder="再输入一次密码" />
					</div>

				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" id="create-modal-go">创建</button>
			</div>
		</div>
	</div>
</div>



<div class="text-center {loadmore_display}">
	<button id="load-more-users-btn" class="btn btn-primary">载入更多</button>
</div>
<input type="hidden" template-variable="yourid" value="{yourid}" />
