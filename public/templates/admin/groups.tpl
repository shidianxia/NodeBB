<h1><i class="fa fa-group"></i> 用户组</h1>

<hr />

<div class="groups">
	<ul id="groups-list">
	<!-- BEGIN groups -->
		<li data-gid="{groups.gid}">
			<div class="row">
				<div class="col-lg-8">
					<h2>{groups.name}</h2>
					<p>{groups.description}</p>
					<div class="btn-group">
						<button class="btn btn-default" data-action="members">成员</button>
						<!-- IF groups.deletable -->
						<button class="btn btn-danger" data-action="delete">删除组</button>
						<!-- ENDIF groups.deletable -->
					</div>
				</div>
				<div class="col-lg-4">
					<ul class="pull-right members">
					<!-- BEGIN members --><li data-uid="{groups.members.uid}" title="{groups.members.username}"><img src="{groups.members.picture}" /></li><!-- END members -->
					</ul>
				</div>
			</div>
		</li>
	<!-- END groups -->
	</ul>

	<div class="text-center">
		<button class="btn btn-primary" id="create">新建用户组</button>
	</div>

	<div class="modal fade" id="create-modal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title">新建用户组</h4>
				</div>
				<div class="modal-body">
					<div class="alert alert-danger hide" id="create-modal-error"></div>
					<form>
						<div class="form-group">
							<label for="group-name">用户组名称</label>
							<input type="text" class="form-control" id="create-group-name" placeholder="输入用户组名称" />
						</div>
						<div class="form-group">
							<label for="group-name">描述</label>
							<input type="text" class="form-control" id="create-group-desc" placeholder="该用户组的简短描述" />
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

	<div class="modal fade" id="group-details-modal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title">管理用户组</h4>
				</div>
				<div class="modal-body">
					<div class="alert alert-danger hide" id="create-modal-error"></div>
					<form>
						<div class="form-group">
							<label for="group-name">用户组名称</label>
							<input type="text" class="form-control" id="change-group-name" placeholder="输入用户组名称" />
						</div>
						<div class="form-group">
							<label for="group-name">描述</label>
							<input type="text" class="form-control" id="change-group-desc" placeholder="该用户组的简短描述" />
						</div>
						<div class="form-group">
							<label>成员</label>
							<p>点击成员将其移出用户组</p>
							<ul class="members current_members" id="group-details-members"></ul>
						</div>
						<div class="form-group">
							<label for="add-member">添加成员</label>
							<input type="text" class="form-control" id="group-details-search" placeholder="搜索成员" />
							<ul class="members" id="group-details-search-results"></ul>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
</div>
