<%@ Page Language="C#" MasterPageFile="../shared/blog.master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" %>

<asp:Content ID="UserEditContent" ContentPlaceHolderID="BlogContent" runat="server" EnableViewState="false">
<%
    lb_user user = ViewData.Model as lb_user;
    if (user == null)
    {
        throw new ArgumentNullException("ViewData.Model");
    }
%>

<br/><br/>
   <div style="text-align:center;">
    <div id="MsgContent" style="width:520px">
      <div id="MsgHead">修改用户信息</div>
      <div id="MsgBody">
       
	  <table width="100%" cellpadding="0" cellspacing="0">
	  <form name="frm" action="<%=Url.Action("editpost") %>" method="post" onsubmit="if (this.Oldpassword.value.length<1){alert('请输入你的登录密码!');this.Oldpassword.focus();return false}">
	  <tr><td align="right" width="85"><strong>　用户名:</strong></td><td align="left" style="padding:3px;"><%=user.name %></td></tr>
	  <tr><td align="right" width="85"><strong>　旧密码:</strong></td><td align="left" style="padding:3px;"><input name="oldpassword" type="password" size="18" class="userpass" maxlength="16"/><font color="#FF0000">&nbsp;*</font> 输入你的旧密码.下面的密码输入框为空则不修改密码</td></tr>
	  <tr><td align="right" width="85"><strong>　密　码:</strong></td><td align="left" style="padding:3px;"><input name="password" type="password" size="18" class="userpass" maxlength="16"/> 密码必须是6到16个字符，建议使用英文和符号混合</td></tr>
	  <tr><td align="right" width="85"><strong>密码重复:</strong></td><td align="left" style="padding:3px;"><input name="confirmpassword" type="password" size="18" class="userpass" maxlength="16"/> 必须和上面的密码一样</td></tr>
	  <tr><td align="right" width="85"><strong>用户昵称:</strong></td><td align="left" style="padding:3px;"><input name="nickname" type="text" size="12" class="userpass" maxlength="50" value="<%=user.userinfo.nickname %>"/></td></tr>
	  <tr><td align="right" width="85"><strong>　性　别:</strong></td><td align="left" style="padding:3px;">
	  <input id="sex_0" name="sex" type="radio" value="0" /> 保密 
	  <input id="sex_1" name="sex" type="radio" value="1" />男 
	  <input id="sex_2" name="sex" type="radio" value="2" />女
	  
	  <script type="text/javascript">
	    var sexRadio=document.getElementById("sex_<%=user.userinfo.sex %>");
	    sexRadio.checked="checked";
	  </script>
	  </td></tr>
	  <tr><td align="right" width="85"><strong>电子邮件:</strong></td><td align="left" style="padding:3px;"><input name="email" type="text" size="38" class="userpass" maxlength="255" value="<%=user.userinfo.mail %>" /> </td></tr>
	  <tr><td align="right" width="85"><strong>用户头像:</strong></td><td align="left" style="padding:3px;"><input name="face" type="text" size="38" maxlength="255" class="userpass" value="<%=user.userinfo.face %>"/></td></tr>
	  <tr><td align="right" width="85" valign="top"><strong>用户签名:</strong></td><td align="left" style="padding:3px;"><textarea id="signature" name="signature" rows="5" cols="50"><%=user.userinfo.signature %></textarea></td></tr>

          <tr>
            <td colspan="2" align="center" style="padding:3px;">
              <input name="action" type="hidden" value="save"/>
			  <input name="submit2" type="submit" class="userbutton" value="修改资料"/>
              <input name="button" type="reset" class="userbutton" value="重写"/></td>
          </tr>
		  </form>
	
	  </table>
		</div>
	  </div>
	</div>
<br/><br/>

</asp:Content>
