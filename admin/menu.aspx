<%@ Page Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>LevenBlog 左面菜单</title>
    <link rel="stylesheet" href="<%=Url.Content("~/admin/images/style.css") %>" type="text/css" />
    <%
        lb_user manager = ViewData["manager"] as lb_user;
        Authority authority = ViewData["managerauthority"] as Authority;
        if (manager == null)
        {
            throw new ArgumentNullException("ViewData[\"manager\"]");
        }
        if (authority == null)
        {
            throw new ArgumentNullException("ViewData[\"managerauthority\"]");
        }
    %>
<script type="text/javascript">
var LastItem=null;
function MenuClick(obj,url){
 if (LastItem!=null){
  LastItem.className="menuA";
 }
 obj.className="menuAS";
 LastItem=obj;
 obj.blur();
 if (url.length>0) parent.MainContent.location=url;
}
</script>
<style type="text/css">
html{
	overflow:hidden;
}
</style>
</head>
<body class="menuBody" onload="MenuClick(document.getElementById('index'),'<%=Url.Action("main") %>')">

 <ul class="menuUL">
   <li><a id="index" href="javascript:void(0)" class="menuA" onclick="MenuClick(this,'<%=Url.Action("main") %>')"><img src="<%=Url.Content("~/admin/images/icon/b.gif") %>" alt="" border="0" class="MenuIcon icon0"/>后台首页</a></li>
   <li><a href="javascript:void(0)" class="menuA" onclick="MenuClick(this,'<%=Url.Action("config") %>')"><img src="<%=Url.Content("~/admin/images/icon/b.gif") %>" alt="" border="0" class="MenuIcon icon2"/>站点基本设置</a></li>
   <li><a href="javascript:void(0)" class="menuA" onclick="MenuClick(this,'<%=Url.Action("category") %>')"><img src="<%=Url.Content("~/admin/images/icon/b.gif") %>" alt="" border="0" class="MenuIcon icon4"/>日志分类管理</a></li>
   <li><a href="javascript:void(0)" class="menuA" onclick="MenuClick(this,'<%=Url.RouteUrl(new { controller = "admin", action="comment", page = "1" }) %>')"><img src="<%=Url.Content("~/admin/images/icon/b.gif") %>" alt="" border="0" class="MenuIcon icon10"/>评论引用管理</a></li>
   <li><a href="javascript:void(0)" class="menuA" onclick="MenuClick(this,'<%=Url.Action("skin") %>')"><img src="<%=Url.Content("~/admin/images/icon/b.gif") %>" alt="" border="0" class="MenuIcon icon5"/>系统模板管理</a></li>
   <li><a href="javascript:void(0)" class="menuA" onclick="MenuClick(this,'<%=Url.Action("upfile") %>')"><img src="<%=Url.Content("~/admin/images/icon/b.gif") %>" alt="" border="0" class="MenuIcon icon3"/>上传附件管理</a></li>
   <li><a href="javascript:void(0)" class="menuA" onclick="MenuClick(this,'<%=Url.Action("role") %>')"><img src="<%=Url.Content("~/admin/images/icon/b.gif") %>" alt="" border="0" class="MenuIcon icon6"/>帐户与权限</a></li>
   <li><a href="javascript:void(0)" class="menuA" onclick="MenuClick(this,'<%=Url.Action("link") %>')"><img src="<%=Url.Content("~/admin/images/icon/b.gif") %>" alt="" border="0" class="MenuIcon icon7"/>友情链接管理</a></li>
   <li><a href="javascript:void(0)" class="menuA" onclick="MenuClick(this,'<%=Url.Action("syslog") %>')"><img src="<%=Url.Content("~/admin/images/icon/b.gif") %>" alt="" border="0" class="MenuIcon icon8"/>系统日志查看</a></li>
   <li><a href="javascript:void(0)" class="menuA" onclick="MenuClick(this,'<%=Url.Action("info") %>')"><img src="<%=Url.Content("~/admin/images/icon/b.gif") %>" alt="" border="0" class="MenuIcon icon1"/>服务器信息</a></li>
   <!--<li><a href="javascript:void(0)" class="menuA" onclick="MenuClick(this,'ConContent.asp?Fmenu=Logout&Smenu=')"><img src="images/Control/icon/icon9.gif" alt="" border="0" class="MenuIcon"/>退出</a></li>-->
</ul>
 </body>
</html>
