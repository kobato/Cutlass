<%@ Page Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" %>

<%
    HandleErrorInfo exct = ViewData.Model as HandleErrorInfo;
    if (exct == null)
    {
        throw new ArgumentNullException("ViewData.Model");
    }
    Exception userException = exct.Exception.InnerException;
    if (userException == null)
        userException = exct.Exception;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<title><%=userException.Message %> - 系统错误页面</title>
<link href="<%=Url.Content("~/skins/default/images/style.css") %>" rel="stylesheet" type="text/css" />
</head>
<body>
   <div style="text-align:center; margin-top:150px;">
    <div id="SysMsgContent" style="width:953px">
      <div id="SysMsgHead"><%=exct.Exception.Message %></div>
      <div id="SysMsgBody">
		 <div class="SysMessageIcon"></div>
        <div class="SysMessageText">
        <strong>错误信息:</strong><br />
        <%
            Exception ex = exct.Exception;
            while (ex != null)
            {
                Response.Write(string.Format("{0}<br />\r\n", ex.Message));
                ex = ex.InnerException;
            }
        %>
        <br />
        <strong>出错页面:</strong><br /><%=Url.Action(exct.ActionName, exct.ControllerName) %>
        <br /><br />
        <a href="<%=Url.Action("blog","index") %>" title="返回系统首页">返回系统首页</a>
		</div>
	  </div>
	</div>
	</div>
<br/><br/>

</body>
</html>