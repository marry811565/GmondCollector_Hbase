<%@ page
import="com.baidu.inf.matrix.master.rpc.masterclientproto.ThriftInstanceMeta"
import="com.google.gson.Gson"
        import="com.google.gson.GsonBuilder"
import="org.apache.thrift.TException"
import="tentacles.matrix_util.GetInstanceMetaInService"
import="org.apache.thrift.transport.TTransportException"
import="tentacles.matrix_util.GetMultiMetaInstance"
import="tentacles.util.Get_Conf_Concurrent"
import="tentacles.util.*"
import="tentacles.http_tools.*"
import="java.io.PrintWriter"
import="java.io.StringWriter"
import="java.util.HashMap"
import="java.util.List"
import="java.util.Map"
import="java.util.Date"
import="java.util.regex.Matcher"
import="java.util.regex.Pattern"

%>
<%
        String old="thread\":{\"quota\":0,\"limit\":0}";
        String old_change="thread\":{\"quota\":0,\"limit\":-1}";


        String clustername=request.getParameter("cluster");
        String normandyTag=request.getParameter("phy");
          String host=request.getParameter("host");
            String []phy=new String[1];
             phy[0]=normandyTag;
              // get_single_phy testnode=new get_single_phy();
                 get_single_phy single=new get_single_phy();
              List testhui=single.get_phy_single(clustername,phy);
              GetMatrixNodeByClusterTag testhh=new GetMatrixNodeByClusterTag();
               Map<String, Map<Object,Map<String,Map<String,Object>>>> resultmap=testhh.GetMatrixNode(testhui);
           Object metajson=null;   
           // Object metajson=resultmap.getValue(normandyTag);
               // Object metajson=testss.GetMatrixNode(clustername,normandyTag);
                    for (Map.Entry<String, Map<Object,Map<String,Map<String,Object>>>> entry : resultmap.entrySet() )
        {
             //i++;
            //System.out.println("i is" +i);
             //System.out.println("come metajson");
           // System.out.println(entry.getKey());
              //System.out.println(entry.getKey().toString().split(":").length);
          //  System.out.println(entry.getKey().toString().split(":")[entry.getKey().toString().split(":").length-1]);
            Map<Object,Map<String,Map<String,Object>> > metaInstance = entry.getValue();
            for ( Map.Entry<Object,Map<String,Map<String,Object>>> entry1 : metaInstance.entrySet())
            {
                  StringBuffer scheduler = new StringBuffer();
                metajson=entry1.getKey();
                 //  out.println(entry1.getKey());
        //        for ( Map.Entry<String,Map<String,Object>> entryChild : entry1.getValue().entrySet() ) {
        //           scheduler.append(entryChild.getKey()+"\n");
                  //System.out.println("come host");
             //       System.out.println(entryChild.getKey());
//                    System.out.println(entryChild.getValue().get("State"));
//                    System.out.println(entryChild.getValue().get("ErrorCode"));
          //      }
                 //System.out.println(scheduler);
                // System.out.println("come host");
            }
        }

          //out.println(metajson);
            Gson testgson=new Gson();

                // ThriftInstanceMeta metatest=testgson.fromJson(metajson.toString(), ThriftInstanceMeta.class);

                                                 //  System.out.println(new_rand_version);


                SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-kk_HH-mm-ss");
                String nowTime = df.format(new Date());
                String org=metajson.toString();
                Gson gs = new GsonBuilder().disableHtmlEscaping().create();

                ThriftInstanceMeta oldMj= gs.fromJson(org,ThriftInstanceMeta.class);
                ThriftInstanceMeta newMj= gs.fromJson(org,ThriftInstanceMeta.class);
                String oldPackageSource = oldMj.getPackageSource().toString();
                String oldVersion = oldMj.getPackageVersion().toString();
                newMj.setPackageSource("http://fakeadress/forturnaround");
                newMj.setPackageVersion(nowTime);
                out.println(gs.toJson(newMj));
                oldMj.setPackageSource(oldPackageSource);
                oldMj.setPackageVersion(oldVersion);
                out.println(gs.toJson(oldMj));



//                String meta_power_str=metajson.toString().replace(old_package,new_rand_version).replace(old,old_change);



//out.println(meta_power_str);



//
              String meta_power_over_str=metajson.toString().replace(new_rand_version,old_package).replace(old,old_change);



                ThriftInstanceMeta meta_power=newMj;
//             testgson.fromJson(meta_power_str, ThriftInstanceMeta.class);


                ThriftInstanceMeta meta_power_over=oldMj;
//        testgson.fromJson(meta_power_over_str, ThriftInstanceMeta.class);


                matrix_clientop clientop=new matrix_clientop();
                get_host get_host=new get_host();
                get_single_phy single_phy=new get_single_phy();
                List node=single_phy.get_phy_single(clustername,phy);
                int[] offset=new int[get_host.get_host_ip(host).toString().split(" ").length];
                String matrix_service=node.toString().split(":")[0].substring(1,node.toString().split(":")[0].length());
                String user=node.toString().split(":")[2];
                String token=node.toString().split(":")[3];
                String serviceName=node.toString().split(":")[4];
                   try {
                           clientop.matrix_client_open(matrix_service);
                            }
                           catch ( TTransportException e)
                           {
                            StringWriter sw = new StringWriter();
                            PrintWriter pw = new PrintWriter(sw);
                            e.printStackTrace(pw);
                            out.println(sw.toString());
                            }
                              int host_length=get_host.get_host_ip(host).toString().split(" ").length;
                                    for (int i=0;i<host_length;i++) {
                                    offset[i] = Integer.valueOf(get_host.get_host_ip(host).toString().replace(".", "").split(" ")[i]).intValue();
                                 //out.  
                                  try{
                                    clientop.matrix_update(user,token,serviceName,offset[i],meta_power);
                                   //Thread.sleep(60000); 
                                   clientop.matrix_update(user,token,serviceName,offset[i],meta_power_over);
                                  //  out.println("update"+offset[i]+"success");
                                  out.println("power_update" +get_host.get_host_ip(host).toString().split(" ")[i]  + "success");
                                   }catch (TException e){
                                    StringWriter sw = new StringWriter();
                                    PrintWriter pw = new PrintWriter(sw);
                                   e.printStackTrace(pw);
                                    out.println(sw.toString());
                                    }
                                    }

        %>
