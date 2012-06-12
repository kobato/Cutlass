<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl, System.Web.Mvc" %>
<%
    string skinpath = ViewData["skinpath"] as string;
    lb_config config = ViewData["config"] as lb_config;
    IList<lb_category> categoryList = ViewData["categories"] as IList<lb_category>;
    IList<lb_category> topCategoryList = categoryList.Where(cate => cate.view == 1 || cate.view == 0).OrderBy(c => c.order).ToList();
%>
<!-- 头部 -->
<div id="header">
<div id="blogname"><%=config.title %>
<div id="Div1"><%=config.intro %></div>
</div>
<div id="menu">
<div id="Left"></div>
<div id="Right"></div>
<ul>
<li class="menuL"></li>
<%
    foreach (lb_category category in topCategoryList)
    {
        if (category.isurl)
        {
            if (System.Text.RegularExpressions.Regex.IsMatch(category.url, "^.*?:\\/\\/"))
            {
                Response.Write(string.Format("<li><a class=\"menuA\" href=\"{0}\" title=\"{1}\">{2}</a></li>\r\n", category.url, category.info, category.name));
            }
            else
            {
                Response.Write(string.Format("<li><a class=\"menuA\" href=\"{0}\" title=\"{1}\">{2}</a></li>\r\n", Url.Content(category.url), category.info, category.name));
            }
        }
        else
        {
            Response.Write(string.Format("<li><a class=\"menuA\" href=\"{0}\" title=\"{1}\">{2}</a></li>\r\n", Url.Action("list", new { controller = "blog", category = category.id, page = "1" }), category.info, category.name));
        }
        Response.Write("<li class=\"menuDiv\"></li>\r\n");
    }
%>
<li class="menuR"></li>
</ul>
</div>
</div>