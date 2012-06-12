<%@ Page Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>LevenBlog - 后台登陆</title>
    <style type=text/css>

body {

	background:#CAD7F7; font-size: 12px; margin-top:0px;

	SCROLLBAR-FACE-COLOR: #799AE1; SCROLLBAR-HIGHLIGHT-COLOR: #799AE1; 

	SCROLLBAR-SHADOW-COLOR: #799AE1; SCROLLBAR-DARKSHADOW-COLOR: #799AE1; 

	SCROLLBAR-3DLIGHT-COLOR: #799AE1; SCROLLBAR-ARROW-COLOR: #FFFFFF;

	SCROLLBAR-TRACK-COLOR: #AABFEC;

}

TD {

	FONT-SIZE: 12px

}

INPUT {

	BORDER-TOP-WIDTH: 1px; BORDER-LEFT-WIDTH: 1px; FONT-SIZE: 12px; BORDER-BOTTOM-WIDTH: 1px; BORDER-RIGHT-WIDTH: 1px

}

TEXTAREA {

	BORDER-TOP-WIDTH: 1px; BORDER-LEFT-WIDTH: 1px; FONT-SIZE: 12px; BORDER-BOTTOM-WIDTH: 1px; BORDER-RIGHT-WIDTH: 1px

}

SELECT {

	BORDER-TOP-WIDTH: 1px; BORDER-LEFT-WIDTH: 1px; FONT-SIZE: 12px; BORDER-BOTTOM-WIDTH: 1px; BORDER-RIGHT-WIDTH: 1px

}

SPAN {

	FONT-SIZE: 12px; POSITION: static

}

A {

	COLOR: #000000; TEXT-DECORATION: none

}

A:hover { color:#428EFF;text-decoration:underline; }

A.highlight {

	COLOR: red; TEXT-DECORATION: none

}

A.highlight:hover {

	COLOR: red

}

A.thisclass {

	FONT-WEIGHT: bold; TEXT-DECORATION: none

}

A.thisclass:hover {

	FONT-WEIGHT: bold

}

A.navlink {

	COLOR: #000000; TEXT-DECORATION: none

}

A.navlink:hover {

	COLOR: #003399; TEXT-DECORATION: none

}

.twidth {

	WIDTH: 760px

}

.content {

	FONT-SIZE: 14px; MARGIN: 5px 20px; LINE-HEIGHT: 140%; FONT-FAMILY: Tahoma,宋体

}

.aTitle {

	FONT-WEIGHT: bold; FONT-SIZE: 15px

}

TD.forumHeaderBackgroundAlternate {

	BACKGROUND-IMAGE: url(Admin/images/admin_top_bg.gif); COLOR: #000000; BACKGROUND-COLOR: #799ae1

}

#TableTitleLink A:link {

	COLOR: #ffffff; TEXT-DECORATION: none

}

#TableTitleLink A:visited {

	COLOR: #ffffff; TEXT-DECORATION: none

}

#TableTitleLink A:active {

	COLOR: #ffffff; TEXT-DECORATION: none

}

#TableTitleLink A:hover {

	COLOR: #ffffff; TEXT-DECORATION: underline

}

TD.forumRow {

	PADDING-RIGHT: 3px; PADDING-LEFT: 3px; BACKGROUND: #F1F3F5; PADDING-BOTTOM: 3px; PADDING-TOP: 3px

}

TH {

	FONT-WEIGHT: bold; FONT-SIZE: 12px; BACKGROUND-IMAGE: url(Admin/images/admin_bg_1.gif); COLOR: white; BACKGROUND-COLOR: #4455aa

}

TD.bodytitle {

	BACKGROUND-IMAGE: url(Admin/images/admin_bg_2.gif)

}

TD.bodytitle1 {

	BACKGROUND-IMAGE: url(Admin/images/admin_bg_3.gif)

}

TD.tablebody1 {

	PADDING-RIGHT: 3px; PADDING-LEFT: 3px; BACKGROUND: #bebbdb; PADDING-BOTTOM: 3px; PADDING-TOP: 3px

}

TD.forumRowHighlight {

	PADDING-RIGHT: 3px; PADDING-LEFT: 3px; BACKGROUND: #E4EDF9; PADDING-BOTTOM: 3px; PADDING-TOP: 3px

}

.tableBorder {

	BORDER-RIGHT: #183789 1px solid; BORDER-TOP: #183789 1px solid; BORDER-LEFT: #183789 1px solid; WIDTH: 98%; BORDER-BOTTOM: #183789 1px solid; BACKGROUND-COLOR: #ffffff

}

.tableBorder1 {WIDTH: 98%; }

.helplink {

	FONT: 10px verdana,arial,helvetica,sans-serif; CURSOR: help; TEXT-DECORATION: none

}

.copyright {

	PADDING-RIGHT: 1px; BORDER-TOP: #6595d6 1px dashed; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; FONT: 11px verdana,arial,helvetica,sans-serif; COLOR: #4455aa; PADDING-TOP: 1px; TEXT-DECORATION: none

}

.menuskin {

	BORDER: #666666 1px solid; VISIBILITY: hidden; FONT: 12px Verdana;

	POSITION: absolute; 

	BACKGROUND-COLOR:#EFEFEF;

	background-image:url("../skins/default/dvmenubg3.gif");

	background-repeat : repeat-y;

	}

.menuskin A {

	PADDING-RIGHT: 10px; PADDING-LEFT: 25px; COLOR: black; TEXT-DECORATION: none; behavior:url(inc/noline.htc);

	}

#mouseoverstyle {

	BACKGROUND-COLOR: #C9D5E7; margin:2px; padding:0px; border:#597DB5 1px solid;

	}

#mouseoverstyle A {

	COLOR: black

}

.menuitems{

	margin:2px;padding:1px;word-break:keep-all;

}

</style>
<style type="text/css">
body { background:#fff; background-image : url("skins/images/body_bg.gif");background-repeat: repeat-x ;  }
td { font-size:12px;}
input { border:1px solid #999; }
.button { color: #135294; border:1px solid #666; height:21px; line-height:18px; background:url("Admin/skins/images/button_bg.gif")}
div#nifty{margin: 0 10%;background: #ABD4EF;width: 420px;word-break:break-all; margin-top:60px;}
b.rtop, b.rbottom{display:block;background: #FFF}
b.rtop b, b.rbottom b{display:block;height: 1px;overflow: hidden; background: #ABD4EF}
b.r1{margin: 0 5px}
b.r2{margin: 0 3px}
b.r3{margin: 0 2px}
b.rtop b.r4, b.rbottom b.r4{margin: 0 1px;height: 2px}
</style>
</head>
<body>
<%
    string message = ViewData["message"] as string;
    message = message == null ? string.Empty : message;
%>
        <center>
        <form action="<%=Url.Action("logincheck") %>" method="post">
<div id="nifty">
<b class="rtop"><b class="r1"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b></b>
<div style="width:403px; height:26px; line-height:26px; background:none; font-size:12px; text-align:left;">LBlog后台管理 -- 管理登录</div>
<div style="width:403px; height:46px; background:#166CA3;"><img src="<%=Url.Content("~/admin/images/login.gif") %>" alt="" /></div>
<div style="width:401px !important; width:403px; height:120px; background:#fff; border-left:1px solid #649EB2; border-right:1px solid #649EB2; ">
<table width="100%" border="0" cellspacing="3" cellpadding="0">
<input name="reaction" type="hidden" value="chklogin" />
	
	<tr>
		<td align="right" style="width:120px;"><b>用户名：</b></td>
		<td align="left"><input type="text" name="username" size="16" maxlength="10" /></td>
	</tr>
	<tr>
		<td align="right"><b>密　码：</b></td>
		<td align="left"><input type="password" name="password" size="16" maxlength="20" /></td>
	</tr>
	<tr>
	
		<td align="right"><b>附加码：</b></td>
		<td align="left"><!--验证码表单--><input type="text" name="code" size="5" maxlength="5" />&nbsp;<img src="<%=Url.RouteUrl( new { controller = "blog", action = "code" } ) %>" alt="验证码,看不清楚?请点击刷新验证码" style="margin-right:17px;cursor:pointer;width:60px;height:20px;margin-bottom:-4px;margin-top:2px;" onclick="this.src=this.src+'?'"/> </td>
	</tr>
	
	<tr>
	<td align="right"></td>
	<td align="left"><input type="submit" class="AdminSub" style="padding-top:2px;" value="登陆" /></td>
	</tr>
</table>
<font color="red"><%=message %></font>
</div>
<div style="width:401px !important; width:403px; height:50px; background:#F7F7E7; border:1px solid #649EB2; border-top:1px solid #ddd; margin-bottom:5px; font-size:12px; line-height:20px; ">  版权所有&copy; 2000-2010<a href="http://leven.com.cn/" target="_blank">Leven Studio</a></div>
<b class="rbottom"><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r1"></b>
</div>
</form>
</center>
</body>
</html>
