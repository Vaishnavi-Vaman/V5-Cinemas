package com.V5.Schedular;

import com.V5.dao.user.FeedbackDAO;
import com.V5.dto.user.RatingRequest;
import com.V5.util.FeedbackMailUtil;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.util.List;
import java.util.concurrent.*;

@WebListener
public class FeedbackScheduler implements ServletContextListener {

    private ScheduledExecutorService exec;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        exec = Executors.newSingleThreadScheduledExecutor();
        // Run immediately at startup, then every 5 minutes
        exec.scheduleAtFixedRate(this::tick, 0, 5, TimeUnit.MINUTES);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (exec != null) {
            exec.shutdownNow();
        }
    }

    private void tick() {
        try {
            FeedbackDAO dao = new FeedbackDAO();
            List<RatingRequest> pending = dao.getPendingFeedbackRequests();

            for (RatingRequest r : pending) {
                try {
                    FeedbackMailUtil.sendFeedbackMail(r);
                    dao.markFeedbackSent(r.getBookingId()); // mark once mail sent
                } catch (Exception mailEx) {
                    mailEx.printStackTrace(); // log and continue
                }
            }
        } catch (Exception e) {
            e.printStackTrace(); // log
        }
    }
}
