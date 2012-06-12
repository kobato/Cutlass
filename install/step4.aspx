<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="install.master" CodeBehind="step4.aspx.cs" Inherits="LevenBlog.Web.install.step4" %>

<asp:Content ID="step2Head" ContentPlaceHolderID="installHead" runat="server">

    <script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">  
    function StartInstall(){
        $("#<%=step4_pre.UniqueID.Replace("$", "_") %>").attr("disabled", "disabled");
        $("#step4_ntext").attr("disabled", "disabled");
        var queries = $("#queries").html().split("|");
        var result = true;
        for(var i = 0; i < queries.length; i++){
            $.ajax({
                type: "GET",
                async: false,
                url: "step4.aspx",
                data: "q=" + queries[i],
                dataType: "json",
                cache: false,
                success: function(data) {
                    $("#checkcontainer").append(data.message);
                    $("#checkcontainer").append("<br />");
                    result = result && data.result;
                }
            });
        }
        $("#<%=step4_pre.UniqueID.Replace("$", "_") %>").attr("disabled", "");
        $("#step4_next").attr("disabled", result ? "" : "disabled");
        $("#step4_next").val(result ? "安装成功,前往首页" : "对不起,安装失败,请重新安装");
    }
    
    $(document).ready(function() {
        StartInstall();
    });
    
    function jumpIndex(){
        window.location="../default.aspx";
    }
</script>
</asp:Content>

<asp:Content ID="step2Content" ContentPlaceHolderID="installContent" runat="server">
    <div id="queries" style="display:none;">
<%=Queries %>
</div>
<table width="98%" border="0px" cellpadding="0px" cellspacing="0px" style="margin:0px auto;">
<tr>
<td>
<div id="checkcontainer">
</div>
<div style="margin:0px auto; text-align:center;">
<asp:Button ID="step4_pre" Text="上一步" runat="server" Enabled="false" 
        CssClass="button" onclick="step4_pre_Click" />
<input id="step4_next" type="button" disabled="disabled" class="button" onclick="jumpIndex();" />
</div>
</td>
</tr>
</table>
</asp:Content>