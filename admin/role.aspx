<%@ Page Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>LevenBlog - 用户权限管理</title>
    <link rel="stylesheet" href="<%=Url.Content("~/admin/images/style.css") %>" type="text/css" />
    <script type="text/javascript" src="<%=Url.Content("~/admin/js/control.js") %>"></script>
    <script type="text/javascript" src="<%=Url.Content("~/admin/js/jquery.js") %>"></script>
    <script type="text/javascript" src="<%=Url.Content("~/admin/js/jquery.blockUI.js") %>"></script>
    <style type="text/css">
	.style1 {color: #999}
	.dialogtitle{ background:url("<%=Url.Content("~/admin/images/menu_bg.jpg")%>") repeat-x; margin:0px; padding:3px 0px 0px 0px; width:100%; height:25px; font-size:14px; font-weight:bold; color:#fff;}
	.dialogbody{ width:100%; height:120px;}
	.dialogtextarea{margin:5px;width:435px; height:115px;}
	.dialogfoot{margin:3px 1px 0px 0px; float:right; clear:both; height:28px; overflow:hidden;}
	</style>
	<script type="text/javascript">
	    function DeleteRole(url){
	        if (confirm("是否删除所选的用户组？(该用户组的用户将自动转入\"注册用户\"组)")){
    		  window.location=url;
		  }
	    }
	</script>
</head>
<%
    IList<lb_usertype> roles = ViewData.Model as IList<lb_usertype>;
    if (roles == null)
    {
        throw new ArgumentNullException("ViewData.Model");
    }
%>
<body class="ContentBody">
  <div class="MainDiv">
	
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="CContent">
		  <tr>
		    <th class="CTitle">帐户与权限管理 - 权限管理</th>
		  </tr>
		  <tr>
		    <td class="CPanel">
			<div class="SubMenu"><a href="<%=Url.Action("role") %>">权限管理</a> | 
			<a href="<%=Url.Action("userlist") %>">帐户管理</a></div>
		
		   <form action="<%=Url.Action("roleadd") %>" method="post" style="margin:0px">
		   <input type="hidden" name="action" value="Members"/>
		   <input type="hidden" name="whatdo" value="Group"/>
		   <input type="hidden" name="DelGroup" value=""/>
		    <div align="left" style="padding:5px;">
			      <table border="0" cellpadding="2" cellspacing="1" class="TablePanel">
		        <tr align="center">
		          <td nowrap="nowrap" class="TDHead">权限标识</td>
		          <td nowrap="nowrap" class="TDHead">权限标题</td>
		          <td width="100" nowrap="nowrap" class="TDHead">&nbsp;</td>
			   </tr>
		        <%
                    foreach (lb_usertype role in roles)
                    {      
		        %>
		        <tr align="center">
		          <td ><input type="text" size="15" class="text" value="<%=role.name %>" readonly="readonly" style="background:#ffe;font-size:11px" /></td>
		          <td ><input type="text" size="20" class="text" value="<%=role.intro %>" readonly="readonly" style="background:#ffe;font-size:11px" /></td>
		          <td align="left">
		          <a href="<%=Url.Action("roleedit", new { controller = "admin", id = role.id.ToString() } ) %>" title="编辑该用户组"><img border="0" src="<%=Url.Content("~/admin/images/icon_edit.gif") %>" width="16" height="16" style="margin:0px 2px -3px 0px"/>编辑权限</a>
                  <%if(role.id>3){ %>
                  <a href="javascript:void(0);" onclick="DeleteRole('<%=Url.Action("roledelete", new { controller = "admin", id = role.id.ToString() })%>');" title="删除该用户组"><img border="0" src="<%=Url.Content("~/admin/images/icon_del.gif")%>" width="16" height="16" style="margin:0px 2px -3px 0px"/>删除用户组</a>
                  <%} %>
				  </td>
			   </tr>
			   <%
                    }
               %>
		
		        <tr align="center" bgcolor="#D5DAE0">
		         <td colspan="12" class="TDHead" align="left" style="border-top:1px solid #9EA9C5"><img src="<%=Url.Content("~/admin/images/add.gif") %>" style="margin:0px 2px -3px 2px"/>添加新权限分组</td>
		        </tr>
		        <tr align="center">
		          <td ><input name="new_name" type="text" size="15" class="text" style="font-size:11px"/></td>
		          <td ><input name="new_intro" type="text" size="20" class="text"/></td>
		          <td ><input type="submit" name="Submit" value="新增用户组" class="button"/> </td>
			   </tr>
			 </table>
		  <div style="color:#f00">权限标识是唯一标记.一旦确定就无法修改.系统自带的用户组不允许删除.新建的用户组默认为普通用户权限.</div>
			<div class="SubButton">
		      
		     </div>	  
			 </div></form>
		 </td>
		  </tr></table>
		
  </div>
 </body>
</html>
