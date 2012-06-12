<%@ Page Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>LevenBlog 分类管理</title>
    <link rel="stylesheet" href="<%=Url.Content("~/admin/images/style.css") %>" type="text/css" />
    	<style type="text/css">
		<!--
		.style1 {color: #999}
		-->
	</style>
</head>
<%
    IList<lb_category> categories = ViewData.Model as IList<lb_category>;
    IList<string> icons = ViewData["icons"] as IList<string>;
    string iconpath = ViewData["iconpath"] as string;
    string skinpath = ViewData["skinpath"] as string;
    if (categories == null)
    {
        throw new ArgumentNullException("ViewData.Model");
    }
    if (icons == null)
    {
        throw new ArgumentNullException("ViewData[\"icons\"]");
    }
    if (iconpath == null)
    {
        throw new ArgumentNullException("ViewData[\"iconpath\"]");
    }
    if (skinpath == null)
    {
        throw new ArgumentNullException("ViewData[\"skinpath\"]");
    }
%>
<body class="ContentBody">
  <div class="MainDiv">
	
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="CContent">
		  <tr>
		    <th class="CTitle">日志分类管理 - 设置日志分类</th>
		  </tr>
		  <tr>
		    <td class="CPanel">
		    <div class="SubMenu"><a href="<%=Url.Action("category") %>">设置日志分类</a></div>
			 <script type="text/javascript">
			 	var il = [];
		        <%
                foreach (string icon in icons)
                {
                    Response.Write(string.Format("il.push('{0}');\r\n", icon));
                }      
		        %>

		       
		       function fillList(o){
			     	var v = o.defaultValue;
			     	for (var i=0;i<il.length;i++){
			     		var n = new Option(il[i],"<%=iconpath %>/" + il[i]);
			     		o.options.add(n);
			     	}
			     	if (!v) o.selectedIndex = 0; else o.value  = v;
		       }
		       
		       function fillAllList(){
		       		var ci = document.getElementsByName("icons");
		       		for (var i=0;i<ci.length;i++)
		       			fillList(ci[i]);
		       		fillList(document.getElementsByName("new_icons")[0]);
		       }
			 </script>
		   <form action="<%=Url.Action("categorypost") %>" method="post" style="margin:0px">
		   <input type="hidden" name="action" value="Categories"/>
		   <input type="hidden" name="whatdo" value="Cate"/>
		   <input type="hidden" name="DelCate" value=""/>
		    <div align="left" style="padding:5px;">
		      <table border="0" cellpadding="2" cellspacing="1" class="TablePanel">
		        <tr align="center">
		          <td class="TDHead" nowrap>分类图标</td>
		          <td class="TDHead" nowrap>标题</td>
		          <td class="TDHead" nowrap>提示说明</td>
		          <td width="180" class="TDHead" nowrap>外部链接</td>
		          <td width="180" class="TDHead" nowrap>访问别名</td>
		          <td width="29" class="TDHead" nowrap>排序</td>
		          <td width="30" class="TDHead" nowrap>外链</td>
		          <td class="TDHead" nowrap>别名</td>
		          <td class="TDHead" nowrap>位置</td>
		          <td class="TDHead" nowrap>日志数量</td>
		          <td align="center" class="TDHead">&nbsp;</td>
		        </tr>
		        
		        <%
                    foreach (lb_category category in categories)
                    {
		        %>
		        <tr id="Catetr_<%=category.id %>" style="background:<%if(category.view==1) Response.Write("#a9c9e9"); else if(category.view==2) Response.Write("#bcf39e"); %>;">
		          <td align="center" nowrap>
		          <img name="image_<%=category.id %>" src="<%=Url.Content("~/" + skinpath + category.image) %>" width="16" height="16" />
		         
		          <select name="icons" defaultValue="<%=Url.Content("~/" + skinpath + category.image) %>" onChange="document.images['image_<%=category.id %>'].src=this.value;" style="width:120px;"></select>
		          
		          </td>
		          <td><input name="name_<%=category.id %>" type="text" class="text" value="<%=category.name %>" size="14"/></td>
		          <td align="left"><input name="info_<%=category.id %>" type="text" class="text" value="<%=category.info %>" size="30"/></td>
		          <td align="left"><input name="url_<%=category.id %>" type="text" value="<%=category.url %>" size="30" class="text"<%if(category.num>0){ Response.Write(" readonly=\"readonly\"  style=\"background:#e5e5e5\""); } %> /></td>
		          <td align="left"><input name="showurl_<%=category.id %>" type="text" value="<%=category.showurl %>" size="30" class="text" /></td>
		          <td align="left"><input name="order_<%=category.id %>" type="text" value="<%=category.order %>" size="2" class="text"/></td>
		          <td align="left"><input type="checkbox" name="isurl_<%=category.id %>" value="true" <%=category.isurl.ToCheckString() %> <%if(category.num>0){ Response.Write(" disabled=\"disabled\"  style=\"background:#e5e5e5\""); } %> /></td>
		          <td align="left"><input type="checkbox" name="isshowurl_<%=category.id %>" value="true" <%=category.isshowurl.ToCheckString() %> /></td>
		          <td align="center">
		           <select id="view_<%=category.id %>" name="view_<%=category.id %>" onChange="getElementById('Catetr_<%=category.id %>').style.backgroundColor=(this.value==1)?'#a9c9e9':(this.value==2)?'#bcf39e':''" >
			            <option value="0">同时</option>
			            <option value="1" >顶部</option>
			            <option value="2" >侧边</option>
		           </select>
		           <script type="text/javascript">
		           document.getElementById("view_<%=category.id %>").value=<%=category.view %>;
		           </script>
		          </td>
		          <td align="left" nowrap><input type="text" class="text" name="num_<%=category.id %>" value="<%=category.num %>" size="2" readonly="readonly" style="background:#ffe"/> 篇</td>
		          <td align="center">
				   <a href="javascript:window.location='<%=Url.Action("categorydelete",new { controller="admin", id = category.id.ToString() } ) %>';" onclick="if (!window.confirm('是否要删除该分类(该分类下的日志和评论等都会被删除)?')) return false" title="删除该分类"><img border="0" src="<%=Url.Content("~/admin/images/icon_del.gif") %>" width="16" height="16" /></a>
		           <input type="hidden" name="id" value="<%=category.id %>"/>
		          </td>
		        </tr>
		        <%
                    }
                %>
		        
		        <tr align="center" bgcolor="#D5DAE0">
		         <td colspan="9" class="TDHead" align="left" style="border-top:1px solid #9EA9C5"><img alt="" src="<%=Url.Content("~/admin/images/add.gif") %>" style="margin:0px 2px -3px 2px"/>添加日志分类</td>
		        </tr>
		        <tr>
		          <td align="center" nowrap><img name="new_image" src="<%=iconpath + "/" + icons[0] %>" width="16" height="16" />
		          
			          <select name="new_icons" onChange="document.images['new_image'].src=this.value" style="width:120px;"></select>
		          
		          </td>
		          <td><input name="new_name" type="text" size="14" class="text"/></td>
		          <td align="left"><input name="new_info" type="text" class="text" size="30"/></td>
		          <td align="left"><input name="new_url" type="text" size="30" class="text"/></td>
		          <td align="left"><input name="new_showurl" type="text" size="30" class="text"/></td>
		          <td align="left"><input name="new_order" type="text" size="2" value="1000" class="text"/></td>
		          <td align="left"><input type="checkbox" name="new_isurl" value="true" /></td>
		          <td align="left"><input type="checkbox" name="new_isshowurl" value="true" /></td>
		          <td align="center">
		           <select name="new_view">
		            <option value="0">同时</option>
		            <option value="1">顶部</option>
		            <option value="2">侧边</option>
		           </select>
		          </td>
		          <td align="center">&nbsp;</td>
		          <td align="center">&nbsp;</td>
		        </tr>
		      </table>
		      <script type="text/javascript">fillAllList()</script>
		    </div>
		    <div style="color:#f00">如果分类中存在日志，则无法使用外部连接.删除日志分类的时假如分类中存在日志,那么日志也会被删除</div>
			<div class="SubButton">
		      <input type="submit" name="Submit" value="保存日志分类" class="button"/> 
		     </div>   
		     </form></td>
		  </tr>
		
		</td></tr>
		</table>

  </div>
 </body>
</html>
