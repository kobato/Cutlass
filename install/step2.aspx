<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="install.master" CodeBehind="step2.aspx.cs" Inherits="LevenBlog.Web.install.step2" %>

<asp:Content ID="step2Head" ContentPlaceHolderID="installHead" runat="server">
<script type="text/javascript" src="js/jquery.js"></script>
<style type="text/css">
.checkerror{color:Red;}
</style>
<script type="text/javascript">
    function CheckFileSystem() {
        var paths = $("#checkedpath").html().split("|");
        var result = true;
        for (var i = 0; i < paths.length; i++) {
            //alert(paths[i]);
            $.ajax({
                type: "GET",
                async: false,
                url: "step2.aspx",
                data: "q=ajax&path=" + paths[i],
                dataType: "json",
                cache: false,
                success: function(data) {
                    //alert("Data Saved: " + msg);
                    //alert(msg);
                    $("#checkcontainer").append(data.message);
                    result = result && data.result;
                }
            });
        }
        $("#<%=step2_pre.UniqueID.Replace("$", "_") %>").attr("disabled", "");
        $("#<%=step2_next.UniqueID.Replace("$", "_") %>").attr("disabled", result ? "" : "disabled");
    }
    $(document).ready(function() {
        CheckFileSystem();
    });
</script>
</asp:Content>

<asp:Content ID="step2Content" ContentPlaceHolderID="installContent" runat="server">
<div id="checkedpath" style="display:none;">
~/App_Data|~/uploadfiles|~/install|~/install/img|~/install/js|~/config|~/web.config|~/default.aspx
</div>
<table width="98%" border="0px" cellpadding="0px" cellspacing="0px" style="margin:0px auto;">
<tr>
<td>
<div id="checkcontainer">
</div>
<div style="margin:0px auto; text-align:center;">
<asp:Button ID="step2_pre" Text="上一步" runat="server" Enabled="false" 
        onclick="step2_pre_Click" CssClass="button" />
<asp:Button ID="step2_next" Text="下一步" runat="server" Enabled="false" 
        onclick="step2_next_Click" CssClass="button" />
</div>
</td>
</tr>
</table>
</asp:Content>