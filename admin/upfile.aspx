<%@ Page Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" %>
<%@ Register Src="page.ascx" TagName="Page" TagPrefix="LevenBlog" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>LevenBlog - 附件管理</title>
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
	<script type="text/javascript">
	    function DeleteFiles(){
	        if (confirm("是否删除所选的项目？")){
    		  var url="<%=Url.Action("filedelete") %>";
    		  url+="?idarray=";
    		  var paras=$(":checkbox[@name=Files]:checked");
    		  var result=false;
    		  for(var i=0;i<paras.length;i++){
    		    //if(paras[i].checked="checked"){
    		        url+=paras[i].value+",";
    		        if(result==false)
    		            result=true;
    		    //}
    		  }
    		  if(url.charAt(url.length-1)==',')
    		    url=url.substring(0,url.length-1);
    		  if(result)
    		    window.location=url;
    		  else
    		    alert("请先选择要删除的评论.");
		  }
	    }
	</script>
</head>
<%
    IList<lb_file> files = ViewData.Model as IList<lb_file>;
    if (files == null)
    {
        throw new ArgumentNullException("ViewData.Model");
    }
%>
<body class="ContentBody">
  <div class="MainDiv">
	
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="CContent">
		  <tr>
		    <th class="CTitle">数据库与附件 - 附件管理</th>
		  </tr>
		  <tr>
		    <td class="CPanel">
			<div class="SubMenu"><a href="<%=Url.Action("upfile") %>">附件管理</a></div>
		    <div align="left" style="padding:5px;">
		   <form action="ConContent.asp" method="post" style="margin:0px">
		   <input type="hidden" name="action" value="Attachments"/>
		   <input type="hidden" name="whatdo" value="DelFiles"/>
		     <div style="font-weight:bold;font-size:14px;margin:3px;margin-left:0px">attachments</div>
		     <div style="margin:3px;margin-left:0px;">
		     <%
                 foreach (lb_file file in files)
                 {
		     %>
		     <input name="Files" type="checkbox" value="<%=file.id %>"/>&nbsp;<a href="<%=Url.RouteUrl( new { controller = "blog", action = "file", id = file.id.ToString() } ) %>" target="_blank"><img border="0" src="<%=Url.Content("~/admin/images/file/" + file.type.ToFileIcon() + ".gif") %>" style="margin:4px 3px -3px 0px"/><%=file.name + "." + file.type %></a>&nbsp;&nbsp;<%=file.hits %> Hits | <%=file.time.ToString("yyyy-MM-dd HH:mm:ss") %> | 路径:<%=file.path %><br>
		     <%
                 }
             %>
		     </div>
		    <div style="color:#f00">单独删除附件可能导致日志中图片或者下载链接失效,请谨慎操作!</div>
			<div style="float:left;margin:3px;margin-left:0px">
		    <LevenBlog:Page ID="ListPage" runat="server"></LevenBlog:Page>
		    </div>
			  	<div class="SubButton">
		      <input type="button" value="全选" class="button" onClick="checkAll()"/>  
		      <input type="button" name="Submit" onclick="DeleteFiles();" value="删除所选的文件或文件夹" class="button"/> 

		     </div>
		     </form>
			  
			 </div>
		 </td>
		  </tr></table>

  </div>
 </body>
</html>
