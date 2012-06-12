<%@ Page Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>LevenBlog - 模板管理</title>
    <link rel="stylesheet" href="<%=Url.Content("~/admin/images/style.css") %>" type="text/css" />
    <script type="text/javascript" src="<%=Url.Content("~/admin/js/control.js") %>"></script>
    <script type="text/javascript" src="<%=Url.Content("~/admin/js/jquery.js") %>"></script>
    <script type="text/javascript" src="<%=Url.Content("~/admin/js/jquery.blockUI.js") %>"></script>
    <style type="text/css">
	.style1 {color: #999}
	.dialogtitle{ background:url("<%=Url.Content("~/admin/images/menu_bg.jpg")%>") repeat-x; margin:0px; padding:3px 0px 0px 0px; width:100%; height:25px; font-size:14px; font-weight:bold; color:#fff;}
	.dialogbody{ width:100%; height:120px;}
	.dialogtextarea{margin:5px;width:435px; height:115px;}
	.dialogfoot{margin:3px 1px 0px 0px; float:right; clear:both; height:28px; overflow:hidden;}
	</style>
</head>
<%
    IList<SkinEntity> skins = ViewData.Model as IList<SkinEntity>;
    lb_config config = ViewData["config"] as lb_config;
    if (skins == null)
    {
        throw new ArgumentNullException("ViewData.Model");
    }
    if (config == null)
    {
        throw new ArgumentNullException("ViewData[\"config\"]");
    }
%>
<body class="ContentBody">
  <div class="MainDiv">
	
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="CContent">
		  <tr>
		    <th class="CTitle">界面设置 - 设置外观</th>
		  </tr>
		  <tr>
		    <td class="CPanel">
			<div class="SubMenu">
			<b>风格设置: </b> <a href="<%=Url.Action("skin") %>">设置外观</a> <br/> 
			</div>
		    <div align="left" style="padding:5px;">
		   <form action="ConContent.asp" method="post" style="margin:0px">
		       <input type="hidden" name="action" value="Skins"/>
		       <input type="hidden" name="whatdo" value="setDefaultSkin"/>
		       <input type="hidden" name="SkinName" value=""/>
		       <input type="hidden" name="SkinPath" value=""/>
		  </form>
		      <table border="0" cellpadding="2" cellspacing="1" class="TablePanel" width="800">
		        <tr>
			          <td width="700" class="TDHead" colspan="2">界面列表</td>
		        </tr>
		        <%
                    int temp = 0;
                    foreach (SkinEntity skin in skins)
                    {
                        if (temp % 2 == 0)
                            Response.Write("<tr>\r\n");        
		        %>
				 		<td width="50%" style='border-bottom:1px dotted #ccc'>
				 			<div class="selectskin">
				 			<img src="<%=Url.Content("~/skins/" + skin.Path + "/" + skin.Image) %>" alt="" border="0" class="skinimg"/>
				 			  <div class="skinDes">
				 			  <div style="height:38px;overflow:hidden"><b style="color:#004000"><a href="<%=skin.Url %>" target="_blank" title="访问模板站点"><%=skin.Name %></a></b></div>
				 			  <span style="height:16px;overflow:hidden;cursor:default" title="设计者:<%=skin.Designer %>"><B>设计者:</B> <a href="mailto:<%=skin.Mail %>" title="联系作者" target="_blank"><%=skin.Designer %></a></span><br/>
				 			  <B>发布时间:</B> <%=skin.PublicDate.ToString("yyyy-MM-dd") %><br/></div>
							  <%if (skin.Path != config.skinpath)
                                { %>
							  <a href="<%=Url.Action("skinchange", new { controller= "admin", path = skin.Path } ) %>"><img border="0" src="<%=Url.Content("~/admin/images/icon_apply.gif") %>" style="margin:0px 2px -3px 0px"/>应用此主题</a>
							  <%} %>
						  </div>
				 		</td>
				<%
                    if (temp % 2 == 1)
                        Response.Write("</tr>\r\n");
                    temp++;
                    }
                    if (temp%2!=00)
                    {
                        Response.Write("<td></td>\r\n");
                        Response.Write("</tr>\r\n");
                    }		    
    		    %>	
		      </table>
		</div>
		
		 </td>
		  </tr></table>

  </div>
 </body>
</html>
