<%@ page
contentType="text/html; charset=utf-8"
import="com.google.gson.Gson"
import="tentacles.util.EasyWebGet"
import="java.io.IOException"
import="java.util.LinkedHashMap"
import="java.util.Map"
%>

<html ><head id="Head1"><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><title>

</title>
    <link href="./pop_style1_files/intuit-BaseMaster-styles" rel="stylesheet">
    <script type="text/javascript" async="" src="./pop_style1_files/ga.js"></script><script src="./pop_style1_files/intuit-BaseMaster-scripts"></script><style>.mboxDefault { visibility:hidden; }</style>
    <script language="javascript" src="./pop_style1_files/qb_win_help.js" type="text/javascript"></script>
</head>
<body>
            
            
<div id="help_header">

<%
        String clusterName = request.getParameter("cluster");


        String jsonRes = null;
        try {
            jsonRes = EasyWebGet.get("http://szwg-hadoop-nb07.szwg01.baidu.com:8800/yunrang/interface.php?r=monitor/matrixdisplay/getmnodelist&name=" + clusterName);
        } catch (IOException e) {
            e.printStackTrace();
        }
        out.println("<br><br><br><br>");
        out.println("<h1><a>Normandy queue info inspection</a></h1><br><h2></a>CLUSTER: " + clusterName + " </a></h2><br><br>");

        Map<String, Map<String, Map<String, Map<String,String>>>> resMap = new Gson().fromJson(jsonRes, LinkedHashMap.class);
        /*Map<String, Map<String, Map<String, String>>> resMap = new Gson().fromJson(jsonRes,
                new TypeToken< Map<String, Map<String, Map<String, String> >>>(){}.getType());*/
        /**
         * matrix logical node display exp: "matrix_server:user:token:service:tag"
        * */
        for (Map.Entry<String,Map<String, Map<String, Map<String,String> >>> entry : resMap.entrySet() ) {
            String mnode = entry.getKey();
            String matrix_server = mnode.split(":")[0];
            String service = mnode.split(":")[3];

            StringBuffer sb_matrix_node = new StringBuffer();
            StringBuffer sb_matrix_body = new StringBuffer();

            //System.out.println(entry.getKey());
            int total_running = 0; vcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc-0===============================================[≥vcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc-0
            int total_norunning = 0;

            /**
             * the metajson of one matirx logical node
             */
            for(Map.Entry<String, Map<String,Map<String,String>>> entry1: entry.getValue().entrySet()){
                StringBuffer sb_metajson = new StringBuffer();
                sb_metajson.append("<tr>" + "\n"
                          + "<td align=\"center\"><a expando=\"\" class=\"IPHexpando\">METAJSON</a>" + "\n"
                          + "<div class=\"expando\" style=\"border: 1px solid rgb(239, 239, 239); position: relative; width: 20%; display: none;\">"
                          + "<p>" + entry1.getKey() + "</p>" + "\n"
                          + "</div>" + "\n"
                          + "</td>" + "\n"


                          );
                //System.out.println(entry1.getKey());

                StringBuffer sb_running_head = new StringBuffer();
                StringBuffer sb_running_hosts = new StringBuffer();
                StringBuffer sb_error_head = new StringBuffer();
                StringBuffer sb_error_hosts = new StringBuffer();
                int running_num = 0;
                int error_num = 0;

                if( !entry1.getValue().isEmpty()){
                    if(entry1.getValue().containsKey("RUNNING")){

                        //System.out.println(entry1.getValue().get("RUNNING").getClass().toString());
                        for(Map.Entry<String, String> entry2: entry1.getValue().get("RUNNING").entrySet()){
                            //System.out.println(entry2.getKey() + ":" + entry2.getValue());
                            sb_running_hosts.append("<p>" + "\n"
                                       + entry2.getKey() + ":" + entry2.getValue() + "\n"
                                       + "</p>" + "\n");
                            running_num++;

                        }

                    }else if(entry1.getValue().containsKey("ERROR")){

                        //System.out.println(entry1.getValue().get("RUNNING").getClass().toString());
                        for(Map.Entry<String, String> entry2: entry1.getValue().get("ERROR").entrySet()){
                            //System.out.println(entry2.getKey() + ":" + entry2.getValue());
                            sb_error_hosts.append("<p>" + "\n"
                                    + entry2.getKey() + ":" + entry2.getValue() + "\n"
                                    + "</p>" + "\n");
                            error_num++;

                        }


                    }
                    total_running+=running_num;
                    total_norunning+=error_num;
                    sb_running_head.append("<td align=\"center\">\n"
                                    + "<a expando=\"\" class=\"IPHexpando\">RUNNING(" + Integer.toString(running_num) +")</a>\n"
                                    + "<div class=\"expando\" style=\"border: 1px solid rgb(239, 239, 239); position: relative; width: 20%; display: none;\">" + "\n"
                    );
                    sb_error_head.append("<td align=\"center\">" + "\n"
                                    + "<a expando=\"\" class=\"IPHexpando\">NOT RUNNING(" + Integer.toString(error_num) + ")</a>" + "\n"
                                    + "<div class=\"expando\" style=\"border: 1px solid rgb(239, 239, 239); position: relative; width: 20%; display: none;\">" + "\n"
                    );

                    String sb_running_hosts_res = sb_running_hosts.toString();
                    if(sb_running_hosts_res.length() > 5 ){
                        sb_running_head.append(sb_running_hosts_res);
                    }
                    String sb_error_hosts_res = sb_error_hosts.toString();
                    if(sb_error_hosts_res.length() > 5 ) {
                        sb_error_head.append(sb_error_hosts_res);
                    }

                    sb_running_head.append("</div>" + "\n" + "</td>" + "\n");
                    sb_error_head.append("</div>" + "\n" + "</td>" + "\n");
                }
                sb_metajson.append(sb_running_head.toString());
                sb_metajson.append(sb_error_head.toString());
                sb_metajson.append("</tr>");
                sb_matrix_body.append(sb_metajson.toString());
            }
            String head_html = "<h3><a href=http://" + matrix_server + ":8529/servicedetail.jsp?serviceName="
                    + service + ">" + mnode + "</a><a><font color=red >  Run/NoRun:   " + total_running + "/" + total_norunning 
                    + "</a></h3></div>" + "\n" + "<table border=0 cellpadding=0 cellspacing=0>" ;
            sb_matrix_node.append(head_html);
            sb_matrix_node.append(sb_matrix_body);
            sb_matrix_node.append("</table>");
            sb_matrix_node.append("<br><br>");
            out.println(sb_matrix_node.toString());

        }




%>
<script language="javascript">var inProduct = 'False'; var userSku = 'pro';if(window.doStartup){doStartup()}</script>
      
</body></html>
