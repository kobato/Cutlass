<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="install.master" CodeBehind="step3.aspx.cs" Inherits="LevenBlog.Web.install.step3" %>

<asp:Content ID="step2Head" ContentPlaceHolderID="installHead" runat="server">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
    var newuser = "";
    var newpassword = "";
    var newmail = "";
    var checkurl = "check/test";
    $(document).ready(function() {
        changerouteextend();
    });
    
    function changeinstallmode() {
        var modeSelecter = $("#<%=setup_mode.UniqueID.Replace("$", "_") %>");
        var setup_new = $("#setup_new");
        var setup_update = $("#setup_update");
        if (modeSelecter.val() == 1) {
            setup_new.css("display", "");
            setup_update.css("display", "none");
            inituserinputs(false);
        } else {
            setup_new.css("display", "none");
            setup_update.css("display", "");
            inituserinputs(true);
        }
    }
    
    function inituserinputs(isupdate){
        var username = $("#<%=setup_new_username.UniqueID.Replace("$", "_") %>");
        var password = $("#<%=setup_new_password.UniqueID.Replace("$", "_") %>");
        var newdbpath = $("#<%=setup_new_datapath.UniqueID.Replace("$", "_") %>");
        var updbpath = $("#<%=setup_update_datapath.UniqueID.Replace("$", "_") %>");
        var mail = $("#<%=setup_new_mail.UniqueID.Replace("$", "_") %>");
        if(isupdate){
            if(newuser.length > 0){
                username.val(newuser);
            }else{
                username.val("admin");
            }
            if(newpassword.length > 0){
                password.val(newpassword);
            }else{
                password.val("admin888");
            }
            if(mail.length > 0){
                mail.val(newmail);
            }else{
                mail.val("admin@leven.com.cn");
            }
            newdbpath.val("~/App_Data/Database.db3");
        }else{
            username.val(newuser);
            password.val(newpassword);
            mail.val(newmail);
            updbpath.val("~/App_Data/Database.db3");
        }
    }
    
    function changerouteextend(){
        var extend = $("#<%=rotute_selectext.UniqueID.Replace("$", "_") %>");
        var next = $("#<%=step3_next.UniqueID.Replace("$", "_") %>");
        var pre = $("#<%=step3_pre.UniqueID.Replace("$", "_") %>")
        var msg = $("#route_select_msg");
        extend.attr("disabled", "disabled");
        next.attr("disabled", "disabled");
        pre.attr("disabled", "disabled");
        msg.html("正在测试,请稍候...");
        $.ajax({
            type: "GET",
            url: checkurl + extend.val(),
            //data: "q=ajax&path=" + paths[i],
            dataType: "json",
            cache: false,
            success: function(result) {
                extend.attr("disabled", "");
                pre.attr("disabled", "");
                if(result){
                    msg.attr("class", "message_ok");
                    msg.html("恭喜,您的服务器支持该扩展.");
                    next.attr("disabled", "");
                }else{
                    msg.attr("class", "message_error");
                    msg.html("对不起,您的服务器不支持该扩展,请重新选择.");
                    next.attr("disabled", "disabled");
                }
            },
            error: function(){
                extend.attr("disabled", "");
                pre.attr("disabled", "");
                msg.attr("class", "message_error");
                msg.html("对不起,您的服务器不支持该扩展,请重新选择.");
                next.attr("disabled", "disabled");
            }
        });
    }
</script>
<style type="text/css">
.message_ok{ color:Green; }
.message_error{ color:Red; }
</style>
</asp:Content>

<asp:Content ID="step2Content" ContentPlaceHolderID="installContent" runat="server">
<fieldset>
<legend> 安装模式选项</legend>
<table border="0" cellpadding="2" cellspacing="1">
<tr>
<td width="180" align="right"><div align="right">安装模式:</div></td>
<td align="left">
<asp:DropDownList ID="setup_mode" runat="server">
<asp:ListItem Text="全新安装" Value="1" Selected="True"></asp:ListItem>
<asp:ListItem Text="升级安装" Value="2"></asp:ListItem>
</asp:DropDownList>
</td>
</tr>
</table>
</fieldset>

<fieldset id="setup_new">
<legend> 全新安装选项</legend>
<table border="0" cellpadding="2" cellspacing="1">
<tr>
<td width="180" align="right"><div align="right">数据库路径:</div></td>
<td align="left" width="350px">
<asp:TextBox ID="setup_new_datapath" runat="server" Width="200" Text="~/App_Data/Database.db3"></asp:TextBox>
<asp:RequiredFieldValidator ID="setup_new_datapath_check" runat="server" Text="数据库路径不能为空" ControlToValidate="setup_new_datapath"></asp:RequiredFieldValidator>
</td>
</tr>
<tr>
<td width="180" align="right">
管理员用户名:
</td>
<td width="300">
<asp:TextBox ID="setup_new_username" runat="server"></asp:TextBox>
<asp:RequiredFieldValidator ID="setup_new_username_required" runat="server" ErrorMessage="用户名不能为空" Display="Dynamic" ControlToValidate="setup_new_username"></asp:RequiredFieldValidator>
</td>
</tr>
<tr>
<td width="180" align="right">
管理员邮箱:
</td>
<td width="300">
<asp:TextBox ID="setup_new_mail" runat="server"></asp:TextBox>
<asp:RegularExpressionValidator ID="setup_new_mail_required" ValidationExpression="^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$" runat="server" ErrorMessage="邮箱格式错误" Display="Dynamic" ControlToValidate="setup_new_mail"></asp:RegularExpressionValidator>
</td>
</tr>
<tr>
<td width="180" align="right">
管理员密码:
</td>
<td width="300">
<asp:TextBox ID="setup_new_password" runat="server"></asp:TextBox>
<asp:RequiredFieldValidator ID="setup_new_password_required" runat="server" ErrorMessage="用户密码不能为空" Display="Dynamic" ControlToValidate="setup_new_password"></asp:RequiredFieldValidator>
</td>
</tr>
</table>
</fieldset>

<fieldset id="setup_update" style="display:none;">
<legend> 升级选项(适合levenblog2.0.2及以上升级)</legend>
<table border="0" cellpadding="2" cellspacing="1">
<tr>
<td width="180" align="right"><div align="right">升级说明:</div></td>
<td align="left">
<textarea cols="60" rows="8" readonly="readonly">
升级方法:
1.将原来程序中的App_Data,uploadfiles,skins,web.config等您可能修改过的目录或者文件备份.
2.删除除了1中保留的文件
3.将全新的新版程序上传,然后执行http://xxx/install进行升级安装
重要提示:为了您的数据安全,请尽可能将原来的程序和数据备份,或者现在本地进行升级测试.
</textarea>
</td>
</tr>
<tr>
<td width="180" align="right"><div align="right">原始数据库路径:</div></td>
<td align="left">
<asp:TextBox ID="setup_update_datapath" runat="server" Width="250" Text="~/App_Data/Database.db3"></asp:TextBox>
<asp:RequiredFieldValidator ID="setup_update_datapath_check" runat="server" Text="数据库路径不能为空" ControlToValidate="setup_update_datapath"></asp:RequiredFieldValidator>
</td>
</tr>
<tr>
<td><div align="right">使用默认模板:<div class="shuom">程序可能升级模板结构,此时需选择该项保证升级后正确执行.</div></div></td>
<td align="left">
<asp:CheckBox ID="setup_update_skin" runat="server" runat="server" Checked="true" />
</td>
</tr>
</table>
</fieldset>

<fieldset id="install_route">
<legend> UrlRouting选项</legend>
<table border="0" cellpadding="2" cellspacing="1">
<tr>
<td width="180px" align="right"><div align="right">选择路由扩展名:
</div></td>
<td align="left" width="400px">
<asp:DropDownList ID="rotute_selectext" runat="server">
<asp:ListItem Text="无扩展" Value="" Selected="True"></asp:ListItem>
<asp:ListItem Text=".aspx" Value=".aspx"></asp:ListItem>
<asp:ListItem Text=".mvc" Value=".mvc"></asp:ListItem>
<asp:ListItem Text=".ashx" Value=".ashx"></asp:ListItem>
<asp:ListItem Text=".html" Value=".html"></asp:ListItem>
<asp:ListItem Text=".htm" Value=".htm"></asp:ListItem>
<asp:ListItem Text=".asmx" Value=".asmx"></asp:ListItem>
<asp:ListItem Text=".shtml" Value=".shtml"></asp:ListItem>
</asp:DropDownList>
<span id="route_select_msg"></span>
</td>
</tr>
<tr>
<td width="180" align="right">
启用短路由模式:
</td>
<td width="300">
<asp:CheckBox ID="route_enableshort" runat="server" Checked="true" />
</td>
</tr>
</table>
</fieldset>

<fieldset id="Fieldset1">
<legend> 安全选项</legend>
<table border="0" cellpadding="2" cellspacing="1">
<tr>
<td width="180px" align="right"><div align="right">前台Cookie加密密钥:
</div></td>
<td align="left" width="400px">
<asp:TextBox ID="setup_passwordkey" runat="server"></asp:TextBox>
<asp:RequiredFieldValidator ID="setup_passwordkey_check" runat="server" ErrorMessage="前台加密密钥不能为空." Display="Dynamic" ControlToValidate="setup_passwordkey"></asp:RequiredFieldValidator>
</td>
</tr>
<tr>
<td width="180px" align="right"><div align="right">后台Cookie加密密钥:
</div></td>
<td align="left" width="400px">
<asp:TextBox ID="setup_adminpasswordkey" runat="server"></asp:TextBox>
<asp:RequiredFieldValidator ID="setup_adminpasswordkey_check" runat="server" ErrorMessage="后台加密密钥不能为空." Display="Dynamic" ControlToValidate="setup_adminpasswordkey"></asp:RequiredFieldValidator>
<asp:CompareValidator ID="setup_passwordkey_checksame" runat="server" ErrorMessage="前后台加密密钥不能相同" Display="Dynamic" ControlToValidate="setup_adminpasswordkey" ControlToCompare="setup_passwordkey" Operator="NotEqual"></asp:CompareValidator>
</td>
</tr>
<tr>
<td width="180px" align="right"><div align="right">系统变量前缀:
</div></td>
<td align="left" width="400px">
<asp:TextBox ID="setup_prefixkey" runat="server"></asp:TextBox>
<asp:RequiredFieldValidator ID="setup_prefixkey_check" runat="server" ErrorMessage="系统变量前缀不能为空." Display="Dynamic" ControlToValidate="setup_prefixkey"></asp:RequiredFieldValidator>
</td>
</tr>
</table>
</fieldset>

<div style="margin:0px auto; text-align:center;">
<div style="margin:0px auto; text-align:center;">
<asp:Button ID="step3_pre" Text="上一步" runat="server" 
        CssClass="button" onclick="step3_pre_Click" />
<asp:Button ID="step3_next" Text="下一步" runat="server"
        CssClass="button" onclick="step3_next_Click" />
</div>
</div>
</asp:Content>