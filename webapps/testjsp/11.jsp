<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<form name="op" action="./333.jsp" method="post">
<title>test</title>
<style type="text/css">
.ct{
text-align:center;
}
</style>
<%@ page
import="tentacles.util.*"
import="net.sf.json.JSONArray"
%>
<script type="text/javascript">
function allCheck(){
    var obj=document.getElementsByTagName("input");
    if(document.getElementById("all").checked==true){
        for(var i=0;i<obj.length;i++){
            obj[i].checked=true;
        }
    }else{
        for(var i=0;i<obj.length;i++){
            obj[i].checked=false;
        }
    }
}
function checkT_F(){
    var obj=document.getElementsByTagName("input");
    var j=0;
    for(var i=0;i<obj.length;i++){
        if(obj[i].id!='all'){   
            if(obj[i].checked==true){  
                j++;
            }
        }
    }
    if(j==(obj.length-1)){   
        document.getElementById("all").checked=true;
    }else{
        document.getElementById("all").checked=false;
    }
}
</script>
</head>
<body>
<input onclick="javascript:checkT_F()">
<div>
    <div class="zuo">
   <div><input type="checkbox" id="all"  onclick="javascript:allCheck()"/>all</div>
   </div>
    <%
      String clusterName = request.getParameter("cluster");
      get_single_phy single=new get_single_phy();
      JSONArray singletest=single.get_phy(clusterName);
     String[] a=new String[singletest.toString().split(",").length];
      for (int j=0;j<singletest.toString().split(",").length;j++)
       {  a[j]=singletest.toString().replace("\"","").replace("[","").replace("]","").split(",")[j];
          }
    for(int i=0;i<singletest.toString().split(",").length;i++) {
    %><div><input type="checkbox" name="phy" value="<%=a[i]%>">[<%=a[i]%>]</div><%
    }
 %>
 </div>
  <label class="checkbox-inline">
      <input type="radio" name="choose" id="large"
         value="<%=clusterName%>l" checked>全量 </input>
   </label>
   <label class="checkbox-inline">
      <input type="radio" name="choose" id="small"
         value="<%=clusterName%>s">小流量</input>
   </label>
   <label class="checkbox-inline">
      <input type="radio" name="choose" id="small"
         value="<%=clusterName%>e">error拉起</input>
   </label>
<input type ="submit" value ="下一步">
</body>
</html>
