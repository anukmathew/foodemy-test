-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_CoursePackage" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "description" TEXT,
    "streamInfo" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "categoryId" TEXT NOT NULL,
    "sortOrder" INTEGER NOT NULL DEFAULT 0,
    CONSTRAINT "CoursePackage_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "CourseCategory" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_CoursePackage" ("categoryId", "createdAt", "description", "id", "isActive", "name", "slug", "streamInfo", "updatedAt") SELECT "categoryId", "createdAt", "description", "id", "isActive", "name", "slug", "streamInfo", "updatedAt" FROM "CoursePackage";
DROP TABLE "CoursePackage";
ALTER TABLE "new_CoursePackage" RENAME TO "CoursePackage";
CREATE UNIQUE INDEX "CoursePackage_slug_key" ON "CoursePackage"("slug");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
