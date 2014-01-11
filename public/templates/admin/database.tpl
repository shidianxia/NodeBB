

<!-- IF redis -->
<h1><i class="fa fa-hdd-o"></i> Redis 数据库信息</h1>
<hr />
<div id="admin-redis-info">
	<span>Redis 版本</span> <span class="text-right">{redis_version}</span><br/>
	<hr/>
	<span>持续运行时间 按秒</span> <span class="text-right">{uptime_in_seconds}</span><br/>
	<span>持续运行时间 按天</span> <span class="text-right">{uptime_in_days}</span><br/>
	<hr/>
	<span>连接的 Clients</span> <span class="text-right">{connected_clients}</span><br/>
	<span>连接的 Slaves</span> <span class="text-right">{connected_slaves}</span><br/>
	<span>禁止的 Clients</span> <span class="text-right">{blocked_clients}</span><br/>
	<hr/>

	<span>已使用内存</span> <span class="text-right">{used_memory_human}</span><br/>
	<span>内存碎片化比率</span> <span class="text-right">{mem_fragmentation_ratio}</span><br/>
	<hr/>
	<span>总计接收连接</span> <span class="text-right">{total_connections_received}</span><br/>
	<span>总计处理链接</span> <span class="text-right">{total_commands_processed}</span><br/>
	<span>每秒即时操作次数</span> <span class="text-right">{instantaneous_ops_per_sec}</span><br/>
	<hr/>
	<span>键空间命中</span> <span class="text-right">{keyspace_hits}</span><br/>
	<span>键空间未命中</span> <span class="text-right">{keyspace_misses}</span><br/>
</div>
<hr />
<h3>原始信息 </h3>
<div class="highlight">
<pre>{raw}</pre>
</div>
<!-- ENDIF redis -->

<!-- IF mongo -->
<h1><i class="fa fa-hdd-o"></i> Mongo 数据库</h1>
<hr />
<div id="admin-redis-info">

	<span>表</span> <span class="text-right">{collections}</span><br/>
	<span>对象</span> <span class="text-right">{objects}</span><br/>
	<span>对象平均大小</span> <span class="text-right">{avgObjSize} kb</span><br/>
	<hr/>
	<span>数据大小</span> <span class="text-right">{dataSize} kb</span><br/>
	<span>存储大小</span> <span class="text-right">{storageSize} kb</span><br/>
	<span>文件大小</span> <span class="text-right">{fileSize} kb</span><br/>
</div>
<hr />
<h3>原始信息 </h3>
<div class="highlight">
<pre>{raw}</pre>
</div>
<!-- ENDIF mongo -->
