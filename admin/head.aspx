<%@ Page Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>后台管理-顶部</title>
    <link rel="stylesheet" href="<%=Url.Content("~/admin/images/style.css") %>" type="text/css" />
    <script type="text/javascript">
	var _toolStatus = 1; // 默认打开
	function switchToolbar(o){
		if (_toolStatus) {
			_toolStatus = 0;
			o.src="<%=Url.Content("~/admin/images/openMenu.png") %>";
			parent.document.getElementById("ContentSet").rows = "0,*";
		}else{
			_toolStatus = 1;
			o.src="<%=Url.Content("~/admin/images/closeMenu.png") %>";
			parent.document.getElementById("ContentSet").rows = "80,*";
		}
	}
</script>
</head>
<body class="headbody">
 <div class="headmain">
 	<div style="float:right;margin:4px;">
 		<img src="<%=Url.Content("~/admin/images/closeMenu.png") %>" style="cursor:pointer" onclick="switchToolbar(this)"/>
 		<img onclick="parent.location='<%=Url.Action("logout") %>'" src="<%=Url.Content("~/admin/images/logout.png") %>" onmouseover="this.src='<%=Url.Content("~/admin/images/logoutIn.png") %>'" onmouseout="this.src='<%=Url.Content("~/admin/images/logout.png") %>'" style="cursor:pointer"/>
 	</div>
 
   <div style="height:70px;background:url('<%=Url.Content("~/admin/images/Pic2.jpg") %>') no-repeat;">
   	<div style="position: absolute; font-family: verdana; top: 10px; font-size: 10px; color: rgb(158, 169, 197); left: 143px;">LevenBlog 2.0.0 <%=DateTime.Now.ToString("yyyy-MM-dd") %></div>
   </div>
 </div>
</body>
</html>
