-- CreateTable
CREATE TABLE "User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "role" TEXT NOT NULL,
    "employeeId" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "Project" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "projectCode" TEXT NOT NULL,
    "isBillable" BOOLEAN NOT NULL
);

-- CreateTable
CREATE TABLE "TaskProcess" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "processCode" INTEGER NOT NULL,
    "processName" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "WorkLocation" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "locationCode" TEXT NOT NULL,
    "locationName" TEXT NOT NULL,
    "startTime" DATETIME NOT NULL,
    "endTime" DATETIME NOT NULL,
    "timeInterval" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "TimesheetEntry" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "employeeId" INTEGER NOT NULL,
    "projectCode" TEXT NOT NULL,
    "processCode" INTEGER NOT NULL,
    "locationCode" TEXT NOT NULL,
    "startTime" DATETIME NOT NULL,
    "endTime" DATETIME NOT NULL,
    "taskDescription" TEXT,
    CONSTRAINT "TimesheetEntry_employeeId_fkey" FOREIGN KEY ("employeeId") REFERENCES "User" ("employeeId") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "TimesheetEntry_projectCode_fkey" FOREIGN KEY ("projectCode") REFERENCES "Project" ("projectCode") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "TimesheetEntry_processCode_fkey" FOREIGN KEY ("processCode") REFERENCES "TaskProcess" ("processCode") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "TimesheetEntry_locationCode_fkey" FOREIGN KEY ("locationCode") REFERENCES "WorkLocation" ("locationCode") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_employeeId_key" ON "User"("employeeId");

-- CreateIndex
CREATE UNIQUE INDEX "Project_projectCode_key" ON "Project"("projectCode");

-- CreateIndex
CREATE UNIQUE INDEX "TaskProcess_processCode_key" ON "TaskProcess"("processCode");

-- CreateIndex
CREATE UNIQUE INDEX "WorkLocation_locationCode_key" ON "WorkLocation"("locationCode");
