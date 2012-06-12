<%@ Page Language="C#" MasterPageFile="~/skins/mono/shared/blog.master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" %>

<asp:Content ID="RegContent" ContentPlaceHolderID="BlogContent" runat="server" EnableViewState="false">

<br/><br/>
   <div style="text-align:center;">
    <div id="MsgContent" style="width:520px">
      <div id="MsgHead">用户注册</div>
      <div id="MsgBody">
	  <table width="100%" cellpadding="0" cellspacing="0">
	  <form name="frm" action="<%=Url.Action("regpost") %>" method="post">
	  <tr><td align="right" width="85"><strong>　用户名:</strong></td><td align="left" style="padding:3px;"><input name="username" type="text" size="18" class="userpass" maxlength="24"/><font color="#FF0000">&nbsp;*</font> 用户名由2到24个字符组成</td></tr>
	  <tr><td align="right" width="85"><strong>　密　码:</strong></td><td align="left" style="padding:3px;"><input name="password" type="password" size="18" class="userpass" maxlength="16"/><font color="#FF0000">&nbsp;*</font> 密码必须是6到16个字符，建议使用英文和符号混合</td></tr>
	  <tr><td align="right" width="85"><strong>密码重复:</strong></td><td align="left" style="padding:3px;"><input name="password2" type="password" size="18" class="userpass" maxlength="16"/><font color="#FF0000">&nbsp;*</font> 必须和上面的密码一样</td></tr>
	  <tr><td align="right" width="85"><strong>个人邮件:</strong></td><td align="left" style="padding:3px;"><input name="mail" type="password" size="18" class="userpass" maxlength="16"/><font color="#FF0000">&nbsp;*</font> 用户邮箱</td></tr>
	  <tr><td align="right" width="85"><strong>　性　别:</strong></td><td align="left" style="padding:3px;"><input name="sex" type="radio" value="0" checked/> 保密 <input name="Gender" type="radio" value="1"/>男 <input name="Gender" type="radio" value="2"/>女</td></tr>
	  <tr><td align="right" width="85"><strong>用户昵称:</strong></td><td align="left" style="padding:3px;"><input name="nockname" type="text" size="18" class="userpass" maxlength="20"/> </td></tr>
	  <tr><td align="right" width="85"><strong>验证码:</strong></td><td align="left" style="padding:3px;"><input name="code" type="text" size="5" class="userpass" maxlength="5"/> <img id="vcodeImg" src="<%=Url.Action("code", "blog") %>" alt="验证码" title="看不清楚?换一张" style="margin-right:17px;cursor:pointer;width:63px;height:18px;margin-bottom:-4px;margin-top:3px;" onclick="this.src=this.src+'?'"/> <font color="#FF0000">&nbsp;*</font> 请输入验证码</td></tr>

          <tr>
            <td colspan="2" align="center" style="padding:3px;">
              <input name="action" type="hidden" value="save"/>
			  <input name="submit2" type="submit" class="userbutton" value="注册新用户"/>
              <input name="button" type="reset" class="userbutton" value="重写"/></td>
          </tr>
		  </form>
	  </table>
		</div>
	  </div>
	</div>
<br/><br/>

</asp:Content>