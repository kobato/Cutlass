<%@ Control Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewUserControl, System.Web.Mvc" %>
<% 
    DateTime? selectDate = ViewData["selectdate"] as DateTime?;
    IList<int> calendardata = ViewData["calendardata"] as IList<int>;
    if (!selectDate.HasValue )
    {
        throw new ArgumentNullException("ViewData[\"selectdate\"]");
    }
    if (calendardata == null)
    {
        throw new ArgumentNullException("ViewData[\"calendardata\"]");
    }
    DateTime lastLink = selectDate.Value.AddMonths(-1);
    DateTime preLink = selectDate.Value.AddMonths(1);
%>
<div id="Calendar_Body">
<div id="Calendar_Top">
<div id="LeftB" onclick="location.href='<%=Url.Action("archive", new { year = lastLink.Year.ToString(), month = lastLink.Month.ToString() } ) %>'">
</div>
<div id="RightB" onclick="location.href='<%=Url.Action("archive", new { year = preLink.Year.ToString(), month = preLink.Month.ToString() } ) %>'">
</div>
<%=selectDate.Value.ToString("yyyy年MM月") %></div>
<div id="Calendar_week">
<ul class="Week_UL">
<li><font color="#FF0000">日</font></li>
<li>一</li>
<li>二</li>
<li>三</li>
<li>四</li>
<li>五</li>
<li>六</li>
</ul>
</div>
<%
    DateTime startDate = selectDate.Value.AddDays(1 - selectDate.Value.Day);
    startDate = startDate.AddDays(0 - (int)startDate.DayOfWeek);
    DateTime firstDate = selectDate.Value.AddDays(1 - selectDate.Value.Day);
    double outDays = 0;
    DateTime thisDate = startDate.AddDays(outDays).Date;
    DateTime lastDate = firstDate.AddMonths(1).AddDays(-1);
    while (thisDate <= lastDate.Date)
    {
        Response.Write("<div class=\"Calendar_Day\">\r\n");
        Response.Write("<ul class=\"Day_UL\">\r\n");
        for (int i = 0; i < 7; i++)
        {
            if (thisDate.Month != firstDate.Month)
                Response.Write(string.Format("<li class=\"DayA\"><a class=\"otherday\">{0}</a></li>\r\n", thisDate.Day));
            else if (thisDate.Date == DateTime.Now.Date)
                if (calendardata.Where(d => d == thisDate.Day).Count() > 0)
                    Response.Write(string.Format("<li class=\"DayA\"><a class=\"today\" href=\"{0}\" title=\"当日有{2}篇日志\">{1}</a></li>\r\n", Url.Action("archive", new { year = thisDate.Year.ToString(), month = thisDate.Month.ToString(), day = thisDate.Day.ToString(), page="1" }), thisDate.Day, calendardata.Where(d => d == thisDate.Day).Count()));
                else
                    Response.Write(string.Format("<li class=\"DayA\"><a class=\"today\">{0}</a></li>\r\n", thisDate.Day));
            else if (thisDate.Date == selectDate.Value.Date)
            {
                if (calendardata.Where(d => d == thisDate.Day).Count() > 0)
                    Response.Write(string.Format("<li class=\"DayA\"><a class=\"click\" href=\"{0}\" title=\"当日有{2}篇日志\">{1}</a></li>\r\n", Url.Action("archive", new { year = thisDate.Year.ToString(), month = thisDate.Month.ToString(), day = thisDate.Day.ToString(), page="1" }), thisDate.Day, calendardata.Where(d => d == thisDate.Day).Count()));
                else
                    Response.Write(string.Format("<li class=\"DayA\"><a class=\"click\">{0}</a></li>\r\n", thisDate.Day));
            }
            else if (calendardata.Where(d => d == thisDate.Day).Count() > 0)
                Response.Write(string.Format("<li class=\"DayA\"><a class=\"DayD\" href=\"{0}\" title=\"当日有{2}篇日志\">{1}</a></li>\r\n", Url.Action("archive", new { year = thisDate.Year.ToString(), month = thisDate.Month.ToString(), day = thisDate.Day.ToString(), page="1" }), thisDate.Day, calendardata.Where(d => d == thisDate.Day).Count()));
            else
                Response.Write(string.Format("<li class=\"DayA\"><a>{0}</a></li>\r\n", thisDate.Day));
            outDays++;
            thisDate = startDate.AddDays(outDays).Date;
        }
        Response.Write("</ul>\r\n");
        Response.Write("</div>\r\n");
    }
%>
</div>
