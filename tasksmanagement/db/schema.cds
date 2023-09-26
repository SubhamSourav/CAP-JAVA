namespace sap.ui.taskmanagement;

using { managed } from '@sap/cds/common';

entity Tasks : managed {
    key ID          : UUID @(Core.Computed: true);
    title           : String(100);
    descr           : String;
    dueDate         : Date;
    status          : String enum{
                new;
        in_progress = 'in-progress';
        completed; 
    };
    criticality     : Integer;
}
