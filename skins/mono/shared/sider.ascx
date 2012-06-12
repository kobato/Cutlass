<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl, System.Web.Mvc" %>
<%
    //获取side部分数据
    string skinpath = ViewData["skinpath"] as string;
    lb_state state = ViewData["state"] as lb_state;
    lb_config config = ViewData["config"] as lb_config;
    IList<lb_blog> sideBlogs = ViewData["sideblogs"] as IList<lb_blog>;
    lb_user loginUser = ViewData["loginuser"] as lb_user;
    Authority authority = ViewData["authority"] as Authority;
    IList<lb_comment> sideComments = ViewData["sidecomments"] as IList<lb_comment>;
    IList<lb_archive> sideArchive = ViewData["sidearchive"] as IList<lb_archive>;
    IList<lb_friendlink> links = ViewData["friendlinks"] as IList<lb_friendlink>;
    IList<lb_category> categoryList = ViewData["categories"] as IList<lb_category>;
    IList<lb_category> sideCategoryList = categoryList.Where(cate => cate.view == 2 || cate.view == 0).OrderBy(c => c.order).ToList();
%>
<div id="sidebar">
<div id="sidebar-topimg"><!--工具条顶部图象--></div>

<div id="Side_Article" class="sidepanel">
<h4>Recent Article</h4>
<div class="panelcontent">
<ul>
<%
    foreach (lb_blog sideblog in sideBlogs)
    {
        Response.Write(string.Format("<li><a href=\"{0}\" title=\"{1} 于 {2} 发表该日志:{3}\">{4}</a></li>\r\n", Url.Action("view", new { id = sideblog.id.ToString() }), sideblog.postuser, sideblog.posttime.ToString("yyyy-MM-dd HH:mm:ss"), sideblog.title, sideblog.title));
    }		    
%>
</ul>
</div>
<div class="panelfoot"></div>
</div>

<div id="Side_Category" class="sidepanel">
<h4>Category</h4>
<div class="panelcontent">
<ul>
<%	    
    foreach (lb_category category in sideCategoryList)
    {
        if (category.isurl)
        {
            if (category.id == 1)
            {
                Response.Write(string.Format("<li><img src=\"{0}\" border=\"0\" style=\"margin:3px 4px -4px 0px;\" alt=\"{1}\"/><a class=\"CategoryA\" href=\"{2}\" title=\"{1}\">{3}</a><a href=\"{4}\" title=\"Rss\" target=\"_blank\"><img src=\"{5}\" border=\"0px\" alt=\"Rss\" /></a></li>\r\n", Url.Content("~/" + skinpath + category.image), category.info, Url.Content(category.url), category.name, Url.Action("rss"), Url.Content("~/" + skinpath + "images/rss.png")));
            }
            else
            {
                Response.Write(string.Format("<li><img src=\"{0}\" border=\"0\" style=\"margin:3px 4px -4px 0px;\" alt=\"{1}\"/><a class=\"CategoryA\" href=\"{2}\" title=\"{1}\">{3}</a></li>\r\n", Url.Content("~/" + skinpath + category.image), category.info, Url.Content(category.url), category.name));
            }
        }
        else
        {
            Response.Write(string.Format("<li><img src=\"{0}\" border=\"0\" style=\"margin:3px 4px -4px 0px;\" alt=\"{1}\"/><a class=\"CategoryA\" href=\"{2}\" title=\"{1}\">{3}[{6}]</a><a href=\"{4}\" title=\"Rss\" target=\"_blank\"><img src=\"{5}\" border=\"0px\" alt=\"Rss\" /></a></li>\r\n", Url.Content("~/" + skinpath + category.image), category.info, Url.Action("list", new { category = category.id.ToString(), page = "1" }), category.name, Url.Action("rss", new { category = category.id.ToString() }), Url.Content("~/" + skinpath + "images/rss.png"), category.num));
        }
    }		    
%>
</ul>
</div>
<div class="panelfoot"></div>
</div>
        
<div id="Side_Calendar" class="sidepanel">
<dl>
<dt><h4>Calendar</h4></dt>
<dd>
<%Html.RenderPartial("calendar"); %>
</dd>
</dl>
<div class="panelfoot"></div>
</div>

<div id="Side_UserPanel" class="sidepanel">
<dl>
<dt><h4>User Panel</h4></dt>
<%if (loginUser.id < 0)
  { 
%>
<dd><a href="<%=Url.RouteUrl( new { controller="user", action="login" } ) %>" class="sideA" accesskey="L">登录</a></dd>
<dd><a href="<%=Url.RouteUrl( new { controller="user", action="reg" } ) %>" class="sideA" accesskey="U">用户注册</a></dd>
<%}
  else
  { 
%>
<dd><strong><%=loginUser.name%></strong>，欢迎你!</dd>
<dd>你的权限: <strong><%=loginUser.usertype.name%></strong> </dd>
<dd>&nbsp;</dd>
<%
    if (authority.AdminLink)
    {
        Response.Write(string.Format("<dd><a href=\"{0}\" title=\"系统管理\">系统管理</a></dd>\r\n", Url.RouteUrl(new { controller = "admin", action = "login" })));
    }
    if (authority.Post)
    {
        Response.Write(string.Format("<dd><a href=\"{0}\" title=\"发表新日志\">发表新日志</a></dd>\r\n", Url.RouteUrl(new { controller = "blog", action = "write" })));
        Response.Write(string.Format("<dd><a href=\"{0}\" title=\"管理草稿箱\">管理草稿箱</a></dd>\r\n", Url.RouteUrl(new { controller = "blog", action = "draft" })));
    }
%>
<dd><a href="<%=Url.RouteUrl( new { controller="user", action="edit" } ) %>" title="修改个人资料">修改个人资料</a></dd>
<dd><a href="<%=Url.RouteUrl( new { controller="user", action="logout" } ) %>" title="退出系统">退出系统</a></dd>
<%
  }
%>
</dl>
<div class="panelfoot"></div>
</div>

<div id="Side_Statistics" class="sidepanel">
<dl>
<dt><h4>Statistics</h4></dt>
<dd>日志: <a href="<%=Url.RouteUrl( new { controller="blog", action="index" } ) %>" title="查看日志"><%=state.blognum %> 篇</a></dd>
<dd>评论: <a href="<%=Url.RouteUrl( new { controller="blog", action="comment" } ) %>" title="查看所有评论"><%=state.commentnum %> 个</a></dd>
<dd>引用: <%=state.tracknum %> 个</dd>
<dd>会员: <%=state.usernum %> 人</dd>
<dd>访问: <%=state.hits %> 次</dd>
<dd>在线: <%=ViewData["online"] %> 人</dd>
<dd>站长: <%=config.master %></dd>
<dd>建站时间: <%=config.buildtime.ToString("yyyy-MM-dd") %></dd>
</dl>
<div class="panelfoot"></div>
</div>

<div id="Side_Comments" class="sidepanel">
<h4>Recent Comments</h4>
<div class="panelcontent">
<ul>
<%
    foreach (lb_comment comment in sideComments)
    {
        Response.Write(string.Format("<li><a href=\"{0}#comm_top\" title=\"{1} 于 {2} 发布评论: {3}\">{3}</a></li>\r\n", Url.Action("view", new { id = comment.blogid, page = "1" }), Html.Encode(comment.user), comment.posttime, Html.Encode(comment.content.RemoveHtml())));
    }
%>
</ul>
</div>
<div class="panelfoot"></div>
</div>

<div id="Side_Archive" class="sidepanel">
<h4>Archive</h4>
<div class="panelcontent">
<ul>
<%
    foreach (lb_archive archive in sideArchive)
    {
        Response.Write(string.Format("<li><a href=\"{0}\" title=\"查看{1}年{2}月日志存档\">{1}年{2}月[{3}]</a></li>\r\n", Url.Action("archive", new { year = archive.year.ToString(), month = archive.month.ToString(), page = "1" }), archive.year, archive.month, archive.num));
    }
%>
</ul>
</div>
<div class="panelfoot"></div>
</div>

<div id="Side_Search" class="sidepanel">
<dl>
<dt><h4>Search</h4></dt>
<dd>
<script type="text/javascript">
//<!--
function StartSearch(){
    var titleSearchUrl="<%=Url.Action("jump", new { controller = "blog" } ) %>" + "?actionName=search&q=";
    var tagSearchUrl="<%=Url.Action("jump", new { controller = "blog" } ) %>" + "?actionName=tag&q=";
    var searchType=document.getElementById("searchType");
    var searchString=document.getElementById("searchString");
    if(searchType.value=="title"){
        titleSearchUrl+=escape(searchString.value);
        window.location=titleSearchUrl;
    }else if(searchType.value=="tags"){
        tagSearchUrl+=escape(searchString.value);
        window.location=tagSearchUrl;
    }else{
        return;
    }
}
//-->
</script>
关键字 <input class="searchString" name="searchString" id="searchString" />
<div style="OVERFLOW: hidden; HEIGHT: 3px">&nbsp;</div>
类　型 <select name="searchType" id="searchType">
<option value="title" selected="selected">日志标题</option>
<option value="tags">Tags</option>
</select> <input class="userbutton" type="submit" onclick="StartSearch();" value="查 找"/>

</dd>
</dl>
<div class="panelfoot"></div>
</div>

<div id="Side_Link" class="sidepanel">
<dl>
<dt><h4>Links</h4></dt>
<%
    foreach (lb_friendlink link in links)
    {
        if (link.isimg)
        {
            Response.Write(string.Format("<dd><a href=\"{0}\" title=\"{1}\" target=\"_blank\"><img src=\"{2}\" alt=\"\" border=\"0px\" /></a></dd>\r\n", link.url, link.intro, link.image));
        }
        else
        {
            Response.Write(string.Format("<dd><a href=\"{0}\" title=\"{1}\" target=\"_blank\">{2}</a></dd>\r\n", link.url, link.intro, link.name));
        }
    }
%>
<dd><div align="right"><a href="<%=Url.Action("link") %>">更多链接… </a></div></dd>
</dl>
<div class="panelfoot"></div>
</div>

<div id="Side_Support" class="sidepanel">
<dl>
<dt><h4>Support</h4></dt>
<dd>
<div style="PADDING-RIGHT: 4px; PADDING-LEFT: 4px; PADDING-BOTTOM: 4px; PADDING-TOP: 4px; TEXT-ALIGN: left">
<a href="http://validator.w3.org/check/referer" target="_blank">
<img alt="XHTML 1.0 Transitional" src="<%=Url.Content("~/" + skinpath + "images/xhtml.png") %>" border="0" />
</a> 
<a href="http://jigsaw.w3.org/css-validator/validator-uri.html" target="_blank">
<img alt="Css Validator" src="<%=Url.Content("~/" + skinpath + "images/css.png") %>" border="0" />
</a> 
<a href="<%=Url.Action("rss") %>" target="_blank">
<img alt="RSS 2.0" src="<%=Url.Content("~/" + skinpath + "images/rss2.png" )%>" border="0" />
</a> 
<a href="<%=Url.Action("atom") %>" target="_blank">
<img alt="Atom 1.0" src="<%=Url.Content("~/" + skinpath + "images/atom.png" )%>" border="0" />
</a> 
<a href="http://www.mozilla.org/products/firefox/" target="_blank">
<img alt="Get firefox" src="<%=Url.Content("~/" + skinpath + "images/firefox.gif" )%>" border="0" />
</a> 
<a href="http://www.creativecommons.cn/licenses/by-nc-sa/1.0/" target="_blank">
<img alt="Creative Commons" src="<%=Url.Content("~/" + skinpath + "images/cc.png" )%>" border="0" />
</a>
</div>
</dd>
</dl>
<div class="panelfoot"></div>
</div>

<div id="sidebar-bottomimg"></div>

</div>
