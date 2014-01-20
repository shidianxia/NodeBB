<!DOCTYPE html>
<html>
<head>
	<title>论坛管理中心</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<script>
		var RELATIVE_PATH = "{relative_path}";
	</script>
	<link id="base-theme" href="//cdn.bootcss.com/twitter-bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link rel="stylesheet" href="//cdn.bootcss.com/font-awesome/4.0.3/css/font-awesome.min.css">
	<script type="text/javascript" src="//cdn.bootcss.com/jquery/1.10.2/jquery.min.js"></script>
	<script type="text/javascript" src="//cdn.bootcss.com/twitter-bootstrap/3.0.3/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="//cdn.bootcss.com/qunit/1.12.0/qunit.min.js"></script>
	<link rel="stylesheet" type="text/css" href="//cdn.bootcss.com/qunit/1.12.0/qunit.min.css">
	<link rel="stylesheet" type="text/css" href="{relative_path}/vendor/colorpicker/colorpicker.css">
	<script type="text/javascript" src="//cdn.bootcss.com/socket.io/0.9.16/socket.io.min.js"></script>
	<script type="text/javascript" src="{relative_path}/src/app.js"></script>
	<script type="text/javascript" src="{relative_path}/src/templates.js"></script>
	<script type="text/javascript" src="{relative_path}/src/translator.js"></script>
	<script type="text/javascript" src="{relative_path}/src/ajaxify.js"></script>
	<script src="{relative_path}/vendor/jquery/js/jquery.timeago.js"></script>
	<script src="//cdn.bootcss.com/jquery.form/3.46/jquery.form.min.js"></script>
	<script src="//cdn.bootcss.com/require.js/2.1.10/require.min.js"></script>
	<script src="//cdn.bootcss.com/bootbox.js/4.0.0/bootbox.min.js"></script>
	<script src="{relative_path}/vendor/colorpicker/colorpicker.js"></script>

	<script>
		require.config({
			baseUrl: "{relative_path}/src/modules",
			waitSeconds: 3,
			paths: {
				"forum": '../forum'
			}
		});
	</script>
	<link rel="stylesheet" type="text/css" href="//lib.sinaapp.com/js/jquery-ui/1.10.2/themes/smoothness/jquery-ui.min.css">
	<script type="text/javascript" src="//cdn.bootcss.com/jqueryui/1.10.2/jquery-ui.min.js"></script>
	<script src="{relative_path}/src/utils.js"></script>

	<link rel="stylesheet" type="text/css" href="{relative_path}/css/theme.css" />
</head>

<body class="admin">
	<div class="navbar navbar-inverse navbar-fixed-top header">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="{relative_path}/admin/index">论坛管理中心</a>
			</div>
			<div class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li>
						<a href="{relative_path}/admin/index"><i class="fa fa-home" title="首页"></i></a>
					</li>
					<li>
						<a href="{relative_path}/admin/settings"><i class="fa fa-cogs" title="设置"></i></a>
					</li>
					<li>
						<a href="{relative_path}/" target="_top"><i class="fa fa-book" title="论坛"></i></a>
					</li>
					<li>
						<a href="#" id="reconnect"></a>
					</li>
				</ul>

				<ul id="logged-in-menu" class="nav navbar-nav navbar-right">
					<li id="user_label" class="dropdown">
						<a class="dropdown-toggle" data-toggle="dropdown" href="#" id="user_dropdown">
							<img src="{userpicture}"/>
						</a>
						<ul id="user-control-list" class="dropdown-menu" aria-labelledby="user_dropdown">
							<li>
								<a id="user-profile-link" href="{relative_path}/user/{userslug}" target="_top"><span>个人页面</span></a>
							</li>
							<li id="logout-link">
								<a href="#">退出</a>
							</li>
						</ul>
					</li>

				</ul>
			</div>
		</div>
	</div>

	<input id="csrf_token" type="hidden" template-variable="csrf" value="{csrf}" />

	<div class="container" id="content">
		<div class="row">
			<div class="col-sm-3">
				<div class="well sidebar-nav">
					<ul class="nav nav-list">
						<li class="nav-header">论坛</li>
						<li class="active"><a href="{relative_path}/admin/index"><i class="fa fa-fw fa-home"></i> 首页</a></li>
						<li><a href="{relative_path}/admin/categories/active"><i class="fa fa-fw fa-folder"></i> 节点</a></li>
						<li><a href="{relative_path}/admin/users/latest"><i class="fa fa-fw fa-user"></i> 成员</a></li>
						<li><a href="{relative_path}/admin/groups"><i class="fa fa-fw fa-group"></i> 用户组</a></li>
						<li><a href="{relative_path}/admin/topics"><i class="fa fa-fw fa-book"></i> 话题</a></li>
						<li><a href="{relative_path}/admin/themes"><i class="fa fa-fw fa-th"></i> 主题</a></li>
						<li><a href="{relative_path}/admin/plugins"><i class="fa fa-fw fa-code-fork"></i> 插件</a></li>
						<li><a href="{relative_path}/admin/languages"><i class="fa fa-fw fa-comments-o"></i> 语言</a></li>
						<li><a href="{relative_path}/admin/settings"><i class="fa fa-fw fa-cogs"></i> 设置</a></li>
						<li><a href="{relative_path}/admin/database"><i class="fa fa-fw fa-hdd-o"></i> 数据库</a></li>
						<li><a href="{relative_path}/admin/logger"><i class="fa fa-fw fa-th"></i> 日志</a></li>
						<li><a href="{relative_path}/admin/motd"><i class="fa fa-fw fa-comment"></i> 每日提示</a></li>
						<li><a href="{relative_path}/admin/events"><i class="fa fa-fw fa-calendar-o"></i> 事件</a></li>
					</ul>
				</div>
				<div class="well sidebar-nav">
					<ul class="nav nav-list">
						<li class="nav-header">Social Authentication</li>
						<li><a href="{relative_path}/admin/twitter"><i class="fa fa-fw fa-twitter-square"></i> Twitter</a></li>
						<li><a href="{relative_path}/admin/facebook"><i class="fa fa-fw fa-facebook-square"></i> Facebook</a></li>
						<li><a href="{relative_path}/admin/gplus"><i class="fa fa-fw fa-google-plus-square"></i> Google+</a></li>
						<!-- BEGIN authentication -->
						<li>
							<a href="{relative_path}/admin{authentication.route}"><i class="fa fa-fw {authentication.icon}"></i> {authentication.name}</a>
						</li>
						<!-- END authentication -->
					</ul>
				</div>
				<div class="well sidebar-nav">
					<ul class="nav nav-list">
						<li class="nav-header">插件</li>
						<!-- BEGIN plugins -->
						<li>
							<a href="{relative_path}/admin{plugins.route}"><i class="fa fa-fw {plugins.icon}"></i> {plugins.name}</a>
						</li>
						<!-- END plugins -->
					</ul>
				</div>
				<div class="well sidebar-nav">
					<ul class="nav nav-list">
						<li class="nav-header">单元测试</li>
						<ul class="nav nav-list">
							<li><a href="{relative_path}/admin/testing/categories">节点</a></li>
							<!--<li><a href="{relative_path}/admin/testing/topics">话题</a></li>
							<li><a href="{relative_path}/admin/testing/posts">帖子</a></li>
							<li><a href="{relative_path}/admin/testing/accounts">账户</a></li>
							<li><a href="{relative_path}/admin/testing/chat">聊天</a></li>
							<li><a href="{relative_path}/admin/testing/notifications">提醒</a></li>
							<li><a href="{relative_path}/admin/testing/friends">友邻</a></li>
							<li><a href="{relative_path}/admin/testing/feed">RSS Feed</a></li>
							<li><a href="{relative_path}/admin/testing/emails">邮件地址</a></li>-->
						</ul>
					</ul>
				</div><!--/.well -->
			</div><!--/span-->

			<div class="col-sm-9" id="content">
