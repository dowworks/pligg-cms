<!-- modules.tpl -->
{literal}
<script type="text/javascript">
$(document).ready(function(){ 
	
	$(function() {
		$("#contentLeft tbody").sortable({ opacity: 0.6, cursor: 'move', update: function() {
			var order = $(this).sortable("serialize") + '&action=updateRecordsListings'; 
			$.post("admin_update_module_widgets.php", order, function(theResponse){
				$("#contentRight").html(theResponse);
			}); 															 
		}								  
		});
	});

});	
</script>
{/literal}
{checkActionsTpl location="tpl_admin_modules_top"}

<legend>{$module_management_name}</legend>
<p>{$module_management_desc}</p>
{if $status neq ""}
	<ul class="nav nav-tabs">
		<li class="{if $status eq "installed"}active{/if}" ><a href="admin_modules.php?status=installed">Installed</a></li>
		<li class="{if $status eq "uninstalled"}active{/if}" ><a href="admin_modules.php?status=uninstalled">Uninstalled</a></li>
	</ul>
	<div class="tab-content" >
		{if $status eq "installed"}
			{if $no_module_update_require neq '0'}
				<div class="alert">
					There are updates available for {$no_module_update_require} modules. <a href="admin_modules.php?token=1">Click here</a> to review them.
				</div>
			{/if}
			<form name="bulk_moderate" method="post">
				{* 
				<div class="module_apply">
					<input type="submit" class="btn btn-primary" name="submit" value="{$btn_apply_change}" id="apply_changes" />
				</div>
				<br />
				*}
				<table class="table table-bordered" id="contentLeft">
				<thead>
					<tr>
						{* <th style="text-align:center;">Enabled</th> *}
						<th>Details</th>
						<th>Requires</th>
						<th style="text-align:center;">Homepage</th>
						{php} if (!isset($_GET['token'])) { {/php}
							<th style="text-align:center;">Settings</th>
						{php} } {/php}
						<th style="text-align:center;">Uninstall</th>
						{php} if (isset($_GET['token'])) { {/php}
							<th style="text-align:center;">Update</th>
						{php} } {/php}
					</tr>
				</thead>
				<tbody>
					{section name=nr1 loop=$module_info}	
						<tr id="recordsArray_{$module_info[nr1].id}"  style="cursor:move;">
							{*
							<td style="text-align:center;vertical-align:middle;">
								{$module_info[nr1].first_row}
							</td>
							*}
							<td>{$module_info[nr1].dname} {$module_info[nr1].desc}</td>
							<td style="vertical-align:middle;">{$module_info[nr1].requires}</td>
							<td style="text-align:center;vertical-align:middle;">{$module_info[nr1].homepage_url}</td>
							{php} if (!isset($_GET['token'])) { {/php}
								<td style="text-align:center;vertical-align:middle;">{$module_info[nr1].settings_url}</td>
							{php} } {/php}
							<td style="text-align:center;vertical-align:middle;">
								<a class="btn btn-danger btn-mini" href="?action=remove&module={$module_info[nr1].name}">{$btn_module_remove}</a>
							</td>
							{php} if (isset($_GET['token'])) { {/php}
								<td style="text-align:center;vertical-align:middle;">
									{$module_info[nr1].version}
								</td>
							{php} } {/php}
						</tr>
					{/section}
				</tbody>
				</table>    
			</form>
		{else if $status eq "uninstalled"}	
			{if $no_module_update_require neq '0'}
				<div class="alert">
					There are updates available for {$no_module_update_require} modules. <a href="admin_modules.php?status=uninstalled&updkey={$updatekey}&token=1">Click here</a> to review them.
				</div>
			{/if}
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>Details</th>
						<th>Requires</th>
						<th style="text-align:center;">Homepage</th>
						<th style="text-align:center;">Install</th>
						{php} if (isset($_GET['token'])) { {/php}
							<th style="text-align:center;">Update</th>
						{php} } {/php}
					</tr>
				</thead>
				<tbody>	
					{section name=nr loop=$module_info}	
						<tr>
							<td style="vertical-align:middle;">{$module_info[nr].dname} <br/> {$module_info[nr].desc} {$requirement_failed}</td>
							<td style="vertical-align:middle;">{$module_info[nr].requires}</td>
							<td style="text-align:center;vertical-align:middle;">{$module_info[nr].homepage_url}</td>
							<td style="text-align:center;vertical-align:middle;"><a class="btn {if $requirement_failed eq 'false'}disabled{else}btn-success{/if} btn-mini" href="?action=install&module={$module_info[nr].value}">Install</a></td>
							{php} if (isset($_GET['token'])) { {/php}
								<td style="text-align:center;vertical-align:middle;">
									{$module_info[nr].version}
								</td>
							{php} } {/php}
						</tr>
					{/section}
				</tbody>
			</table>
		{/if}
	</div>
{/if}
<!--/modules.tpl -->