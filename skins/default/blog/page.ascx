<%@ Control Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewUserControl, System.Web.Mvc" %>

<%
    int currentPage = 1;
    ValueProviderResult pageResult;
    if (ViewContext.Controller.ValueProvider.TryGetValue("page", out pageResult)) {
        if (!Int32.TryParse(pageResult.AttemptedValue, out currentPage)) {
            currentPage = 1;
        }
    }
    string url;
    ValueProviderResult urlResult;
    if (ViewContext.Controller.ValueProvider.TryGetValue("url", out urlResult)) {
        url = urlResult.AttemptedValue;
    } else {
        url = String.Empty;
    }
    int? recordCount = ViewData["recordcount"] as int?;
    int? pageSize = ViewData["pagesize"] as int?;
    int splitSize = 8;
    string extend = LevenBlog.Core.Configuretion.Route.RouteCollectionExtensions.GetExtendName(RouteTable.Routes);
    if (!recordCount.HasValue)
    {
        throw new ArgumentNullException("ViewData[\"recordcount\"]");
    }
    if (!pageSize.HasValue)
    {
        throw new ArgumentNullException("ViewData[\"pagesize\"]");
    }
    StringBuilder sb = new StringBuilder();
    int pagecount = recordCount.Value % pageSize.Value == 0 ? recordCount.Value / pageSize.Value : recordCount.Value / pageSize.Value + 1;
    if (currentPage < 1)
        currentPage = 1;
    if (currentPage > pagecount)
        currentPage = pagecount;
    int startpage = currentPage % splitSize == 0 ? currentPage - (currentPage - 1) % splitSize : currentPage - (currentPage % splitSize) + 1;
    int endpage = startpage + splitSize - 1;
    if (endpage > pagecount)
        endpage = pagecount;
    ViewContext.RouteData.Values.Remove("page");
    string baseUrl = Url.Action("jump");
    string actionName = Convert.ToString(ViewContext.RouteData.Values["action"]);
    baseUrl += "?actionName=" + actionName;
    string category = Convert.ToString(ViewContext.RouteData.Values["category"]);
    int categoryid = 0;
    if (Int32.TryParse(category, out categoryid)) {
        baseUrl += "&category=" + categoryid;
    }
    if (!String.IsNullOrEmpty(url)) {
        baseUrl += "&url=" + Url.Encode(url);
    }
    string idString = Convert.ToString(ViewContext.RouteData.Values["id"]);
    int idInt = 0;
    if (Int32.TryParse(idString, out idInt)) {
        baseUrl += "&id=" + idInt;
    }
    string q = Convert.ToString(ViewContext.RouteData.Values["q"]);
    if (!String.IsNullOrEmpty(q)) {
        baseUrl += "&q=" + q;
    }
    baseUrl += "&page=";
    sb.AppendLine("<div class=\"lpage_main\">");
    sb.AppendLine("<script type=\"text/javascript\">");
    sb.AppendLine("//<!--");
    sb.AppendLine("function lpage_change(){");
    sb.AppendLine("var lpage_input=document.getElementById(\"lpage_inputbox\");");
    sb.AppendFormat("var url=\"{0}\";\r\n", baseUrl);
    sb.AppendFormat("url=url + lpage_input.value;\r\n");
    sb.AppendLine("window.location=url;");
    sb.AppendLine("}");
    sb.AppendLine("//-->");
    sb.AppendLine("</script>");
    sb.AppendLine("<div class=\"lpage_list\">");
    sb.AppendLine("<ul>");
    if (currentPage != 1)
    {
        ViewContext.RouteData.Values["page"] = 1;
        sb.AppendFormat("<li><a href=\"{0}\"><img src=\"{1}\" alt=\"首页\" /></a></li>\r\n", Url.RouteUrl(ViewContext.RouteData.Values), Url.Content("~/" + ViewData["skinpath"] + "images/page/first.gif"));
    }
    if (currentPage > splitSize)
    {
        ViewContext.RouteData.Values["page"] = currentPage - splitSize;
        sb.AppendFormat("<li><a href=\"{0}\"><img src=\"{1}\" alt=\"前{2}页\" /></a></li>\r\n", Url.RouteUrl(ViewContext.RouteData.Values), Url.Content("~/" + ViewData["skinpath"] + "images/page/previous.gif"), splitSize);
    }
    for (int page = startpage; page <= endpage; page++)
    {
        if (page == currentPage)
            sb.AppendFormat("<li id=\"lpage_list_checked\"><a>{0}</a></li>\r\n", page);
        else
        {
            ViewContext.RouteData.Values["page"] = page;
            sb.AppendFormat("<li><a href=\"{0}\" title=\"第{1}页\">{1}</a></li>\r\n", Url.RouteUrl(ViewContext.RouteData.Values), page);
        }
    }
    if (endpage < pagecount)
    {
        ViewContext.RouteData.Values["page"] = currentPage + splitSize;
        sb.AppendFormat("<li><a href=\"{0}\"><img src=\"{1}\" alt=\"后{2}页\" /></a></li>\r\n", Url.RouteUrl(ViewContext.RouteData.Values), Url.Content("~/" + ViewData["skinpath"] + "images/page/next.gif"), splitSize);
    }
    if (currentPage != pagecount)
    {
        ViewContext.RouteData.Values["page"] = pagecount;
        sb.AppendFormat("<li><a href=\"{0}\"><img src=\"{1}\" alt=\"末页\" /></a></li>\r\n", Url.RouteUrl(ViewContext.RouteData.Values), Url.Content("~/" + ViewData["skinpath"] + "images/page/last.gif"));
    }
    sb.AppendLine("</ul>");
    sb.AppendFormat("<div class=\"lpage_input\"><input type=\"text\" id=\"lpage_inputbox\" name=\"lpage_inputbox\" maxlength=\"6\" value=\"{0}\" /></div>\r\n", currentPage);
    sb.AppendLine("<div class=\"lpage_submit\"><input type=\"button\" name=\"lpage_submit\" value=\"GO\" onclick=\"lpage_change();\" /></div>");
    sb.AppendFormat("<div class=\"lpage_info\">{0} {1}/{2} 页</div>\r\n", recordCount, currentPage, pagecount);
    sb.AppendLine("</div>");
    sb.AppendLine("</div>");
    ViewContext.RouteData.Values["page"] = currentPage.ToString();
    Writer.WriteLine(sb.ToString());
%>
