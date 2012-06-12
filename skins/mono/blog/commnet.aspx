<%@ Page Language="C#" MasterPageFile="~/skins/mono/shared/blog.master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" %>

<asp:Content ID="commentSider" ContentPlaceHolderID="BlogSider" runat="server">
<%Html.RenderPartial("sider"); %>
</asp:Content>

<asp:Content ID="CommentListContent" ContentPlaceHolderID="BlogContent" runat="server" EnableViewState="false">

<%
    string skinpath = ViewData["skinpath"] as string;
    IList<lb_comment> commentList = ViewData.Model as IList<lb_comment>;
    Authority authority = ViewData["authority"] as Authority;
    lb_user user = ViewData["loginuser"] as lb_user;
    if (skinpath == null)
    {
        throw new ArgumentNullException("ViewData[\"skinpath\"]");
    }
    if (commentList == null)
    {
        throw new ArgumentNullException("ViewData.Model");
    }
    if (authority == null)
    {
        throw new ArgumentNullException("ViewData[\"authority\"]");
    }
    if (user == null)
    {
        throw new ArgumentNullException("ViewData[\"loginuser\"]");
    }
%>

<div id="body_container">
<div id="mainContent">

<div id="tagview" class="content-width">

<!-- 评论部分开始 -->
<div class="pageContent">
<div class="page" style="float:right;">
<%Html.RenderPartial("page"); %>
</div>
</div>

<%foreach(lb_comment comment in commentList){ %>
<div class="comment">
<div class="commenttop">
<img border="0" src="<%=Url.Content("~/" + skinpath + "images/icon_quote.gif") %>" alt="" style="margin:0px 4px -3px 0px"/>
<a href="<%=Url.Action("view", "user", new { name = comment.user } ) %>"><strong><%=comment.user%></strong></a> 
<span class="commentinfo">[<%=comment.posttime.ToString("yyyy-MM-dd HH:mm:ss")%>
<%if (authority.Super) Response.Write(string.Format(" | {0}", comment.ip)); %>
<%if (authority.ManageComment) Response.Write(string.Format(" |  <a href=\"{0}\" onclick=\"if (!window.confirm('是否删除该评论?')) {{return false;}}\"><img src=\"{1}\" alt=\"删除该评论\" border=\"0\"/></a>", Url.Action("commentdelete", new { id = comment.id.ToString() }), Url.Content("~/" + skinpath + "images/del1.gif"))); %>]</span>
<span style="margin:0px 0px 0px 8px;">
<a href="<%=Url.Action("view", new { id = comment.blogid } ) %>#comm_top" title="查看对应Blog">查看Blog</a>
</span>
</div>
<div class="commentcontent" id="commcontent_<%=comment.id %>">
<%=comment.content %>
</div>
</div>
<%} %>

<div class="pageContent">
<div class="page" style="float:right;">
<%Html.RenderPartial("page"); %>
</div>
</div>
<!-- 评论部分结束 -->

</div>
</div>
</div>

</asp:Content>
