<%@ Page Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    lb_config config = ViewData["config"] as lb_config;
    lb_state state = ViewData["state"] as lb_state;
    var modules = ViewData["modules"] as System.Reflection.AssemblyName[];
    if (config == null)
    {
        throw new ArgumentNullException("ViewData[\"config\"]");
    }
    if (state == null)
    {
        throw new ArgumentNullException("ViewData[\"state\"]");
    }
%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>LevenBlog 后台首页</title>
    <link rel="stylesheet" href="<%=Url.Content("~/admin/images/style.css") %>" type="text/css" />
    <script type="text/javascript" src="<%=Url.Content("~/admin/js/control.js") %>"></script>
    <style type="text/css">
		<!--
		.style1 {color: #999}
		-->
	</style>
</head>
<body class="ContentBody">
  <div class="MainDiv">
	
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="CContent">
		  <tr>
		 	<th class="CTitle">欢迎使用LevenBlog</th>
		  </tr>
		  <tr>
		    <td class="CPanel">
		        <div id="updateInfo" style="background:ffffe1;border:1px solid #89441f;padding:4px;display:none"></div>
		    <script>
		      var CVersion="2.0.0";
		      var CDate="2008-08-08";
		    </script>
		    <%--<script src="http://blog.leven.com.cn/infomation.js"></script>--%>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
			 <tr>
				 <td valign="top" style="padding:5px;width:140px"><img alt="" src="<%=Url.Content("~/admin/images/icon/ControlPanel.png") %>"/></td>
				 <td valign="top">
				    <div align="left" style="padding:5px;line-height:170%;clear:both;font-size:12px">
				     <b>当前软件主版本:</b> <%=Fetch.Version %><br/>
				     <b>软件更新日期:</b> <%=Fetch.BuildDate %><br/>
				     <b>日志数量:</b> <%=state.blognum %> 篇<br/>
				     <b>评论数量:</b> <%=state.commentnum %> 个<br/>
				     <b>引用数量:</b> <%=state.tracknum %> 个<br/>
				     <b>标签数量:</b> <%=state.tagnum %><br/>
				     <b>会员数:</b> <%=state.usernum %> 人<br/>
				     <b>访问次数:</b> <%=state.hits %> 次<br/>
				     <b>最高在线:</b> <%=state.online %> 人<br/>
				     <b><span style="font-size:12px; color:Red;">系统加载模块及版本:</span></b><br />
				     <%foreach(var item in modules){ %>
				     <b>模块名称:</b><%=item.Name %>,<b>版本号:</b><%=item.Version %><br />
				     <%} %>
				    </div>    
				 </td>
			 </tr>
			</table>
		
		</td></tr></table>
	
  </div>
 </body>
</html>
