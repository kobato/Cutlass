<%@ Page Language="C#" MasterPageFile="~/skins/mono/shared/blog.master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" ValidateRequest="false" %>

<asp:Content ID="BlogMessage" ContentPlaceHolderID="BlogContent" runat="server" EnableViewState="false">
<%
    object obj = ViewData.Model;
    if (obj == null)
    {
        throw new ArgumentNullException("ViewData.Model");
    }
    MessageEntity message = obj as MessageEntity;
%>
<br/><br/>
   <div style="text-align:center;">
    <div id="SysMsgContent" style="width:300px">
      <div id="SysMsgHead"><%=message.Title %></div>
      <div id="SysMsgBody">
		 <div class="SysMessageIcon"></div>
        <div class="SysMessageText"><%=message.Content %>
        <br />
        <%if (message.JumpRoute != null)
          { %>
        <a href="<%=Url.RouteUrl(message.JumpRoute) %>" title="返回"><%=message.JumpUrl%></a>
        <%}
          else
          { %>
        <%=message.JumpUrl%>
        <%} %>
		</div>
	  </div>
	</div>
	</div>
<br/><br/>
</asp:Content>