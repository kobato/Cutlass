<%@ Page Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" %>
<%@ Register Src="page.ascx" TagName="Page" TagPrefix="LevenBlog" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>LevenBlog - 系统日志管理</title>
    <link rel="stylesheet" href="<%=Url.Content("~/admin/images/style.css") %>" type="text/css" />
    <script type="text/javascript" src="<%=Url.Content("~/admin/js/control.js") %>"></script>
    <script type="text/javascript" src="<%=Url.Content("~/admin/js/jquery.js") %>"></script>
    <script type="text/javascript" src="<%=Url.Content("~/admin/js/jquery.blockUI.js") %>"></script>
    <style type="text/css">
	.style1 {color: #999}
	.dialogtitle{ background:url("<%=Url.Content("~/admin/images/menu_bg.jpg")%>") repeat-x; margin:0px; padding:8px 0px 0px 0px; width:100%; height:25px; font-size:14px; font-weight:bold; color:#fff;}
	.dialogbody{ width:100%; height:120px;}
	.dialogtextarea{margin:5px;width:435px; height:115px;}
	.dialogfoot{margin:3px 1px 0px 0px; float:right; clear:both; height:28px; overflow:hidden;}
	.LogTabld{ border:#b6c3de 1px solid; text-align:left;}
	.LogTable tr{ border:#b6c3de 1px solid;}
	.LogTable td{ border:#b6c3de 1px solid;}
	.logtr{ text-align:left; border:#b6c3de 1px solid;}
	.logtd{ border-left:#b6c3de 1px solid; border-top:#b6c3de 1px solid; vertical-align:top; word-break:break-all;}
	</style>
</head>
<%
    IList<lb_log> logs = ViewData.Model as IList<lb_log>;
    if (logs == null)
    {
        throw new ArgumentNullException("ViewData.Model");
    }
%>
<body class="ContentBody">
<div class="MainDiv">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="CContent">
                <tr>
                    <th class="CTitle">
                        系统日志管理-查看系统日志</th>
                </tr>
                <tr>
                    <td class="CPanel">
                        <div class="SubMenu">
                            查看系统日志 | <a href="<%=Url.Action("logclear") %>" onclick="if (confirm('是否清除系统日志？')) {return true;} else {return false;}" title="清除系统日志">清除系统日志</a><span style="color: Red;">[最近7天的日志不会删除]</span></div>
                        <table border="0px" cellpadding="0" cellspacing="0" class="LogTabld">
                            <tr>
                                <td colspan="6" style="border-bottom: 1px solid #999;">
                                    <div class="pageContent">
                                        <div style="float: left;">
                                            <LevenBlog:Page ID="ListPage" runat="server"></LevenBlog:Page>
                                        </div>
                                    </div>
                                    <div class="Content-body" style="line-height: 10px;">&nbsp;</div>
                                </td>
                            </tr>
                            <tr align="center">
                                <td width="20" nowrap="nowrap" class="TDHead">
                                    ID</td>
                                <td width="100px" nowrap="nowrap" class="TDHead">
                                    操作页面</td>
                                <td width="300" nowrap="nowrap" class="TDHead">
                                    日志正文</td>
                                <td width="60" nowrap="nowrap" class="TDHead">
                                    操作用户</td>
                                <td class="TDHead">
                                    用户IP</td>
                                <td class="TDHead">
                                    提交日期</td>
                            </tr>
                            <%
                                foreach (lb_log log in logs)
                                {
                            %>
                                    <tr align="center" class="logtr">
                                        <td class="logtd" width="50px" align="center">
                                            <%=log.id %>
                                        </td>
                                        <td class="logtd" width="150px">
                                            <%=log.page %>
                                        </td>
                                        <td class="logtd" width="400px;">
                                            <%=Html.Encode(log.message) %>
                                        </td>
                                        <td class="logtd" width="100px" align="center">
                                            <%=Html.Encode(log.user) %>
                                        </td>
                                        <td class="logtd" width="100px" align="center">
                                            <%=Html.Encode(log.ip) %>
                                        </td>
                                        <td class="logtd" width="150px" align="center">
                                            <%=log.time.ToString("yyyy-MM-dd HH:mm:ss") %>
                                        </td>
                                    </tr>
                              <%} %>  
                        </table>
                    </td>
                </tr>
            </table>
        </div>
</body>
</html>
