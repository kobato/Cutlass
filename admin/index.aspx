<%@ Page Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>LevenBlog后台管理 - By Leven</title>
</head>
<frameset rows="31,*" framespacing="0" border="0" frameborder="0">
    <frame src="<%=Url.Action("head") %>" scrolling="no" name="Head" noresize>
      <frameset  id="ContentSet" rows="80,*">
      <frame src="<%=Url.Action("menu") %>">
       <frame src="<%=Url.Action("main") %>" name="MainContent" scrolling="yes" noresize>
     </frameset>
    </frameset>
</html>
