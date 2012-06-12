<%@ Page Language="C#" MasterPageFile="~/skins/mono/shared/blog.master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage, System.Web.Mvc" %>


<asp:Content ID="ReginfoContent" ContentPlaceHolderID="BlogContent" runat="server" EnableViewState="false">

<br/><br/>
   <div style="text-align:center;">
  <form name="aform" action="login.asp" method="post">
    <div id="MsgContent">
      <div id="MsgHead">用户注册</div>
      <div id="MsgBody">
	  <div style="text-align:left;line-height:120%;">为维护网上公共秩序和社会稳定，请您自觉遵守以下条款： <br/><br/>

　 一、不得利用本站危害国家安全、泄露国家秘密，不得侵犯国家社会集体的和公民的合法权益，不得利用本站制作、复制和传播下列信息：<br/> 
　　 （一）煽动抗拒、破坏宪法和法律、行政法规实施的； <br/>
　　 （二）煽动颠覆国家政权，推翻社会主义制度的； <br/>
　　 （三）煽动分裂国家、破坏国家统一的； <br/>
　　 （四）煽动民族仇恨、民族歧视，破坏民族团结的； <br/>
　　 （五）捏造或者歪曲事实，散布谣言，扰乱社会秩序的； <br/>
　　 （六）宣扬封建迷信、淫秽、色情、赌博、暴力、凶杀、恐怖、教唆犯罪的； <br/>
　　 （七）公然侮辱他人或者捏造事实诽谤他人的，或者进行其他恶意攻击的；<br/> 
　　 （八）损害国家机关信誉的； <br/>
　　 （九）其他违反宪法和法律行政法规的； <br/>
　　 （十）进行商业广告行为的。 <br/>
　 二、互相尊重，对自己的言论和行为负责。 <br/><br/></div>
	   <input type="button" name="agreesubmit" value="我同意" class="userbutton" onclick="location='<%=Url.RouteUrl(new { controller = "user", action = "reg", step = "2" }) %>'"/>
	   </div>
	</div>
  </form>
  </div><br/><br/>
 <script language="javascript">
var secs = 3;
var wait = secs * 1000;
var agreetext=" 我同意 ";
document.aform.agreesubmit.value = agreetext+"(" + secs + ") ";
document.aform.agreesubmit.disabled = true;
for(i = 1; i <= secs; i++) {
  window.setTimeout("update(" + i + ")", i * 1000);
}
window.setTimeout("timer()", wait);
function update(num, value) {
  if(num == (wait/1000)) {
    document.aform.agreesubmit.value = agreetext;
  } else {
    printnr = (wait / 1000)-num;
    document.aform.agreesubmit.value = agreetext+"(" + printnr + ") ";
  }
}
function timer() {
  document.aform.agreesubmit.disabled = false;
  document.aform.agreesubmit.value = agreetext;
}
</script>

</asp:Content>