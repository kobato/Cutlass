<%@ Page Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>热门标签选择</title>
    <style type="text/css">
    body{margin:0px;background:#F1F1E3;border-width:0px}
	 #Top{background:#E3E3C7;border-bottom:1px solid #D5D59D;padding:8px;color:#737357;font-size:18px}
	 #Mid{height:250px;overflow:auto}
	 #Bottom{background:#E3E3C7;border-top:1px solid #D5D59D;padding:8px;color:#737357;text-align:right}
	 input{border:1px solid #737357;color:#3B3B1F;background:#C7C78F;font-size:12px;}
	 .tagA:link,.tagA:visited{
	   display:block;
	   background:#D7D79F;
	   padding:4px;
	   font-size:12px;
	   color:#3B3B1F;
	   margin:4px;
	   border:1px solid #D7D79F;
	   text-decoration:none;
	 }
	 .tagA:hover{
	   background:#EFEFDA;
	   border:1px solid #D7D79F;
	 }
    </style>
    <script type="text/javascript">
    function addTag(tagName) {
	     if (opener) {
	       var getTagObj=opener.document.forms[0].tags
	       var tags
	       if (getTagObj.value.length>0) {
	         tags=getTagObj.value.split(",")
	         for (i=0;i<tags.length;i++){
	           if (tags[i].toLowerCase()==tagName.toLowerCase()) return 
	         }
	         getTagObj.value+=","+tagName
	       }
	       else{
	         getTagObj.value+=tagName
	       }
	     }
	   }
    </script>
</head>
<%
    IList<lb_tag> tags = ViewData.Model as IList<lb_tag>;
    if (tags == null)
    {
        throw new ArgumentNullException("ViewData.Model");
    }
%>
<body>
    <div id="Top"><b>插入已经存在的Tag</b></div>
	     <div id="Mid">
	     <%
                foreach (lb_tag tag in tags)
                {
                    Response.Write(string.Format("<a href=\"#\"  class=\"tagA\" onclick=\"addTag('{0}');\" title=\"添加\"><strong>{1}</strong>[{2}]</a>\r\n", tag.name, tag.name, tag.num));
                } 
            %>
	       
	     </div>
		<div id="Bottom">
		  <input type="button" value="关闭" onclick="window.close()"/>
		</div>
</body>
</html>
