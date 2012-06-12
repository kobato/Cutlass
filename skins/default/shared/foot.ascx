<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl, System.Web.Mvc" %>
<!--底部-->
<%
    //获取head和全局数据
    string skinpath = ViewData["skinpath"] as string;
    lb_state state = ViewData["state"] as lb_state;
    lb_config config = ViewData["config"] as lb_config;
    DateTime starttime = (DateTime)ViewData["starttime"];
    TimeSpan ts = DateTime.Now - starttime;
%>
<div id="foot">
<p>Powered By <a href="<%=Fetch.PublicUrl %>" target="_blank"><strong><%=Fetch.Name %> <%=Fetch.Version.ToString(3) %></strong></a> <%=config.copyright %> <a href="http://validator.w3.org/check/referer" target="_blank">xhtml</a> | <a href="http://jigsaw.w3.org/css-validator/validator-uri.html">css</a></p>
<p style="font-size:11px;">Processed in <b><%=ts.TotalMilliseconds.ToString("0.000") %></b> m(s)  , <b><%=ViewData["querynum"] %></b> queries , 
<a href="<%=config.skinurl %>" target="_blank"><strong><%=config.skinname %></strong></a> Design By <a href="<%=config.skinurl %>" target="_blank"><strong><%=config.skinauthor %></strong></a>
<br/><a href="http://www.miibeian.gov.cn" target="_blank" style="font-size:12px"><b><%=config.tcp %></b></a>
</p>
</div>
