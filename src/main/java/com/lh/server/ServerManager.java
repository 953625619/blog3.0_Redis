package com.lh.server;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;

public class ServerManager {
    private static Collection<CountServer> collection = Collections.synchronizedCollection(new ArrayList<CountServer>());

    public static void add(CountServer server){
        collection.add(server);
    }

    public static void remove(CountServer server)
    {
        collection.remove(server);
    }

    public static void broadCast(String msg)
    {
        for (CountServer server:
             collection) {
                server.sendMessage(msg);
        }
    }

    public static int getTotal(){
        return collection.size();
    }
}
