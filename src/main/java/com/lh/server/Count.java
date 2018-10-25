package com.lh.server;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import java.util.Random;

@WebServlet(name = "Count",urlPatterns = "/Count",loadOnStartup = 1)
public class Count extends HttpServlet implements Runnable {
    ServletContext context;
    public void init(ServletConfig config)
    {
        startup();
        context = config.getServletContext();

    }
    public void startup()
    {
        new Thread(this).start();
    }
    @Override
    public void run()
    {
        while (true)
        {
            int duration = 5000+new Random().nextInt(10000);
            try {
                Thread.sleep(duration);
            } catch (InterruptedException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            int total = ServerManager.getTotal();
            String messageFormat = "{\"total\":%d}";
            String message = String.format(messageFormat,total);
            //广播出去
            ServerManager.broadCast(message);
        }

    }
}
