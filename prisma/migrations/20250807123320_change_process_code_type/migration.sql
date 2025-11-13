-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_TaskProcess" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "processCode" TEXT NOT NULL,
    "processName" TEXT NOT NULL
);
INSERT INTO "new_TaskProcess" ("id", "processCode", "processName") SELECT "id", "processCode", "processName" FROM "TaskProcess";
DROP TABLE "TaskProcess";
ALTER TABLE "new_TaskProcess" RENAME TO "TaskProcess";
CREATE UNIQUE INDEX "TaskProcess_processCode_key" ON "TaskProcess"("processCode");
CREATE TABLE "new_TimesheetEntry" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "employeeId" INTEGER NOT NULL,
    "projectCode" TEXT NOT NULL,
    "processCode" TEXT NOT NULL,
    "locationCode" TEXT NOT NULL,
    "startTime" DATETIME NOT NULL,
    "endTime" DATETIME NOT NULL,
    "taskDescription" TEXT,
    CONSTRAINT "TimesheetEntry_employeeId_fkey" FOREIGN KEY ("employeeId") REFERENCES "User" ("employeeId") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "TimesheetEntry_projectCode_fkey" FOREIGN KEY ("projectCode") REFERENCES "Project" ("projectCode") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "TimesheetEntry_processCode_fkey" FOREIGN KEY ("processCode") REFERENCES "TaskProcess" ("processCode") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "TimesheetEntry_locationCode_fkey" FOREIGN KEY ("locationCode") REFERENCES "WorkLocation" ("locationCode") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_TimesheetEntry" ("employeeId", "endTime", "id", "locationCode", "processCode", "projectCode", "startTime", "taskDescription") SELECT "employeeId", "endTime", "id", "locationCode", "processCode", "projectCode", "startTime", "taskDescription" FROM "TimesheetEntry";
DROP TABLE "TimesheetEntry";
ALTER TABLE "new_TimesheetEntry" RENAME TO "TimesheetEntry";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
