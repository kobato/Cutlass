<%@ Page Language="C#" MasterPageFile="../shared/blog.master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" ValidateRequest="false" %>

<asp:Content ID="BlogViewHead" ContentPlaceHolderID="BlogHead" runat="server" EnableViewState="false">
<%
    string skinpath=ViewData["skinpath"] as string;
    if (skinpath == null)
    {
        throw new ArgumentNullException("ViewData[\"skinpath\"]");
    }
%>
<script type="text/javascript" src="<%=Url.Content("~/" + skinpath + "js/common.js") %>"></script>
</asp:Content>

<asp:Content ID="BlogViewMetaHead" ContentPlaceHolderID="BlogMetaHead" runat="server" EnableViewState="false">
<%lb_blog blog = ViewData.Model as lb_blog; %>
<meta name="keywords" content="<%=blog.keywords %>" />
<meta name="description" content="<%=blog.description %>" />
</asp:Content>

<asp:Content ID="blogViewSider" ContentPlaceHolderID="BlogSider" runat="server">
<%Html.RenderPartial("sider"); %>
</asp:Content>

<asp:Content ID="BlogView" ContentPlaceHolderID="BlogContent" runat="server" EnableViewState="false">
<%
    lb_blog blog = ViewData.Model as lb_blog;
    IList<lb_comment> commentList = ViewData["blogcomments"] as IList<lb_comment>;
    Pair<lb_blog, lb_blog> abouts = ViewData["aboutblogs"] as Pair<lb_blog, lb_blog>;
    Authority authority = ViewData["authority"] as Authority;
    lb_user user = ViewData["loginuser"] as lb_user;
    string skinpath = ViewData["skinpath"] as string;
    int? recordcount = ViewData["recordcount"] as int?;
    lb_config config = ViewData["config"] as lb_config;
    if (skinpath == null)
    {
        throw new ArgumentNullException("ViewData[\"skinpath\"]");
    }
    if (blog == null)
    {
        throw new ArgumentNullException("ViewData.Model");
    }
    if (commentList == null)
    {
        throw new ArgumentNullException("ViewData[\"blogcomments\"]");
    }
    if (abouts == null)
    {
        throw new ArgumentNullException("ViewData[\"aboutblogs\"]");
    }
    if (authority == null)
    {
        throw new ArgumentNullException("ViewData[\"authority\"]");
    }
    if (user == null)
    {
        throw new ArgumentNullException("ViewData[\"loginuser\"]");
    }
    if (config == null)
    {
        throw new ArgumentNullException("ViewData[\"config\"]");
    }
    if (!recordcount.HasValue)
    {
        throw new ArgumentNullException("ViewData[\"recordcount\"]");
    }
%>
<div id="body_container">
<div id="mainContent">
<div id="mainContent-topimg"></div>
<div id="Content_ContentList" class="content-width">

<a name="body" accesskey="B" href="#body"></a>
<div class="pageContent">
<div style="float:right;width:180px !important;width:auto">
<%
    if (abouts.First.id < 0)
    {
        Response.Write(string.Format("<img border=\"0\" src=\"{0}\" alt=\"这是第一篇日志\"/>上一篇\r\n", Url.Content("~/" + skinpath + "images/Cprevious1.gif")));
    }
    else
    {
        Response.Write(string.Format("<a href=\"{0}\" title=\"\" accesskey=\",\"><img border=\"0\" src=\"{1}\" alt=\"\"/>上一篇</a>\r\n", Url.Action("view", new { id = abouts.First.id.ToString() }), Url.Content("~/" + skinpath + "images/Cprevious.gif")));
    }
    Response.Write("|\r\n");
    if (abouts.Second.id < 0)
    {
        Response.Write(string.Format("<img border=\"0\" src=\"{0}\" alt=\"这是最后一篇日志\"/>下一篇\r\n", Url.Content("~/" + skinpath + "images/Cnext1.gif")));
    }
    else
    {
        Response.Write(string.Format("<a href=\"{0}\" title=\"\" accesskey=\",\"><img border=\"0\" src=\"{1}\" alt=\"\"/>下一篇</a>\r\n", Url.Action("view", new { id = abouts.Second.id.ToString() }), Url.Content("~/" + skinpath + "images/Cnext.gif")));
    }
    
%>
</div>
<img src="<%=Url.Content("~/" + skinpath + blog.Category.image) %>" style="margin:0px 2px -4px 0px" alt="" /> 
<strong>
<a href="<%=Url.CategoryUrl(blog.Category) %>" title="查看所有<%=blog.Category.name %>的日志"><%=blog.Category.name %></a>
</strong> 
<a href="<%=Url.Action("rss", new { category = blog.categoryid.ToString()}) %>" target="_blank" title="订阅所有<%=blog.Category.name %>的日志" accesskey="O">
<img border="0" src="<%=Url.Content("~/" + skinpath + "images/rss.png") %>" alt="订阅所有<%=blog.Category.name %>的日志" style="margin-bottom:-1px"/>
</a>
</div>
<div class="Content">
	<div class="Content-top">
	    <div class="ContentLeft"></div>
	    <div class="ContentRight"></div>
	    <h1 class="ContentTitle"><strong><%=blog.title %></strong></h1>
	    <h2 class="ContentAuthor">作者:<%=blog.postuser %> 日期:<%=blog.posttime.ToString("yyyy-MM-dd HH:mm:ss") %></h2>
    </div>
    <div class="Content-Info">
	    <div class="InfoOther">字体大小: <a href="javascript:SetFont('12px')" accesskey="1">小</a> <a href="javascript:SetFont('14px')" accesskey="2">中</a> <a href="javascript:SetFont('16px')" accesskey="3">大</a></div>
	    <div class="InfoAuthor">
	    <%if(authority.Edit){ %>
	    <a href="<%=Url.Action("edit", new { id = blog.id.ToString() }) %>" title="编辑该日志" accesskey="E">
	    <img src="<%=Url.Content("~/" + skinpath + "images/icon_edit.gif")%>" alt="" border="0" style="margin-bottom:-2px"/>
	    </a> 
	    <%}
	     if(authority.Delete){    %>
	    <a href="<%=Url.Action("delete", new { id = blog.id.ToString() }) %>" onclick="if (!window.confirm('是否要删除该日志')) return false" title="删除该日志" accesskey="K">
	    <img src="<%=Url.Content("~/" + skinpath + "images/icon_del.gif")%>" alt="" border="0" style="margin-bottom:-2px"/>
	    </a>
	    <%} %>
	    </div>
    </div>
    <div id="logPanel" class="Content-body">
    <%=blog.content %>
    </div>
    <div class="Content-body">
        <img src="<%=Url.Content("~/" + skinpath + "images/From.gif")%>" style="margin:0px 2px -4px 0px" alt=""/><strong>文章来自:</strong> <a href="<%=blog.comeurl %>" target="_blank"><%=blog.come %></a><br/>
	    <img src="<%=Url.Content("~/" + skinpath + "images/icon_trackback.gif")%>" style="margin:4px 2px -4px 0px" alt=""/><strong>引用通告:</strong> <a href="<%=Url.Action("track", new { id = blog.id.ToString() }) %>" target="_blank">查看所有引用</a> | 
	    <a href="<%=Url.Action("trackback",new { id = blog.id.ToString() } ) %>" target="_blank" title="获得引用文章的链接">我要引用此文章</a><br/>
	    <img src="<%=Url.Content("~/" + skinpath + "images/tag.gif")%>" style="margin:4px 2px -4px 0px" alt=""/><strong>Tags:</strong> 
<%
    string[] tagArray = blog.tags.Split(',');
    foreach (string tag in tagArray)
    {
        Response.Write(string.Format("<a href=\"{0}\" title=\"查看Tag{1}\">{1}</a>&nbsp;\r\n", Url.Action("tag", new { q = Html.Encode(tag), page = "1" }), tag));
    }
%>
	    <br/>
    </div>
    <div class="Content-bottom">
        <div class="ContentBLeft"></div>
        <div class="ContentBRight"></div>
        评论: <%=blog.commentnum %> | 
        <a href="<%=Url.Action("track", new { id = blog.id.ToString() }) %>" target="_blank">引用: <%=blog.tracknum %></a> | 
        查看次数: <%=blog.hits %>
    </div>
</div>

<a name="comm_top" href="#comm_top" accesskey="C"></a>

<%if (recordcount > 0)
  { %>

<!-- 评论部分开始 -->
<div class="pageContent">
<div class="page" style="float:right;">
<%Html.RenderPartial("page"); %>
</div>
</div>

<%foreach(lb_comment comment in commentList){ %>
<div class="comment">
<div class="commenttop">
<a name="comm_<%=comment.id %>" href="javascript:addQuote('<%=Html.Encode(comment.user).Replace("'","") %>','commcontent_<%=comment.id %>')">
<img border="0" src="<%=Url.Content("~/" + skinpath + "images/icon_quote.gif") %>" alt="" style="margin:0px 4px -3px 0px"/>
</a>
<a href="<%=Url.Action("view", "user", new { name = comment.user } ) %>"><strong><%=Html.Encode(comment.user)%></strong></a> 
<span class="commentinfo">[<%=comment.posttime.ToString("yyyy-MM-dd HH:mm:ss")%>
<%if (authority.Super) Response.Write(string.Format(" | {0}", comment.ip)); %>
<%if (authority.ManageComment) Response.Write(string.Format(" |  <a href=\"{0}\" onclick=\"if (!window.confirm('是否删除该评论?')) {{return false;}}\"><img src=\"{1}\" alt=\"删除该评论\" border=\"0\"/></a>", Url.Action("commentdelete", new { id = comment.id.ToString() }), Url.Content("~/" + skinpath + "images/del1.gif"))); %>]</span>
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

<%} %>

<%if(!blog.islock && authority.Comment && config.iscomment){ %>
<div id="MsgContent" style="width:94%; margin-top:3px; clear:both;">
<div id="MsgHead">发表评论</div>
<div id="MsgBody">
<form name="frm" action="<%=Url.Action("commentpost", new { id = blog.id.ToString() }) %>" method="post" onsubmit="return checkCommentPost()" style="margin:0px;">	  

<table width="100%" cellpadding="0" cellspacing="0">	  
<tr><td align="right" width="70"><strong>用户名:</strong></td><td align="left" style="padding:3px;"><input name="username" type="text" size="18" class="userpass" maxlength="24"<%if(user.id>0){Response.Write(string.Format(" value=\"{0}\" readonly=\"readonly\"", user.name)) ; }  %> /></td></tr>
<%if(user.id<0){ %>
<tr><td align="right" width="70"><strong>密　码:</strong></td><td align="left" style="padding:3px;"><input name="password" type="password" size="18" class="userpass" maxlength="24"/> 游客发言不需要密码.</td></tr>
<%} %>
<tr><td align="right" width="70"><strong>验证码:</strong></td><td align="left" style="padding:3px;"><input name="code" type="text" size="5" class="userpass" maxlength="5"/> <img id="vcodeImg" src="<%=Url.Action("code", "blog") %>" alt="验证码" title="看不清楚?换一张" style="margin-right:17px;cursor:pointer;width:63px;height:22px;margin-bottom:-5px;margin-top:3px;" onclick="src='<%=Url.Action("code", "blog") %>?s='+Math.random()"/></td></tr>
<tr><td align="right" width="70" valign="top"><strong>内　容:</strong><br/>
</td>
<td style="padding:2px;">
<div class="commentContent">
<textarea id="commenttxt" name="content" class="editTextarea" style="width:99%;" rows="8" cols="70"></textarea>
</div>
</td></tr>
<tr><td align="right" width="70" valign="top"><strong>选　项:</strong></td><td align="left" style="padding:3px;">
     <label for="userinfo"><input name="userinfo" type="checkbox" id="userinfo" value="true"<%if (user.id < 0) { Response.Write(" disabled=\"disabled\""); } %> />评论自带签名</label>
     <label for="html"><input name="html" type="checkbox" id="html" value="true"<%if (!authority.PostHtml) { Response.Write(" disabled=\"disabled\""); } %> />启用HTML提交</label>
     <%    bool added = false;
           if (blog.mails.IndexOf("|" + user.id + "|") > 0 || blog.mails.StartsWith(user.id.ToString() + "|") || blog.mails.EndsWith("|" + user.id) || blog.mails.Trim() == user.id.ToString())
           {
               added = true;
           }
     %>
     <label for="mailnew"><input name="mailnew" type="checkbox" id="mailnew" value="true"<%if (user.id < 0) { Response.Write(" disabled=\"disabled\""); } %> <%if (added) { Response.Write(" checked=\"checked\""); } %> />加入邮件列表</label>
</td></tr>
  <tr>
    <td colspan="2" align="center" style="padding:3px;">
	  <input name="commentpost" type="submit" class="userbutton" value="发表评论" accesskey="S"/>
      <input name="button" type="reset" class="userbutton" value="重写"/></td>
  </tr>
  <tr>
  <td style="heigth:1px;"></td>
    <td colspan="2" align="right">
	 虽然发表评论不用注册，但是为了保护您的发言权，建议您<a href="<%=Url.Action("reg", "user") %>">注册帐号</a>. <br/> 
字数限制 <b><%=authority.CommentLength %> 字</b> | 
HTML代码允许 <b><%if (authority.PostHtml) { Response.Write("开启"); } else { Response.Write("关闭"); } %></b> | 
评论可修改 <b><%if (user.id > 0) { Response.Write("开启"); } else { Response.Write("关闭"); } %></b>
	</td>
  </tr>	  
</table></form>
</div>
</div>
<%} %>

</div>

<div id="mainContent-bottomimg"></div>
</div>
</div>
</asp:Content>