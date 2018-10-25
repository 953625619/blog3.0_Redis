package com.lh.server;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;

@ServerEndpoint("/ws/online")
public class CountServer {
    private Session session;

    @OnOpen
    public void open(Session session)
    {
        this.session = session;
        ServerManager.add(this);
    }

    @OnClose
    public void close()
    {
        ServerManager.remove(this);
    }

    @OnMessage
    public void sendMessage(String msg)
    {
        try {
            session.getBasicRemote().sendText(msg);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    @OnError
    public void error(Throwable throwable)
    {
        throwable.printStackTrace();
    }
}
