<%@ Page Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" %>
<%@ Register Src="page.ascx" TagName="Page" TagPrefix="LevenBlog" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>LevenBlog - 评论管理</title>
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
    <link rel="stylesheet" href="<%=Url.Content("~/admin/images/style.css") %>" type="text/css" />
    <script type="text/javascript" src="<%=Url.Content("~/admin/js/control.js") %>"></script>
    <script type="text/javascript" src="<%=Url.Content("~/admin/js/jquery.js") %>"></script>
    <script type="text/javascript" src="<%=Url.Content("~/admin/js/jquery.blockUI.js") %>"></script>
    <style type="text/css">
	.style1 {color: #999}
	.dialogtitle{ background:url("<%=Url.Content("~/admin/images/menu_bg.jpg")%>") repeat-x; margin:0px; padding:8px 0px 0px 0px; width:100%; height:25px; font-size:14px; font-weight:bold; color:#fff;}
	.dialogbody{ width:100%; height:120px;}
	.dialogtextarea{margin:5px;width:435px; height:115px;}
	.dialogfoot{margin:3px 1px 0px 0px; float:right; clear:both; height:28px; overflow:hidden;}
	</style>
	<script type="text/javascript">
	    function OpenDialog(id){
	        var width=$(window).width()/2-225;
	        $.blockUI({message:$("#editdialog_" + id),css: { width: '450px', height:'185px', top:'50px', left:width, cursor:'default' }});
	    }
	    function DialogCancel(){
	        $.unblockUI();
	    }
	    function PostEdit(id){
	        var content=$("#dialogcontent_" + id).text();
	        content=$.trim(content);
	        if(content.length<1){
	            alert("评论内容不能为空.");
	            return;
	        }
	        var ishtml="false";
	        if($("#dialigishtml_"+id).attr("checked")){
	            ishtml=true;
	        }
	        $("#editdialog_"+id).block({message:'正在提交,请稍后...'});
	        $.ajax({
              type:"POST",
              dataType:"json",
              url:"<%=Url.Action("commentedit")%>",
              //data:"content="+escape(content)+"&id="+id+"&ishtml="+ishtml,
              data:{id:id,content:content,ishtml:ishtml},
              success:function(info){
                $("#editdialog_"+id).unblock();
                $.unblockUI();
                alert(info.info);
                $("#content_"+id).text(content);
                $("#dialogcontent_" + id).val(content);
              },
              error:function(){
                $("#editdialog_"+id).unblock();
                alert("与服务器通信错误.");
                $.unblockUI();
              }
            });
	    }
	    function DelComment(){
    	 if (confirm("是否删除所选的项目？")){
    		  var url="<%=Url.Action("commentdelete") %>";
    		  url+="?idarray=";
    		  var paras=$(":checkbox[@name=selectCommentID]:checked");
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
    IList<lb_comment> comments = ViewData.Model as IList<lb_comment>;
    if (comments == null)
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
		   
		   
				<form action="<%=Url.Action("commentpost") %>" method="post" style="margin:0px">
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
                            foreach (lb_comment comment in comments)
                            {		    
					    %>
				        <div class="item"><input type="hidden" name="CommentID" value="<%=comment.id %>"/>
					        <div class="title">
					        <span class="blogTitle">
					        <a href="<%=Url.RouteUrl(new { controller = "blog", action = "view", id = comment.blogid.ToString(), page = "1"}) %>" target="_blank" title="<%=comment.title %>"><%=comment.title %></a>
					        </span>
					        <input type="checkbox" name="selectCommentID" value="<%=comment.id %>" onClick="highLight(this)"/>
					        <img src="<%=Url.Content("~/admin/images/icon_quote.gif") %>" alt=""/><b><%=comment.user %></b> 
					        <span class="date">[<%=comment.posttime.ToString("yyyy-MM-dd HH:mm:ss") %> | <%=comment.ip %>]
                            <a href="javascript:void(0);" onclick="OpenDialog(<%=comment.id %>);" title="编辑该评论"><img src="<%=Url.Content("~/admin/images/icon_edit.gif") %>" alt="编辑该评论" style="border:0px" /></a>
                            <%if(comment.isshow){ %>
                            <a href="<%=Url.Action("commentverify", new { controller = "admin", id = comment.id.ToString(), verify = "0"}) %>" title="取消审核">取消审核</a>
                            <%}else{ %>
                            <a href="<%=Url.Action("commentverify", new { controller = "admin", id = comment.id.ToString(), verify = "1"}) %>" title="通过审核"><font color="red">审核</font></a>
                            <%} %>
					        </span></div>
					        <div id="content_<%=comment.id %>" class="content">
					        <%=comment.content %>
					        </div>
					        <!-- 留言编辑Dialog -->
                            <div id="editdialog_<%=comment.id %>" style="display:none;">
                            <div class="item">
                                <input id="dialogid_<%=comment.id %>" type="hidden" value="1"/>
                                <div class="dialogtitle">
                                    <span id="dialogtitle_<%=comment.id %>" class="blogTitle">编辑评论</span>
                                </div>
                                <div class="dialogbody" id="dialogcontent_<%=comment.id %>">
                                    <textarea class="dialogtextarea" id="dialogcontent_<%=comment.id %>" cols="30" rows="5"><%=comment.content %></textarea>
                                </div>
                                <div class="dialogfoot">
                                    <label for="dialigishtml_<%=comment.id %>"><input id="dialigishtml_<%=comment.id %>" type="checkbox" style=" height:18px; vertical-align:middle;" value="true" /><span style=" vertical-align:middle; line-height:26px;">HTML提交</span></label>
                                    <input type="button" class="button" onclick="DialogCancel();" value="取消" />
                                    <input type="button" class="button" onclick="PostEdit(<%=comment.id %>);" value="提交修改" />
                                </div>
                            </div>
                            </div>
                            <!-- 留言编辑Dialog完毕 -->
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
