<%@ Page Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" %>
<%@ Register Src="page.ascx" TagName="Page" TagPrefix="LevenBlog" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>LevenBlog - 引用管理</title>
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
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
	    function DelComment(){
    	 if (confirm("是否删除所选的项目？")){
    		  var url="<%=Url.Action("trackdelete") %>";
    		  url+="?idarray=";
    		  var paras=$(":checkbox[@name=selectTrackID]:checked");
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
    IList<lb_track> tracks = ViewData.Model as IList<lb_track>;
    if (tracks == null)
    {
        throw new ArgumentNullException("ViewData.Model");
    }
%>
<body class="ContentBody">
  <div class="MainDiv">
	
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="CContent">
		  <tr>
		    <th class="CTitle">评论留言管理 - 评论管理</th>
		   </tr>
		  <tr>
		    <td class="CPanel">
			<div class="SubMenu">
				<b>评论管理:</b> <a href="<%=Url.Action("comment") %>">评论管理</a> | 
				<a href="<%=Url.Action("track") %>">引用管理</a>
			</div>
		   
		   
				<form action="<%=Url.Action("trackpost") %>" method="post" style="margin:0px">
				   <input type="hidden" name="action" value="Comment"/>
				   <input type="hidden" name="doModule" value="DelSelect"/>
				      <div align="left" style="padding-top:5px; width:100%;">
					       <div style="height:24px; margin-right:4px;">
					           <div style="width:600px; float:left">
					           <LevenBlog:Page ID="ListPage" runat="server"></LevenBlog:Page>
					           </div>
					           <div style="float:right">
						       <input type="button" value="删除所选内容" onClick="DelComment()" class="button" style="margin:0px;margin-bottom:5px;float:right;"/> 
						       <input type="button" value="全选" onClick="checkAll()" class="button" style="margin:0px;margin-bottom:5px;float:right;margin-right:6px; margin-left:5px;"/>
						       </div>
					       </div>
					       <div class="msgDiv">
						
						<%
                            foreach (lb_track track in tracks)
                            {		    
					    %>
				        <div class="item"><input type="hidden" name="TrackID" value="<%=track.id %>"/>
					        <div class="title">
					        <span class="blogTitle">
					        <a href="<%=Url.RouteUrl(new { controller = "blog", action = "view", id = track.blogid.ToString(), page = "1"}) %>" target="_blank" title="<%=track.title %>"><%=track.title%></a>
					        </span>
					        <input type="checkbox" name="selectTrackID" value="<%=track.id %>" onClick="highLight(this)"/>
					        <img src="<%=Url.Content("~/admin/images/icon_quote.gif") %>" alt=""/><%=track.title %>
					        <b><a href="<%=track.siteurl %>" title="查看引用地址" target="_blank"><%=track.site%></a></b> 
					        <span class="date">[<%=track.posttime.ToString("yyyy-MM-dd HH:mm:ss") %> | <%=track.ip%>]
                            
					        </span></div>
					        <div id="content_<%=track.id %>" class="content">
					        <%=track.intro%>
					        </div>
					    </div>
				      <% }%>			      
					</div>
					<div style="height:24px; margin-right:4px;"">
					       <LevenBlog:Page ID="ListPage2" runat="server"></LevenBlog:Page>
					       <input type="button" value="删除所选内容" onClick="DelComment()" class="button" style="margin:0px;margin-bottom:5px;float:right;"/> 
					       <input type="button" value="全选" onClick="checkAll()" class="button" style="margin:0px;margin-bottom:5px;float:right;margin-right:6px"/>				    </div>
					  </div>
				 </form>
				   
	  </td></tr>
	  </table>

  </div>
 </body>
</html>

