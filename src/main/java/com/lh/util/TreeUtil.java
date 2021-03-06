package com.lh.util;

import java.util.*;

public class TreeUtil {
    //树形结构数据转化
    public static List<Map<String, Object>> treeViewDataTransform(List<Map<String, Object>> dataList) {

        List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
        List<String> rootNodeId = new ArrayList<>();
        for (int i = 0; i < dataList.size(); i++) {
            if (dataList.get(i).get("parent_id").toString().equals("0")) {
                rootNodeId.add(dataList.get(i).get("id").toString());
            }
        }
        for (int n = 0; n < dataList.size(); n++) {
            for (int a = 0; a < rootNodeId.size(); a++) {
                Map<String, Object> temp = new HashMap<String, Object>();
                if (dataList.get(n).get("parent_id").toString().equals(rootNodeId.get(a))) {
                    temp.put("text", dataList.get(n).get("layer_name").toString());
                    temp.put("id", dataList.get(n).get("id").toString());
                    temp.put("state", dataList.get(n).get("state"));
                    List<Map<String, Object>> bList = new ArrayList<Map<String, Object>>();
                    for (int m = 0; m < dataList.size(); m++) {
                        Map<String, Object> bTemp = new HashMap<String, Object>();
                        if (dataList.get(m).get("parent_id").toString().equals(dataList.get(n).get("id").toString())) {
                            bTemp.put("text", dataList.get(m).get("layer_name").toString());
                            bTemp.put("id", dataList.get(m).get("id").toString());
                            bTemp.put("state", dataList.get(m).get("state"));
                            List<Map<String, Object>> cList = new ArrayList<Map<String, Object>>();
                            for (int t = 0; t < dataList.size(); t++) {
                                Map<String, Object> cTemp = new HashMap<String, Object>();
                                if (dataList.get(t).get("parent_id").toString().equals(dataList.get(m).get("id").toString())) {
                                    cTemp.put("text", dataList.get(t).get("layer_name").toString());
                                    cTemp.put("id", dataList.get(t).get("id").toString());
                                    cTemp.put("state", dataList.get(t).get("state"));
                                }
                                if (!cTemp.isEmpty()) {
                                    cList.add(cTemp);
                                }
                            }
                            if (!cList.isEmpty()) {
                                bTemp.put("nodes", cList);
                            }
                        }
                        if (!bTemp.isEmpty()) {
                            bList.add(bTemp);
                        }
                    }
                    if (!bList.isEmpty()) {
                        temp.put("nodes", bList);
                    }
                }
                if (!temp.isEmpty()) {
                    resultList.add(temp);
                }

            }
        }
            return resultList;
    }
}
