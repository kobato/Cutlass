<%@ Page Language="C#" MasterPageFile="../shared/blog.master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" %>

<asp:Content ID="linkSider" ContentPlaceHolderID="BlogSider" runat="server">
<%Html.RenderPartial("sider"); %>
</asp:Content>

<asp:Content ID="LinkContent" ContentPlaceHolderID="BlogContent" runat="server" EnableViewState="false">

<%
    IList<lb_friendlink> links = ViewData.Model as IList<lb_friendlink>;
    if (links == null)
    {
        throw new ArgumentNullException("ViewData.Model");
    }
%>
   <div id="mainContent">
     <div id="innermainContent">
       <div id="mainContent-topimg"></div>
       	 <div id="Content_ContentList" class="content-width">
<div class="Content">
           <div class="Content-top"><div class="ContentLeft"></div><div class="ContentRight"></div>
                   <h1 class="ContentTitle"><img src="<%=Url.Content("~/admin/images/image.gif") %>" alt="" style="margin:0px 2px -3px 0px" class="CateIcon"/><b>图象链接</b></h1>
                   <h2 class="ContentAuthor">Image Link</h2>
           </div>
           <div class="Content-body">
           <%
               var imageLinks = links.Where(f => f.isimg == true);
               foreach (var link in imageLinks)
               {
                   Response.Write(string.Format("<a href=\"{0}\" target=\"_blank\"><img src=\"{1}\" alt=\"{2}\" border=\"0\" style=\"margin:3px;width:88px;height:31px\"/></a>\r\n", link.url, link.image, link.intro));
               }
           %>
           </div>
         </div>
         
         <div class="Content">
           <div class="Content-top"><div class="ContentLeft"></div><div class="ContentRight"></div>
                   <h1 class="ContentTitle"><img src="<%=Url.Content("~/admin/images/html.gif") %>" alt="" style="margin:0px 2px -3px 0px" class="CateIcon"/><b>文字链接</b></h1>
                   <h2 class="ContentAuthor">Text Link</h2>
           </div>
           <div class="Content-body">
           <%
               var textLinks = links.Where(f => f.isimg == false);
               foreach (var link in textLinks)
               {
                   Response.Write(string.Format("<div class=\"link\" style=\"width:108px;float:left;overflow:hidden;margin-right:8px;height:24px;line-height:180%\"><a href=\"{0}\" target=\"_blank\" title=\"{1}\">{2}</a></div>\r\n", link.url, link.intro, link.name));
               }
           %>
           </div>
         </div>
         
           <div id="MsgContent" style="width:94%;">
                <div id="MsgHead">申请友情链接</div>
                <div id="MsgBody">
                <script type="text/javascript">
                    function CheckPost(){
                    }
                </script>
                <form name="frm" action="<%=Url.Action("linkpost") %>" method="post" onsubmit="return CheckPost();" style="margin:0px;">	  
          	  <table width="100%" cellpadding="0" cellspacing="0">
          	  <tr><td align="right" width="70"><strong>网站名称:</strong></td><td align="left" style="padding:3px;"><input name="linkname" type="text" size="35" class="userpass" maxlength="40"/> <span style="color:#f00">*</span></td></tr>
          	  <tr><td align="right" width="70"><strong>网站地址:</strong></td><td align="left" style="padding:3px;"><input name="linkurl" type="text" size="50" class="userpass"/> <span style="color:#f00">*</span></td></tr>
          	  <tr><td align="right" width="70"><strong>网站Logo:</strong></td><td align="left" style="padding:3px;"><input name="linkimage" type="text" size="50" class="userpass"/></td></tr>
          	   <tr><td align="right" width="70"><strong>验证码:</strong></td><td align="left" style="padding:3px;"><input name="code" type="text" size="5" class="userpass" maxlength="5"/><img id="vcodeImg" src="<%=Url.Action("code", "blog") %>" alt="验证码" title="看不清楚?换一张" style="margin-right:17px;cursor:pointer;width:63px;height:18px;margin-bottom:-4px;margin-top:3px;" onclick="this.src=this.src+'?'"/></td></tr>
			  <tr><td align="right" width="70"></td><td align="left">提示：网站的Logo和地址要写完整,必须包含 http://</td></tr>
                    <tr>
                      <td colspan="2" align="center" style="padding:3px;">
                        <input name="action" type="hidden" value="postLink"/>
          			    <input type="submit" class="userbutton" value="提交链接"/>
                        <input name="button" type="reset" class="userbutton" value="重写"/>
                        </td>
                    </tr>
          	  </table></form>
          </div></div>
          </div>
       <div id="mainContent-bottomimg"></div>
   </div>
   </div>

</asp:Content>
