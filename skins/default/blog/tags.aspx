<%@ Page Language="C#" MasterPageFile="../shared/blog.master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" %>

<asp:Content ID="tagsSider" ContentPlaceHolderID="BlogSider" runat="server">
<%Html.RenderPartial("sider"); %>
</asp:Content>

<asp:Content ID="TagsContent" ContentPlaceHolderID="BlogContent" runat="server" EnableViewState="false">
<%
    IList<lb_tag> tags = ViewData.Model as IList<lb_tag>;
    if (tags == null)
    {
        throw new ArgumentNullException("ViewData.Model");
    }
%>
<div id="body_container">
<div id="mainContent">
<div id="mainContent-topimg"></div>
<div id="tagview" class="content-width">

<div class="tagpanel">
<h4>按Tag浏览</h4>
<div class="panelcontent">
<ul>
<%
    foreach (lb_tag tag in tags)
    {
        Response.Write(string.Format("<li><a href=\"{0}\" title=\"浏览Tag:{1}\">{2}[{3}]</a></li>\r\n", Url.Action("tag", new { q = Html.Encode(tag.name), page = "1" }), tag.name, tag.name, tag.num));
    }
%>
</ul>
</div>
<div class="panelfoot"></div>
</div>

</div>

<div class="pageContent">
<div class="page" style="float:right">
<%Html.RenderPartial("page"); %>
</div>
</div>

<div id="mainContent-bottomimg"></div>
</div>
</div>
</asp:Content>