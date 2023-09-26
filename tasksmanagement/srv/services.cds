using { sap.ui.taskmanagement as db } from '../db/schema';
// @path: 'service/task'

service TaskService {

    entity Tasks as projection on db.Tasks;
    // annotate Tasks with @odata.draft.enabled;

}

