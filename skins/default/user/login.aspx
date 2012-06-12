<%@ Page Language="C#" MasterPageFile="../shared/blog.master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" %>

<asp:Content ID="UserLogin" ContentPlaceHolderID="BlogContent" runat="server" EnableViewState="false">

<br/><br/>
   <div style="text-align:center;">
  <form name="checkUser" action="<%=Url.Action("checklogin") %>" method="post">
    <div id="MsgContent">
      <div id="MsgHead">用户登录</div>
      <div id="MsgBody">
	   <label>用户名：<input name="username" type="text" size="18" class="userpass" maxlength="24"/></label><br/>
	   <label>密　码：<input name="password" type="password" size="18" class="userpass"/></label><br/>
	   <label>验证码：<input name="code" type="text" size="4" class="userpass" maxlength="5"/> <img id="vcodeImg" src="<%=Url.Action("code", "blog") %>" alt="验证码" title="看不清楚?换一张" style="margin-right:17px;cursor:pointer;width:63px;height:22px;margin-bottom:-6px;margin-top:3px;" onclick="this.src=this.src+'?s='+Math.random()"/></label><br/>
	   <label>cookie：<select class="userpass" id="savetime" name="savetime" style="margin:2px 53px 0px 0px;">
				<option value="0" selected="selected">不保存</option>
				<option value="1">保存一天</option>
				<option value="2">保存一月</option>
				<option value="3">保存一年</option>
			</select></label><br />
	   <input type="submit" value="登　陆" class="userbutton"/>　<input type="button" value="用户注册" class="userbutton" onclick="location='<%=Url.Action("reg") %>'"/>
	   </div>
	</div>
  </form>
  </div><br/><br/>

</asp:Content>