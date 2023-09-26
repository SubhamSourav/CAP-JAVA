package sap.ui.tasksmanagement.handlers;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.config.Task;

import cds.gen.sap.ui.taskmanagement.Tasks;
import cds.gen.taskservice.TaskService_;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.persistence.PersistenceService;

import org.springframework.stereotype.Component;

import cds.gen.taskservice.Tasks_;

import com.sap.cds.ql.Select;
import com.sap.cds.ql.Update;
import com.sap.cds.ql.cqn.CqnSelect;
import com.sap.cds.ql.cqn.CqnUpdate;
import com.sap.cds.services.ErrorStatuses;
import com.sap.cds.services.ServiceException;
import com.sap.cds.services.cds.CqnService;
import com.sap.cds.services.handler.annotations.Before;

@Component
@ServiceName(TaskService_.CDS_NAME)
public class TaskService implements EventHandler {
    
@Autowired
PersistenceService db;

@Before(event =  {CqnService.EVENT_READ},entity = Tasks_.CDS_NAME)

public void addCriticality() {
    CqnSelect tasks = Select.from(Tasks_.class);
    List<Tasks> allTasks = db.run(tasks).listOf(Tasks.class);
    for (Tasks task : allTasks) {

        String status = task.getStatus();
        System.out.println(status);

        if(status.equals("new")){
            task.setCriticality(1);
        }else if(status.equals("in-progress")){
            task.setCriticality(2);
        }else if(status.equals("completed")){
            task.setCriticality(3);
        }

        // Update the task with the modified criticality
        CqnUpdate update = Update.entity(Tasks_.class)
                .data(task)
                .where(t->t.ID().eq(task.getId())); // Assuming you have an ID field

        try {
            db.run(update);
        } catch (ServiceException e) {
            // Handle any exceptions if the update fails
            throw new ServiceException("Failed to update task: " + e.getMessage(), e);
        }
    }
}

}
