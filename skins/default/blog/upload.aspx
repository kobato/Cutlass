<%@ Page Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" %>

<%
    string skinpath = ViewData["skinpath"] as string;
    string uploadMessage = ViewData["uploadmessage"] as string;
    string filename=ViewData["filename"] as string;
    int? fileid = ViewData["fileid"] as int?;
    string fileUrl = ViewData["fileurl"] as String;
    if (skinpath == null)
    {
        throw new ArgumentNullException("ViewData[\"skinpath\"]");
    }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>LevenBlog2.0 - 文件上传页面</title>
    <link type="text/css" href="<%=Url.Content("~/" + skinpath + "images/style.css") %>" rel="Stylesheet" />
    <script type="text/javascript">
    //<!--
        function IsIframe(par)
        {
            if(top.location==self.location)
            {
                window.alert("该文件不能在浏览器中直接打开");
                //window.alert(self.location);
                window.location='<%=Url.Action("index", "blog") %>';
                return;
            }
        }
        window.onload=function InitPage(){
            IsIframe();
        }
        function AddFile(fID, extName, fileUrl) {
            parent.AddFiles(fID, extName, fileUrl);
        }
    //-->
    </script>
</head>
<body>
<%if(string.IsNullOrEmpty(uploadMessage)){ %>
<div style="text-align:left">
    <form id="uploadform" accept="<%=Url.Action("upload") %>" method="post" enctype="multipart/form-data">
    <input name="file" type="file" size="50" style="font-size:12px;border-width:1px">&nbsp;<input type="Submit" name="Submit" value="确定上传" class="userbutton">
    </form>
</div>
<%}else{ %>
<div style="text-align:left">
<span><%=uploadMessage.Replace("{$backurl}",Url.Action("upload")) %></span>
<%if (!string.IsNullOrEmpty(filename))
  { %>
  <script type="text/javascript">
    AddFile(<%=fileid.Value %>,'<%=filename %>', "<%=fileUrl %>");
  </script>
<%} %>
</div>
<%} %>
</body>
</html>
