<%@ Page Language="C#" MasterPageFile="~/skins/mono/shared/blog.master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" ValidateRequest="false" %>

<asp:Content ID="EditHead" ContentPlaceHolderID="BlogHead" runat="server" EnableViewState="false">
<%
    string skinpath = ViewData["skinpath"] as string;
    if (skinpath == null)
    {
        throw new ArgumentNullException("ViewData[\"skinpath\"]");
    }
%>
<script type="text/javascript" src="<%=Url.Content("~/ckeditor/ckeditor.js") %>"></script>
<script type="text/javascript" src="<%=Url.Action("js") %>"></script>
</asp:Content>

<asp:Content ID="EditContent" ContentPlaceHolderID="BlogContent" runat="server" EnableViewState="false">

<%
    string skinpath = ViewData["skinpath"] as string;
    IList<lb_category> categoryList = ViewData["postcategories"] as IList<lb_category>;
    lb_config config = ViewData["config"] as lb_config;
    lb_blog editblog = ViewData.Model as lb_blog;
    if (skinpath == null)
    {
        throw new ArgumentNullException("ViewData[\"skinpath\"]");
    }
    if (categoryList == null)
    {
        throw new ArgumentNullException("ViewData[\"categories\"]");
    }
    if (config == null)
    {
        throw new ArgumentNullException("ViewData[\"postcategories\"]");
    }
    if (editblog == null)
    {
        throw new ArgumentNullException("ViewData.Model");
    }
%>
<div style="text-align:center;">
  <br/>
   <!--内容-->
  
  <!--第二步-->
    <form name="frm" action="<%=Url.Action("editpost", new { id = editblog.id } ) %>" method="post" onsubmit="return CheckPost();">
  	<div id="MsgContent" style="width:700px">
        <div id="MsgHead">编辑日志</div>
        <div id="MsgBody">        
          <table width="100%" border="0" cellpadding="2" cellspacing="0">
            <tr>
            <td width="72" height="24" align="right" valign="top"><span style="font-weight: bold">分类选择:</span></td>
            <td align="left">
                <select name="category" id="category">
                    <%
                        foreach (lb_category category in categoryList)
                        {
                            if (category.id == editblog.categoryid)
                                Response.Write(string.Format("<option value=\"{0}\" selected=\"selected\">{1}</option>\r\n", category.id, category.name));
                            else
                                Response.Write(string.Format("<option value=\"{0}\">{1}</option>\r\n", category.id, category.name));
                        }
                    %>
                </select>
              </td>
            </tr>
            <tr>
              <td width="72" height="24" align="right" valign="top"><span style="font-weight: bold">标题:</span></td>
              <td align="left"><input name="title" type="text" class="inputBox" id="title" size="50" maxlength="255" value="<%=editblog.title %>"/>
              </td>
              <td width="120" rowspan="3" align="center">
              </td>
            </tr>
            <tr>
              <td height="24" align="right" valign="top"><span style="font-weight: bold">参数:</span></td>
              <td width="517" align="left">
                <label for="label">
                <input id="istemp" name="istemp" type="checkbox" value="true"<%=(!editblog.isshow).ToCheckString() %> />
        保存为草稿</label>
                <label for="label2">
                <input name="islock" type="checkbox" id="islock" value="true"<%=editblog.islock.ToCheckString() %> />
        禁止评论</label>
                <label for="label3">
                <input name="istop" type="checkbox" id="istop" value="true"<%=editblog.istop.ToCheckString() %> />
        日志置顶</label>
              </td>
            </tr>
            <tr>
              <td height="24" align="right" valign="top">&nbsp;</td>
              <td align="left"><span style="font-weight: bold">来自:</span>
                  <input name="come" type="text" id="come" value="<%=editblog.come %>" size="12" class="inputBox" />
                  <span style="font-weight: bold">网址:</span>
                  <input name="comeurl" type="text" id="comeurl" value="<%=editblog.comeurl %>" size="38" class="inputBox" />
                </td>
            </tr>
<%--            <tr>
              <td height="24" align="right" valign="top"><span style="font-weight: bold">发表时间:</span></td>
              <td align="left">
                  <label for="P1"><input name="posttimetype" type="radio" id="P1" value="now" size="12" checked/>当前时间</label> 
                  <label for="P2"><input name="posttimetype" type="radio" id="P2" value="com" size="12" />自定义日期:</label>
                  <input name="posttime" type="text" value="<%=DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") %>" size="21" class="inputBox" /> (格式:yyyy-mm-dd hh:mm:ss)
                </td>
            </tr>--%>
            <tr>
              <td height="24" align="right" valign="top"><span style="font-weight: bold">Tags:</span></td>
              <td align="left">
                      <input name="tags" type="text" value="<%=editblog.tags %>" size="50" class="inputBox" /> <img src="<%=Url.Content("~/" + skinpath + "images/insert.gif") %>" alt="插入已经使用的Tag" onclick="popnew('<%=Url.Action("subtags") %>','tag','250','324')" style="cursor:pointer"/> (tag之间用英文的逗号分割)
               </td>
            </tr>
             <tr>
              <td  align="right" valign="top"><span style="font-weight: bold">内容:</span></td>
              <td colspan="2" align="center">
              <div>
              <textarea id="content" name="content" rows="1" cols="1" style="display:none;">
              <%=Html.Encode(editblog.content) %>
              </textarea>
              <script type="text/javascript">
                  var editor = CKEDITOR.replace('content', { height: 300 });
              </script>
              </div></td>
            </tr>
  
          <tr>
              <td  align="right" valign="top"><span style="font-weight: bold">内容摘要:</span></td>
              <td colspan="2" align="left">
              <div id="Div_Intro">
              <textarea id="intro" name="intro" rows="1" cols="1" style="display:none;">
                <%=Html.Encode(editblog.intro) %>
              </textarea>
              <script type="text/javascript">
                  var editor = CKEDITOR.replace('intro', {
                      height: 120,
                      toolbar:
					    [
						    ['Bold', 'Italic', '-', 'NumberedList', 'BulletedList', '-', 'Link', 'Unlink'],
						    ['About']
					    ]
                  });
              </script>
              </div>
              </td>
          </tr>          <tr>
              <td align="right" valign="top" nowrap><span style="font-weight: bold">附件上传:</span></td>
              <td colspan="2" align="left">
              <iframe src="<%=Url.Action("upload") %>" width="100%" height="24" frameborder="0" scrolling="no" border="0" frameborder="0"></iframe>
              </td>
            </tr>
            <tr>
              <td colspan="3" align="center">
                <input name="postbutton" id="postbutton" type="submit" class="userbutton" value="提交日志" accesskey="S"/>
                <input name="returnbutton" id="returnbutton" type="button" class="userbutton" value="返回" accesskey="Q" onClick="history.go(-1)"/></td>
            </tr>
            <tr>
               <td height="24" align="right" valign="top"></td>
              <td colspan="2" align="left">
                <div id="checkmessage" style="width:100%; border:#f37c3f 1px solid; background:#eaeaea; padding:3px 0px 3px 0px; display:none;">
                
                </div>
              </td>
            </tr>
            <tr>
              <td colspan="3" align="right">
                友情提示:保存草稿后，日志不会在日志列表中出现。只有再次编辑，<b>取消草稿</b>后才显示出来。</td>
            </tr>
           </table>
        </div>
  	</div>
  </form>
  <br/> 
 </div>

</asp:Content>
