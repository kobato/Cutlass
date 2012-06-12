<%@ Page Language="C#" MasterPageFile="~/skins/mono/shared/blog.master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" %>

<asp:Content ID="UserViewContent" ContentPlaceHolderID="BlogContent" runat="server" EnableViewState="false">

<%
    lb_user user = ViewData.Model as lb_user;
    string skinpath = ViewData["skinpath"] as string;
    if (user == null)
    {
        throw new ArgumentNullException("ViewData.Model");
    }
    if (skinpath == null)
    {
        throw new ArgumentNullException("ViewData[\"skinpath\"]");
    }
%>

<br/><br/>
   <div style="text-align:center;">
    <div id="MsgContent" style="width:420px">
      <div id="MsgHead">用户信息</div>
      <div id="MsgBody">
	  <table width="100%" cellpadding="0" cellspacing="0">
	  <tr><td align="right" width="85"><strong>　用户名:</strong></td><td align="left" style="padding:3px;"><%=user.name %></td></tr>
	  <tr><td align="right" width="85"><strong>　昵　称:</strong></td><td align="left" style="padding:3px;"><%=user.userinfo.nickname %></td></tr>
	  <tr><td align="right" width="85"><strong>　性　别:</strong></td><td align="left" style="padding:3px;">
	  <%
          if (user.userinfo.sex == 0)
              Response.Write("保密");
          else if (user.userinfo.sex == 1)
              Response.Write("男");
          else if (user.userinfo.sex == 2)
              Response.Write("女");
          else
              Response.Write("未知");            
	  %>
	  </td></tr>
	  <tr><td align="right" width="85"><strong>电子邮件:</strong></td><td align="left" style="padding:3px;"><%=user.userinfo.mail %></td></tr>
	  <tr><td align="right" width="85"><strong>用户头像:</strong></td><td align="left" style="padding:3px;">
	  <img src="
	  <%
	      if(!string.IsNullOrEmpty(user.userinfo.face))
	      {
              if (user.userinfo.face.StartsWith("http") && user.userinfo.face.StartsWith("https") && user.userinfo.face.StartsWith("ftp"))
                  Response.Write(user.userinfo.face);
              else
                  Response.Write(Url.Content(user.userinfo.face)); 
          }
          else
          {
               Response.Write(Url.Content("~/" + skinpath + "images/face/default.jpg"));
          }
	  %>" alt="" width="80px" height="80px" />
	  </td></tr>
	  <tr><td align="right" width="85"><strong>　用户签名:</strong></td><td align="left" style="padding:3px;"><%=user.userinfo.signature %></td></tr>
	  <tr><td align="right" width="85"><strong>统计:</strong></td><td align="left" style="padding:3px;">共发布Blog<%=user.postnum %>篇</td></tr>
          <tr>
            <td colspan="2" align="center" style="padding:3px;">
			  <input type="button" class="userbutton" value="返回" onclick="history.go(-1)"/>
          </tr>
        
	  </table>
		</div>
	  </div>
	</div>
<br/><br/>

</asp:Content>