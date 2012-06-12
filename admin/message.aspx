<%@ Page Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>后台系统信息页面</title>
    <link rel="stylesheet" href="<%=Url.Content("~/admin/images/style.css") %>" type="text/css" />
    <style type="text/css">
    .SysMessageText{margin:3px 2px 3px 5px;}
    .SysMessageLink a{margin:2px 0px 0px 0px; color:#90bcea;}
    
    </style>
    <%
        MessageEntity message = ViewData.Model as MessageEntity;
        if (message == null)
        {
            throw new ArgumentNullException("ViewData.Model");
        }
    %>
</head>
<body>
<br/><br/>
   <div style="text-align:center;">
    <div id="MsgContent" style="width:300px">
      <div id="MsgHead"><%=message.Title %></div>
      <div id="MsgBody">
		 <div class="MessageIcon"></div>
        <div class="MessageText"><%=message.Content %>
        <br />
        <%if (message.JumpRoute != null)
          { %>
        <a href="<%=Url.RouteUrl(message.JumpRoute) %>" title="返回"><%=message.JumpUrl%></a>
        <%}
          else
          { %>
        <%=message.JumpUrl%>
        <%} %>
		</div>
	  </div>
	</div>
	</div>
<br/><br/>
</body>
</html>
