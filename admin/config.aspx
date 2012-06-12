<%@ Page Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>LevenBlog 系统配置管理</title>
    <link rel="stylesheet" href="<%=Url.Content("~/admin/images/style.css") %>" type="text/css" />
    	<style type="text/css">
		<!--
		.style1 {color: #999}
		-->
	</style>
</head>
<%
    lb_config config = ViewData.Model as lb_config;
    if (config == null)
    {
        throw new ArgumentNullException("ViewData.Model");
    }
%>
<body class="ContentBody">
  <div class="MainDiv">
	
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="CContent">
		  <tr>
		      <th class="CTitle">站点基本设置 - 设置基本信息</th>
		  </tr>
		  <tr>
		    <td class="CPanel">
		    <div class="SubMenu"><a href="<%=Url.Action("config") %>">设置基本信息</a> |
		     <a href="<%=Url.Action("clearcache") %>">清理服务器缓存</a></div>
		
		<form action="<%=Url.Action("configpost") %>" method="post">   
		<fieldset>
		    <legend> 站点基本信息</legend>
		    <div align="left">      
		      <table border="0" cellpadding="2" cellspacing="1">
		        <tr>
		          <td width="180"><div align="right"> BLOG 名称 </div></td>
		          <td align="left"><input name="title" type="text" size="30" class="text" value="<%=config.title %>"/></td>
		        </tr>
				<tr>
		          <td width="180"><div align="right"> BLOG 副标题 </div></td>
		          <td align="left"><input name="intro" type="text" size="50" class="text" value="<%=config.intro %>"/></td>
		        </tr>
				<tr>
		          <td width="180"><div align="right"> 站长昵称 </div></td>
		          <td align="left"><input name="master" type="text" size="10" class="text" value="<%=config.master %>" maxlength="10"/></td>
		        </tr>
				<tr>
		          <td width="180"><div align="right"> 站长邮件地址 </div></td>
		          <td align="left"><input name="mail" type="text" size="50" class="text" value="<%=config.mail %>"/></td>
		        </tr>
		        <tr>
		          <td width="180"><div align="right"> BLOG 地址
		                  <div class="shuom">关系到<strong>RSS</strong>地址的可读性</div>
		          </div></td>
		          <td align="left"><input name="url" type="text" size="50" class="text" value="<%=config.url %>"/></td>
		        </tr>
		        <tr>
		          <td width="180"><div align="right"> 系统Logo地址</td>
		          <td align="left"><input name="logo" type="text" size="50" class="text" value="<%=config.logo %>"/></td>
		        </tr>
				<tr>
		          <td width="180"><div align="right"> 网站备案信息 </div></td>
		          <td align="left"><input name="tcp" type="text" size="50" class="text" value="<%=config.tcp %>"/></td>
		        </tr>  
		        <tr>
		          <td width="180"><div align="right"> 用户提交间隔 </div></td>
		          <td align="left"><input name="posttime" type="text" size="5" class="text" value="<%=config.posttime %>"/> 秒</td>
		        </tr>      
		        <tr>
		          <td width="180"><div align="right"> 站点建立时间 
		                <div class="shuom">请使用标准时间字符串</div>
		          </div></td>
		          <td align="left"><input name="buildtime" type="text" size="50" class="text" value="<%=config.buildtime %>"/></td>
		        </tr> 
		        <tr>
		          <td valign="top"><div align="right">Copyright信息</td>
		          <td align="left"><textarea name="copyright" cols="50" rows="5"><%=config.copyright %></textarea></td>
		        </tr>
		        <tr>
		          <td valign="top"><div align="right">右侧公告信息<div class="shuom">支持html</div></td>
		          <td align="left"><textarea name="notice" cols="50" rows="5"><%=config.notice %></textarea></td>
		        </tr>
		        <tr>
		          <td><div align="right">Blog对外开放</div></td>
		          <td align="left"><input name="isopen" type="checkbox" value="true" <%=config.isopen.ToCheckString() %>/></td>
		        </tr>
		        <tr>
		          <td><div align="right">开放评论</div></td>
		          <td align="left"><input name="iscomment" type="checkbox" value="true" <%=config.iscomment.ToCheckString() %>/></td>
		        </tr>
		        <tr>
		          <td><div align="right">开放引用</div></td>
		          <td align="left"><input name="istrack" type="checkbox" value="true" <%=config.istrack.ToCheckString() %>/></td>
		        </tr>
		      </table>
		    </div>
			</fieldset>
			
			<fieldset>
		    <legend> SEO优化设置</legend>
				<table border="0" cellpadding="2" cellspacing="1">
			    <tr><td width="180" align="right" valign="top">keyWords<div class="shuom">meta信息中的关键字</div></td><td width="300"><textarea name="keywords" cols="50" rows="5"><%=config.keywords %></textarea></td></tr>
				<tr><td width="180" align="right" valign="top">Description<div class="shuom">meta信息中的简介</div></td><td width="300"><textarea name="description" cols="50" rows="5"><%=config.description %></textarea></td></tr>
				</table>
			</fieldset>
			
			<fieldset>
		    <legend> 上传设置</legend>
				<table border="0" cellpadding="2" cellspacing="1">
				<tr>
		          <td><div align="right">开放上传</div></td>
		          <td align="left"><input name="isupload" type="checkbox" value="true" <%=config.isupload.ToCheckString() %>/></td>
		        </tr>
			    <tr><td width="180" align="right">上传全局大小限制<div class="shuom">如果用户组的配置超过该数值,则以该数值为准</div></td><td width="300"><input name="uploadsize" type="text" size="5" class="text" value="<%=config.uploadsize %>"/> KB</td></tr>
				<tr><td width="180" align="right">上传文件保持路径<div class="shuom">请保证该路径的有效性</div></td><td width="300"><input name="uploadpath" type="text" size="40" class="text" value="<%=config.uploadpath %>"/></td></tr>
				<tr><td width="180" align="right">允许上传的文件种类<div class="shuom">不带".",使用"|"间隔</div></td><td width="300"><input name="uploadfiles" type="text" size="60" class="text" value="<%=config.uploadfiles %>"/> </td></tr>
				</table>
			</fieldset>
			
			<fieldset>
		    <legend> 邮件设置</legend>
				<table border="0" cellpadding="2" cellspacing="1">
				<tr>
		          <td><div align="right">开启邮件发送</div></td>
		          <td align="left"><input name="issmtp" type="checkbox" value="true" <%=config.issmtp.ToCheckString() %>/></td>
		        </tr>
			    <tr><td width="180" align="right">SMTP服务器</td><td width="300"><input name="smtpserver" type="text" size="30" class="text" value="<%=config.smtpserver %>"/></td></tr>
				<tr><td width="180" align="right">发信邮箱</td><td width="300"><input name="smtpsender" type="text" size="30" class="text" value="<%=config.smtpsender %>"/></td></tr>
				<tr><td width="180" align="right">SMTP登陆用户名</td><td width="300"><input name="smtpuser" type="text" size="30" class="text" value="<%=config.smtpuser %>"/> </td></tr>
				<tr><td width="180" align="right">SMTP登录密码</td><td width="300"><input name="smtppassword" type="password" size="30" class="text" value="<%=config.smtppassword %>"/></td></tr>
				</table>
			</fieldset>

			<fieldset>
		    <legend> 显示设置</legend>
		    <div align="left">
		      <table border="0" cellpadding="2" cellspacing="1">
			  <tr><td width="180" align="right">每页显示日志</td><td width="300"><input name="blogpage" type="text" size="5" class="text" value="<%=config.blogpage %>"/> 篇</td></tr>
			  <tr><td width="180" align="right">每页显示评论</td><td width="300"><input name="commentpage" type="text" size="5" class="text" value="<%=config.commentpage %>"/> 篇</td></tr>
		      </table>
		    </div>
			</fieldset>
			<fieldset>
		    <legend> 用户注册与过滤</legend>
		    <div align="left">
		      <table border="0" cellpadding="2" cellspacing="1">
		  		<tr><td width="180" align="right">是否允许注册</td><td width="300"><input name="isreg" type="checkbox" value="true" <%=config.isreg.ToCheckString() %>/> </td></tr>		     <tr>
		         <td width="180" valign="top"><div align="right">注册名字过滤
		              <div class="shuom">用"|"分割需要过滤的名字</div>              
		              <div class="shuom"></div>
		          </div></td>
		          <td align="left"><textarea name="baduser" cols="50" rows="5"><%=config.baduser %></textarea></td>
		        </tr>
		        <tr>
		          <td width="180" valign="top"><div align="right">IP过滤
		              <div class="shuom">以下Ip地址将无法访问Blog</div>              
		              <div class="shuom">暂时不支持通配符</div>
		          </div></td>
		          <td align="left"><textarea name="badip" cols="50" rows="5"><%=config.badip %></textarea></td>
		        </tr>
		        <tr>
		          <td width="180" valign="top"><div align="right">关键字过滤
		              <div class="shuom">以下关键字将被替换成*</div>              
		              <div class="shuom">暂时不支持通配符和正则</div>
		          </div></td>
		          <td align="left"><textarea name="badchars" cols="50" rows="5"><%=config.badchars %></textarea></td>
		        </tr>
		     </table>
		    </div>
			</fieldset>	<div class="SubButton">
		      <input type="submit" name="Submit" value="保存配置" class="button"/> 
		     </div>
			 </form>
			 
			 </td>
		  </tr></table>
	
  </div>
 </body>
</html>
