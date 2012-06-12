<%@ Page Language="C#" MasterPageFile="../shared/blog.master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" %>

<asp:Content ID="blogListViewSider" ContentPlaceHolderID="BlogSider" runat="server">
<%Html.RenderPartial("sider"); %>
</asp:Content>

<asp:Content ID="BlogListView" ContentPlaceHolderID="BlogContent" runat="server" EnableViewState="false">
<div id="body_container">
<div id="mainContent">
<div id="mainContent-topimg"></div>
<div id="Content_ContentList" class="content-width">
<%--<div class="pageContent" style="text-align:Right;overflow:hidden;height:18px;line-height:140%">
<span style="float:left"></span>
<div class="page" style="float:Left">
<ul>
<li class="pageNumber"><strong>1</strong></li>
</ul>
</div> 
预览模式: <a href="?distype=normal" accesskey="1">普通</a> | <a href="?distype=list" accesskey="2">列表</a>
</div>--%>
<%
    IList<lb_blog> blogList = ViewData.Model as IList<lb_blog>;
    Authority authority = ViewData["authority"] as Authority;
    string skinpath = ViewData["skinpath"] as string;
    if (blogList == null)
    {
        throw new ArgumentNullException("ViewData.Model");
    }
    if (authority == null)
    {
        throw new ArgumentNullException("ViewData[\"authority\"]");
    }
    if (skinpath == null)
    {
        throw new ArgumentNullException("ViewData[\"skinpath\"]");
    }
    foreach (lb_blog blog in blogList)
    {
%>
<!-- BlogList -->
<div class="Content">
<div class="Content-top">
<div class="ContentLeft"></div>
<div class="ContentRight"></div>
<h1 class="ContentTitle">
<img src="<%=Url.Content("~/" + skinpath + blog.Category.image) %>" style="margin:0px 2px -4px 0px;" alt="" class="CateIcon"/>
<a class="titleA" href="<%=Url.BlogUrl(blog) %>"><%if (blog.istop) Response.Write("<span style=\"color:red;\">[固顶]</span>"); %><%=Html.Encode(blog.title) %></a>
</h1>
<h2 class="ContentAuthor">作者:<%=blog.postuser %> 日期:<%=blog.posttime.ToString("yyyy-MM-dd") %></h2>
</div>
<div id="log_<%=blog.id %>">
<div class="Content-body">
<%=blog.intro %>
<br />
<p><a href="<%=Url.BlogUrl(blog) %>" class="more">查看更多...</a></p>
<p>Tags: 
<%
    string[] tagArray = blog.tags.Split(',');
    foreach (string tag in tagArray)
    {
        Response.Write(string.Format("<a href=\"{0}\" title=\"查看Tag{1}\">{1}</a>&nbsp;\r\n", Url.Action("tag", new { q = Html.Encode(tag), page = "1" }), tag));
    }
%>
</div>
<div class="Content-bottom">
<div class="ContentBLeft"></div>
<div class="ContentBRight"></div>
分类:<a href="<%=Url.CategoryUrl(blog.Category)%>" title=""><%=blog.Category.name %></a> | 
<a href="<%=Url.BlogUrl(blog) %>">固定链接</a> | 
<a href="<%=Url.BlogUrl(blog) %>#comm_top">评论: <%=blog.commentnum %></a> | 
<a href="<%=Url.Action("track", new { id = blog.id.ToString() }) %>" target="_blank">引用: <%=blog.tracknum %></a> | 
查看次数: <%=blog.hits %>
<%
    if (authority.Edit)
    {
        Response.Write(string.Format("|<a href=\"{0}\" title=\"编辑该日志\" accesskey=\"E\"><img src=\"{1}\" alt=\"\" border=\"0\" style=\"margin-bottom:-2px\"/></a>  \r\n", Url.Action("edit", new { id = blog.id.ToString() }), Url.Content("~/" + skinpath + "images/icon_edit.gif")));
    }
    if (authority.Delete)
    {
        Response.Write(string.Format("|<a href=\"{0}\" onclick=\"if (!window.confirm('是否要删除该日志')) return false\" title=\"删除该日志\" accesskey=\"K\"><img src=\"{1}\" alt=\"\" border=\"0\" style=\"margin-bottom:-2px\"/></a>\r\n", Url.Action("delete", new { id = blog.id.ToString() }), Url.Content("~/" + skinpath + "images/icon_del.gif")));
    }
%>
</div>
</div>
</div>
<%} %>
<div class="pageContent">
<div class="page" style="float:right">
<%Html.RenderPartial("page"); %>
</div>
</div>
<div id="mainContent-bottomimg"></div>
</div>
</div>
</div>
</asp:Content>
