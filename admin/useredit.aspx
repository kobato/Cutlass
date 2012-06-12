<%@ Page Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>LevenBlog - 用户资料编辑</title>
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
    lb_user user = ViewData.Model as lb_user;
    IList<lb_usertype> roles = ViewData["roles"] as IList<lb_usertype>;
    if (user == null)
    {
        throw new ArgumentNullException("ViewData.Model");
    }
    if (roles == null)
    {
        throw new ArgumentNullException("ViewData[\"roles\"]");
    }
%>
<body class="ContentBody">
  <div class="MainDiv">
	
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="CContent">
		  <tr>
		    <th class="CTitle">用户管理 - 编辑"<%=user.name %>"的资料</th>
		  </tr>
		  <tr>
		    <td class="CPanel">
			<div class="SubMenu"><a href="<%=Url.Action("role") %>">权限管理</a> | 
			<a href="<%=Url.Action("userlist") %>">帐户管理</a></div>
		
			    <form action="<%=Url.Action("usereditpost", new { controller = "admin", id = user.id.ToString() } ) %>" method="post" style="margin:0px">
			     <div align="left" style="padding:5px;">
			     <table border="0" cellpadding="3" cellspacing="1" class="TablePanel" style="margin:6px">
			     <tr><td colspan="2" align="left" style="background:#e5e5e5;padding:6px">
			     <div style="font-weight:bold;font-size:14px;">编辑"<%=user.name %>"的资料</div></td></tr>
				     <tr><td align="right" width="100">昵称</td>
				     <td width="300">
				     <input name="nickname" type="text" size="10" class="text" value="<%=user.userinfo.nickname %>"/>
				     </td></tr>
				     <tr><td align="right">用户组</td>
			             <td><select name="typeid">
			             <%
                             foreach (lb_usertype role in roles)
                             {
                                 if (role.id == user.typeid)
                                 {
                                     Response.Write(string.Format("<option value=\"{0}\" selected=\"selected\">{1}</option>\r\n", role.id, role.name));
                                 }
                                 else
                                 {
                                     Response.Write(string.Format("<option value=\"{0}\">{1}</option>\r\n", role.id, role.name));
                                 }
                             } 
			             %>
			             </select>
					    </td></tr>
				     <tr><td align="right">用户密码</td>
				         <td><input name="password" type="text" size="20" class="text" value=""/>
			            </td></tr>
			          
			         <tr><td align="right">Mail</td>
			             <td><input name="mail" type="text" size="25" class="text" value="<%=user.userinfo.mail %>"/>
		                 </td></tr>
		
			         <tr><td align="right">生日</td>
			             <td>
			             <input name="birthday" type="text" size="20" class="text" value="<%=user.userinfo.birthday %>"/>
					    </td></tr>
			         <tr><td align="right">性别</td>
			            <td >
			            <input id="sex_0" name="sex" type="radio" value="0" /> 保密 
	                      <input id="sex_1" name="sex" type="radio" value="1" />男 
	                      <input id="sex_2" name="sex" type="radio" value="2" />女
                    	  
	                      <script type="text/javascript">
	                        var sexRadio=document.getElementById("sex_<%=user.userinfo.sex %>");
	                        sexRadio.checked="checked";
	                      </script>
		                </td></tr>
			         <tr><td align="right">头像</td>
				          <td >
				          <input name="face" type="text" size="25" class="text" value="<%=user.userinfo.face %>"/>
				        </td></tr>
			          <tr><td align="right">签名</td>
			            <td>
			            <textarea name="signature" rows="5" cols="40"><%=user.userinfo.signature %></textarea>
		                </td></tr>
		             <tr><td colspan="2" align="center"><input type="submit" name="Submit" value="保存设置" class="button"/><input type="button" value="放弃返回" class="button" onClick="history.go(-1)"/></td></tr>
			         
			     </table>
			     </div>
			    </form>
		
  </div>
 </body>
</html>
