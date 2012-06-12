<%@ Page Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>LevenBlog - 用户组权限编辑</title>
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
</head>
<%
    lb_usertype role = ViewData.Model as lb_usertype;
    Dictionary<string, string> authcode = ViewData["authcode"] as Dictionary<string, string>;
    if (role == null)
    {
        throw new ArgumentNullException("ViewData.Model");
    }
    if (authcode == null)
    {
        throw new ArgumentNullException("ViewData[\"authcode\"]");
    }
%>
<body class="ContentBody">
  <div class="MainDiv">
	
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="CContent">
		  <tr>
		    <th class="CTitle">帐户与权限管理 - 编辑权限细节</th>
		  </tr>
		  <tr>
		    <td class="CPanel">
			<div class="SubMenu"><a href="<%=Url.Action("role") %>">权限管理</a> | 
			<a href="<%=Url.Action("userlist") %>">帐户管理</a></div>
		
			    <form action="<%=Url.Action("roleeditpost", new { controller = "admin", id = role.id.ToString() } ) %>" method="post" style="margin:0px">
			     <div align="left" style="padding:5px;">
			     <table border="0" cellpadding="3" cellspacing="1" class="TablePanel" style="margin:6px">
			     <tr><td colspan="2" align="left" style="background:#e5e5e5;padding:6px">
			     <div style="font-weight:bold;font-size:14px;"><%=role.name %> 权限设置</div></td></tr>
				     <tr><td align="right" width="100">权限简介</td><td width="300"><input name="intro" type="text" size="20" class="text" value="<%=role.intro %>"/></td></tr>
			          <%
                          foreach (KeyValuePair<string, string> au in authcode)
                          {         
			          %>
			         <tr><td align="right"><%=au.Key %></td>
			             <td>
			             <%if (au.Value.IsBooleanString())
                  { %>
			             <input type="checkbox" name="<%=au.Key %>" value="True" <%=au.Value.ToCheckString() %> />
			             <%}
                  else
                  { %>
                         <input type="text" name="<%=au.Key %>" value="<%=au.Value %>" />
			             <%} %>
		                 </td></tr>
		            <%} %>
		             <tr><td colspan="2" align="center"><input type="submit" value="保存设置" class="button"/><input type="button" value="放弃返回" class="button" onClick="history.go(-1)"/></td></tr>
			         
			     </table>
			     </div>
			    </form>
		
  </div>
 </body>
</html>
