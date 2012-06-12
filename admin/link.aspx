<%@ Page Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>LevenBlog - 友情链接</title>
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
    <link rel="stylesheet" href="<%=Url.Content("~/admin/images/style.css") %>" type="text/css" />
    <script type="text/javascript" src="<%=Url.Content("~/admin/js/control.js") %>"></script>
    <script type="text/javascript" src="<%=Url.Content("~/admin/js/jquery.js") %>"></script>
    <script type="text/javascript" src="<%=Url.Content("~/admin/js/jquery.blockUI.js") %>"></script>
    <style type="text/css">
	.style1 {color: #999}
	.dialogtitle{ background:url("<%=Url.Content("~/admin/images/menu_bg.jpg")%>") repeat-x; margin:0px; padding:8px 0px 0px 0px; width:100%; height:25px; font-size:14px; font-weight:bold; color:#fff;}
	.dialogbody{ width:100%; height:246px;clear:both;}
	.dialogtextarea{margin:5px;width:435px; height:115px;}
	.dialogfoot{margin:0px auto; float:right; clear:both; height:28px; overflow:hidden;}
	.readonlyinput input{ background:#dce8fa;}
	</style>
    <script type="text/javascript">
	    function OpenDialog(id){
	        var width=$(window).width()/2-130;
	        $.blockUI({message:$("#editdialog_" + id),css: { width: '260px', height:'310px', top:'50px', left:width, cursor:'default' }});
	    }
	    function DialogCancel(){
	        $.unblockUI();
	    }
	    function PostEdit(id){
	        var name=$.trim($("#name_" + id).val());
	        var intro=$.trim($("#intro_" + id).val());
	        var url=$.trim($("#url_" + id).val());
	        var image=$.trim($("#image_" + id).val());
	        var order=$.trim($("#order_" + id).val());
	        var isindex=$("#isindex_" + id).val();
	        var isshow=$("#isshow_" + id).val();
	        var isimg=$("#isimg_" + id).val();
//	        alert(name);
//	        alert(intro);
//	        alert(url);
//	        alert(image);
//	        alert(order);
//	        alert(isindex);
//	        alert(isshow);
//	        alert(isimg);
	        var nump=/\d+/;
	        if(!nump.test(order)){
	            alert("排序信息必须为非负整数.");
	            return null;
	        }
	        if(name.length<1 || url.length<1){
	            alert("链接名称和地址不能为空.");
	            return null;
	        }
	        $("#editdialog_"+id).block({message:'正在提交,请稍后...'});
	        $.ajax({
              type:"POST",
              dataType:"json",
              url:"<%=Url.Action("linkeditpost")%>",
              //data:"content="+escape(content)+"&id="+id+"&ishtml="+ishtml,
              data:{id:id,name:name,intro:intro,url:url,image:image,order:order,isindex:isindex,isshow:isshow,isimg:isimg},
              success:function(back){
                $("#editdialog_"+id).unblock();
                $.unblockUI();
                alert(back.info);
                window.navigate('<%=Url.Action("link") %>');
                //$("#content_"+id).text(content);
                //$("#dialogcontent_" + id).val(content);
              },
              error:function(){
                $("#editdialog_"+id).unblock();
                alert("与服务器通信错误.");
                $.unblockUI();
              }
            });
	    }
	    function DeleteLink(id){
    	 if (confirm("是否删除该评论？")){
    		  var url="<%=Url.Action("linkdelete") %>";
    		  url += "?id=";
              url += id; 
    		  window.location=url;
		  }
        }
	</script>
</head>
<%
    IList<lb_friendlink> links = ViewData.Model as IList<lb_friendlink>;
    if (links == null)
    {
        throw new ArgumentNullException("ViewData.Model");
    }
    Dictionary<string, bool> selectItems = new Dictionary<string, bool>();
    selectItems.Add("是", true);
    selectItems.Add("否", false);
%>
<body class="ContentBody">
  <div class="MainDiv">
	
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="CContent">
		  <tr>
			<th class="CTitle">友情链接管理</th>
		  </tr>
		  <tr>
		    <td class="CPanel"><form name="filter" action="ConContent.asp" method="post" style="margin:0px">
			
		<div class="SubMenu">过滤器: 
        <a href="<%=Url.Action("link") %>">友情链接管理</a></div> </form>
	   <form name="Link" action="<%=Url.Action("linkadd") %>" method="post" style="margin:0px">
	    <div align="left" style="padding:5px;">
	       <input type="hidden" name="action" value="Links"/>
	       <input type="hidden" name="whatdo" value="SaveLink"/>
	       <input type="hidden" name="ALinkID" value=""/>
	       <input type="hidden" name="Page" value="1"/>       
		   <table border="0" cellpadding="2" cellspacing="1" class="TablePanel">
	<tr><td colspan="7" style="border-bottom:1px solid #999;"><div class="pageContent"></div><div class="Content-body" style="line-height:200%"></td></tr>
	        <tr align="center">
	          <td width="16" nowrap="nowrap" class="TDHead">&nbsp;</td>
	          <td width="120" nowrap="nowrap" class="TDHead">网站名称</td>
	          <td width="120" nowrap="nowrap" class="TDHead">网站简介</td>
	          <td width="120" nowrap="nowrap" class="TDHead">网站地址</td>
	          <td width="190" nowrap="nowrap" class="TDHead">Logo图片地址</td>
	          <td class="TDHead">排序</td>
	          <td class="TDHead">操作</td>
		   </tr>
		   <%
               foreach (lb_friendlink link in links)
               {
		   %>
	        <tr align="center" class="readonlyinput">
	          <td>
<!-- 友情链接编辑Dialog -->
<div id="editdialog_<%=link.id %>" style="display:none;">
<div class="item">
<input id="dialogid_<%=link.id %>" type="hidden" value="1"/>
<div class="dialogtitle">
<span id="dialogtitle_<%=link.id %>" class="blogTitle">编辑友情链接</span>
</div>
<div class="dialogbody" id="dialogcontent_<%=link.id %>">
<table border="0" cellpadding="2" cellspacing="1" class="TablePanel">
<tr>
<td width="100px" align="right">ID:</td>
<td width="160px" align="left"><%=link.id %></td>
</tr>
<tr>
<td align="right">网站名称:</td>
<td align="left"><input type="text" id="name_<%=link.id %>" size="20" value="<%=link.name %>" /></td>
</tr>
<tr>
<td align="right">网站简介:</td>
<td align="left"><input type="text" id="intro_<%=link.id %>" size="20" value="<%=link.intro %>" /></td>
</tr>
<tr>
<td align="right">网站地址:</td>
<td align="left"><input type="text" id="url_<%=link.id %>" size="20" value="<%=link.url %>" /></td>
</tr>
<tr>
<td align="right">LOGO图片地址:</td>
<td align="left"><input type="text" id="image_<%=link.id %>" size="20" value="<%=link.image %>" /></td>
</tr>
<tr>
<td align="right">链接排序:</td>
<td align="left"><input type="text" id="order_<%=link.id %>" size="5" value="<%=link.order %>" /></td>
</tr>
<tr>
<td align="right">是否显示:</td>
<td align="left">
<%=Html.DropDownList("isshow_" + link.id, new SelectList(selectItems, "Value", "Key", link.isshow)) %>
</td>
</tr>
<tr>
<td align="right">是否首页链接:</td>
<td align="left">
<%=Html.DropDownList("isindex_" + link.id, new SelectList(selectItems, "Value", "Key", link.isindex))%>
</td>
</tr>
<tr>
<td align="right">是否图片链接:</td>
<td align="left">
<%=Html.DropDownList("isimg_" + link.id, new SelectList(selectItems, "Value", "Key", link.isimg))%>
</td>
</tr>
</table>
</div>
<div class="dialogfoot">
<input type="button" class="button" onclick="DialogCancel();" value="取消" />
<input type="button" class="button" onclick="PostEdit(<%=link.id %>);" value="提交修改" />
</div>
</div>
</div>
<!-- 友情链接编辑Dialog完毕 -->
	          </td>
	          <td><input readonly="readonly" type="text" size="16" class="text" value="<%=link.name %>"/></td>
	          <td><input type="text" readonly="readonly" size="25" class="text" value="<%=link.intro %>"/></td>
	          <td><input type="text" readonly="readonly" size="25" class="text" value="<%=link.url %>"/></td>
	          <td><input type="text" readonly="readonly" size="30" class="text" value="<%=link.image %>"/></td>
	          <td><input type="text" readonly="readonly" class="text" size="2" value="<%=link.order %>"/></td>
	          <td><a href="javascript:void(0);" onclick="OpenDialog(<%=link.id %>);" title="编辑"><img border="0" src="<%=Url.Content("~/admin/images/icon_edit.gif") %>" style="margin:0px 2px -3px 0px"/>编辑</a> 
			  <a href="<%=link.url %>" target="_blank" title="查看该链接"><img border="0" src="<%=Url.Content("~/admin/images/icon_trackback.gif") %>" width="16" height="16" style="margin:0px 2px -3px 0px"/>查看</a> 
			  <a href="javascript:void(0);" onClick="DeleteLink(<%=link.id %>);" title="删除该链接"><img border="0" src="<%=Url.Content("~/admin/images/icon_del.gif") %>" width="16" height="16" style="margin:0px 2px -3px 0px"/>删除</a> </td>
		   </tr>
		    <%
               }
            %>
		
	        <tr align="center" bgcolor="#D5DAE0">
	         <td colspan="7" class="TDHead" align="left" style="border-top:1px solid #9EA9C5"><a name="AddLink"></a><img src="<%=Url.Content("~/admin/images/add.gif") %>" style="margin:0px 2px -3px 2px"/>添加新友情链接</td>
	        </tr>	
	        <tr align="center">
	          <td>&nbsp;</td>
	          <td><input name="new_name" type="text" size="16" class="text"/></td>
	          <td><input name="new_intro" type="text" size="25" class="text" /></td>
	          <td><input name="new_url" type="text" size="25" class="text" /></td>
	          <td><input name="new_image" type="text" size="30" class="text" /></td>
	          <td><input name="new_order" type="text" class="text" size="2" value="1000" /></td>
	          <td align="left"><input name="new_add" type="submit" class="button" value="新增链接" /></td>
		   </tr>
		 	</table>
	  </div>
	  </form>
	  <div class="SubButton">
	     </div>	  
	 </td>
	  </tr></table></div>

  </div>
 </body>
</html>
