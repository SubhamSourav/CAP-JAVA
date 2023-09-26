
DROP VIEW IF EXISTS TaskService_Tasks;
DROP TABLE IF EXISTS sap_ui_taskmanagement_Tasks;

CREATE TABLE sap_ui_taskmanagement_Tasks (
  createdAt TIMESTAMP(7),
  createdBy NVARCHAR(255),
  modifiedAt TIMESTAMP(7),
  modifiedBy NVARCHAR(255),
  ID NVARCHAR(36) NOT NULL,
  title NVARCHAR(100),
  descr NVARCHAR(255),
  dueDate DATE,
  status NVARCHAR(255),
  criticality INTEGER,
  PRIMARY KEY(ID)
); 

CREATE VIEW TaskService_Tasks AS SELECT
  Tasks_0.createdAt,
  Tasks_0.createdBy,
  Tasks_0.modifiedAt,
  Tasks_0.modifiedBy,
  Tasks_0.ID,
  Tasks_0.title,
  Tasks_0.descr,
  Tasks_0.dueDate,
  Tasks_0.status,
  Tasks_0.criticality
FROM sap_ui_taskmanagement_Tasks AS Tasks_0; 

