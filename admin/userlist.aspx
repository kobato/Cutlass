<%@ Page Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" %>
<%@ Register Src="page.ascx" TagName="Page" TagPrefix="LevenBlog" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>LevenBlog - 用户管理</title>
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
    IList<lb_user> users = ViewData.Model as IList<lb_user>;
    if (users == null)
    {
        throw new ArgumentNullException("ViewData.Model");
    }
%>
<body class="ContentBody">
  <div class="MainDiv">
	
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="CContent">
		  <tr>
		    <th class="CTitle">帐户与权限管理 - 帐户管理</th>
		  </tr>
		  <tr>
		    <td class="CPanel">
			<div class="SubMenu"><a href="<%=Url.Action("role") %>">权限管理</a> | 
			<a href="<%=Url.Action("userlist") %>">帐户管理</a></div>
		
		   <input type="hidden" name="action" value="Members"/>
		   <input type="hidden" name="whatdo" value="SaveUserRight"/>
		   <input type="hidden" name="DelID" value=""/>
		<table border="0" cellpadding="2" cellspacing="1" class="TablePanel" style="margin:5px;">
		<tr><td colspan="8" style="border-bottom:1px solid #999;background:#fae1af;height:36px">&nbsp;用户名&nbsp;<input id="FindUser" type="text" class="text" size="16"/><input type="button" value="查找用户" class="button" style="margin-bottom:-2px" onclick="window.location='<%=Url.Action("usersearch") %>?name=' + escape(document.getElementById('FindUser').value);" /></td></tr><tr><td colspan="8" style="border-bottom:1px solid #999;"><div class="pageContent"></div><div class="Content-body" style="line-height:200%"></td></tr>
		        <tr align="center">
		          <td nowrap="nowrap" class="TDHead">编号</td>
		          <td width="100" nowrap="nowrap" class="TDHead">会员名称</td>
		          <td width="100" class="TDHead">会员身份</td>
		          <td class="TDHead">注册时间</td>
		          <td class="TDHead">上次访问时间</td>
		          <td class="TDHead">最后登录IP地址</td>
		          <td class="TDHead">资料修改</td>
		          <td class="TDHead">&nbsp;</td>
			   </tr>
			   <%
                   foreach (lb_user user in users)
                   {
                          
			   %>
		        <tr align="center">
		          <td nowrap><%=user.id %>
				</td>
		          <td nowrap align="left"><a href="<%=Url.RouteUrl(new { controller = "user", action = "view", name = user.name } ) %>" target="_blank"><%=user.name %></a></td>
		          <td nowrap>&nbsp;<span id="RightStr_1"><%=user.usertype.name %></span>&nbsp;</td>
		          <td nowrap>&nbsp;<%=user.userinfo.regtime.ToString("yyyy-MM-dd HH:mm:ss") %>&nbsp;</td>
		          <td nowrap>&nbsp;<%=user.userinfo.lastlogintime.ToString("yyyy-MM-dd HH:mm:ss")%>&nbsp;</td>
		          <td nowrap>&nbsp;<%=user.userinfo.lastloginip %>&nbsp;</td>
		          <td>
		                <a href="<%=Url.Action("useredit", new { controller = "admin", id = user.id.ToString() } ) %>" title="编辑资料">编辑资料</a>
		          </td>
		          <td>
		           
		          </td>
			   </tr>
			   <%} %>
		   </table>
		 	<div class="SubButton">
		      <LevenBlog:Page ID="ListPage" runat="server"></LevenBlog:Page>
		     </div>
		 
  </div>
 </body>
</html>
