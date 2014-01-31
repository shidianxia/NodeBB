<div class="composer">
	<div class="composer-container">
		<input class="title form-control" type="text" tabIndex="1" placeholder="输入您的帖子标题..." />
		<div class="btn-toolbar formatting-bar">
			<div class="btn-group">
				<span class="btn btn-link" tabindex="-1"><i class="fa fa-bold"></i></span>
				<span class="btn btn-link" tabindex="-1"><i class="fa fa-italic"></i></span>
				<span class="btn btn-link" tabindex="-1"><i class="fa fa-list"></i></span>
				<span class="btn btn-link" tabindex="-1"><i class="fa fa-link"></i></span>
				<span class="btn btn-link img-upload-btn hide" tabindex="-1">
					<i class="fa fa-picture-o"></i>
				</span>
				<span class="btn btn-link file-upload-btn hide" tabindex="-1">
					<i class="fa fa-upload"></i>
				</span>
				<form id="fileForm">
						<input type="file" id="files" name="files[]" multiple class="hide"/>
				</form>
			</div>
		</div>

		<ul class="nav nav-tabs">
			<li class="active"><a data-pane=".tab-write" data-toggle="tab">编辑</a></li>
			<li><a data-pane=".tab-preview" data-toggle="tab">预览</a></li>
			<li class="btn-group pull-right action-bar">
				<button class="btn btn-default" data-action="discard" tabIndex="5"><i class="fa fa-times"></i> 撤销</button>
				<button data-action="post" class="btn btn-default btn-primary" tabIndex="3"><i class="fa fa-check"></i> 发布</button>
			</li>
		</ul>

		<div class="tab-content">
			<div class="tab-pane active tab-write">
				<textarea class="write" tabIndex="2"></textarea>
			</div>
			<div class="tab-pane tab-preview">
				<div class="preview well"></div>
			</div>
		</div>

		<div class="imagedrop"><div>您可以拖放图片到这里</div></div>

		<div class="text-center">
			<span>
				<small>内容支持<a href="http://daringfireball.net/projects/markdown/syntax">Markdown</a>格式 </small>
				<span class="upload-instructions hide"><small>通过拖放简单方便上传图片</small></span>
			</span>

		</div>

		<div class="resizer"><div class="trigger text-center"><i class="fa fa-chevron-up"></i></div></div>
	</div>
</div>