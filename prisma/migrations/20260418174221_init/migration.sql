-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "email" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "name" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "Note" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "title" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "ownerId" TEXT NOT NULL,
    CONSTRAINT "Note_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "NoteImage" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "altText" TEXT,
    "objectKey" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "noteId" TEXT NOT NULL,
    CONSTRAINT "NoteImage_noteId_fkey" FOREIGN KEY ("noteId") REFERENCES "Note" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "UserImage" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "altText" TEXT,
    "objectKey" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "userId" TEXT NOT NULL,
    CONSTRAINT "UserImage_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Password" (
    "hash" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    CONSTRAINT "Password_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Session" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "expirationDate" DATETIME NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "userId" TEXT NOT NULL,
    CONSTRAINT "Session_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Permission" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "action" TEXT NOT NULL,
    "entity" TEXT NOT NULL,
    "access" TEXT NOT NULL,
    "description" TEXT NOT NULL DEFAULT '',
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "Role" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL DEFAULT '',
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "Verification" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "type" TEXT NOT NULL,
    "target" TEXT NOT NULL,
    "secret" TEXT NOT NULL,
    "algorithm" TEXT NOT NULL,
    "digits" INTEGER NOT NULL,
    "period" INTEGER NOT NULL,
    "charSet" TEXT NOT NULL,
    "expiresAt" DATETIME
);

-- CreateTable
CREATE TABLE "Connection" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "providerName" TEXT NOT NULL,
    "providerId" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "userId" TEXT NOT NULL,
    CONSTRAINT "Connection_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Passkey" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "aaguid" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "publicKey" BLOB NOT NULL,
    "userId" TEXT NOT NULL,
    "webauthnUserId" TEXT NOT NULL,
    "counter" BIGINT NOT NULL,
    "deviceType" TEXT NOT NULL,
    "backedUp" BOOLEAN NOT NULL,
    "transports" TEXT,
    CONSTRAINT "Passkey_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "CourseCategory" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "description" TEXT,
    "generalInfo" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true
);

-- CreateTable
CREATE TABLE "WhatYouWillGet" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "iconUrl" TEXT,
    "sortOrder" INTEGER NOT NULL DEFAULT 0
);

-- CreateTable
CREATE TABLE "CoursePackage" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "description" TEXT,
    "streamInfo" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "categoryId" TEXT NOT NULL,
    "sortOrder" INTEGER NOT NULL,
    CONSTRAINT "CoursePackage_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "CourseCategory" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Subject" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "name" TEXT NOT NULL,
    "abbreviation" TEXT NOT NULL,
    "description" TEXT,
    "sortOrder" INTEGER NOT NULL DEFAULT 0,
    "isActive" BOOLEAN NOT NULL DEFAULT true
);

-- CreateTable
CREATE TABLE "Topic" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "sortOrder" INTEGER NOT NULL DEFAULT 0,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "subjectId" TEXT NOT NULL,
    CONSTRAINT "Topic_subjectId_fkey" FOREIGN KEY ("subjectId") REFERENCES "Subject" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "VideoLecture" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "url" TEXT,
    "demoUrl" TEXT,
    "duration" INTEGER NOT NULL,
    "sortOrder" INTEGER NOT NULL DEFAULT 0,
    "lastUpdated" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "topicId" TEXT NOT NULL,
    CONSTRAINT "VideoLecture_topicId_fkey" FOREIGN KEY ("topicId") REFERENCES "Topic" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "StudyMaterial" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "url" TEXT,
    "demoUrl" TEXT,
    "pages" INTEGER NOT NULL,
    "sortOrder" INTEGER NOT NULL DEFAULT 0,
    "lastUpdated" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "topicId" TEXT NOT NULL,
    CONSTRAINT "StudyMaterial_topicId_fkey" FOREIGN KEY ("topicId") REFERENCES "Topic" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Module" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "sortOrder" INTEGER NOT NULL DEFAULT 0,
    "packageId" TEXT NOT NULL,
    CONSTRAINT "Module_packageId_fkey" FOREIGN KEY ("packageId") REFERENCES "CoursePackage" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "YearlyProduct" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "year" INTEGER NOT NULL,
    "displayName" TEXT NOT NULL,
    "price" INTEGER NOT NULL,
    "discountedPrice" INTEGER,
    "accessEndsAt" DATETIME NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "packageId" TEXT NOT NULL,
    CONSTRAINT "YearlyProduct_packageId_fkey" FOREIGN KEY ("packageId") REFERENCES "CoursePackage" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Batch" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "name" TEXT NOT NULL,
    "startDate" DATETIME NOT NULL,
    "endDate" DATETIME NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "yearlyProductId" TEXT NOT NULL,
    CONSTRAINT "Batch_yearlyProductId_fkey" FOREIGN KEY ("yearlyProductId") REFERENCES "YearlyProduct" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "BatchModule" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "releaseDate" DATETIME NOT NULL,
    "batchId" TEXT NOT NULL,
    "moduleId" TEXT NOT NULL,
    CONSTRAINT "BatchModule_batchId_fkey" FOREIGN KEY ("batchId") REFERENCES "Batch" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "BatchModule_moduleId_fkey" FOREIGN KEY ("moduleId") REFERENCES "Module" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Purchase" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "snapshotName" TEXT NOT NULL,
    "snapshotYear" INTEGER NOT NULL,
    "amountPaid" INTEGER NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'INR',
    "status" TEXT NOT NULL DEFAULT 'COMPLETED',
    "paymentRef" TEXT,
    "purchasedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" TEXT NOT NULL,
    "yearlyProductId" TEXT NOT NULL,
    CONSTRAINT "Purchase_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Purchase_yearlyProductId_fkey" FOREIGN KEY ("yearlyProductId") REFERENCES "YearlyProduct" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Enrollment" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "joinedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" TEXT NOT NULL,
    "batchId" TEXT NOT NULL,
    CONSTRAINT "Enrollment_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Enrollment_batchId_fkey" FOREIGN KEY ("batchId") REFERENCES "Batch" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_PermissionToRole" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,
    CONSTRAINT "_PermissionToRole_A_fkey" FOREIGN KEY ("A") REFERENCES "Permission" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_PermissionToRole_B_fkey" FOREIGN KEY ("B") REFERENCES "Role" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_RoleToUser" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,
    CONSTRAINT "_RoleToUser_A_fkey" FOREIGN KEY ("A") REFERENCES "Role" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_RoleToUser_B_fkey" FOREIGN KEY ("B") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_CourseCategoryToWhatYouWillGet" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,
    CONSTRAINT "_CourseCategoryToWhatYouWillGet_A_fkey" FOREIGN KEY ("A") REFERENCES "CourseCategory" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_CourseCategoryToWhatYouWillGet_B_fkey" FOREIGN KEY ("B") REFERENCES "WhatYouWillGet" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_CoursePackageToSubject" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,
    CONSTRAINT "_CoursePackageToSubject_A_fkey" FOREIGN KEY ("A") REFERENCES "CoursePackage" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_CoursePackageToSubject_B_fkey" FOREIGN KEY ("B") REFERENCES "Subject" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_ModuleToTopic" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,
    CONSTRAINT "_ModuleToTopic_A_fkey" FOREIGN KEY ("A") REFERENCES "Module" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_ModuleToTopic_B_fkey" FOREIGN KEY ("B") REFERENCES "Topic" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");

-- CreateIndex
CREATE INDEX "Note_ownerId_idx" ON "Note"("ownerId");

-- CreateIndex
CREATE INDEX "Note_ownerId_updatedAt_idx" ON "Note"("ownerId", "updatedAt");

-- CreateIndex
CREATE INDEX "NoteImage_noteId_idx" ON "NoteImage"("noteId");

-- CreateIndex
CREATE UNIQUE INDEX "UserImage_userId_key" ON "UserImage"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Password_userId_key" ON "Password"("userId");

-- CreateIndex
CREATE INDEX "Session_userId_idx" ON "Session"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Permission_action_entity_access_key" ON "Permission"("action", "entity", "access");

-- CreateIndex
CREATE UNIQUE INDEX "Role_name_key" ON "Role"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Verification_target_type_key" ON "Verification"("target", "type");

-- CreateIndex
CREATE UNIQUE INDEX "Connection_providerName_providerId_key" ON "Connection"("providerName", "providerId");

-- CreateIndex
CREATE INDEX "Passkey_userId_idx" ON "Passkey"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "CourseCategory_slug_key" ON "CourseCategory"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "CoursePackage_slug_key" ON "CoursePackage"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "Module_packageId_name_key" ON "Module"("packageId", "name");

-- CreateIndex
CREATE UNIQUE INDEX "YearlyProduct_packageId_year_key" ON "YearlyProduct"("packageId", "year");

-- CreateIndex
CREATE UNIQUE INDEX "Batch_yearlyProductId_name_key" ON "Batch"("yearlyProductId", "name");

-- CreateIndex
CREATE UNIQUE INDEX "BatchModule_batchId_moduleId_key" ON "BatchModule"("batchId", "moduleId");

-- CreateIndex
CREATE UNIQUE INDEX "Purchase_userId_yearlyProductId_key" ON "Purchase"("userId", "yearlyProductId");

-- CreateIndex
CREATE UNIQUE INDEX "Enrollment_userId_batchId_key" ON "Enrollment"("userId", "batchId");

-- CreateIndex
CREATE UNIQUE INDEX "_PermissionToRole_AB_unique" ON "_PermissionToRole"("A", "B");

-- CreateIndex
CREATE INDEX "_PermissionToRole_B_index" ON "_PermissionToRole"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_RoleToUser_AB_unique" ON "_RoleToUser"("A", "B");

-- CreateIndex
CREATE INDEX "_RoleToUser_B_index" ON "_RoleToUser"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_CourseCategoryToWhatYouWillGet_AB_unique" ON "_CourseCategoryToWhatYouWillGet"("A", "B");

-- CreateIndex
CREATE INDEX "_CourseCategoryToWhatYouWillGet_B_index" ON "_CourseCategoryToWhatYouWillGet"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_CoursePackageToSubject_AB_unique" ON "_CoursePackageToSubject"("A", "B");

-- CreateIndex
CREATE INDEX "_CoursePackageToSubject_B_index" ON "_CoursePackageToSubject"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_ModuleToTopic_AB_unique" ON "_ModuleToTopic"("A", "B");

-- CreateIndex
CREATE INDEX "_ModuleToTopic_B_index" ON "_ModuleToTopic"("B");


INSERT INTO CourseCategory VALUES('cmo4m9lcv0000p5i2r01c3zp5',1776533650016,1776533650016,'GATE','gate','GATE is a national level entrance exam for admission to M.Tech programs in India.','Foodemy packages combine shared aptitude preparation with stream-specific content, staggered module releases, and long-tail access through the exam cycle.',1);

INSERT INTO WhatYouWillGet VALUES('cmo4m9lcw0001p5i21o9vg10e',1776533650016,1776533650016,'High Quality Video Lectures','Our expert faculty brings their wealth of knowledge and teaching experience to deliver high-quality video lectures. These engaging and informative sessions ensure you grasp even the most complex concepts with ease, at your own pace.',NULL,1);
INSERT INTO WhatYouWillGet VALUES('cmo4m9lcw0002p5i2c1v3kuig',1776533650016,1776533650016,'Crisp and Concise Study Materials','We provide you with crisp and concise study materials, eliminating the need for exhaustive searches through numerous books. Our materials are thoughtfully curated, focusing on the most relevant GATE syllabus topics, saving you valuable time and effort.',NULL,2);
INSERT INTO WhatYouWillGet VALUES('cmo4m9lcw0003p5i2vlrheg9n',1776533650016,1776533650016,'Solved Previous Year Questions','Access to solved previous year questions helps you understand the exam''s pattern and gain insight into the frequently asked topics, giving you the competitive edge you need.',NULL,3);
INSERT INTO WhatYouWillGet VALUES('cmo4m9lcw0004p5i23go84ev8',1776533650016,1776533650016,'Practice Questions','Practice makes perfect! Our extensive repository of practice questions challenges your problem-solving skills and reinforces your understanding of the subject matter, ensuring you are well-prepared to tackle any GATE question.',NULL,4);
INSERT INTO WhatYouWillGet VALUES('cmo4m9lcw0005p5i202jte1zq',1776533650016,1776533650016,'Mentorship from Subject Experts','At fyGATE, we believe in providing personalized attention. Benefit from mentorship from our experienced subject experts who guide you throughout your GATE preparation journey, offering valuable insights and support.',NULL,5);
INSERT INTO WhatYouWillGet VALUES('cmo4m9lcw0006p5i2h7mxkm50',1776533650016,1776533650016,'Mock Test on Dedicated Platform','Evaluate your progress and build confidence with our mock tests conducted on dedicated platform. These tests simulate the actual GATE exam environment, preparing you to excel on the big day.',NULL,6);
INSERT INTO WhatYouWillGet VALUES('cmo4m9lcw0007p5i2pw75y5lz',1776533650016,1776533650016,'Doubt Clearance Sessions','We understand that doubts can hinder progress. Our dedicated doubt clearance systems offer you the opportunity to seek clarifications on any topic, leaving no room for confusion.',NULL,7);
INSERT INTO WhatYouWillGet VALUES('cmo4m9lcw0008p5i2b7tgpnvi',1776533650016,1776533650016,'Personal Mentoring Sessions','Our commitment to your success goes beyond conventional coaching. Personal mentoring sessions allow you to interact one-on-one with our faculty, enabling customized learning and addressing specific challenges.',NULL,8);

INSERT INTO Subject VALUES('cmo4m9ld00009p5i2tn6ehitm',1776533650020,1776533650020,'General Aptitude','GA','General aptitude topics common across GATE streams.',1,1);
INSERT INTO Subject VALUES('cmo4m9ld0000ap5i26derw8ov',1776533650020,1776533650020,'Engineering Mathematics','EM','Engineering mathematics for GATE XE streams.',2,1);
INSERT INTO Subject VALUES('cmo4m9ld0000bp5i2adbbrfma',1776533650020,1776533650020,'Thermodynamics','TH','Thermodynamics syllabus for GATE XE.',3,1);
INSERT INTO Subject VALUES('cmo4m9ld0000cp5i2ht9c3aij',1776533650020,1776533650020,'Food Technology','FT','Core food technology syllabus shared across XE and XL packages.',4,1);
INSERT INTO Subject VALUES('cmo4m9ld0000dp5i2hzwakjmo',1776533650020,1776533650020,'Chemistry','CH','Chemistry topics used in GATE XL streams.',5,1);
INSERT INTO Subject VALUES('cmo4m9ld0000ep5i2wk1rv3yh',1776533650020,1776533650020,'Biochemistry','BC','Biochemistry syllabus for GATE XL.',6,1);
INSERT INTO Subject VALUES('cmo4m9ld0000fp5i2agm4gapx',1776533650020,1776533650020,'Microbiology','MB','Microbiology syllabus for GATE XL.',7,1);

INSERT INTO Topic VALUES('cmo4m9ld1000hp5i214ny4m5q',1776533650022,1776533650022,'Analytical Aptitude','Analogy',1,1,'cmo4m9ld00009p5i2tn6ehitm');
INSERT INTO Topic VALUES('cmo4m9ld2000lp5i2uxzbtaak',1776533650023,1776533650023,'Analytical Aptitude','Numerical relations and reasoning',1,1,'cmo4m9ld00009p5i2tn6ehitm');
INSERT INTO Topic VALUES('cmo4m9ld3000pp5i26f1gi7xq',1776533650024,1776533650024,'Verbal Aptitude','Basic English grammar: Articles',1,1,'cmo4m9ld00009p5i2tn6ehitm');
INSERT INTO Topic VALUES('cmo4m9ld4000tp5i2r4um49wi',1776533650024,1776533650024,'Quantitative Aptitude','Average, mean, mode',1,1,'cmo4m9ld00009p5i2tn6ehitm');
INSERT INTO Topic VALUES('cmo4m9ld5000xp5i2t0hyav7p',1776533650025,1776533650025,'Quantitative Aptitude','Percentage',1,1,'cmo4m9ld00009p5i2tn6ehitm');
INSERT INTO Topic VALUES('cmo4m9ld60011p5i2s2cg6x92',1776533650026,1776533650026,'Verbal Aptitude','Basic English grammar: Tenses',1,1,'cmo4m9ld00009p5i2tn6ehitm');
INSERT INTO Topic VALUES('cmo4m9ld70015p5i2qfsm110d',1776533650027,1776533650027,'Quantitative Aptitude','Ratio and proportions',1,1,'cmo4m9ld00009p5i2tn6ehitm');
INSERT INTO Topic VALUES('cmo4m9ld70019p5i2vg87o8cb',1776533650028,1776533650028,'Quantitative Aptitude','Series completion',1,1,'cmo4m9ld00009p5i2tn6ehitm');
INSERT INTO Topic VALUES('cmo4m9ld8001dp5i2rllm1y5c',1776533650028,1776533650028,'Quantitative Aptitude','Profit Loss',1,1,'cmo4m9ld00009p5i2tn6ehitm');
INSERT INTO Topic VALUES('cmo4m9ld9001hp5i2rm3tykv9',1776533650029,1776533650029,'Verbal Aptitude','Reading Comprehension',1,1,'cmo4m9ld00009p5i2tn6ehitm');
INSERT INTO Topic VALUES('cmo4m9ld9001lp5i21mj2m2xr',1776533650030,1776533650030,'Analytical Aptitude','Logic: deduction and induction',1,1,'cmo4m9ld00009p5i2tn6ehitm');
INSERT INTO Topic VALUES('cmo4m9lda001pp5i2r4ul1weo',1776533650031,1776533650031,'Verbal Aptitude','Basic vocabulary- words, idioms and phrases in context',1,1,'cmo4m9ld00009p5i2tn6ehitm');
INSERT INTO Topic VALUES('cmo4m9ldb001tp5i279sgop2p',1776533650032,1776533650032,'Quantitative Aptitude','Permutation and Combination',1,1,'cmo4m9ld00009p5i2tn6ehitm');
INSERT INTO Topic VALUES('cmo4m9ldc001xp5i2qd02ka8i',1776533650032,1776533650032,'Quantitative Aptitude','Probability',1,1,'cmo4m9ld00009p5i2tn6ehitm');
INSERT INTO Topic VALUES('cmo4m9ldd0021p5i2vqwh2lxd',1776533650033,1776533650033,'Verbal Aptitude','Basic English grammar: adjectives, preposition and conjunctions',1,1,'cmo4m9ld00009p5i2tn6ehitm');
INSERT INTO Topic VALUES('cmo4m9ldd0025p5i218vweddo',1776533650034,1776533650034,'Quantitative Aptitude','Data Interpretation: data graphs (bar graphs, pie charts and other graphs representing data), 2- and 3- dimensional plots, maps and tables',1,1,'cmo4m9ld00009p5i2tn6ehitm');
INSERT INTO Topic VALUES('cmo4m9lde0029p5i2owr35tan',1776533650035,1776533650035,'Quantitative Aptitude','Mensuration and geometry',1,1,'cmo4m9ld00009p5i2tn6ehitm');
INSERT INTO Topic VALUES('cmo4m9ldf002dp5i2fjldb0ul',1776533650036,1776533650036,'Verbal Aptitude','English grammar: verb-noun agreement and other parts of speech',1,1,'cmo4m9ld00009p5i2tn6ehitm');
INSERT INTO Topic VALUES('cmo4m9ldg002hp5i2kqikj3fj',1776533650036,1776533650036,'Quantitative Aptitude','Speed and distance',1,1,'cmo4m9ld00009p5i2tn6ehitm');
INSERT INTO Topic VALUES('cmo4m9ldg002lp5i2bpemzue0',1776533650037,1776533650037,'Spatial Aptitude','Transformation of shapes:Translation, rotation, scaling, mirroring, assembling and grouping, Paper folding, cutting and patterns in 2 and 3 dimensions',1,1,'cmo4m9ld00009p5i2tn6ehitm');
INSERT INTO Topic VALUES('cmo4m9ldh002pp5i2it83x5yy',1776533650038,1776533650038,'Verbal Aptitude','Narrative sequencing',1,1,'cmo4m9ld00009p5i2tn6ehitm');
INSERT INTO Topic VALUES('cmo4m9ldi002tp5i2nxkn7hze',1776533650039,1776533650039,'Quantitative Aptitude','Powers, exponents and logarithms',1,1,'cmo4m9ld00009p5i2tn6ehitm');
INSERT INTO Topic VALUES('cmo4m9ldj002xp5i2qrlurp0l',1776533650040,1776533650040,'Quantitative Aptitude','Elementary statistics',1,1,'cmo4m9ld00009p5i2tn6ehitm');
INSERT INTO Topic VALUES('cmo4m9ldk0031p5i2j5x7oo2j',1776533650040,1776533650040,'Quantitative Aptitude','Time and work',1,1,'cmo4m9ld00009p5i2tn6ehitm');
INSERT INTO Topic VALUES('cmo4m9ldl0035p5i2v5h8na33',1776533650041,1776533650041,'Basics of Engineering Mathematics',NULL,1,1,'cmo4m9ld0000ap5i26derw8ov');
INSERT INTO Topic VALUES('cmo4m9ldm0039p5i27vfvpttc',1776533650042,1776533650042,'Linear Algebra','Algebra of real matrices: Determinant, inverse and rank of a matrix; System of linear equations (conditions for unique solution, no solution and infinite number of solutions)',1,1,'cmo4m9ld0000ap5i26derw8ov');
INSERT INTO Topic VALUES('cmo4m9ldn003dp5i21filmr8x',1776533650043,1776533650043,'Linear Algebra','Eigenvalues and eigenvectors of matrices; Properties of eigenvalues and eigenvectors of symmetric matrices, diagonalization of matrices; Cayley Hamilton Theorem',1,1,'cmo4m9ld0000ap5i26derw8ov');
INSERT INTO Topic VALUES('cmo4m9ldo003hp5i2srfxg9n7',1776533650044,1776533650044,'Calculus',unistr('Functions of single variable: Limit, indeterminate forms and L''Hospital''s rule; Continuity and differentiability;\u000aMean value theorems; Maxima and minima; Taylor''s theorem; Fundamental theorem and mean value theorem of integral calculus;'),1,1,'cmo4m9ld0000ap5i26derw8ov');
INSERT INTO Topic VALUES('cmo4m9ldo003lp5i29at6v7np',1776533650045,1776533650045,'Calculus','Evaluation of definite and improper integrals; Applications of definite integrals to evaluate areas and volumes (rotation of a curve about an axis)',1,1,'cmo4m9ld0000ap5i26derw8ov');
INSERT INTO Topic VALUES('cmo4m9ldp003pp5i2ixziw7b4',1776533650046,1776533650046,'Calculus','Functions of two variables: Limit, continuity and partial derivatives; Directional derivative; Total derivative; Maxima, minima and saddle points; Method of Lagrange multipliers; Double integrals and their applications',1,1,'cmo4m9ld0000ap5i26derw8ov');
INSERT INTO Topic VALUES('cmo4m9ldr003tp5i27gzl0rkh',1776533650047,1776533650047,'Complex Variables','Complex numbers, Argand plane and polar representation of complex numbers; De Moivre’s theorem; Analytic functions; Cauchy-Riemann equations.',1,1,'cmo4m9ld0000ap5i26derw8ov');
INSERT INTO Topic VALUES('cmo4m9ldr003xp5i2f949fumm',1776533650048,1776533650048,'Probability','Axioms of probability; Conditional probability; Bayes'' Theorem;',1,1,'cmo4m9ld0000ap5i26derw8ov');
INSERT INTO Topic VALUES('cmo4m9lds0041p5i2lnj8nd6o',1776533650049,1776533650049,'Statistics','Mean, variance and standard deviation of random variables; Binomial, Poisson and Normal distributions; Correlation and linear regression.',1,1,'cmo4m9ld0000ap5i26derw8ov');
INSERT INTO Topic VALUES('cmo4m9ldt0045p5i2if43o0fn',1776533650050,1776533650050,'Sequence and series','Convergence of sequences and series; Tests of convergence of series with non-negative terms (ratio, root and integral tests); Power series; Taylor''s series; Fourier Series of functions of period 2π.',1,1,'cmo4m9ld0000ap5i26derw8ov');
INSERT INTO Topic VALUES('cmo4m9ldu0049p5i2wojng6zc',1776533650051,1776533650051,'Vector Calculus','Gradient, divergence and curl; Line integrals and Green''s theorem.',1,1,'cmo4m9ld0000ap5i26derw8ov');
INSERT INTO Topic VALUES('cmo4m9ldv004dp5i2cmf046l2',1776533650051,1776533650051,'ODE','First order equations (linear and nonlinear); Second order linear differential equations with constant coefficients;',1,1,'cmo4m9ld0000ap5i26derw8ov');
INSERT INTO Topic VALUES('cmo4m9ldw004hp5i2bd9grdwh',1776533650052,1776533650052,'ODE','Cauchy-Euler equation; Second order linear differential equations with variable coefficients; Wronskian; Method of variation of parameters;',1,1,'cmo4m9ld0000ap5i26derw8ov');
INSERT INTO Topic VALUES('cmo4m9ldx004lp5i2ljx6mnf3',1776533650053,1776533650053,'ODE','Eigenvalue problem for second order equations with constant coefficients; Power series solutions for ordinary points.',1,1,'cmo4m9ld0000ap5i26derw8ov');
INSERT INTO Topic VALUES('cmo4m9ldy004pp5i2hv9twp31',1776533650054,1776533650054,'Partial Differential Equation','Classification of second order linear partial differential equations;',1,1,'cmo4m9ld0000ap5i26derw8ov');
INSERT INTO Topic VALUES('cmo4m9ldy004tp5i2tftt5v5r',1776533650055,1776533650055,'Partial Differential Equation','Method of separation of variables: One dimensional heat equation and two dimensional Laplace equation',1,1,'cmo4m9ld0000ap5i26derw8ov');
INSERT INTO Topic VALUES('cmo4m9ldz004xp5i22c5h0lz1',1776533650056,1776533650056,'Numerical Methods',unistr('Solution of systems of linear equations using LU decomposition, Gauss elimination method; Lagrange and Newton''s interpolations; Solution of polynomial and transcendental equations by\u000aNewton-Raphson method'),1,1,'cmo4m9ld0000ap5i26derw8ov');
INSERT INTO Topic VALUES('cmo4m9le00051p5i2d5uqw8dc',1776533650057,1776533650057,'Numerical Methods',unistr('Numerical integration by trapezoidal rule and Simpson''s rule;\u000aNumerical solutions of first order differential equations by explicit Euler''s method.'),1,1,'cmo4m9ld0000ap5i26derw8ov');
INSERT INTO Topic VALUES('cmo4m9le10055p5i2x6a458th',1776533650058,1776533650058,'Basic Concepts',unistr('Introduction\u000aContinuum and macroscopic approach\u000aThermodynamic systems (closed and open)\u000aThermodynamic properties and equilibrium'),1,1,'cmo4m9ld0000bp5i2adbbrfma');
INSERT INTO Topic VALUES('cmo4m9le20059p5i2b3wn7dwh',1776533650059,1776533650059,'Second topic inside a module','Second topic description',2,1,'cmo4m9ld0000bp5i2adbbrfma');
INSERT INTO Topic VALUES('cmo4m9le3005dp5i2cckf7qh7',1776533650059,1776533650059,'Basic Concepts',unistr('State of a system\u000aState postulate for simple compressible substances\u000aState diagrams\u000aPaths and processes on state diagram\u000aConcepts of heat and work\u000aDifferent modes of work'),1,1,'cmo4m9ld0000bp5i2adbbrfma');
INSERT INTO Topic VALUES('cmo4m9le4005hp5i27vtvbccc',1776533650060,1776533650060,'Basic Concepts',unistr('Ideal gas equation\u000aZeroth law of thermodynamics\u000aConcept of temperature'),1,1,'cmo4m9ld0000bp5i2adbbrfma');
INSERT INTO Topic VALUES('cmo4m9le5005lp5i2ikpzlvg3',1776533650061,1776533650061,'First law of Thermodynamics',unistr('Concept of energy and various forms of energy\u000aInternal Energy\u000aEnthalpy\u000aSpecific heats'),1,1,'cmo4m9ld0000bp5i2adbbrfma');
INSERT INTO Topic VALUES('cmo4m9le5005pp5i24c3aqr6g',1776533650062,1776533650062,'First law of Thermodynamics','First law applied to elementary processes, closed systems and control volumes',1,1,'cmo4m9ld0000bp5i2adbbrfma');
INSERT INTO Topic VALUES('cmo4m9le6005tp5i2y44fmlia',1776533650063,1776533650063,'First Law of Thermodynamics','Steady and unsteady flow analysis',1,1,'cmo4m9ld0000bp5i2adbbrfma');
INSERT INTO Topic VALUES('cmo4m9le7005xp5i2pflcit1j',1776533650064,1776533650064,'Second Law of Thermodynamics',unistr('Limitations of first law of thermodynamics\u000aConcept of heat engines and heat pumps/ refrigerators'),1,1,'cmo4m9ld0000bp5i2adbbrfma');
INSERT INTO Topic VALUES('cmo4m9le80061p5i2026gwhum',1776533650064,1776533650064,'Second Law of Thermodynamics',unistr('Kelvin-Planck and Clausius statements and their equivalence\u000aReversible and irreversible processes'),1,1,'cmo4m9ld0000bp5i2adbbrfma');
INSERT INTO Topic VALUES('cmo4m9le90065p5i2lij2nqg9',1776533650065,1776533650065,'Second Law of Thermodynamics',unistr('Carnot cycle and Carnot principles/theorems\u000aThermodymanic temperature scale'),1,1,'cmo4m9ld0000bp5i2adbbrfma');
INSERT INTO Topic VALUES('cmo4m9lea0069p5i283dkbayb',1776533650066,1776533650066,'Second Law of Thermodynamics',unistr('Clausius inequality and concept of entropy\u000aMicroscopic interpretation of entropy\u000aThe principle of increase of entropy\u000aT-s diagrams'),1,1,'cmo4m9ld0000bp5i2adbbrfma');
INSERT INTO Topic VALUES('cmo4m9lea006dp5i2erfqvaly',1776533650067,1776533650067,'Second Law of Thermodynamics',unistr('Second law analysis of control volume\u000aAvailability and irreversibilty\u000aThird law of thermodynamics'),1,1,'cmo4m9ld0000bp5i2adbbrfma');
INSERT INTO Topic VALUES('cmo4m9leb006hp5i20duhq60u',1776533650068,1776533650068,'Properties of pure substances',unistr('Thermodynamic properties of pure substances in solid, liquid and vapor phases\u000aPvT behaviour of simple compressible substances\u000aPhase rule\u000aThermodynamic property tables and charts\u000aIdeal and real gases\u000aIdeal gas equation of state and van der Waals equation of state'),1,1,'cmo4m9ld0000bp5i2adbbrfma');
INSERT INTO Topic VALUES('cmo4m9lec006lp5i2x752qv8v',1776533650068,1776533650068,'Properties of pure substances',unistr('Law of corresponding states\u000aCompressibility factor and generalized compressibility chart'),1,1,'cmo4m9ld0000bp5i2adbbrfma');
INSERT INTO Topic VALUES('cmo4m9led006pp5i2ukymg4en',1776533650069,1776533650069,'Thermodynamic Relations',unistr('Tds relations\u000aHelmholtz and Gibbs functions\u000aGibbs relations\u000aMaxwell relations\u000aJoule-Thomson coefficient\u000aCoefficient of volume expansion\u000aAdiabatic and isothermal compressibilities\u000aClapeyron and Clapeyron-Clausius equations'),1,1,'cmo4m9ld0000bp5i2adbbrfma');
INSERT INTO Topic VALUES('cmo4m9lee006tp5i2laii3l8d',1776533650070,1776533650070,'Thermodynamic Cycles',unistr('Carnot vapor cycle\u000aIdeal Rankine cycle\u000aRankine reheat cycle'),1,1,'cmo4m9ld0000bp5i2adbbrfma');
INSERT INTO Topic VALUES('cmo4m9lee006xp5i2vuvqlpi8',1776533650071,1776533650071,'Thermodynamic Cycles',unistr('Air-standard Otto cycle\u000aAir-standard Diesel cycle\u000aAir-standard Brayton cycle'),1,1,'cmo4m9ld0000bp5i2adbbrfma');
INSERT INTO Topic VALUES('cmo4m9lef0071p5i2zwao1jeo',1776533650071,1776533650071,'Thermodynamic Cycles','Vapor-compression refrigeration cycle',1,1,'cmo4m9ld0000bp5i2adbbrfma');
INSERT INTO Topic VALUES('cmo4m9leg0075p5i2actbg3hz',1776533650072,1776533650072,'Ideal gas mixtures',unistr('Dalton’s and Amagat’s laws\u000aProperties of ideal gas mixtures'),1,1,'cmo4m9ld0000bp5i2adbbrfma');
INSERT INTO Topic VALUES('cmo4m9leh0079p5i2rhvwuumb',1776533650073,1776533650073,'Ideal gas mixtures',unistr('Air-water vapor mixtures and simple thermodynamic processes involving them\u000aSpecific and relative humidities\u000aDew point and wet bulb temperature\u000aAdiabatic saturation temperature'),1,1,'cmo4m9ld0000bp5i2adbbrfma');
INSERT INTO Topic VALUES('cmo4m9lei007dp5i2fkjunymj',1776533650074,1776533650074,'Ideal gas mixtures','Psychrometric chart',1,1,'cmo4m9ld0000bp5i2adbbrfma');
INSERT INTO Topic VALUES('cmo4m9lei007hp5i2irc09skw',1776533650075,1776533650075,'Carbohydrates','Structure and functional properties of mono-, oligo-, & poly-saccharides, starch, Cellulose',1,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lej007lp5i2xzulwign',1776533650076,1776533650076,'Mass and Energy Balance',NULL,2,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lek007pp5i29jpfozoz',1776533650076,1776533650076,'Microorganisms','Characteristics of microorganisms: morphology of bacteria, gram-staining',1,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lel007tp5i29mpetr7j',1776533650077,1776533650077,'Carbohydrates','Pectic substances dietary fibre, gelatinization of starch, Retrogradation of starch',2,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lel007xp5i26f7jrvn0',1776533650078,1776533650078,'Microorganisms','Morphology of yeast, morphology of mold, morphology of actinomycetes, spores and vegetative cells',1,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lem0081p5i20dm6zcol',1776533650079,1776533650079,'Intermediate Moisture Foods','Moisture content, Water activity',2,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9len0085p5i2ccihnqtq',1776533650079,1776533650079,'Lipids','Classification, structure of lipids, rancidity, polymerization, polymorphism',1,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9leo0089p5i277f709pl',1776533650080,1776533650080,'Processing Principles','Thermal processing - Blanching, Pasteurization and Sterilization',2,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lep008dp5i2jt87ex5x',1776533650081,1776533650081,'Oil Processing','Expelling, solvent extraction, refining, hydrogenation',1,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lep008hp5i2n6e5vng0',1776533650082,1776533650082,'Proteins','Classification, structure of proteins in food',2,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9leq008lp5i2sri7qi7l',1776533650083,1776533650083,'Microbial Growth','Growth and death kinetics, serial dilution technique',1,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9ler008pp5i2z5fqjieq',1776533650083,1776533650083,'Enzymes','Specificity, simple and inhibition kinetics, coenzymes',2,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9les008tp5i2zbmymzak',1776533650084,1776533650084,'Thermal Operations','Thermal sterilization - D,F,Z values',1,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9les008xp5i2xdn6gmys',1776533650085,1776533650085,'Plantation Crops Processing','Tea',2,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9let0091p5i2iap1mo3s',1776533650085,1776533650085,'Momentum Transfer','Flow rate and pressure drop relationships for Newtonian fluids flowing through pipe, Reynolds number',1,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9leu0095p5i2g80v7363',1776533650086,1776533650086,'Browning','Enzymatic and Non enzymatic browning',2,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9leu0099p5i2ptbjyknr',1776533650087,1776533650087,'Fermented Beverages','Alcoholic beverages',1,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lev009dp5i26axk6ttx',1776533650088,1776533650088,'Fermented Foods','Curd, yogurt, cheese, pickle, sauerkraut, soya sauce, idli & dosa, vinegar, sauce',2,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lew009hp5i2ji6a80dr',1776533650089,1776533650089,'Cereal Processing','Parboiling of paddy',1,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lex009lp5i28ntgwqr0',1776533650090,1776533650090,'Cereal Processing','Milling of rice. Waste utilization: uses of by-products from rice milling',2,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9ley009pp5i2842m09yv',1776533650090,1776533650090,'Heat Transfer','Heat transfer by conduction, convection, Radiation',1,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9ley009tp5i27vibnzlw',1776533650091,1776533650091,'Cereal Processing','Milling of wheat',2,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lez009xp5i2k972huw0',1776533650092,1776533650092,'Heat Transfer','Heat exchangers',1,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lf000a1p5i2o0be7834',1776533650092,1776533650092,'Cereal Processing','Milling of maize',2,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lf000a5p5i2m9l2tmdw',1776533650093,1776533650093,'Meat','Biochemical changes in post mortem, tenderization of muscles',1,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lf100a9p5i2hmmkdjr6',1776533650093,1776533650093,'Nutrition','Water soluble and fat soluble vitamins, role of minerals in nutrition, co-factors, anti-nutrients, nutraceuticals',2,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lf200adp5i2ghr3q6hd',1776533650094,1776533650094,'Nutrition','Balanced diet, essential amino acids, essential fatty acids, protein efficiency ratio, nutrient deficiency diseases',3,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lf200ahp5i2wch90b7y',1776533650095,1776533650095,'Milk Processing','Pasteurization, sterilization, High pressure homogenization',1,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lf300alp5i2z0km0m41',1776533650095,1776533650095,'Mechanical Operation in Milk Processing','Filtration, centrifugation',2,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lf300app5i2wd42rtmm',1776533650096,1776533650096,'Milk Products Processing','Cream, Butter, Ghee, Ice cream, Cheese, Milk powder',1,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lf400atp5i2pcct8an4',1776533650096,1776533650096,'Processing Principle','Irradiation',2,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lf400axp5i2p0i0lzdn',1776533650097,1776533650097,'Food Spoilage','Spoilage microorganisms in fish, milk, meat, egg, cereal and their products',1,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lf500b1p5i2w8zdchc4',1776533650098,1776533650098,'Pigments','Carotenoids, chlorophylls, anthocyanins, tannins, myoglobin. Food flavours: Terpenes, esters, aldehydes, ketones and quinines',2,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lf600b5p5i24vbnz2fx',1776533650098,1776533650098,'Mass Transfer','Molecular diffusion and Fick''s law, conduction and convective mass transfer, permeability through single and multilayer films',1,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lf600b9p5i2t6qqbsr8',1776533650099,1776533650099,'Plantation Crops Processing','Coffee',2,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lf700bdp5i2lfphci2q',1776533650099,1776533650099,'Cereal Processing','Bread, biscuits, extruded products, ready to eat breakfast cereals',1,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lf700bhp5i21mrggv98',1776533650100,1776533650100,'Food Standards','Food plant sanitation and cleaning in place (CIP)',2,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lf800blp5i2xizmz7dn',1776533650101,1776533650101,'Processing Principles','Chilling, freezing, crystallization',1,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lf900bpp5i2pxxm0ynn',1776533650101,1776533650101,'Mass Transfer Operations','Psychometric, humidification and dehumidification operations',2,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lf900btp5i2z7l87jql',1776533650102,1776533650102,'Plantation Crops Processing','Spice, extraction of essential oils and oleoresins from spice',1,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lfa00bxp5i2u8p9ovfy',1776533650103,1776533650103,'Thermal Operations','Evaporation of liquid foods',2,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lfb00c1p5i28gsejw41',1776533650103,1776533650103,'Thermal Operations','Hot air drying of solids; Spray drying, Freeze drying, Dehydration',1,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lfb00c5p5i2udotqm1i',1776533650104,1776533650104,'Plantation Crops Processing','Cocoa',2,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lfc00c9p5i27nln5kfe',1776533650104,1776533650104,'Processing of Animal Products','Drying, canning, and freezing of fish and meat',1,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lfd00cdp5i2mun3mw4l',1776533650106,1776533650106,'Processing of Animal Products','Production of egg powder',2,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lfe00chp5i2jkpe9dmq',1776533650107,1776533650107,'Food Standards','HACCP',1,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lff00clp5i20eep8wxn',1776533650107,1776533650107,'Food Standards','FPO, PFA, A-Mark, ISI',2,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lff00cpp5i2khr7rhko',1776533650108,1776533650108,'Waste Utilization','Pectin from fruit wastes',3,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lfg00ctp5i2xlmswh64',1776533650108,1776533650108,'Mechanical Operation','Settling, sieving, mixing & agitation of liquid',1,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lfg00cxp5i2esk45xfk',1776533650109,1776533650109,'Processing Principle','Hurdle technology',2,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lfh00d1p5i2w04llk4f',1776533650109,1776533650109,'Mechanical Operation','Size reduction of solids',1,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lfi00d5p5i2fq97adtj',1776533650110,1776533650110,'Processing Principle','Addition of preservatives and food additives',2,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lfi00d9p5i2td1qx682',1776533650111,1776533650111,'Fruit and Vegetable Processing','Extraction, clarification, concentration and packaging of fruit juice, jam, jelly, marmalade, squash, candies, tomato sauce, ketchup, and puree, potato chips, pickles',1,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lfj00ddp5i2nmvn96qq',1776533650111,1776533650111,'Food Packaging and Storage','Packaging materials, aseptic packaging, controlled and modified atmosphere storage',2,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lfj00dhp5i2l4tnq3d0',1776533650112,1776533650112,'Toxins from Microbes','Pathogens and non-pathogens, Staphylococcus, Salmonella, Shebelle, Shigella, Escherichia, Bacillus, Clostridium Aspergillus genera',1,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lfk00dlp5i2siakb62z',1776533650113,1776533650113,'Chemical and Biochemical Changes','Changes occurring in foods during different processing',2,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lfl00dpp5i2abghgxjs',1776533650113,1776533650113,'Processing Principle','Fermentation',3,1,'cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO Topic VALUES('cmo4m9lfl00dtp5i2qlzh8d89',1776533650114,1776533650114,'Primitive atomic models (briefly), wave particle duality of electromagnetic radiation, Black body radiation and Planck''s quantum theory',NULL,1,1,'cmo4m9ld0000dp5i2hzwakjmo');
INSERT INTO Topic VALUES('cmo4m9lfm00dxp5i2tnr0kzng',1776533650115,1776533650115,'Comparison between Bohr''s model and quantum mechanical model, uncertainty principle, electronic configuration of atoms and ions, Hund''s rule and Pauli''s exclusion principle',NULL,1,1,'cmo4m9ld0000dp5i2hzwakjmo');
INSERT INTO Topic VALUES('cmo4m9lfn00e1p5i21n1upoop',1776533650115,1776533650115,'Periodic table & periodic properties: ionisation energy, electronegativity, electron affinity and atomic size',NULL,1,1,'cmo4m9ld0000dp5i2hzwakjmo');
INSERT INTO Topic VALUES('cmo4m9lfo00e5p5i2r4s00xu3',1776533650116,1776533650116,'Structure and bonding: ionic and covalent bonding, MO & VB approaches for diatomic molecules',NULL,1,1,'cmo4m9ld0000dp5i2hzwakjmo');
INSERT INTO Topic VALUES('cmo4m9lfo00e9p5i2gsodzqg5',1776533650117,1776533650117,'VSEPR theory and shape of molecules, hybridization, resonance, dipole moment, structural parameters, hydrogen bonding and van der Waals interaction, ionic solids and ionic radii, lattice energy (Born‐Haber cycle), HSAB principle',NULL,1,1,'cmo4m9ld0000dp5i2hzwakjmo');
INSERT INTO Topic VALUES('cmo4m9lfp00edp5i25esbymu0',1776533650117,1776533650117,'s block elements',NULL,1,1,'cmo4m9ld0000dp5i2hzwakjmo');
INSERT INTO Topic VALUES('cmo4m9lfp00ehp5i2auy47bks',1776533650118,1776533650118,'p block elements',NULL,1,1,'cmo4m9ld0000dp5i2hzwakjmo');
INSERT INTO Topic VALUES('cmo4m9lfq00elp5i2g6x5vw59',1776533650119,1776533650119,'d block elements',NULL,1,1,'cmo4m9ld0000dp5i2hzwakjmo');
INSERT INTO Topic VALUES('cmo4m9lfr00epp5i2nis3s2l9',1776533650119,1776533650119,'Coordination Compounds: nomenclature, isomerism, geometry, valence bond theory',NULL,1,1,'cmo4m9ld0000dp5i2hzwakjmo');
INSERT INTO Topic VALUES('cmo4m9lfr00etp5i2lw32r5si',1776533650120,1776533650120,'Coordination Compounds: Valence bond theory, crystal field theory, color, magnetic properties',NULL,1,1,'cmo4m9ld0000dp5i2hzwakjmo');
INSERT INTO Topic VALUES('cmo4m9lfs00exp5i2s8ov7pk7',1776533650121,1776533650121,'Chemical equilibria: Osmotic pressure, elevation of boiling point and depression of freezing point, ionic equilibria in solution, solubility product.',NULL,1,1,'cmo4m9ld0000dp5i2hzwakjmo');
INSERT INTO Topic VALUES('cmo4m9lft00f1p5i218fnbgt2',1776533650121,1776533650121,'Chemical equilibria: common ion effect, hydrolysis of salts, pH, buffer and their applications. Equilibrium constants (Kc, Kp and Kx) for homogeneous reactions',NULL,1,1,'cmo4m9ld0000dp5i2hzwakjmo');
INSERT INTO Topic VALUES('cmo4m9lft00f5p5i2phanurmo',1776533650122,1776533650122,'Reaction Kinetics: Rate constant, order of reaction, molecularity, activation energy, zero, first and second order kinetics, catalysis and elementary enzyme reactions. Reversible and irreversible inhibition of enzymes',NULL,1,1,'cmo4m9ld0000dp5i2hzwakjmo');
INSERT INTO Topic VALUES('cmo4m9lfu00f9p5i27c946n8b',1776533650122,1776533650122,'Reaction Kinetics: catalysis and elementary enzyme reactions. Reversible and irreversible inhibition of enzymes',NULL,1,1,'cmo4m9ld0000dp5i2hzwakjmo');
INSERT INTO Topic VALUES('cmo4m9lfv00fdp5i239ou5amz',1776533650123,1776533650123,'Electrochemistry: Conductance, Kohlrausch law, cell potentials, EMF, Nernst equation, thermodynamic aspects and their applications',NULL,1,1,'cmo4m9ld0000dp5i2hzwakjmo');
INSERT INTO Topic VALUES('cmo4m9lfw00fhp5i2nj0rn5sh',1776533650124,1776533650124,'Thermodynamics: Qualitative treatment of state and path functions, First law, reversible and irreversible processes, internal energy, enthalpy, Kirchoff equation, heat of reaction, Hess’s law, heat of formation.',NULL,1,1,'cmo4m9ld0000dp5i2hzwakjmo');
INSERT INTO Topic VALUES('cmo4m9lfw00flp5i2x4cqp6es',1776533650125,1776533650125,'Thermodynamics: Second law, entropy and free energy. Gibbs‐Helmholtz equation, free energy change and spontaneity, Free energy changes from equilibrium constant.',NULL,1,1,'cmo4m9ld0000dp5i2hzwakjmo');
INSERT INTO Topic VALUES('cmo4m9lfx00fpp5i2m3alj94h',1776533650126,1776533650126,'Organic Reaction Mechanisms and Hydrocarbon: Acids and bases, electronic and steric effects, Stereochemistry, optical and geometrical isomerism, tautomerism, conformers and concept of aromaticity.',NULL,1,1,'cmo4m9ld0000dp5i2hzwakjmo');
INSERT INTO Topic VALUES('cmo4m9lfy00ftp5i2xlwpeuqp',1776533650126,1776533650126,'Organic Reaction Mechanisms and Hydrocarbon: Elementary treatment of SN1, SN2, E1, E2 and radical reactions',NULL,1,1,'cmo4m9ld0000dp5i2hzwakjmo');
INSERT INTO Topic VALUES('cmo4m9lfy00fxp5i2wwcn5og3',1776533650127,1776533650127,'Hoffmann/Saytzeff rules, addition reactions, Markownikoff rule and Kharasch effect. Elementary hydroboration reactions. Grignard’s reagents and their uses',NULL,1,1,'cmo4m9ld0000dp5i2hzwakjmo');
INSERT INTO Topic VALUES('cmo4m9lfz00g1p5i2gv649neq',1776533650127,1776533650127,'Alcohol: Aromatic electrophilic substitutions, orientation effect as exemplified by various functional groups. Identification of common functional groups by chemical tests',NULL,1,1,'cmo4m9ld0000dp5i2hzwakjmo');
INSERT INTO Topic VALUES('cmo4m9lg000g5p5i2lzc9z8f3',1776533650128,1776533650128,'Aldehydes and Ketones: Aromatic electrophilic substitutions, orientation effect as exemplified by various functional groups. Identification of common functional groups by chemical tests.',NULL,1,1,'cmo4m9ld0000dp5i2hzwakjmo');
INSERT INTO Topic VALUES('cmo4m9lg000g9p5i2lncbt39m',1776533650129,1776533650129,'Carboxylic acids and amines: Aromatic electrophilic substitutions, orientation effect as exemplified by various functional groups. Identification of common functional groups by chemical tests.',NULL,1,1,'cmo4m9ld0000dp5i2hzwakjmo');
INSERT INTO Topic VALUES('cmo4m9lg100gdp5i2yst72ye8',1776533650129,1776533650129,'Chemistry of Biomolecules: Amino acids, proteins, nucleic acids and nucleotides. Peptide sequencing. DNA sequencing, Carbohydrates (upto hexoses only). Lipids (triglycerides only).',NULL,1,1,'cmo4m9ld0000dp5i2hzwakjmo');
INSERT INTO Topic VALUES('cmo4m9lg200ghp5i2iace28g7',1776533650130,1776533650130,'Chemistry of Biomolecules: Principles of biomolecule purification - Ion exchange and gel filtration chromatography. Identification of these biomolecules and Beer-Lambert’s law.',NULL,1,1,'cmo4m9ld0000dp5i2hzwakjmo');
INSERT INTO Topic VALUES('cmo4m9lg300glp5i2nm8az2ey',1776533650131,1776533650131,'Importance of water; Structure and function of biomolecules: Lipids',NULL,1,1,'cmo4m9ld0000ep5i2wk1rv3yh');
INSERT INTO Topic VALUES('cmo4m9lg300gpp5i2i1wymh0s',1776533650132,1776533650132,'Structure and function of biomolecules: Carbohydrates',NULL,1,1,'cmo4m9ld0000ep5i2wk1rv3yh');
INSERT INTO Topic VALUES('cmo4m9lg400gtp5i2dbys76e8',1776533650132,1776533650132,'Structure and function of biomolecules: Amino acids and Nucleic acids',NULL,1,1,'cmo4m9ld0000ep5i2wk1rv3yh');
INSERT INTO Topic VALUES('cmo4m9lg400gxp5i2r8pgfdft',1776533650133,1776533650133,'Protein structure, folding and function',NULL,1,1,'cmo4m9ld0000ep5i2wk1rv3yh');
INSERT INTO Topic VALUES('cmo4m9lg500h1p5i21ruswwok',1776533650133,1776533650133,'Protein structure, folding and function: II; Myoglobin and Hemoglobin',NULL,1,1,'cmo4m9ld0000ep5i2wk1rv3yh');
INSERT INTO Topic VALUES('cmo4m9lg500h5p5i2f9n29ou5',1776533650134,1776533650134,'Enzymes: Kinetics, regulation and inhibition; Lysozyme, Ribonuclease A, Carboxypeptidase and Chymotrypsin; Vitamins and Coenzymes',NULL,1,1,'cmo4m9ld0000ep5i2wk1rv3yh');
INSERT INTO Topic VALUES('cmo4m9lg600h9p5i2m49lgd4n',1776533650134,1776533650134,'Metabolism and bioenergetics, Generation and utilization of ATP',NULL,1,1,'cmo4m9ld0000ep5i2wk1rv3yh');
INSERT INTO Topic VALUES('cmo4m9lg700hdp5i2vctmjidp',1776533650135,1776533650135,'Metabolic pathways and their regulation: glycolysis',NULL,1,1,'cmo4m9ld0000ep5i2wk1rv3yh');
INSERT INTO Topic VALUES('cmo4m9lg700hhp5i2s8ga1jwn',1776533650136,1776533650136,'Metabolic pathways and their regulation: gluconeogenesis, pentose phosphate pathway',NULL,1,1,'cmo4m9ld0000ep5i2wk1rv3yh');
INSERT INTO Topic VALUES('cmo4m9lg800hlp5i2sapxs5or',1776533650136,1776533650136,'Metabolic pathways and their regulation: TCA cycle (Kreb Cycle), oxidative phosphorylation',NULL,1,1,'cmo4m9ld0000ep5i2wk1rv3yh');
INSERT INTO Topic VALUES('cmo4m9lg900hpp5i26jz1htoj',1776533650137,1776533650137,'Metabolic pathways and their regulation: glycogen and fatty acid metabolism',NULL,1,1,'cmo4m9ld0000ep5i2wk1rv3yh');
INSERT INTO Topic VALUES('cmo4m9lga00htp5i20uwd8gjk',1776533650138,1776533650138,'Metabolism of Nitrogen containing compounds: nitrogen fixation, amino acids, nucleotides',NULL,1,1,'cmo4m9ld0000ep5i2wk1rv3yh');
INSERT INTO Topic VALUES('cmo4m9lgb00hxp5i20nlt2x9y',1776533650139,1776533650139,'Photosynthesis: Calvin cycle.',NULL,1,1,'cmo4m9ld0000ep5i2wk1rv3yh');
INSERT INTO Topic VALUES('cmo4m9lgb00i1p5i2submrnde',1776533650140,1776533650140,'Biochemical separation techniques: ion exchange, size exclusion and affinity chromatography',NULL,1,1,'cmo4m9ld0000ep5i2wk1rv3yh');
INSERT INTO Topic VALUES('cmo4m9lgc00i5p5i2d4wvot56',1776533650140,1776533650140,'Biochemical separation techniques: centrifugation; Characterisation of biomolecules by electrophoresis',NULL,1,1,'cmo4m9ld0000ep5i2wk1rv3yh');
INSERT INTO Topic VALUES('cmo4m9lgc00i9p5i2ma3mfnpz',1776533650141,1776533650141,'Biochemical separation techniques: UV-visible and fluorescence spectroscopy, Mass spectrometry',NULL,1,1,'cmo4m9ld0000ep5i2wk1rv3yh');
INSERT INTO Topic VALUES('cmo4m9lgd00idp5i2fyuhwz68',1776533650141,1776533650141,'Organisation of life; Cell structure and organelles; Biological membranes (plasma membrane)',NULL,1,1,'cmo4m9ld0000ep5i2wk1rv3yh');
INSERT INTO Topic VALUES('cmo4m9lge00ihp5i2otnz9tz8',1776533650142,1776533650142,'Membrane Action potential; Transport across membranes; Membrane assembly and Protein targeting',NULL,1,1,'cmo4m9ld0000ep5i2wk1rv3yh');
INSERT INTO Topic VALUES('cmo4m9lge00ilp5i28gok29ig',1776533650143,1776533650143,'DNA-protein and protein–protein interactions',NULL,1,1,'cmo4m9ld0000ep5i2wk1rv3yh');
INSERT INTO Topic VALUES('cmo4m9lgf00ipp5i2kpw2hq91',1776533650143,1776533650143,'Cell Signaling: Signal transduction; Receptor-ligand interaction; Hormones and neurotransmitters',NULL,1,1,'cmo4m9ld0000ep5i2wk1rv3yh');
INSERT INTO Topic VALUES('cmo4m9lgf00itp5i2luapx0bn',1776533650144,1776533650144,'DNA replication, transcription and translation; DNA damage and repair; Biochemical regulation of gene expression',NULL,1,1,'cmo4m9ld0000ep5i2wk1rv3yh');
INSERT INTO Topic VALUES('cmo4m9lgg00ixp5i2rkaxnhvu',1776533650145,1776533650145,'Immune system: Innate and adaptive; Cell of the immune system; Active and passive immunity; Complement system',NULL,1,1,'cmo4m9ld0000ep5i2wk1rv3yh');
INSERT INTO Topic VALUES('cmo4m9lgh00j1p5i2s63abi2i',1776533650145,1776533650145,'Antibody structure, function and diversity; B cell and T Cell receptors; B cell and T cell activation',NULL,1,1,'cmo4m9ld0000ep5i2wk1rv3yh');
INSERT INTO Topic VALUES('cmo4m9lgh00j5p5i2rn9w7wzn',1776533650146,1776533650146,'Immunological techniques: Immunodiffusion, immune-electrophoresis, RIA and ELISA, flow cytometry; monoclonal antibodies and their applications.',NULL,1,1,'cmo4m9ld0000ep5i2wk1rv3yh');
INSERT INTO Topic VALUES('cmo4m9lgi00j9p5i21dea5v6m',1776533650147,1776533650147,'Recombinant DNA technology and applications: PCR',NULL,1,1,'cmo4m9ld0000ep5i2wk1rv3yh');
INSERT INTO Topic VALUES('cmo4m9lgj00jdp5i233auxd83',1776533650147,1776533650147,'Site directed mutagenesis, DNA-microarray; Next generation sequencing; Gene silencing and editing.',NULL,1,1,'cmo4m9ld0000ep5i2wk1rv3yh');
INSERT INTO Topic VALUES('cmo4m9lgk00jhp5i2l86wg9lv',1776533650148,1776533650148,'Historical Perspective (1)',NULL,1,1,'cmo4m9ld0000fp5i2agm4gapx');
INSERT INTO Topic VALUES('cmo4m9lgk00jlp5i25n4fr865',1776533650149,1776533650149,'Historical Perspective (2): Role of microorganisms in transformation of organic matter and in the causation of diseases',NULL,1,1,'cmo4m9ld0000fp5i2agm4gapx');
INSERT INTO Topic VALUES('cmo4m9lgl00jpp5i2v1gaym99',1776533650149,1776533650149,'Methods in Microbiology 1: Pure culture techniques; Theory and practice of sterilization; Principles of microbial nutrition; Enrichment culture techniques for isolation of microorganisms',NULL,1,1,'cmo4m9ld0000fp5i2agm4gapx');
INSERT INTO Topic VALUES('cmo4m9lgl00jtp5i2az5eyonw',1776533650150,1776533650150,'Methods in Microbiology 2: Light-, phase contrast- and electron-microscopy',NULL,1,1,'cmo4m9ld0000fp5i2agm4gapx');
INSERT INTO Topic VALUES('cmo4m9lgm00jxp5i29hmn318u',1776533650150,1776533650150,'Methods in Microbiology 3: antigen and antibody detection methods for microbial diagnosis',NULL,1,1,'cmo4m9ld0000fp5i2agm4gapx');
INSERT INTO Topic VALUES('cmo4m9lgm00k1p5i2qwx5kklu',1776533650151,1776533650151,'Methods in Microbiology 4: PCR, real-time PCR for quantitation of microbes Next generation sequencing technologies in microbiology.',NULL,1,1,'cmo4m9ld0000fp5i2agm4gapx');
INSERT INTO Topic VALUES('cmo4m9lgn00k5p5i2372vbgdn',1776533650151,1776533650151,'Microbial Taxonomy and Diversity 1: Bacteria, Archea and their broad classification Eukaryotic microbes: Yeasts, molds and protozoa',NULL,1,1,'cmo4m9ld0000fp5i2agm4gapx');
INSERT INTO Topic VALUES('cmo4m9lgn00k9p5i2blzaol2j',1776533650152,1776533650152,'Microbial Taxonomy and Diversity 2: Viruses and their classification; Molecular approaches to microbial taxonomy and phylogeny',NULL,1,1,'cmo4m9ld0000fp5i2agm4gapx');
INSERT INTO Topic VALUES('cmo4m9lgo00kdp5i210cnnwc9',1776533650153,1776533650153,'Prokaryotic Cells: cell walls, cell membranes and their biosynthesis, mechanisms of solute transport across membranes, Flagella and Pili, Capsules, Cell inclusions like endospores and gas vesicles; Bacterial locomotion, including positive and negative chemotaxis',NULL,1,1,'cmo4m9ld0000fp5i2agm4gapx');
INSERT INTO Topic VALUES('cmo4m9lgp00khp5i2gwrmg7pv',1776533650153,1776533650153,'Microbial Growth 1: Definition of growth, Growth curve, Mathematical expression of exponential growth phase',NULL,1,1,'cmo4m9ld0000fp5i2agm4gapx');
INSERT INTO Topic VALUES('cmo4m9lgp00klp5i2znauy7oa',1776533650154,1776533650154,'Microbial Growth 2: Measurement of growth and growth yields; Synchronous growth; Continuous culture; Effect of environmental factors on growth. Bacterial biofilm and biofouling',NULL,1,1,'cmo4m9ld0000fp5i2agm4gapx');
INSERT INTO Topic VALUES('cmo4m9lgq00kpp5i2nt1t94fa',1776533650154,1776533650154,'Control of Micro-organisms: Disinfection and sterilization: principles, methods and assessment of efficacy',NULL,1,1,'cmo4m9ld0000fp5i2agm4gapx');
INSERT INTO Topic VALUES('cmo4m9lgq00ktp5i2r4facq08',1776533650155,1776533650155,'Microbial Metabolism 1: Energetics: redox reactions and electron carriers; Electron transport and oxidative phosphorylation; An overview of metabolism;',NULL,1,1,'cmo4m9ld0000fp5i2agm4gapx');
INSERT INTO Topic VALUES('cmo4m9lgr00kxp5i25xw8lnpw',1776533650155,1776533650155,'Microbial Metabolism 2: Glycolysis; Pentose-phosphate pathway; Entner-Doudoroff pathway; Glyoxalate pathway; The citric acid cycle',NULL,1,1,'cmo4m9ld0000fp5i2agm4gapx');
INSERT INTO Topic VALUES('cmo4m9lgs00l1p5i2yresk7m3',1776533650156,1776533650156,'Microbial Metabolism 3: Fermentation; Aerobic and anaerobic respiration; Chemolithotrophy; Photosynthesis; Calvin cycle; Biosynthetic pathway for fatty acids synthesis',NULL,1,1,'cmo4m9ld0000fp5i2agm4gapx');
INSERT INTO Topic VALUES('cmo4m9lgt00l5p5i2oveamb50',1776533650157,1776533650157,'Microbial Metabolism 4: Common regulatory mechanisms in synthesis of amino acids; Regulation of major metabolic pathways',NULL,1,1,'cmo4m9ld0000fp5i2agm4gapx');
INSERT INTO Topic VALUES('cmo4m9lgu00l9p5i2ro1lupvo',1776533650159,1776533650159,'Microbial Diseases and Host Pathogen Interaction 1: Normal microbiota; Classification of infectious diseases; Reservoirs of infection; Nosocomial infection; Opportunistic infections; Emerging infectious diseases; Mechanism of microbial pathogenicity',NULL,1,1,'cmo4m9ld0000fp5i2agm4gapx');
INSERT INTO Topic VALUES('cmo4m9lgv00ldp5i2fis9uuna',1776533650159,1776533650159,'Microbial Diseases and Host Pathogen Interaction 2: Nonspecific defense of host; Antigens and antibodies; Humoral and cell mediated immunity; Vaccines; Passive immunization; Immune deficiency; Human diseases caused by viruses, bacteria, and pathogenic fungi',NULL,1,1,'cmo4m9ld0000fp5i2agm4gapx');
INSERT INTO Topic VALUES('cmo4m9lgw00lhp5i2u1wuml5t',1776533650160,1776533650160,'Chemotherapy/ Antibiotics: General characteristics of antimicrobial drugs; Antibiotics: Classification, mode of action and resistance; Antifungal and antiviral drugs',NULL,1,1,'cmo4m9ld0000fp5i2agm4gapx');
INSERT INTO Topic VALUES('cmo4m9lgw00llp5i2n4glf9qz',1776533650161,1776533650161,'Microbial Genetics part 1: Types of mutation; UV and chemical mutagens; Selection of mutants; Ames test for mutagenesis',NULL,1,1,'cmo4m9ld0000fp5i2agm4gapx');
INSERT INTO Topic VALUES('cmo4m9lgx00lpp5i2b1aen8vh',1776533650162,1776533650162,'Microbial Genetics part 2: Bacterial genetic system: transformation, conjugation, transduction, recombination, plasmids, transposons',NULL,1,1,'cmo4m9ld0000fp5i2agm4gapx');
INSERT INTO Topic VALUES('cmo4m9lgy00ltp5i2v1t7nynn',1776533650162,1776533650162,'Microbial Genetics part 3: DNA repair; Regulation of gene expression: repression and induction; Operon model; Bacterial genome with special reference to E.coli; Phage λ and its life cycle; RNA phages',NULL,1,1,'cmo4m9ld0000fp5i2agm4gapx');
INSERT INTO Topic VALUES('cmo4m9lgy00lxp5i2391s776h',1776533650163,1776533650163,'Microbial Genetics part 4: RNA viruses Retroviruses; mutation in virus genomes, virus recombination and reassortment; Basic concept of microbial genomics',NULL,1,1,'cmo4m9ld0000fp5i2agm4gapx');
INSERT INTO Topic VALUES('cmo4m9lgz00m1p5i2f3e6vigd',1776533650164,1776533650164,'Microbial Ecology: Microbial interactions:Carbon, sulphur and nitrogen cycles Soil microorganisms associated with vascular plants. Bioremediation; Uncultivable microorganisms; basic concept of metagenomics and metatranscriptomics',NULL,1,1,'cmo4m9ld0000fp5i2agm4gapx');

INSERT INTO VideoLecture VALUES('cmo4m9ld1000jp5i2ucodzgla',1776533650022,1776533650022,'Analytical Aptitude Video Lecture','Analogy',NULL,NULL,900,1,1776533650022,'cmo4m9ld1000hp5i214ny4m5q');
INSERT INTO VideoLecture VALUES('cmo4m9ld2000np5i20680igrz',1776533650023,1776533650023,'Analytical Aptitude Video Lecture','Numerical relations and reasoning',NULL,NULL,900,1,1776533650023,'cmo4m9ld2000lp5i2uxzbtaak');
INSERT INTO VideoLecture VALUES('cmo4m9ld3000rp5i21x3jrv9p',1776533650024,1776533650024,'Verbal Aptitude Video Lecture','Basic English grammar: Articles',NULL,NULL,900,1,1776533650024,'cmo4m9ld3000pp5i26f1gi7xq');
INSERT INTO VideoLecture VALUES('cmo4m9ld4000vp5i2gdgbs5q5',1776533650024,1776533650024,'Quantitative Aptitude Video Lecture','Average, mean, mode',NULL,NULL,900,1,1776533650024,'cmo4m9ld4000tp5i2r4um49wi');
INSERT INTO VideoLecture VALUES('cmo4m9ld5000zp5i2h61nfn1x',1776533650025,1776533650025,'Quantitative Aptitude Video Lecture','Percentage',NULL,NULL,900,1,1776533650025,'cmo4m9ld5000xp5i2t0hyav7p');
INSERT INTO VideoLecture VALUES('cmo4m9ld60013p5i25u90a6z4',1776533650026,1776533650026,'Verbal Aptitude Video Lecture','Basic English grammar: Tenses',NULL,NULL,900,1,1776533650026,'cmo4m9ld60011p5i2s2cg6x92');
INSERT INTO VideoLecture VALUES('cmo4m9ld70017p5i2c17wb07n',1776533650027,1776533650027,'Quantitative Aptitude Video Lecture','Ratio and proportions',NULL,NULL,900,1,1776533650027,'cmo4m9ld70015p5i2qfsm110d');
INSERT INTO VideoLecture VALUES('cmo4m9ld7001bp5i25r4zlef9',1776533650028,1776533650028,'Quantitative Aptitude Video Lecture','Series completion',NULL,NULL,900,1,1776533650028,'cmo4m9ld70019p5i2vg87o8cb');
INSERT INTO VideoLecture VALUES('cmo4m9ld8001fp5i2pzv2m2sh',1776533650028,1776533650028,'Quantitative Aptitude Video Lecture','Profit Loss',NULL,NULL,900,1,1776533650028,'cmo4m9ld8001dp5i2rllm1y5c');
INSERT INTO VideoLecture VALUES('cmo4m9ld9001jp5i2og7c3y6m',1776533650029,1776533650029,'Verbal Aptitude Video Lecture','Reading Comprehension',NULL,NULL,900,1,1776533650029,'cmo4m9ld9001hp5i2rm3tykv9');
INSERT INTO VideoLecture VALUES('cmo4m9lda001np5i2xr2tvp4y',1776533650030,1776533650030,'Analytical Aptitude Video Lecture','Logic: deduction and induction',NULL,NULL,900,1,1776533650030,'cmo4m9ld9001lp5i21mj2m2xr');
INSERT INTO VideoLecture VALUES('cmo4m9ldb001rp5i2ea27fs1x',1776533650031,1776533650031,'Verbal Aptitude Video Lecture','Basic vocabulary- words, idioms and phrases in context',NULL,NULL,900,1,1776533650031,'cmo4m9lda001pp5i2r4ul1weo');
INSERT INTO VideoLecture VALUES('cmo4m9ldb001vp5i2dwbum371',1776533650032,1776533650032,'Quantitative Aptitude Video Lecture','Permutation and Combination',NULL,NULL,900,1,1776533650032,'cmo4m9ldb001tp5i279sgop2p');
INSERT INTO VideoLecture VALUES('cmo4m9ldc001zp5i248kw4ck0',1776533650032,1776533650032,'Quantitative Aptitude Video Lecture','Probability',NULL,NULL,900,1,1776533650032,'cmo4m9ldc001xp5i2qd02ka8i');
INSERT INTO VideoLecture VALUES('cmo4m9ldd0023p5i25xquvoe2',1776533650033,1776533650033,'Verbal Aptitude Video Lecture','Basic English grammar: adjectives, preposition and conjunctions',NULL,NULL,900,1,1776533650033,'cmo4m9ldd0021p5i2vqwh2lxd');
INSERT INTO VideoLecture VALUES('cmo4m9lde0027p5i2azuarrss',1776533650034,1776533650034,'Quantitative Aptitude Video Lecture','Data Interpretation: data graphs (bar graphs, pie charts and other graphs representing data), 2- and 3- dimensional plots, maps and tables',NULL,NULL,900,1,1776533650034,'cmo4m9ldd0025p5i218vweddo');
INSERT INTO VideoLecture VALUES('cmo4m9lde002bp5i2sng4x229',1776533650035,1776533650035,'Quantitative Aptitude Video Lecture','Mensuration and geometry',NULL,NULL,900,1,1776533650035,'cmo4m9lde0029p5i2owr35tan');
INSERT INTO VideoLecture VALUES('cmo4m9ldf002fp5i259a3se33',1776533650036,1776533650036,'Verbal Aptitude Video Lecture','English grammar: verb-noun agreement and other parts of speech',NULL,NULL,900,1,1776533650036,'cmo4m9ldf002dp5i2fjldb0ul');
INSERT INTO VideoLecture VALUES('cmo4m9ldg002jp5i2tvyrtta0',1776533650036,1776533650036,'Quantitative Aptitude Video Lecture','Speed and distance',NULL,NULL,900,1,1776533650036,'cmo4m9ldg002hp5i2kqikj3fj');
INSERT INTO VideoLecture VALUES('cmo4m9ldg002np5i204lbntlc',1776533650037,1776533650037,'Spatial Aptitude Video Lecture','Transformation of shapes:Translation, rotation, scaling, mirroring, assembling and grouping, Paper folding, cutting and patterns in 2 and 3 dimensions',NULL,NULL,900,1,1776533650037,'cmo4m9ldg002lp5i2bpemzue0');
INSERT INTO VideoLecture VALUES('cmo4m9ldh002rp5i2pubb7rov',1776533650038,1776533650038,'Verbal Aptitude Video Lecture','Narrative sequencing',NULL,NULL,900,1,1776533650038,'cmo4m9ldh002pp5i2it83x5yy');
INSERT INTO VideoLecture VALUES('cmo4m9ldi002vp5i23q3g1qc9',1776533650039,1776533650039,'Quantitative Aptitude Video Lecture','Powers, exponents and logarithms',NULL,NULL,900,1,1776533650039,'cmo4m9ldi002tp5i2nxkn7hze');
INSERT INTO VideoLecture VALUES('cmo4m9ldj002zp5i2e4154neb',1776533650040,1776533650040,'Quantitative Aptitude Video Lecture','Elementary statistics',NULL,NULL,900,1,1776533650040,'cmo4m9ldj002xp5i2qrlurp0l');
INSERT INTO VideoLecture VALUES('cmo4m9ldk0033p5i2uu6auq2b',1776533650040,1776533650040,'Quantitative Aptitude Video Lecture','Time and work',NULL,NULL,900,1,1776533650040,'cmo4m9ldk0031p5i2j5x7oo2j');
INSERT INTO VideoLecture VALUES('cmo4m9ldl0037p5i27pdyd92k',1776533650041,1776533650041,'Basics of Engineering Mathematics Video Lecture',NULL,NULL,NULL,900,1,1776533650041,'cmo4m9ldl0035p5i2v5h8na33');
INSERT INTO VideoLecture VALUES('cmo4m9ldm003bp5i2ftjdwhj4',1776533650042,1776533650042,'Linear Algebra Video Lecture','Algebra of real matrices: Determinant, inverse and rank of a matrix; System of linear equations (conditions for unique solution, no solution and infinite number of solutions)',NULL,NULL,900,1,1776533650042,'cmo4m9ldm0039p5i27vfvpttc');
INSERT INTO VideoLecture VALUES('cmo4m9ldn003fp5i2auqch00u',1776533650043,1776533650043,'Linear Algebra Video Lecture','Eigenvalues and eigenvectors of matrices; Properties of eigenvalues and eigenvectors of symmetric matrices, diagonalization of matrices; Cayley Hamilton Theorem',NULL,NULL,900,1,1776533650043,'cmo4m9ldn003dp5i21filmr8x');
INSERT INTO VideoLecture VALUES('cmo4m9ldo003jp5i25bnsj407',1776533650044,1776533650044,'Calculus Video Lecture',unistr('Functions of single variable: Limit, indeterminate forms and L''Hospital''s rule; Continuity and differentiability;\u000aMean value theorems; Maxima and minima; Taylor''s theorem; Fundamental theorem and mean value theorem of integral calculus;'),NULL,NULL,900,1,1776533650044,'cmo4m9ldo003hp5i2srfxg9n7');
INSERT INTO VideoLecture VALUES('cmo4m9ldp003np5i2hvqqwsig',1776533650045,1776533650045,'Calculus Video Lecture','Evaluation of definite and improper integrals; Applications of definite integrals to evaluate areas and volumes (rotation of a curve about an axis)',NULL,NULL,900,1,1776533650045,'cmo4m9ldo003lp5i29at6v7np');
INSERT INTO VideoLecture VALUES('cmo4m9ldq003rp5i24crkkbjq',1776533650046,1776533650046,'Calculus Video Lecture','Functions of two variables: Limit, continuity and partial derivatives; Directional derivative; Total derivative; Maxima, minima and saddle points; Method of Lagrange multipliers; Double integrals and their applications',NULL,NULL,900,1,1776533650046,'cmo4m9ldp003pp5i2ixziw7b4');
INSERT INTO VideoLecture VALUES('cmo4m9ldr003vp5i22c47ny1n',1776533650047,1776533650047,'Complex Variables Video Lecture','Complex numbers, Argand plane and polar representation of complex numbers; De Moivre’s theorem; Analytic functions; Cauchy-Riemann equations.',NULL,NULL,900,1,1776533650047,'cmo4m9ldr003tp5i27gzl0rkh');
INSERT INTO VideoLecture VALUES('cmo4m9ldr003zp5i2s1jmyqsj',1776533650048,1776533650048,'Probability Video Lecture','Axioms of probability; Conditional probability; Bayes'' Theorem;',NULL,NULL,900,1,1776533650048,'cmo4m9ldr003xp5i2f949fumm');
INSERT INTO VideoLecture VALUES('cmo4m9lds0043p5i2qf1k7qf9',1776533650049,1776533650049,'Statistics Video Lecture','Mean, variance and standard deviation of random variables; Binomial, Poisson and Normal distributions; Correlation and linear regression.',NULL,NULL,900,1,1776533650049,'cmo4m9lds0041p5i2lnj8nd6o');
INSERT INTO VideoLecture VALUES('cmo4m9ldt0047p5i2ee8z0ps7',1776533650050,1776533650050,'Sequence and series Video Lecture','Convergence of sequences and series; Tests of convergence of series with non-negative terms (ratio, root and integral tests); Power series; Taylor''s series; Fourier Series of functions of period 2π.',NULL,NULL,900,1,1776533650050,'cmo4m9ldt0045p5i2if43o0fn');
INSERT INTO VideoLecture VALUES('cmo4m9ldu004bp5i23rr667yf',1776533650051,1776533650051,'Vector Calculus Video Lecture','Gradient, divergence and curl; Line integrals and Green''s theorem.',NULL,NULL,900,1,1776533650051,'cmo4m9ldu0049p5i2wojng6zc');
INSERT INTO VideoLecture VALUES('cmo4m9ldv004fp5i24qelluev',1776533650051,1776533650051,'ODE Video Lecture','First order equations (linear and nonlinear); Second order linear differential equations with constant coefficients;',NULL,NULL,900,1,1776533650051,'cmo4m9ldv004dp5i2cmf046l2');
INSERT INTO VideoLecture VALUES('cmo4m9ldw004jp5i2nxtqd33a',1776533650052,1776533650052,'ODE Video Lecture','Cauchy-Euler equation; Second order linear differential equations with variable coefficients; Wronskian; Method of variation of parameters;',NULL,NULL,900,1,1776533650052,'cmo4m9ldw004hp5i2bd9grdwh');
INSERT INTO VideoLecture VALUES('cmo4m9ldx004np5i2pk5uajss',1776533650053,1776533650053,'ODE Video Lecture','Eigenvalue problem for second order equations with constant coefficients; Power series solutions for ordinary points.',NULL,NULL,900,1,1776533650053,'cmo4m9ldx004lp5i2ljx6mnf3');
INSERT INTO VideoLecture VALUES('cmo4m9ldy004rp5i2a2231kr9',1776533650054,1776533650054,'Partial Differential Equation Video Lecture','Classification of second order linear partial differential equations;',NULL,NULL,900,1,1776533650054,'cmo4m9ldy004pp5i2hv9twp31');
INSERT INTO VideoLecture VALUES('cmo4m9ldy004vp5i2711ceabb',1776533650055,1776533650055,'Partial Differential Equation Video Lecture','Method of separation of variables: One dimensional heat equation and two dimensional Laplace equation',NULL,NULL,900,1,1776533650055,'cmo4m9ldy004tp5i2tftt5v5r');
INSERT INTO VideoLecture VALUES('cmo4m9ldz004zp5i2ktpml764',1776533650056,1776533650056,'Numerical Methods Video Lecture',unistr('Solution of systems of linear equations using LU decomposition, Gauss elimination method; Lagrange and Newton''s interpolations; Solution of polynomial and transcendental equations by\u000aNewton-Raphson method'),NULL,NULL,900,1,1776533650056,'cmo4m9ldz004xp5i22c5h0lz1');
INSERT INTO VideoLecture VALUES('cmo4m9le00053p5i2kcp0ua26',1776533650057,1776533650057,'Numerical Methods Video Lecture',unistr('Numerical integration by trapezoidal rule and Simpson''s rule;\u000aNumerical solutions of first order differential equations by explicit Euler''s method.'),NULL,NULL,900,1,1776533650057,'cmo4m9le00051p5i2d5uqw8dc');
INSERT INTO VideoLecture VALUES('cmo4m9le10057p5i206h7zqky',1776533650058,1776533650058,'Basic Concepts Video Lecture',unistr('Introduction\u000aContinuum and macroscopic approach\u000aThermodynamic systems (closed and open)\u000aThermodynamic properties and equilibrium'),NULL,'https://www.youtube.com/embed/8w9TwlRzemA?si=ABGjyUsfmWBtjYNn',900,1,1776533650058,'cmo4m9le10055p5i2x6a458th');
INSERT INTO VideoLecture VALUES('cmo4m9le2005bp5i2s9rwe19o',1776533650059,1776533650059,'Second topic inside a module Video Lecture','Second topic description',NULL,NULL,1200,1,1776533650059,'cmo4m9le20059p5i2b3wn7dwh');
INSERT INTO VideoLecture VALUES('cmo4m9le3005fp5i2bsj2hvr4',1776533650059,1776533650059,'Basic Concepts Video Lecture',unistr('State of a system\u000aState postulate for simple compressible substances\u000aState diagrams\u000aPaths and processes on state diagram\u000aConcepts of heat and work\u000aDifferent modes of work'),NULL,NULL,900,1,1776533650059,'cmo4m9le3005dp5i2cckf7qh7');
INSERT INTO VideoLecture VALUES('cmo4m9le4005jp5i2gvqk95zz',1776533650060,1776533650060,'Basic Concepts Video Lecture',unistr('Ideal gas equation\u000aZeroth law of thermodynamics\u000aConcept of temperature'),NULL,NULL,900,1,1776533650060,'cmo4m9le4005hp5i27vtvbccc');
INSERT INTO VideoLecture VALUES('cmo4m9le5005np5i2ilag0ww0',1776533650061,1776533650061,'First law of Thermodynamics Video Lecture',unistr('Concept of energy and various forms of energy\u000aInternal Energy\u000aEnthalpy\u000aSpecific heats'),NULL,NULL,900,1,1776533650061,'cmo4m9le5005lp5i2ikpzlvg3');
INSERT INTO VideoLecture VALUES('cmo4m9le5005rp5i2vn07ywj6',1776533650062,1776533650062,'First law of Thermodynamics Video Lecture','First law applied to elementary processes, closed systems and control volumes',NULL,NULL,900,1,1776533650062,'cmo4m9le5005pp5i24c3aqr6g');
INSERT INTO VideoLecture VALUES('cmo4m9le6005vp5i2eaz183g8',1776533650063,1776533650063,'First Law of Thermodynamics Video Lecture','Steady and unsteady flow analysis',NULL,NULL,900,1,1776533650063,'cmo4m9le6005tp5i2y44fmlia');
INSERT INTO VideoLecture VALUES('cmo4m9le7005zp5i27gv6dmp7',1776533650064,1776533650064,'Second Law of Thermodynamics Video Lecture',unistr('Limitations of first law of thermodynamics\u000aConcept of heat engines and heat pumps/ refrigerators'),NULL,NULL,900,1,1776533650064,'cmo4m9le7005xp5i2pflcit1j');
INSERT INTO VideoLecture VALUES('cmo4m9le80063p5i2aymrntn9',1776533650064,1776533650064,'Second Law of Thermodynamics Video Lecture',unistr('Kelvin-Planck and Clausius statements and their equivalence\u000aReversible and irreversible processes'),NULL,NULL,900,1,1776533650064,'cmo4m9le80061p5i2026gwhum');
INSERT INTO VideoLecture VALUES('cmo4m9le90067p5i20m7t2zgf',1776533650065,1776533650065,'Second Law of Thermodynamics Video Lecture',unistr('Carnot cycle and Carnot principles/theorems\u000aThermodymanic temperature scale'),NULL,NULL,900,1,1776533650065,'cmo4m9le90065p5i2lij2nqg9');
INSERT INTO VideoLecture VALUES('cmo4m9lea006bp5i2nhs6xjwd',1776533650066,1776533650066,'Second Law of Thermodynamics Video Lecture',unistr('Clausius inequality and concept of entropy\u000aMicroscopic interpretation of entropy\u000aThe principle of increase of entropy\u000aT-s diagrams'),NULL,NULL,900,1,1776533650066,'cmo4m9lea0069p5i283dkbayb');
INSERT INTO VideoLecture VALUES('cmo4m9leb006fp5i207hnb3sv',1776533650067,1776533650067,'Second Law of Thermodynamics Video Lecture',unistr('Second law analysis of control volume\u000aAvailability and irreversibilty\u000aThird law of thermodynamics'),NULL,NULL,900,1,1776533650067,'cmo4m9lea006dp5i2erfqvaly');
INSERT INTO VideoLecture VALUES('cmo4m9leb006jp5i2aajsr9wo',1776533650068,1776533650068,'Properties of pure substances Video Lecture',unistr('Thermodynamic properties of pure substances in solid, liquid and vapor phases\u000aPvT behaviour of simple compressible substances\u000aPhase rule\u000aThermodynamic property tables and charts\u000aIdeal and real gases\u000aIdeal gas equation of state and van der Waals equation of state'),NULL,NULL,900,1,1776533650068,'cmo4m9leb006hp5i20duhq60u');
INSERT INTO VideoLecture VALUES('cmo4m9lec006np5i2isq7n5qq',1776533650068,1776533650068,'Properties of pure substances Video Lecture',unistr('Law of corresponding states\u000aCompressibility factor and generalized compressibility chart'),NULL,NULL,900,1,1776533650068,'cmo4m9lec006lp5i2x752qv8v');
INSERT INTO VideoLecture VALUES('cmo4m9led006rp5i2s582kakp',1776533650069,1776533650069,'Thermodynamic Relations Video Lecture',unistr('Tds relations\u000aHelmholtz and Gibbs functions\u000aGibbs relations\u000aMaxwell relations\u000aJoule-Thomson coefficient\u000aCoefficient of volume expansion\u000aAdiabatic and isothermal compressibilities\u000aClapeyron and Clapeyron-Clausius equations'),NULL,NULL,900,1,1776533650069,'cmo4m9led006pp5i2ukymg4en');
INSERT INTO VideoLecture VALUES('cmo4m9lee006vp5i2ssy3vt42',1776533650070,1776533650070,'Thermodynamic Cycles Video Lecture',unistr('Carnot vapor cycle\u000aIdeal Rankine cycle\u000aRankine reheat cycle'),NULL,NULL,900,1,1776533650070,'cmo4m9lee006tp5i2laii3l8d');
INSERT INTO VideoLecture VALUES('cmo4m9lee006zp5i2er3ok3f2',1776533650071,1776533650071,'Thermodynamic Cycles Video Lecture',unistr('Air-standard Otto cycle\u000aAir-standard Diesel cycle\u000aAir-standard Brayton cycle'),NULL,NULL,900,1,1776533650071,'cmo4m9lee006xp5i2vuvqlpi8');
INSERT INTO VideoLecture VALUES('cmo4m9lef0073p5i2l2vnjset',1776533650071,1776533650071,'Thermodynamic Cycles Video Lecture','Vapor-compression refrigeration cycle',NULL,NULL,900,1,1776533650071,'cmo4m9lef0071p5i2zwao1jeo');
INSERT INTO VideoLecture VALUES('cmo4m9leg0077p5i2ucf62s6w',1776533650072,1776533650072,'Ideal gas mixtures Video Lecture',unistr('Dalton’s and Amagat’s laws\u000aProperties of ideal gas mixtures'),NULL,NULL,900,1,1776533650072,'cmo4m9leg0075p5i2actbg3hz');
INSERT INTO VideoLecture VALUES('cmo4m9leh007bp5i26fchhc4i',1776533650073,1776533650073,'Ideal gas mixtures Video Lecture',unistr('Air-water vapor mixtures and simple thermodynamic processes involving them\u000aSpecific and relative humidities\u000aDew point and wet bulb temperature\u000aAdiabatic saturation temperature'),NULL,NULL,900,1,1776533650073,'cmo4m9leh0079p5i2rhvwuumb');
INSERT INTO VideoLecture VALUES('cmo4m9lei007fp5i2cf789koi',1776533650074,1776533650074,'Ideal gas mixtures Video Lecture','Psychrometric chart',NULL,NULL,900,1,1776533650074,'cmo4m9lei007dp5i2fkjunymj');
INSERT INTO VideoLecture VALUES('cmo4m9lei007jp5i2ixe0bzla',1776533650075,1776533650075,'Carbohydrates Video Lecture','Structure and functional properties of mono-, oligo-, & poly-saccharides, starch, Cellulose',NULL,'https://www.youtube.com/embed/Pv-UxwkV0zU?si=DC2X2SniGkrGcedS',900,1,1776533650075,'cmo4m9lei007hp5i2irc09skw');
INSERT INTO VideoLecture VALUES('cmo4m9lej007np5i2n24icj6f',1776533650076,1776533650076,'Mass and Energy Balance Video Lecture',NULL,NULL,NULL,1200,1,1776533650076,'cmo4m9lej007lp5i2xzulwign');
INSERT INTO VideoLecture VALUES('cmo4m9lek007rp5i2dj1qag2z',1776533650076,1776533650076,'Microorganisms Video Lecture','Characteristics of microorganisms: morphology of bacteria, gram-staining',NULL,NULL,900,1,1776533650076,'cmo4m9lek007pp5i29jpfozoz');
INSERT INTO VideoLecture VALUES('cmo4m9lel007vp5i2c5wcssin',1776533650077,1776533650077,'Carbohydrates Video Lecture','Pectic substances dietary fibre, gelatinization of starch, Retrogradation of starch',NULL,NULL,1200,1,1776533650077,'cmo4m9lel007tp5i29mpetr7j');
INSERT INTO VideoLecture VALUES('cmo4m9lel007zp5i2ojzkanh8',1776533650078,1776533650078,'Microorganisms Video Lecture','Morphology of yeast, morphology of mold, morphology of actinomycetes, spores and vegetative cells',NULL,NULL,900,1,1776533650078,'cmo4m9lel007xp5i26f7jrvn0');
INSERT INTO VideoLecture VALUES('cmo4m9lem0083p5i2i32o5noj',1776533650079,1776533650079,'Intermediate Moisture Foods Video Lecture','Moisture content, Water activity',NULL,NULL,1200,1,1776533650079,'cmo4m9lem0081p5i20dm6zcol');
INSERT INTO VideoLecture VALUES('cmo4m9len0087p5i2o803func',1776533650079,1776533650079,'Lipids Video Lecture','Classification, structure of lipids, rancidity, polymerization, polymorphism',NULL,NULL,900,1,1776533650079,'cmo4m9len0085p5i2ccihnqtq');
INSERT INTO VideoLecture VALUES('cmo4m9leo008bp5i2fd90jrgv',1776533650080,1776533650080,'Processing Principles Video Lecture','Thermal processing - Blanching, Pasteurization and Sterilization',NULL,NULL,1200,1,1776533650080,'cmo4m9leo0089p5i277f709pl');
INSERT INTO VideoLecture VALUES('cmo4m9lep008fp5i23ya07s5j',1776533650081,1776533650081,'Oil Processing Video Lecture','Expelling, solvent extraction, refining, hydrogenation',NULL,NULL,900,1,1776533650081,'cmo4m9lep008dp5i2jt87ex5x');
INSERT INTO VideoLecture VALUES('cmo4m9lep008jp5i2n3mujo74',1776533650082,1776533650082,'Proteins Video Lecture','Classification, structure of proteins in food',NULL,NULL,1200,1,1776533650082,'cmo4m9lep008hp5i2n6e5vng0');
INSERT INTO VideoLecture VALUES('cmo4m9leq008np5i2hv5j58qt',1776533650083,1776533650083,'Microbial Growth Video Lecture','Growth and death kinetics, serial dilution technique',NULL,NULL,900,1,1776533650083,'cmo4m9leq008lp5i2sri7qi7l');
INSERT INTO VideoLecture VALUES('cmo4m9ler008rp5i2dyx5rdv8',1776533650083,1776533650083,'Enzymes Video Lecture','Specificity, simple and inhibition kinetics, coenzymes',NULL,NULL,1200,1,1776533650083,'cmo4m9ler008pp5i2z5fqjieq');
INSERT INTO VideoLecture VALUES('cmo4m9les008vp5i2etzkkvug',1776533650084,1776533650084,'Thermal Operations Video Lecture','Thermal sterilization - D,F,Z values',NULL,'https://www.youtube.com/embed/H6xvluM7fy0?si=3u1wJvFxIT-40l8_',900,1,1776533650084,'cmo4m9les008tp5i2zbmymzak');
INSERT INTO VideoLecture VALUES('cmo4m9les008zp5i2d6y5i13u',1776533650085,1776533650085,'Plantation Crops Processing Video Lecture','Tea',NULL,NULL,1200,1,1776533650085,'cmo4m9les008xp5i2xdn6gmys');
INSERT INTO VideoLecture VALUES('cmo4m9let0093p5i2zoohy1dw',1776533650085,1776533650085,'Momentum Transfer Video Lecture','Flow rate and pressure drop relationships for Newtonian fluids flowing through pipe, Reynolds number',NULL,NULL,900,1,1776533650085,'cmo4m9let0091p5i2iap1mo3s');
INSERT INTO VideoLecture VALUES('cmo4m9leu0097p5i271tvjpz0',1776533650086,1776533650086,'Browning Video Lecture','Enzymatic and Non enzymatic browning',NULL,NULL,1200,1,1776533650086,'cmo4m9leu0095p5i2g80v7363');
INSERT INTO VideoLecture VALUES('cmo4m9lev009bp5i2xdk4oylo',1776533650087,1776533650087,'Fermented Beverages Video Lecture','Alcoholic beverages',NULL,NULL,900,1,1776533650087,'cmo4m9leu0099p5i2ptbjyknr');
INSERT INTO VideoLecture VALUES('cmo4m9lev009fp5i238hwdj60',1776533650088,1776533650088,'Fermented Foods Video Lecture','Curd, yogurt, cheese, pickle, sauerkraut, soya sauce, idli & dosa, vinegar, sauce',NULL,NULL,1200,1,1776533650088,'cmo4m9lev009dp5i26axk6ttx');
INSERT INTO VideoLecture VALUES('cmo4m9lew009jp5i2whgzkqi2',1776533650089,1776533650089,'Cereal Processing Video Lecture','Parboiling of paddy',NULL,NULL,900,1,1776533650089,'cmo4m9lew009hp5i2ji6a80dr');
INSERT INTO VideoLecture VALUES('cmo4m9lex009np5i28f7dz5kw',1776533650090,1776533650090,'Cereal Processing Video Lecture','Milling of rice. Waste utilization: uses of by-products from rice milling',NULL,NULL,1200,1,1776533650090,'cmo4m9lex009lp5i28ntgwqr0');
INSERT INTO VideoLecture VALUES('cmo4m9ley009rp5i286oa3t68',1776533650090,1776533650090,'Heat Transfer Video Lecture','Heat transfer by conduction, convection, Radiation',NULL,NULL,900,1,1776533650090,'cmo4m9ley009pp5i2842m09yv');
INSERT INTO VideoLecture VALUES('cmo4m9ley009vp5i2t96hcpzw',1776533650091,1776533650091,'Cereal Processing Video Lecture','Milling of wheat',NULL,NULL,1200,1,1776533650091,'cmo4m9ley009tp5i27vibnzlw');
INSERT INTO VideoLecture VALUES('cmo4m9lez009zp5i2oc7e1euo',1776533650092,1776533650092,'Heat Transfer Video Lecture','Heat exchangers',NULL,NULL,900,1,1776533650092,'cmo4m9lez009xp5i2k972huw0');
INSERT INTO VideoLecture VALUES('cmo4m9lf000a3p5i20vrngfcl',1776533650092,1776533650092,'Cereal Processing Video Lecture','Milling of maize',NULL,NULL,1200,1,1776533650092,'cmo4m9lf000a1p5i2o0be7834');
INSERT INTO VideoLecture VALUES('cmo4m9lf000a7p5i29luaam8o',1776533650093,1776533650093,'Meat Video Lecture','Biochemical changes in post mortem, tenderization of muscles',NULL,NULL,900,1,1776533650093,'cmo4m9lf000a5p5i2m9l2tmdw');
INSERT INTO VideoLecture VALUES('cmo4m9lf100abp5i209um4mfu',1776533650093,1776533650093,'Nutrition Video Lecture','Water soluble and fat soluble vitamins, role of minerals in nutrition, co-factors, anti-nutrients, nutraceuticals',NULL,NULL,1200,1,1776533650093,'cmo4m9lf100a9p5i2hmmkdjr6');
INSERT INTO VideoLecture VALUES('cmo4m9lf200afp5i2gascf7at',1776533650094,1776533650094,'Nutrition Video Lecture','Balanced diet, essential amino acids, essential fatty acids, protein efficiency ratio, nutrient deficiency diseases',NULL,NULL,1500,1,1776533650094,'cmo4m9lf200adp5i2ghr3q6hd');
INSERT INTO VideoLecture VALUES('cmo4m9lf200ajp5i2kxsxepcc',1776533650095,1776533650095,'Milk Processing Video Lecture','Pasteurization, sterilization, High pressure homogenization',NULL,NULL,900,1,1776533650095,'cmo4m9lf200ahp5i2wch90b7y');
INSERT INTO VideoLecture VALUES('cmo4m9lf300anp5i248k3flzp',1776533650095,1776533650095,'Mechanical Operation in Milk Processing Video Lecture','Filtration, centrifugation',NULL,NULL,1200,1,1776533650095,'cmo4m9lf300alp5i2z0km0m41');
INSERT INTO VideoLecture VALUES('cmo4m9lf300arp5i2cce8dyyz',1776533650096,1776533650096,'Milk Products Processing Video Lecture','Cream, Butter, Ghee, Ice cream, Cheese, Milk powder',NULL,NULL,900,1,1776533650096,'cmo4m9lf300app5i2wd42rtmm');
INSERT INTO VideoLecture VALUES('cmo4m9lf400avp5i241my35oz',1776533650096,1776533650096,'Processing Principle Video Lecture','Irradiation',NULL,NULL,1200,1,1776533650096,'cmo4m9lf400atp5i2pcct8an4');
INSERT INTO VideoLecture VALUES('cmo4m9lf500azp5i2dukij46u',1776533650097,1776533650097,'Food Spoilage Video Lecture','Spoilage microorganisms in fish, milk, meat, egg, cereal and their products',NULL,NULL,900,1,1776533650097,'cmo4m9lf400axp5i2p0i0lzdn');
INSERT INTO VideoLecture VALUES('cmo4m9lf500b3p5i2ejf6a3z0',1776533650098,1776533650098,'Pigments Video Lecture','Carotenoids, chlorophylls, anthocyanins, tannins, myoglobin. Food flavours: Terpenes, esters, aldehydes, ketones and quinines',NULL,NULL,1200,1,1776533650098,'cmo4m9lf500b1p5i2w8zdchc4');
INSERT INTO VideoLecture VALUES('cmo4m9lf600b7p5i27l1wtj3g',1776533650098,1776533650098,'Mass Transfer Video Lecture','Molecular diffusion and Fick''s law, conduction and convective mass transfer, permeability through single and multilayer films',NULL,NULL,900,1,1776533650098,'cmo4m9lf600b5p5i24vbnz2fx');
INSERT INTO VideoLecture VALUES('cmo4m9lf600bbp5i22ecqx3lw',1776533650099,1776533650099,'Plantation Crops Processing Video Lecture','Coffee',NULL,NULL,1200,1,1776533650099,'cmo4m9lf600b9p5i2t6qqbsr8');
INSERT INTO VideoLecture VALUES('cmo4m9lf700bfp5i22n5fwihm',1776533650099,1776533650099,'Cereal Processing Video Lecture','Bread, biscuits, extruded products, ready to eat breakfast cereals',NULL,NULL,900,1,1776533650099,'cmo4m9lf700bdp5i2lfphci2q');
INSERT INTO VideoLecture VALUES('cmo4m9lf700bjp5i23p4ihihp',1776533650100,1776533650100,'Food Standards Video Lecture','Food plant sanitation and cleaning in place (CIP)',NULL,NULL,1200,1,1776533650100,'cmo4m9lf700bhp5i21mrggv98');
INSERT INTO VideoLecture VALUES('cmo4m9lf800bnp5i277sjjxvr',1776533650101,1776533650101,'Processing Principles Video Lecture','Chilling, freezing, crystallization',NULL,NULL,900,1,1776533650101,'cmo4m9lf800blp5i2xizmz7dn');
INSERT INTO VideoLecture VALUES('cmo4m9lf900brp5i2m6os47ws',1776533650101,1776533650101,'Mass Transfer Operations Video Lecture','Psychometric, humidification and dehumidification operations',NULL,NULL,1200,1,1776533650101,'cmo4m9lf900bpp5i2pxxm0ynn');
INSERT INTO VideoLecture VALUES('cmo4m9lfa00bvp5i21mj4kmxx',1776533650102,1776533650102,'Plantation Crops Processing Video Lecture','Spice, extraction of essential oils and oleoresins from spice',NULL,NULL,900,1,1776533650102,'cmo4m9lf900btp5i2z7l87jql');
INSERT INTO VideoLecture VALUES('cmo4m9lfa00bzp5i2ux1vv141',1776533650103,1776533650103,'Thermal Operations Video Lecture','Evaporation of liquid foods',NULL,NULL,1200,1,1776533650103,'cmo4m9lfa00bxp5i2u8p9ovfy');
INSERT INTO VideoLecture VALUES('cmo4m9lfb00c3p5i27gmbqri5',1776533650103,1776533650103,'Thermal Operations Video Lecture','Hot air drying of solids; Spray drying, Freeze drying, Dehydration',NULL,NULL,900,1,1776533650103,'cmo4m9lfb00c1p5i28gsejw41');
INSERT INTO VideoLecture VALUES('cmo4m9lfb00c7p5i2ff4cmom6',1776533650104,1776533650104,'Plantation Crops Processing Video Lecture','Cocoa',NULL,NULL,1200,1,1776533650104,'cmo4m9lfb00c5p5i2udotqm1i');
INSERT INTO VideoLecture VALUES('cmo4m9lfc00cbp5i2hot58b70',1776533650104,1776533650104,'Processing of Animal Products Video Lecture','Drying, canning, and freezing of fish and meat',NULL,NULL,900,1,1776533650104,'cmo4m9lfc00c9p5i27nln5kfe');
INSERT INTO VideoLecture VALUES('cmo4m9lfd00cfp5i25nou7z13',1776533650106,1776533650106,'Processing of Animal Products Video Lecture','Production of egg powder',NULL,NULL,1200,1,1776533650106,'cmo4m9lfd00cdp5i2mun3mw4l');
INSERT INTO VideoLecture VALUES('cmo4m9lfe00cjp5i2psm2fzla',1776533650107,1776533650107,'Food Standards Video Lecture','HACCP',NULL,NULL,900,1,1776533650107,'cmo4m9lfe00chp5i2jkpe9dmq');
INSERT INTO VideoLecture VALUES('cmo4m9lff00cnp5i2y1vmuqmi',1776533650107,1776533650107,'Food Standards Video Lecture','FPO, PFA, A-Mark, ISI',NULL,NULL,1200,1,1776533650107,'cmo4m9lff00clp5i20eep8wxn');
INSERT INTO VideoLecture VALUES('cmo4m9lff00crp5i299l0dh7p',1776533650108,1776533650108,'Waste Utilization Video Lecture','Pectin from fruit wastes',NULL,NULL,1500,1,1776533650108,'cmo4m9lff00cpp5i2khr7rhko');
INSERT INTO VideoLecture VALUES('cmo4m9lfg00cvp5i21dtdc2ul',1776533650108,1776533650108,'Mechanical Operation Video Lecture','Settling, sieving, mixing & agitation of liquid',NULL,NULL,900,1,1776533650108,'cmo4m9lfg00ctp5i2xlmswh64');
INSERT INTO VideoLecture VALUES('cmo4m9lfg00czp5i2zi1idmhw',1776533650109,1776533650109,'Processing Principle Video Lecture','Hurdle technology',NULL,NULL,1200,1,1776533650109,'cmo4m9lfg00cxp5i2esk45xfk');
INSERT INTO VideoLecture VALUES('cmo4m9lfh00d3p5i2amj5y8wf',1776533650109,1776533650109,'Mechanical Operation Video Lecture','Size reduction of solids',NULL,NULL,900,1,1776533650109,'cmo4m9lfh00d1p5i2w04llk4f');
INSERT INTO VideoLecture VALUES('cmo4m9lfi00d7p5i2ips8djy6',1776533650110,1776533650110,'Processing Principle Video Lecture','Addition of preservatives and food additives',NULL,NULL,1200,1,1776533650110,'cmo4m9lfi00d5p5i2fq97adtj');
INSERT INTO VideoLecture VALUES('cmo4m9lfi00dbp5i266ecwfso',1776533650111,1776533650111,'Fruit and Vegetable Processing Video Lecture','Extraction, clarification, concentration and packaging of fruit juice, jam, jelly, marmalade, squash, candies, tomato sauce, ketchup, and puree, potato chips, pickles',NULL,NULL,900,1,1776533650111,'cmo4m9lfi00d9p5i2td1qx682');
INSERT INTO VideoLecture VALUES('cmo4m9lfj00dfp5i25im7owxu',1776533650111,1776533650111,'Food Packaging and Storage Video Lecture','Packaging materials, aseptic packaging, controlled and modified atmosphere storage',NULL,NULL,1200,1,1776533650111,'cmo4m9lfj00ddp5i2nmvn96qq');
INSERT INTO VideoLecture VALUES('cmo4m9lfj00djp5i2n6oc7es1',1776533650112,1776533650112,'Toxins from Microbes Video Lecture','Pathogens and non-pathogens, Staphylococcus, Salmonella, Shebelle, Shigella, Escherichia, Bacillus, Clostridium Aspergillus genera',NULL,NULL,900,1,1776533650112,'cmo4m9lfj00dhp5i2l4tnq3d0');
INSERT INTO VideoLecture VALUES('cmo4m9lfk00dnp5i2xokdgg72',1776533650113,1776533650113,'Chemical and Biochemical Changes Video Lecture','Changes occurring in foods during different processing',NULL,NULL,1200,1,1776533650113,'cmo4m9lfk00dlp5i2siakb62z');
INSERT INTO VideoLecture VALUES('cmo4m9lfl00drp5i2lydkuk42',1776533650113,1776533650113,'Processing Principle Video Lecture','Fermentation',NULL,NULL,1500,1,1776533650113,'cmo4m9lfl00dpp5i2abghgxjs');
INSERT INTO VideoLecture VALUES('cmo4m9lfl00dvp5i29ir8ldgy',1776533650114,1776533650114,'Primitive atomic models (briefly), wave particle duality of electromagnetic radiation, Black body radiation and Planck''s quantum theory Video Lecture',NULL,NULL,'https://www.youtube.com/embed/qqdA2impLh8?si=etSjQNJcVSpZ_cZZ',900,1,1776533650114,'cmo4m9lfl00dtp5i2qlzh8d89');
INSERT INTO VideoLecture VALUES('cmo4m9lfm00dzp5i2bfuf6bgt',1776533650115,1776533650115,'Comparison between Bohr''s model and quantum mechanical model, uncertainty principle, electronic configuration of atoms and ions, Hund''s rule and Pauli''s exclusion principle Video Lecture',NULL,NULL,NULL,900,1,1776533650115,'cmo4m9lfm00dxp5i2tnr0kzng');
INSERT INTO VideoLecture VALUES('cmo4m9lfn00e3p5i2du31mcx3',1776533650115,1776533650115,'Periodic table & periodic properties: ionisation energy, electronegativity, electron affinity and atomic size Video Lecture',NULL,NULL,NULL,900,1,1776533650115,'cmo4m9lfn00e1p5i21n1upoop');
INSERT INTO VideoLecture VALUES('cmo4m9lfo00e7p5i2r69ieyec',1776533650116,1776533650116,'Structure and bonding: ionic and covalent bonding, MO & VB approaches for diatomic molecules Video Lecture',NULL,NULL,NULL,900,1,1776533650116,'cmo4m9lfo00e5p5i2r4s00xu3');
INSERT INTO VideoLecture VALUES('cmo4m9lfo00ebp5i20qzn1ihh',1776533650117,1776533650117,'VSEPR theory and shape of molecules, hybridization, resonance, dipole moment, structural parameters, hydrogen bonding and van der Waals interaction, ionic solids and ionic radii, lattice energy (Born‐Haber cycle), HSAB principle Video Lecture',NULL,NULL,NULL,900,1,1776533650117,'cmo4m9lfo00e9p5i2gsodzqg5');
INSERT INTO VideoLecture VALUES('cmo4m9lfp00efp5i2byar30s4',1776533650117,1776533650117,'s block elements Video Lecture',NULL,NULL,NULL,900,1,1776533650117,'cmo4m9lfp00edp5i25esbymu0');
INSERT INTO VideoLecture VALUES('cmo4m9lfq00ejp5i2sklxqrgn',1776533650118,1776533650118,'p block elements Video Lecture',NULL,NULL,NULL,900,1,1776533650118,'cmo4m9lfp00ehp5i2auy47bks');
INSERT INTO VideoLecture VALUES('cmo4m9lfq00enp5i25fmg235u',1776533650119,1776533650119,'d block elements Video Lecture',NULL,NULL,NULL,900,1,1776533650119,'cmo4m9lfq00elp5i2g6x5vw59');
INSERT INTO VideoLecture VALUES('cmo4m9lfr00erp5i2rcdodklz',1776533650119,1776533650119,'Coordination Compounds: nomenclature, isomerism, geometry, valence bond theory Video Lecture',NULL,NULL,NULL,900,1,1776533650119,'cmo4m9lfr00epp5i2nis3s2l9');
INSERT INTO VideoLecture VALUES('cmo4m9lfr00evp5i23cyi2jke',1776533650120,1776533650120,'Coordination Compounds: Valence bond theory, crystal field theory, color, magnetic properties Video Lecture',NULL,NULL,NULL,900,1,1776533650120,'cmo4m9lfr00etp5i2lw32r5si');
INSERT INTO VideoLecture VALUES('cmo4m9lfs00ezp5i2umlpvc4q',1776533650121,1776533650121,'Chemical equilibria: Osmotic pressure, elevation of boiling point and depression of freezing point, ionic equilibria in solution, solubility product. Video Lecture',NULL,NULL,NULL,900,1,1776533650121,'cmo4m9lfs00exp5i2s8ov7pk7');
INSERT INTO VideoLecture VALUES('cmo4m9lft00f3p5i2iqxe3bge',1776533650121,1776533650121,'Chemical equilibria: common ion effect, hydrolysis of salts, pH, buffer and their applications. Equilibrium constants (Kc, Kp and Kx) for homogeneous reactions Video Lecture',NULL,NULL,NULL,900,1,1776533650121,'cmo4m9lft00f1p5i218fnbgt2');
INSERT INTO VideoLecture VALUES('cmo4m9lft00f7p5i2cvn79xa0',1776533650122,1776533650122,'Reaction Kinetics: Rate constant, order of reaction, molecularity, activation energy, zero, first and second order kinetics, catalysis and elementary enzyme reactions. Reversible and irreversible inhibition of enzymes Video Lecture',NULL,NULL,NULL,900,1,1776533650122,'cmo4m9lft00f5p5i2phanurmo');
INSERT INTO VideoLecture VALUES('cmo4m9lfu00fbp5i2pqmslpag',1776533650122,1776533650122,'Reaction Kinetics: catalysis and elementary enzyme reactions. Reversible and irreversible inhibition of enzymes Video Lecture',NULL,NULL,NULL,900,1,1776533650122,'cmo4m9lfu00f9p5i27c946n8b');
INSERT INTO VideoLecture VALUES('cmo4m9lfv00ffp5i2e0ncf05f',1776533650123,1776533650123,'Electrochemistry: Conductance, Kohlrausch law, cell potentials, EMF, Nernst equation, thermodynamic aspects and their applications Video Lecture',NULL,NULL,NULL,900,1,1776533650123,'cmo4m9lfv00fdp5i239ou5amz');
INSERT INTO VideoLecture VALUES('cmo4m9lfw00fjp5i2y1wkj04a',1776533650124,1776533650124,'Thermodynamics: Qualitative treatment of state and path functions, First law, reversible and irreversible processes, internal energy, enthalpy, Kirchoff equation, heat of reaction, Hess’s law, heat of formation. Video Lecture',NULL,NULL,NULL,900,1,1776533650124,'cmo4m9lfw00fhp5i2nj0rn5sh');
INSERT INTO VideoLecture VALUES('cmo4m9lfw00fnp5i25t7n0ghp',1776533650125,1776533650125,'Thermodynamics: Second law, entropy and free energy. Gibbs‐Helmholtz equation, free energy change and spontaneity, Free energy changes from equilibrium constant. Video Lecture',NULL,NULL,NULL,900,1,1776533650125,'cmo4m9lfw00flp5i2x4cqp6es');
INSERT INTO VideoLecture VALUES('cmo4m9lfx00frp5i2rn5geffb',1776533650126,1776533650126,'Organic Reaction Mechanisms and Hydrocarbon: Acids and bases, electronic and steric effects, Stereochemistry, optical and geometrical isomerism, tautomerism, conformers and concept of aromaticity. Video Lecture',NULL,NULL,NULL,900,1,1776533650126,'cmo4m9lfx00fpp5i2m3alj94h');
INSERT INTO VideoLecture VALUES('cmo4m9lfy00fvp5i231zjdky8',1776533650126,1776533650126,'Organic Reaction Mechanisms and Hydrocarbon: Elementary treatment of SN1, SN2, E1, E2 and radical reactions Video Lecture',NULL,NULL,NULL,900,1,1776533650126,'cmo4m9lfy00ftp5i2xlwpeuqp');
INSERT INTO VideoLecture VALUES('cmo4m9lfy00fzp5i2519gy4on',1776533650127,1776533650127,'Hoffmann/Saytzeff rules, addition reactions, Markownikoff rule and Kharasch effect. Elementary hydroboration reactions. Grignard’s reagents and their uses Video Lecture',NULL,NULL,NULL,900,1,1776533650127,'cmo4m9lfy00fxp5i2wwcn5og3');
INSERT INTO VideoLecture VALUES('cmo4m9lfz00g3p5i2atg8ip4v',1776533650127,1776533650127,'Alcohol: Aromatic electrophilic substitutions, orientation effect as exemplified by various functional groups. Identification of common functional groups by chemical tests Video Lecture',NULL,NULL,NULL,900,1,1776533650127,'cmo4m9lfz00g1p5i2gv649neq');
INSERT INTO VideoLecture VALUES('cmo4m9lg000g7p5i281fcmnv9',1776533650128,1776533650128,'Aldehydes and Ketones: Aromatic electrophilic substitutions, orientation effect as exemplified by various functional groups. Identification of common functional groups by chemical tests. Video Lecture',NULL,NULL,NULL,900,1,1776533650128,'cmo4m9lg000g5p5i2lzc9z8f3');
INSERT INTO VideoLecture VALUES('cmo4m9lg000gbp5i2otdp74t0',1776533650129,1776533650129,'Carboxylic acids and amines: Aromatic electrophilic substitutions, orientation effect as exemplified by various functional groups. Identification of common functional groups by chemical tests. Video Lecture',NULL,NULL,NULL,900,1,1776533650129,'cmo4m9lg000g9p5i2lncbt39m');
INSERT INTO VideoLecture VALUES('cmo4m9lg100gfp5i213qdz8ij',1776533650129,1776533650129,'Chemistry of Biomolecules: Amino acids, proteins, nucleic acids and nucleotides. Peptide sequencing. DNA sequencing, Carbohydrates (upto hexoses only). Lipids (triglycerides only). Video Lecture',NULL,NULL,NULL,900,1,1776533650129,'cmo4m9lg100gdp5i2yst72ye8');
INSERT INTO VideoLecture VALUES('cmo4m9lg200gjp5i2kifjr5fw',1776533650130,1776533650130,'Chemistry of Biomolecules: Principles of biomolecule purification - Ion exchange and gel filtration chromatography. Identification of these biomolecules and Beer-Lambert’s law. Video Lecture',NULL,NULL,NULL,900,1,1776533650130,'cmo4m9lg200ghp5i2iace28g7');
INSERT INTO VideoLecture VALUES('cmo4m9lg300gnp5i2tpgq49rc',1776533650131,1776533650131,'Importance of water; Structure and function of biomolecules: Lipids Video Lecture',NULL,NULL,NULL,900,1,1776533650131,'cmo4m9lg300glp5i2nm8az2ey');
INSERT INTO VideoLecture VALUES('cmo4m9lg300grp5i2xual8m1p',1776533650132,1776533650132,'Structure and function of biomolecules: Carbohydrates Video Lecture',NULL,NULL,NULL,900,1,1776533650132,'cmo4m9lg300gpp5i2i1wymh0s');
INSERT INTO VideoLecture VALUES('cmo4m9lg400gvp5i2f1lygmcl',1776533650132,1776533650132,'Structure and function of biomolecules: Amino acids and Nucleic acids Video Lecture',NULL,NULL,NULL,900,1,1776533650132,'cmo4m9lg400gtp5i2dbys76e8');
INSERT INTO VideoLecture VALUES('cmo4m9lg400gzp5i2p5ep7ibm',1776533650133,1776533650133,'Protein structure, folding and function Video Lecture',NULL,NULL,NULL,900,1,1776533650133,'cmo4m9lg400gxp5i2r8pgfdft');
INSERT INTO VideoLecture VALUES('cmo4m9lg500h3p5i2jduexqdu',1776533650133,1776533650133,'Protein structure, folding and function: II; Myoglobin and Hemoglobin Video Lecture',NULL,NULL,NULL,900,1,1776533650133,'cmo4m9lg500h1p5i21ruswwok');
INSERT INTO VideoLecture VALUES('cmo4m9lg500h7p5i290umuwx5',1776533650134,1776533650134,'Enzymes: Kinetics, regulation and inhibition; Lysozyme, Ribonuclease A, Carboxypeptidase and Chymotrypsin; Vitamins and Coenzymes Video Lecture',NULL,NULL,NULL,900,1,1776533650134,'cmo4m9lg500h5p5i2f9n29ou5');
INSERT INTO VideoLecture VALUES('cmo4m9lg600hbp5i26hz9mpfl',1776533650134,1776533650134,'Metabolism and bioenergetics, Generation and utilization of ATP Video Lecture',NULL,NULL,NULL,900,1,1776533650134,'cmo4m9lg600h9p5i2m49lgd4n');
INSERT INTO VideoLecture VALUES('cmo4m9lg700hfp5i24rw6nb0w',1776533650135,1776533650135,'Metabolic pathways and their regulation: glycolysis Video Lecture',NULL,NULL,NULL,900,1,1776533650135,'cmo4m9lg700hdp5i2vctmjidp');
INSERT INTO VideoLecture VALUES('cmo4m9lg700hjp5i2r2p8qupi',1776533650136,1776533650136,'Metabolic pathways and their regulation: gluconeogenesis, pentose phosphate pathway Video Lecture',NULL,NULL,NULL,900,1,1776533650136,'cmo4m9lg700hhp5i2s8ga1jwn');
INSERT INTO VideoLecture VALUES('cmo4m9lg800hnp5i22zg5c0i2',1776533650136,1776533650136,'Metabolic pathways and their regulation: TCA cycle (Kreb Cycle), oxidative phosphorylation Video Lecture',NULL,NULL,NULL,900,1,1776533650136,'cmo4m9lg800hlp5i2sapxs5or');
INSERT INTO VideoLecture VALUES('cmo4m9lg900hrp5i2ftbife1x',1776533650137,1776533650137,'Metabolic pathways and their regulation: glycogen and fatty acid metabolism Video Lecture',NULL,NULL,NULL,900,1,1776533650137,'cmo4m9lg900hpp5i26jz1htoj');
INSERT INTO VideoLecture VALUES('cmo4m9lga00hvp5i2m838ml8d',1776533650138,1776533650138,'Metabolism of Nitrogen containing compounds: nitrogen fixation, amino acids, nucleotides Video Lecture',NULL,NULL,NULL,900,1,1776533650138,'cmo4m9lga00htp5i20uwd8gjk');
INSERT INTO VideoLecture VALUES('cmo4m9lgb00hzp5i2uiw8sjo6',1776533650139,1776533650139,'Photosynthesis: Calvin cycle. Video Lecture',NULL,NULL,NULL,900,1,1776533650139,'cmo4m9lgb00hxp5i20nlt2x9y');
INSERT INTO VideoLecture VALUES('cmo4m9lgb00i3p5i20cq79oqg',1776533650140,1776533650140,'Biochemical separation techniques: ion exchange, size exclusion and affinity chromatography Video Lecture',NULL,NULL,NULL,900,1,1776533650140,'cmo4m9lgb00i1p5i2submrnde');
INSERT INTO VideoLecture VALUES('cmo4m9lgc00i7p5i2i76g2vam',1776533650140,1776533650140,'Biochemical separation techniques: centrifugation; Characterisation of biomolecules by electrophoresis Video Lecture',NULL,NULL,NULL,900,1,1776533650140,'cmo4m9lgc00i5p5i2d4wvot56');
INSERT INTO VideoLecture VALUES('cmo4m9lgc00ibp5i2i5pf011e',1776533650141,1776533650141,'Biochemical separation techniques: UV-visible and fluorescence spectroscopy, Mass spectrometry Video Lecture',NULL,NULL,NULL,900,1,1776533650141,'cmo4m9lgc00i9p5i2ma3mfnpz');
INSERT INTO VideoLecture VALUES('cmo4m9lgd00ifp5i2oq9l0s5f',1776533650141,1776533650141,'Organisation of life; Cell structure and organelles; Biological membranes (plasma membrane) Video Lecture',NULL,NULL,NULL,900,1,1776533650141,'cmo4m9lgd00idp5i2fyuhwz68');
INSERT INTO VideoLecture VALUES('cmo4m9lge00ijp5i2lu5l9ie4',1776533650142,1776533650142,'Membrane Action potential; Transport across membranes; Membrane assembly and Protein targeting Video Lecture',NULL,NULL,NULL,900,1,1776533650142,'cmo4m9lge00ihp5i2otnz9tz8');
INSERT INTO VideoLecture VALUES('cmo4m9lge00inp5i26dp5mlhf',1776533650143,1776533650143,'DNA-protein and protein–protein interactions Video Lecture',NULL,NULL,NULL,900,1,1776533650143,'cmo4m9lge00ilp5i28gok29ig');
INSERT INTO VideoLecture VALUES('cmo4m9lgf00irp5i27z3201as',1776533650143,1776533650143,'Cell Signaling: Signal transduction; Receptor-ligand interaction; Hormones and neurotransmitters Video Lecture',NULL,NULL,NULL,900,1,1776533650143,'cmo4m9lgf00ipp5i2kpw2hq91');
INSERT INTO VideoLecture VALUES('cmo4m9lgf00ivp5i2ip7hf6vp',1776533650144,1776533650144,'DNA replication, transcription and translation; DNA damage and repair; Biochemical regulation of gene expression Video Lecture',NULL,NULL,NULL,900,1,1776533650144,'cmo4m9lgf00itp5i2luapx0bn');
INSERT INTO VideoLecture VALUES('cmo4m9lgg00izp5i2vup7278a',1776533650145,1776533650145,'Immune system: Innate and adaptive; Cell of the immune system; Active and passive immunity; Complement system Video Lecture',NULL,NULL,NULL,900,1,1776533650145,'cmo4m9lgg00ixp5i2rkaxnhvu');
INSERT INTO VideoLecture VALUES('cmo4m9lgh00j3p5i2fgcvw2qb',1776533650145,1776533650145,'Antibody structure, function and diversity; B cell and T Cell receptors; B cell and T cell activation Video Lecture',NULL,NULL,NULL,900,1,1776533650145,'cmo4m9lgh00j1p5i2s63abi2i');
INSERT INTO VideoLecture VALUES('cmo4m9lgh00j7p5i2qavy9jnh',1776533650146,1776533650146,'Immunological techniques: Immunodiffusion, immune-electrophoresis, RIA and ELISA, flow cytometry; monoclonal antibodies and their applications. Video Lecture',NULL,NULL,NULL,900,1,1776533650146,'cmo4m9lgh00j5p5i2rn9w7wzn');
INSERT INTO VideoLecture VALUES('cmo4m9lgi00jbp5i2j6ti27f4',1776533650147,1776533650147,'Recombinant DNA technology and applications: PCR Video Lecture',NULL,NULL,NULL,900,1,1776533650147,'cmo4m9lgi00j9p5i21dea5v6m');
INSERT INTO VideoLecture VALUES('cmo4m9lgj00jfp5i2np8gdpiy',1776533650147,1776533650147,'Site directed mutagenesis, DNA-microarray; Next generation sequencing; Gene silencing and editing. Video Lecture',NULL,NULL,NULL,900,1,1776533650147,'cmo4m9lgj00jdp5i233auxd83');
INSERT INTO VideoLecture VALUES('cmo4m9lgk00jjp5i2hsl0cczq',1776533650148,1776533650148,'Historical Perspective (1) Video Lecture',NULL,NULL,NULL,900,1,1776533650148,'cmo4m9lgk00jhp5i2l86wg9lv');
INSERT INTO VideoLecture VALUES('cmo4m9lgk00jnp5i25e5ekrxk',1776533650149,1776533650149,'Historical Perspective (2): Role of microorganisms in transformation of organic matter and in the causation of diseases Video Lecture',NULL,NULL,NULL,900,1,1776533650149,'cmo4m9lgk00jlp5i25n4fr865');
INSERT INTO VideoLecture VALUES('cmo4m9lgl00jrp5i23wp0e478',1776533650149,1776533650149,'Methods in Microbiology 1: Pure culture techniques; Theory and practice of sterilization; Principles of microbial nutrition; Enrichment culture techniques for isolation of microorganisms Video Lecture',NULL,NULL,NULL,900,1,1776533650149,'cmo4m9lgl00jpp5i2v1gaym99');
INSERT INTO VideoLecture VALUES('cmo4m9lgl00jvp5i2vd08568q',1776533650150,1776533650150,'Methods in Microbiology 2: Light-, phase contrast- and electron-microscopy Video Lecture',NULL,NULL,NULL,900,1,1776533650150,'cmo4m9lgl00jtp5i2az5eyonw');
INSERT INTO VideoLecture VALUES('cmo4m9lgm00jzp5i2pcey7me6',1776533650150,1776533650150,'Methods in Microbiology 3: antigen and antibody detection methods for microbial diagnosis Video Lecture',NULL,NULL,NULL,900,1,1776533650150,'cmo4m9lgm00jxp5i29hmn318u');
INSERT INTO VideoLecture VALUES('cmo4m9lgm00k3p5i20xwhk541',1776533650151,1776533650151,'Methods in Microbiology 4: PCR, real-time PCR for quantitation of microbes Next generation sequencing technologies in microbiology. Video Lecture',NULL,NULL,NULL,900,1,1776533650151,'cmo4m9lgm00k1p5i2qwx5kklu');
INSERT INTO VideoLecture VALUES('cmo4m9lgn00k7p5i2bsnebwb4',1776533650151,1776533650151,'Microbial Taxonomy and Diversity 1: Bacteria, Archea and their broad classification Eukaryotic microbes: Yeasts, molds and protozoa Video Lecture',NULL,NULL,NULL,900,1,1776533650151,'cmo4m9lgn00k5p5i2372vbgdn');
INSERT INTO VideoLecture VALUES('cmo4m9lgo00kbp5i24w4cb4ws',1776533650152,1776533650152,'Microbial Taxonomy and Diversity 2: Viruses and their classification; Molecular approaches to microbial taxonomy and phylogeny Video Lecture',NULL,NULL,NULL,900,1,1776533650152,'cmo4m9lgn00k9p5i2blzaol2j');
INSERT INTO VideoLecture VALUES('cmo4m9lgo00kfp5i22kn2hnbj',1776533650153,1776533650153,'Prokaryotic Cells: cell walls, cell membranes and their biosynthesis, mechanisms of solute transport across membranes, Flagella and Pili, Capsules, Cell inclusions like endospores and gas vesicles; Bacterial locomotion, including positive and negative chemotaxis Video Lecture',NULL,NULL,NULL,900,1,1776533650153,'cmo4m9lgo00kdp5i210cnnwc9');
INSERT INTO VideoLecture VALUES('cmo4m9lgp00kjp5i2hxoosifv',1776533650153,1776533650153,'Microbial Growth 1: Definition of growth, Growth curve, Mathematical expression of exponential growth phase Video Lecture',NULL,NULL,NULL,900,1,1776533650153,'cmo4m9lgp00khp5i2gwrmg7pv');
INSERT INTO VideoLecture VALUES('cmo4m9lgp00knp5i2we1s55lg',1776533650154,1776533650154,'Microbial Growth 2: Measurement of growth and growth yields; Synchronous growth; Continuous culture; Effect of environmental factors on growth. Bacterial biofilm and biofouling Video Lecture',NULL,NULL,NULL,900,1,1776533650154,'cmo4m9lgp00klp5i2znauy7oa');
INSERT INTO VideoLecture VALUES('cmo4m9lgq00krp5i2nbkz655p',1776533650154,1776533650154,'Control of Micro-organisms: Disinfection and sterilization: principles, methods and assessment of efficacy Video Lecture',NULL,NULL,NULL,900,1,1776533650154,'cmo4m9lgq00kpp5i2nt1t94fa');
INSERT INTO VideoLecture VALUES('cmo4m9lgq00kvp5i2xip9skly',1776533650155,1776533650155,'Microbial Metabolism 1: Energetics: redox reactions and electron carriers; Electron transport and oxidative phosphorylation; An overview of metabolism; Video Lecture',NULL,NULL,NULL,900,1,1776533650155,'cmo4m9lgq00ktp5i2r4facq08');
INSERT INTO VideoLecture VALUES('cmo4m9lgr00kzp5i2x3tavs9q',1776533650155,1776533650155,'Microbial Metabolism 2: Glycolysis; Pentose-phosphate pathway; Entner-Doudoroff pathway; Glyoxalate pathway; The citric acid cycle Video Lecture',NULL,NULL,NULL,900,1,1776533650155,'cmo4m9lgr00kxp5i25xw8lnpw');
INSERT INTO VideoLecture VALUES('cmo4m9lgs00l3p5i25y05ov5e',1776533650156,1776533650156,'Microbial Metabolism 3: Fermentation; Aerobic and anaerobic respiration; Chemolithotrophy; Photosynthesis; Calvin cycle; Biosynthetic pathway for fatty acids synthesis Video Lecture',NULL,NULL,NULL,900,1,1776533650156,'cmo4m9lgs00l1p5i2yresk7m3');
INSERT INTO VideoLecture VALUES('cmo4m9lgt00l7p5i2nxkcv3pq',1776533650157,1776533650157,'Microbial Metabolism 4: Common regulatory mechanisms in synthesis of amino acids; Regulation of major metabolic pathways Video Lecture',NULL,NULL,NULL,900,1,1776533650157,'cmo4m9lgt00l5p5i2oveamb50');
INSERT INTO VideoLecture VALUES('cmo4m9lgu00lbp5i22gcpe5vg',1776533650159,1776533650159,'Microbial Diseases and Host Pathogen Interaction 1: Normal microbiota; Classification of infectious diseases; Reservoirs of infection; Nosocomial infection; Opportunistic infections; Emerging infectious diseases; Mechanism of microbial pathogenicity Video Lecture',NULL,NULL,NULL,900,1,1776533650159,'cmo4m9lgu00l9p5i2ro1lupvo');
INSERT INTO VideoLecture VALUES('cmo4m9lgv00lfp5i24edmzcgd',1776533650159,1776533650159,'Microbial Diseases and Host Pathogen Interaction 2: Nonspecific defense of host; Antigens and antibodies; Humoral and cell mediated immunity; Vaccines; Passive immunization; Immune deficiency; Human diseases caused by viruses, bacteria, and pathogenic fungi Video Lecture',NULL,NULL,NULL,900,1,1776533650159,'cmo4m9lgv00ldp5i2fis9uuna');
INSERT INTO VideoLecture VALUES('cmo4m9lgw00ljp5i25oj61b4r',1776533650160,1776533650160,'Chemotherapy/ Antibiotics: General characteristics of antimicrobial drugs; Antibiotics: Classification, mode of action and resistance; Antifungal and antiviral drugs Video Lecture',NULL,NULL,NULL,900,1,1776533650160,'cmo4m9lgw00lhp5i2u1wuml5t');
INSERT INTO VideoLecture VALUES('cmo4m9lgw00lnp5i2uzxw6jf1',1776533650161,1776533650161,'Microbial Genetics part 1: Types of mutation; UV and chemical mutagens; Selection of mutants; Ames test for mutagenesis Video Lecture',NULL,NULL,NULL,900,1,1776533650161,'cmo4m9lgw00llp5i2n4glf9qz');
INSERT INTO VideoLecture VALUES('cmo4m9lgx00lrp5i27wfcypr6',1776533650162,1776533650162,'Microbial Genetics part 2: Bacterial genetic system: transformation, conjugation, transduction, recombination, plasmids, transposons Video Lecture',NULL,NULL,NULL,900,1,1776533650162,'cmo4m9lgx00lpp5i2b1aen8vh');
INSERT INTO VideoLecture VALUES('cmo4m9lgy00lvp5i2udqx6dqk',1776533650162,1776533650162,'Microbial Genetics part 3: DNA repair; Regulation of gene expression: repression and induction; Operon model; Bacterial genome with special reference to E.coli; Phage λ and its life cycle; RNA phages Video Lecture',NULL,NULL,NULL,900,1,1776533650162,'cmo4m9lgy00ltp5i2v1t7nynn');
INSERT INTO VideoLecture VALUES('cmo4m9lgy00lzp5i2qwkmyuua',1776533650163,1776533650163,'Microbial Genetics part 4: RNA viruses Retroviruses; mutation in virus genomes, virus recombination and reassortment; Basic concept of microbial genomics Video Lecture',NULL,NULL,NULL,900,1,1776533650163,'cmo4m9lgy00lxp5i2391s776h');
INSERT INTO VideoLecture VALUES('cmo4m9lgz00m3p5i2cbhhnsio',1776533650164,1776533650164,'Microbial Ecology: Microbial interactions:Carbon, sulphur and nitrogen cycles Soil microorganisms associated with vascular plants. Bioremediation; Uncultivable microorganisms; basic concept of metagenomics and metatranscriptomics Video Lecture',NULL,NULL,NULL,900,1,1776533650164,'cmo4m9lgz00m1p5i2f3e6vigd');

INSERT INTO StudyMaterial VALUES('cmo4m9ld1000ip5i27n8t6q8d',1776533650022,1776533650022,'Analytical Aptitude Study Material','Analogy',NULL,NULL,10,1,1776533650022,'cmo4m9ld1000hp5i214ny4m5q');
INSERT INTO StudyMaterial VALUES('cmo4m9ld2000mp5i2vv2v1g8e',1776533650023,1776533650023,'Analytical Aptitude Study Material','Numerical relations and reasoning',NULL,NULL,10,1,1776533650023,'cmo4m9ld2000lp5i2uxzbtaak');
INSERT INTO StudyMaterial VALUES('cmo4m9ld3000qp5i2iha5ge9z',1776533650024,1776533650024,'Verbal Aptitude Study Material','Basic English grammar: Articles',NULL,NULL,10,1,1776533650024,'cmo4m9ld3000pp5i26f1gi7xq');
INSERT INTO StudyMaterial VALUES('cmo4m9ld4000up5i2gpg2h5ml',1776533650024,1776533650024,'Quantitative Aptitude Study Material','Average, mean, mode',NULL,NULL,10,1,1776533650024,'cmo4m9ld4000tp5i2r4um49wi');
INSERT INTO StudyMaterial VALUES('cmo4m9ld5000yp5i2uhwvqnck',1776533650025,1776533650025,'Quantitative Aptitude Study Material','Percentage',NULL,NULL,10,1,1776533650025,'cmo4m9ld5000xp5i2t0hyav7p');
INSERT INTO StudyMaterial VALUES('cmo4m9ld60012p5i25gbo5dh1',1776533650026,1776533650026,'Verbal Aptitude Study Material','Basic English grammar: Tenses',NULL,NULL,10,1,1776533650026,'cmo4m9ld60011p5i2s2cg6x92');
INSERT INTO StudyMaterial VALUES('cmo4m9ld70016p5i2wt80t4fn',1776533650027,1776533650027,'Quantitative Aptitude Study Material','Ratio and proportions',NULL,NULL,10,1,1776533650027,'cmo4m9ld70015p5i2qfsm110d');
INSERT INTO StudyMaterial VALUES('cmo4m9ld7001ap5i26oxg3c6s',1776533650028,1776533650028,'Quantitative Aptitude Study Material','Series completion',NULL,NULL,10,1,1776533650028,'cmo4m9ld70019p5i2vg87o8cb');
INSERT INTO StudyMaterial VALUES('cmo4m9ld8001ep5i2y9ebb9g2',1776533650028,1776533650028,'Quantitative Aptitude Study Material','Profit Loss',NULL,NULL,10,1,1776533650028,'cmo4m9ld8001dp5i2rllm1y5c');
INSERT INTO StudyMaterial VALUES('cmo4m9ld9001ip5i2dhtvfa27',1776533650029,1776533650029,'Verbal Aptitude Study Material','Reading Comprehension',NULL,NULL,10,1,1776533650029,'cmo4m9ld9001hp5i2rm3tykv9');
INSERT INTO StudyMaterial VALUES('cmo4m9lda001mp5i2ab8r7iyf',1776533650030,1776533650030,'Analytical Aptitude Study Material','Logic: deduction and induction',NULL,NULL,10,1,1776533650030,'cmo4m9ld9001lp5i21mj2m2xr');
INSERT INTO StudyMaterial VALUES('cmo4m9ldb001qp5i20xmanssk',1776533650031,1776533650031,'Verbal Aptitude Study Material','Basic vocabulary- words, idioms and phrases in context',NULL,NULL,10,1,1776533650031,'cmo4m9lda001pp5i2r4ul1weo');
INSERT INTO StudyMaterial VALUES('cmo4m9ldb001up5i27p97qbet',1776533650032,1776533650032,'Quantitative Aptitude Study Material','Permutation and Combination',NULL,NULL,10,1,1776533650032,'cmo4m9ldb001tp5i279sgop2p');
INSERT INTO StudyMaterial VALUES('cmo4m9ldc001yp5i2hxspxd3q',1776533650032,1776533650032,'Quantitative Aptitude Study Material','Probability',NULL,NULL,10,1,1776533650032,'cmo4m9ldc001xp5i2qd02ka8i');
INSERT INTO StudyMaterial VALUES('cmo4m9ldd0022p5i2x2tf26j1',1776533650033,1776533650033,'Verbal Aptitude Study Material','Basic English grammar: adjectives, preposition and conjunctions',NULL,NULL,10,1,1776533650033,'cmo4m9ldd0021p5i2vqwh2lxd');
INSERT INTO StudyMaterial VALUES('cmo4m9ldd0026p5i2rks73khg',1776533650034,1776533650034,'Quantitative Aptitude Study Material','Data Interpretation: data graphs (bar graphs, pie charts and other graphs representing data), 2- and 3- dimensional plots, maps and tables',NULL,NULL,10,1,1776533650034,'cmo4m9ldd0025p5i218vweddo');
INSERT INTO StudyMaterial VALUES('cmo4m9lde002ap5i25weq099l',1776533650035,1776533650035,'Quantitative Aptitude Study Material','Mensuration and geometry',NULL,NULL,10,1,1776533650035,'cmo4m9lde0029p5i2owr35tan');
INSERT INTO StudyMaterial VALUES('cmo4m9ldf002ep5i2fxyt9zih',1776533650036,1776533650036,'Verbal Aptitude Study Material','English grammar: verb-noun agreement and other parts of speech',NULL,NULL,10,1,1776533650036,'cmo4m9ldf002dp5i2fjldb0ul');
INSERT INTO StudyMaterial VALUES('cmo4m9ldg002ip5i2x6rv96mt',1776533650036,1776533650036,'Quantitative Aptitude Study Material','Speed and distance',NULL,NULL,10,1,1776533650036,'cmo4m9ldg002hp5i2kqikj3fj');
INSERT INTO StudyMaterial VALUES('cmo4m9ldg002mp5i2370l1wr8',1776533650037,1776533650037,'Spatial Aptitude Study Material','Transformation of shapes:Translation, rotation, scaling, mirroring, assembling and grouping, Paper folding, cutting and patterns in 2 and 3 dimensions',NULL,NULL,10,1,1776533650037,'cmo4m9ldg002lp5i2bpemzue0');
INSERT INTO StudyMaterial VALUES('cmo4m9ldh002qp5i2ezysj9u2',1776533650038,1776533650038,'Verbal Aptitude Study Material','Narrative sequencing',NULL,NULL,10,1,1776533650038,'cmo4m9ldh002pp5i2it83x5yy');
INSERT INTO StudyMaterial VALUES('cmo4m9ldi002up5i27uy2zke5',1776533650039,1776533650039,'Quantitative Aptitude Study Material','Powers, exponents and logarithms',NULL,NULL,10,1,1776533650039,'cmo4m9ldi002tp5i2nxkn7hze');
INSERT INTO StudyMaterial VALUES('cmo4m9ldj002yp5i2do24cs56',1776533650040,1776533650040,'Quantitative Aptitude Study Material','Elementary statistics',NULL,NULL,10,1,1776533650040,'cmo4m9ldj002xp5i2qrlurp0l');
INSERT INTO StudyMaterial VALUES('cmo4m9ldk0032p5i2nw7vdao9',1776533650040,1776533650040,'Quantitative Aptitude Study Material','Time and work',NULL,NULL,10,1,1776533650040,'cmo4m9ldk0031p5i2j5x7oo2j');
INSERT INTO StudyMaterial VALUES('cmo4m9ldl0036p5i24okr4vxq',1776533650041,1776533650041,'Basics of Engineering Mathematics Study Material',NULL,NULL,NULL,10,1,1776533650041,'cmo4m9ldl0035p5i2v5h8na33');
INSERT INTO StudyMaterial VALUES('cmo4m9ldm003ap5i2svdsj1ul',1776533650042,1776533650042,'Linear Algebra Study Material','Algebra of real matrices: Determinant, inverse and rank of a matrix; System of linear equations (conditions for unique solution, no solution and infinite number of solutions)',NULL,NULL,10,1,1776533650042,'cmo4m9ldm0039p5i27vfvpttc');
INSERT INTO StudyMaterial VALUES('cmo4m9ldn003ep5i27g69tsxd',1776533650043,1776533650043,'Linear Algebra Study Material','Eigenvalues and eigenvectors of matrices; Properties of eigenvalues and eigenvectors of symmetric matrices, diagonalization of matrices; Cayley Hamilton Theorem',NULL,NULL,10,1,1776533650043,'cmo4m9ldn003dp5i21filmr8x');
INSERT INTO StudyMaterial VALUES('cmo4m9ldo003ip5i2910ttyh1',1776533650044,1776533650044,'Calculus Study Material',unistr('Functions of single variable: Limit, indeterminate forms and L''Hospital''s rule; Continuity and differentiability;\u000aMean value theorems; Maxima and minima; Taylor''s theorem; Fundamental theorem and mean value theorem of integral calculus;'),NULL,NULL,10,1,1776533650044,'cmo4m9ldo003hp5i2srfxg9n7');
INSERT INTO StudyMaterial VALUES('cmo4m9ldp003mp5i29fttmxex',1776533650045,1776533650045,'Calculus Study Material','Evaluation of definite and improper integrals; Applications of definite integrals to evaluate areas and volumes (rotation of a curve about an axis)',NULL,NULL,10,1,1776533650045,'cmo4m9ldo003lp5i29at6v7np');
INSERT INTO StudyMaterial VALUES('cmo4m9ldq003qp5i2tjd6jij2',1776533650046,1776533650046,'Calculus Study Material','Functions of two variables: Limit, continuity and partial derivatives; Directional derivative; Total derivative; Maxima, minima and saddle points; Method of Lagrange multipliers; Double integrals and their applications',NULL,NULL,10,1,1776533650046,'cmo4m9ldp003pp5i2ixziw7b4');
INSERT INTO StudyMaterial VALUES('cmo4m9ldr003up5i27x9x5o3v',1776533650047,1776533650047,'Complex Variables Study Material','Complex numbers, Argand plane and polar representation of complex numbers; De Moivre’s theorem; Analytic functions; Cauchy-Riemann equations.',NULL,NULL,10,1,1776533650047,'cmo4m9ldr003tp5i27gzl0rkh');
INSERT INTO StudyMaterial VALUES('cmo4m9ldr003yp5i2f8nydqxn',1776533650048,1776533650048,'Probability Study Material','Axioms of probability; Conditional probability; Bayes'' Theorem;',NULL,NULL,10,1,1776533650048,'cmo4m9ldr003xp5i2f949fumm');
INSERT INTO StudyMaterial VALUES('cmo4m9lds0042p5i2c0r75vld',1776533650049,1776533650049,'Statistics Study Material','Mean, variance and standard deviation of random variables; Binomial, Poisson and Normal distributions; Correlation and linear regression.',NULL,NULL,10,1,1776533650049,'cmo4m9lds0041p5i2lnj8nd6o');
INSERT INTO StudyMaterial VALUES('cmo4m9ldt0046p5i2bizvzrgr',1776533650050,1776533650050,'Sequence and series Study Material','Convergence of sequences and series; Tests of convergence of series with non-negative terms (ratio, root and integral tests); Power series; Taylor''s series; Fourier Series of functions of period 2π.',NULL,NULL,10,1,1776533650050,'cmo4m9ldt0045p5i2if43o0fn');
INSERT INTO StudyMaterial VALUES('cmo4m9ldu004ap5i2zn8nnyhp',1776533650051,1776533650051,'Vector Calculus Study Material','Gradient, divergence and curl; Line integrals and Green''s theorem.',NULL,NULL,10,1,1776533650051,'cmo4m9ldu0049p5i2wojng6zc');
INSERT INTO StudyMaterial VALUES('cmo4m9ldv004ep5i2l9jzrzsl',1776533650051,1776533650051,'ODE Study Material','First order equations (linear and nonlinear); Second order linear differential equations with constant coefficients;',NULL,NULL,10,1,1776533650051,'cmo4m9ldv004dp5i2cmf046l2');
INSERT INTO StudyMaterial VALUES('cmo4m9ldw004ip5i22100hvod',1776533650052,1776533650052,'ODE Study Material','Cauchy-Euler equation; Second order linear differential equations with variable coefficients; Wronskian; Method of variation of parameters;',NULL,NULL,10,1,1776533650052,'cmo4m9ldw004hp5i2bd9grdwh');
INSERT INTO StudyMaterial VALUES('cmo4m9ldx004mp5i2ye2tbly0',1776533650053,1776533650053,'ODE Study Material','Eigenvalue problem for second order equations with constant coefficients; Power series solutions for ordinary points.',NULL,NULL,10,1,1776533650053,'cmo4m9ldx004lp5i2ljx6mnf3');
INSERT INTO StudyMaterial VALUES('cmo4m9ldy004qp5i2dvh73und',1776533650054,1776533650054,'Partial Differential Equation Study Material','Classification of second order linear partial differential equations;',NULL,NULL,10,1,1776533650054,'cmo4m9ldy004pp5i2hv9twp31');
INSERT INTO StudyMaterial VALUES('cmo4m9ldy004up5i2ob1ddmo0',1776533650055,1776533650055,'Partial Differential Equation Study Material','Method of separation of variables: One dimensional heat equation and two dimensional Laplace equation',NULL,NULL,10,1,1776533650055,'cmo4m9ldy004tp5i2tftt5v5r');
INSERT INTO StudyMaterial VALUES('cmo4m9ldz004yp5i2mz4ll5sp',1776533650056,1776533650056,'Numerical Methods Study Material',unistr('Solution of systems of linear equations using LU decomposition, Gauss elimination method; Lagrange and Newton''s interpolations; Solution of polynomial and transcendental equations by\u000aNewton-Raphson method'),NULL,NULL,10,1,1776533650056,'cmo4m9ldz004xp5i22c5h0lz1');
INSERT INTO StudyMaterial VALUES('cmo4m9le00052p5i2gxxm0o43',1776533650057,1776533650057,'Numerical Methods Study Material',unistr('Numerical integration by trapezoidal rule and Simpson''s rule;\u000aNumerical solutions of first order differential equations by explicit Euler''s method.'),NULL,NULL,10,1,1776533650057,'cmo4m9le00051p5i2d5uqw8dc');
INSERT INTO StudyMaterial VALUES('cmo4m9le10056p5i2d2i9rtkx',1776533650058,1776533650058,'Basic Concepts Study Material',unistr('Introduction\u000aContinuum and macroscopic approach\u000aThermodynamic systems (closed and open)\u000aThermodynamic properties and equilibrium'),NULL,'https://drive.google.com/file/d/165zBNznrsEZ3gp4QTMUIIULpcBqByQ7v/preview',10,1,1776533650058,'cmo4m9le10055p5i2x6a458th');
INSERT INTO StudyMaterial VALUES('cmo4m9le2005ap5i2dtr8smn0',1776533650059,1776533650059,'Second topic inside a module Study Material','Second topic description',NULL,NULL,12,1,1776533650059,'cmo4m9le20059p5i2b3wn7dwh');
INSERT INTO StudyMaterial VALUES('cmo4m9le3005ep5i2c04c7jru',1776533650059,1776533650059,'Basic Concepts Study Material',unistr('State of a system\u000aState postulate for simple compressible substances\u000aState diagrams\u000aPaths and processes on state diagram\u000aConcepts of heat and work\u000aDifferent modes of work'),NULL,NULL,10,1,1776533650059,'cmo4m9le3005dp5i2cckf7qh7');
INSERT INTO StudyMaterial VALUES('cmo4m9le4005ip5i2y8u7wk2r',1776533650060,1776533650060,'Basic Concepts Study Material',unistr('Ideal gas equation\u000aZeroth law of thermodynamics\u000aConcept of temperature'),NULL,NULL,10,1,1776533650060,'cmo4m9le4005hp5i27vtvbccc');
INSERT INTO StudyMaterial VALUES('cmo4m9le5005mp5i2ztmahz4g',1776533650061,1776533650061,'First law of Thermodynamics Study Material',unistr('Concept of energy and various forms of energy\u000aInternal Energy\u000aEnthalpy\u000aSpecific heats'),NULL,NULL,10,1,1776533650061,'cmo4m9le5005lp5i2ikpzlvg3');
INSERT INTO StudyMaterial VALUES('cmo4m9le5005qp5i21muujqoy',1776533650062,1776533650062,'First law of Thermodynamics Study Material','First law applied to elementary processes, closed systems and control volumes',NULL,NULL,10,1,1776533650062,'cmo4m9le5005pp5i24c3aqr6g');
INSERT INTO StudyMaterial VALUES('cmo4m9le6005up5i25mogij6u',1776533650063,1776533650063,'First Law of Thermodynamics Study Material','Steady and unsteady flow analysis',NULL,NULL,10,1,1776533650063,'cmo4m9le6005tp5i2y44fmlia');
INSERT INTO StudyMaterial VALUES('cmo4m9le7005yp5i2mfhbiuch',1776533650064,1776533650064,'Second Law of Thermodynamics Study Material',unistr('Limitations of first law of thermodynamics\u000aConcept of heat engines and heat pumps/ refrigerators'),NULL,NULL,10,1,1776533650064,'cmo4m9le7005xp5i2pflcit1j');
INSERT INTO StudyMaterial VALUES('cmo4m9le80062p5i2d0y4i25p',1776533650064,1776533650064,'Second Law of Thermodynamics Study Material',unistr('Kelvin-Planck and Clausius statements and their equivalence\u000aReversible and irreversible processes'),NULL,NULL,10,1,1776533650064,'cmo4m9le80061p5i2026gwhum');
INSERT INTO StudyMaterial VALUES('cmo4m9le90066p5i2fyq82aut',1776533650065,1776533650065,'Second Law of Thermodynamics Study Material',unistr('Carnot cycle and Carnot principles/theorems\u000aThermodymanic temperature scale'),NULL,NULL,10,1,1776533650065,'cmo4m9le90065p5i2lij2nqg9');
INSERT INTO StudyMaterial VALUES('cmo4m9lea006ap5i2xiw9pupk',1776533650066,1776533650066,'Second Law of Thermodynamics Study Material',unistr('Clausius inequality and concept of entropy\u000aMicroscopic interpretation of entropy\u000aThe principle of increase of entropy\u000aT-s diagrams'),NULL,NULL,10,1,1776533650066,'cmo4m9lea0069p5i283dkbayb');
INSERT INTO StudyMaterial VALUES('cmo4m9lea006ep5i2u42js8h5',1776533650067,1776533650067,'Second Law of Thermodynamics Study Material',unistr('Second law analysis of control volume\u000aAvailability and irreversibilty\u000aThird law of thermodynamics'),NULL,NULL,10,1,1776533650067,'cmo4m9lea006dp5i2erfqvaly');
INSERT INTO StudyMaterial VALUES('cmo4m9leb006ip5i242nkieau',1776533650068,1776533650068,'Properties of pure substances Study Material',unistr('Thermodynamic properties of pure substances in solid, liquid and vapor phases\u000aPvT behaviour of simple compressible substances\u000aPhase rule\u000aThermodynamic property tables and charts\u000aIdeal and real gases\u000aIdeal gas equation of state and van der Waals equation of state'),NULL,NULL,10,1,1776533650068,'cmo4m9leb006hp5i20duhq60u');
INSERT INTO StudyMaterial VALUES('cmo4m9lec006mp5i2r2buoci8',1776533650068,1776533650068,'Properties of pure substances Study Material',unistr('Law of corresponding states\u000aCompressibility factor and generalized compressibility chart'),NULL,NULL,10,1,1776533650068,'cmo4m9lec006lp5i2x752qv8v');
INSERT INTO StudyMaterial VALUES('cmo4m9led006qp5i2hbw0gyhn',1776533650069,1776533650069,'Thermodynamic Relations Study Material',unistr('Tds relations\u000aHelmholtz and Gibbs functions\u000aGibbs relations\u000aMaxwell relations\u000aJoule-Thomson coefficient\u000aCoefficient of volume expansion\u000aAdiabatic and isothermal compressibilities\u000aClapeyron and Clapeyron-Clausius equations'),NULL,NULL,10,1,1776533650069,'cmo4m9led006pp5i2ukymg4en');
INSERT INTO StudyMaterial VALUES('cmo4m9lee006up5i206az2wxb',1776533650070,1776533650070,'Thermodynamic Cycles Study Material',unistr('Carnot vapor cycle\u000aIdeal Rankine cycle\u000aRankine reheat cycle'),NULL,NULL,10,1,1776533650070,'cmo4m9lee006tp5i2laii3l8d');
INSERT INTO StudyMaterial VALUES('cmo4m9lee006yp5i2qy2v41l3',1776533650071,1776533650071,'Thermodynamic Cycles Study Material',unistr('Air-standard Otto cycle\u000aAir-standard Diesel cycle\u000aAir-standard Brayton cycle'),NULL,NULL,10,1,1776533650071,'cmo4m9lee006xp5i2vuvqlpi8');
INSERT INTO StudyMaterial VALUES('cmo4m9lef0072p5i2clon8gvc',1776533650071,1776533650071,'Thermodynamic Cycles Study Material','Vapor-compression refrigeration cycle',NULL,NULL,10,1,1776533650071,'cmo4m9lef0071p5i2zwao1jeo');
INSERT INTO StudyMaterial VALUES('cmo4m9leg0076p5i2e3u0g1z1',1776533650072,1776533650072,'Ideal gas mixtures Study Material',unistr('Dalton’s and Amagat’s laws\u000aProperties of ideal gas mixtures'),NULL,NULL,10,1,1776533650072,'cmo4m9leg0075p5i2actbg3hz');
INSERT INTO StudyMaterial VALUES('cmo4m9leh007ap5i2uam93hmk',1776533650073,1776533650073,'Ideal gas mixtures Study Material',unistr('Air-water vapor mixtures and simple thermodynamic processes involving them\u000aSpecific and relative humidities\u000aDew point and wet bulb temperature\u000aAdiabatic saturation temperature'),NULL,NULL,10,1,1776533650073,'cmo4m9leh0079p5i2rhvwuumb');
INSERT INTO StudyMaterial VALUES('cmo4m9lei007ep5i2veggadvx',1776533650074,1776533650074,'Ideal gas mixtures Study Material','Psychrometric chart',NULL,NULL,10,1,1776533650074,'cmo4m9lei007dp5i2fkjunymj');
INSERT INTO StudyMaterial VALUES('cmo4m9lei007ip5i28ezwodj4',1776533650075,1776533650075,'Carbohydrates Study Material','Structure and functional properties of mono-, oligo-, & poly-saccharides, starch, Cellulose',NULL,'https://drive.google.com/file/d/17MG4W65-Hbx64DkqiB4n9JXT7PJFb3nx/preview',10,1,1776533650075,'cmo4m9lei007hp5i2irc09skw');
INSERT INTO StudyMaterial VALUES('cmo4m9lej007mp5i27qzqwthf',1776533650076,1776533650076,'Mass and Energy Balance Study Material',NULL,NULL,NULL,12,1,1776533650076,'cmo4m9lej007lp5i2xzulwign');
INSERT INTO StudyMaterial VALUES('cmo4m9lek007qp5i2pd2ob01h',1776533650076,1776533650076,'Microorganisms Study Material','Characteristics of microorganisms: morphology of bacteria, gram-staining',NULL,NULL,10,1,1776533650076,'cmo4m9lek007pp5i29jpfozoz');
INSERT INTO StudyMaterial VALUES('cmo4m9lel007up5i21cxsa9yu',1776533650077,1776533650077,'Carbohydrates Study Material','Pectic substances dietary fibre, gelatinization of starch, Retrogradation of starch',NULL,NULL,12,1,1776533650077,'cmo4m9lel007tp5i29mpetr7j');
INSERT INTO StudyMaterial VALUES('cmo4m9lel007yp5i2pv55ryvc',1776533650078,1776533650078,'Microorganisms Study Material','Morphology of yeast, morphology of mold, morphology of actinomycetes, spores and vegetative cells',NULL,NULL,10,1,1776533650078,'cmo4m9lel007xp5i26f7jrvn0');
INSERT INTO StudyMaterial VALUES('cmo4m9lem0082p5i2n5jbr0g4',1776533650079,1776533650079,'Intermediate Moisture Foods Study Material','Moisture content, Water activity',NULL,NULL,12,1,1776533650079,'cmo4m9lem0081p5i20dm6zcol');
INSERT INTO StudyMaterial VALUES('cmo4m9len0086p5i2y1fqg7ax',1776533650079,1776533650079,'Lipids Study Material','Classification, structure of lipids, rancidity, polymerization, polymorphism',NULL,NULL,10,1,1776533650079,'cmo4m9len0085p5i2ccihnqtq');
INSERT INTO StudyMaterial VALUES('cmo4m9leo008ap5i2uhimqwz8',1776533650080,1776533650080,'Processing Principles Study Material','Thermal processing - Blanching, Pasteurization and Sterilization',NULL,NULL,12,1,1776533650080,'cmo4m9leo0089p5i277f709pl');
INSERT INTO StudyMaterial VALUES('cmo4m9lep008ep5i250x6o0ig',1776533650081,1776533650081,'Oil Processing Study Material','Expelling, solvent extraction, refining, hydrogenation',NULL,NULL,10,1,1776533650081,'cmo4m9lep008dp5i2jt87ex5x');
INSERT INTO StudyMaterial VALUES('cmo4m9lep008ip5i22dp4qas7',1776533650082,1776533650082,'Proteins Study Material','Classification, structure of proteins in food',NULL,NULL,12,1,1776533650082,'cmo4m9lep008hp5i2n6e5vng0');
INSERT INTO StudyMaterial VALUES('cmo4m9leq008mp5i2qwjqoivc',1776533650083,1776533650083,'Microbial Growth Study Material','Growth and death kinetics, serial dilution technique',NULL,NULL,10,1,1776533650083,'cmo4m9leq008lp5i2sri7qi7l');
INSERT INTO StudyMaterial VALUES('cmo4m9ler008qp5i2e44ts1ew',1776533650083,1776533650083,'Enzymes Study Material','Specificity, simple and inhibition kinetics, coenzymes',NULL,NULL,12,1,1776533650083,'cmo4m9ler008pp5i2z5fqjieq');
INSERT INTO StudyMaterial VALUES('cmo4m9les008up5i2ohh4lnpc',1776533650084,1776533650084,'Thermal Operations Study Material','Thermal sterilization - D,F,Z values',NULL,'https://drive.google.com/file/d/1XZxZ_nA5hs4uo9ZzOX9OYPswqV_Bbhq7/preview',10,1,1776533650084,'cmo4m9les008tp5i2zbmymzak');
INSERT INTO StudyMaterial VALUES('cmo4m9les008yp5i21kp8mvp1',1776533650085,1776533650085,'Plantation Crops Processing Study Material','Tea',NULL,NULL,12,1,1776533650085,'cmo4m9les008xp5i2xdn6gmys');
INSERT INTO StudyMaterial VALUES('cmo4m9let0092p5i2ml9ewvz4',1776533650085,1776533650085,'Momentum Transfer Study Material','Flow rate and pressure drop relationships for Newtonian fluids flowing through pipe, Reynolds number',NULL,NULL,10,1,1776533650085,'cmo4m9let0091p5i2iap1mo3s');
INSERT INTO StudyMaterial VALUES('cmo4m9leu0096p5i2wx60pvez',1776533650086,1776533650086,'Browning Study Material','Enzymatic and Non enzymatic browning',NULL,NULL,12,1,1776533650086,'cmo4m9leu0095p5i2g80v7363');
INSERT INTO StudyMaterial VALUES('cmo4m9leu009ap5i2jjgraoeb',1776533650087,1776533650087,'Fermented Beverages Study Material','Alcoholic beverages',NULL,NULL,10,1,1776533650087,'cmo4m9leu0099p5i2ptbjyknr');
INSERT INTO StudyMaterial VALUES('cmo4m9lev009ep5i2zcja6cgm',1776533650088,1776533650088,'Fermented Foods Study Material','Curd, yogurt, cheese, pickle, sauerkraut, soya sauce, idli & dosa, vinegar, sauce',NULL,NULL,12,1,1776533650088,'cmo4m9lev009dp5i26axk6ttx');
INSERT INTO StudyMaterial VALUES('cmo4m9lew009ip5i2jflukorx',1776533650089,1776533650089,'Cereal Processing Study Material','Parboiling of paddy',NULL,NULL,10,1,1776533650089,'cmo4m9lew009hp5i2ji6a80dr');
INSERT INTO StudyMaterial VALUES('cmo4m9lex009mp5i2k00uq76f',1776533650090,1776533650090,'Cereal Processing Study Material','Milling of rice. Waste utilization: uses of by-products from rice milling',NULL,NULL,12,1,1776533650090,'cmo4m9lex009lp5i28ntgwqr0');
INSERT INTO StudyMaterial VALUES('cmo4m9ley009qp5i2t5h0iegd',1776533650090,1776533650090,'Heat Transfer Study Material','Heat transfer by conduction, convection, Radiation',NULL,NULL,10,1,1776533650090,'cmo4m9ley009pp5i2842m09yv');
INSERT INTO StudyMaterial VALUES('cmo4m9ley009up5i250jlaaqi',1776533650091,1776533650091,'Cereal Processing Study Material','Milling of wheat',NULL,NULL,12,1,1776533650091,'cmo4m9ley009tp5i27vibnzlw');
INSERT INTO StudyMaterial VALUES('cmo4m9lez009yp5i2l0c6ine9',1776533650092,1776533650092,'Heat Transfer Study Material','Heat exchangers',NULL,NULL,10,1,1776533650092,'cmo4m9lez009xp5i2k972huw0');
INSERT INTO StudyMaterial VALUES('cmo4m9lf000a2p5i2anf0lv3i',1776533650092,1776533650092,'Cereal Processing Study Material','Milling of maize',NULL,NULL,12,1,1776533650092,'cmo4m9lf000a1p5i2o0be7834');
INSERT INTO StudyMaterial VALUES('cmo4m9lf000a6p5i2nib977gl',1776533650093,1776533650093,'Meat Study Material','Biochemical changes in post mortem, tenderization of muscles',NULL,NULL,10,1,1776533650093,'cmo4m9lf000a5p5i2m9l2tmdw');
INSERT INTO StudyMaterial VALUES('cmo4m9lf100aap5i2n6ro0w3m',1776533650093,1776533650093,'Nutrition Study Material','Water soluble and fat soluble vitamins, role of minerals in nutrition, co-factors, anti-nutrients, nutraceuticals',NULL,NULL,12,1,1776533650093,'cmo4m9lf100a9p5i2hmmkdjr6');
INSERT INTO StudyMaterial VALUES('cmo4m9lf200aep5i2is4trnul',1776533650094,1776533650094,'Nutrition Study Material','Balanced diet, essential amino acids, essential fatty acids, protein efficiency ratio, nutrient deficiency diseases',NULL,NULL,14,1,1776533650094,'cmo4m9lf200adp5i2ghr3q6hd');
INSERT INTO StudyMaterial VALUES('cmo4m9lf200aip5i2229alcg8',1776533650095,1776533650095,'Milk Processing Study Material','Pasteurization, sterilization, High pressure homogenization',NULL,NULL,10,1,1776533650095,'cmo4m9lf200ahp5i2wch90b7y');
INSERT INTO StudyMaterial VALUES('cmo4m9lf300amp5i2fkuu4k8g',1776533650095,1776533650095,'Mechanical Operation in Milk Processing Study Material','Filtration, centrifugation',NULL,NULL,12,1,1776533650095,'cmo4m9lf300alp5i2z0km0m41');
INSERT INTO StudyMaterial VALUES('cmo4m9lf300aqp5i2uyg3id0h',1776533650096,1776533650096,'Milk Products Processing Study Material','Cream, Butter, Ghee, Ice cream, Cheese, Milk powder',NULL,NULL,10,1,1776533650096,'cmo4m9lf300app5i2wd42rtmm');
INSERT INTO StudyMaterial VALUES('cmo4m9lf400aup5i23hcvysif',1776533650096,1776533650096,'Processing Principle Study Material','Irradiation',NULL,NULL,12,1,1776533650096,'cmo4m9lf400atp5i2pcct8an4');
INSERT INTO StudyMaterial VALUES('cmo4m9lf400ayp5i28glae27l',1776533650097,1776533650097,'Food Spoilage Study Material','Spoilage microorganisms in fish, milk, meat, egg, cereal and their products',NULL,NULL,10,1,1776533650097,'cmo4m9lf400axp5i2p0i0lzdn');
INSERT INTO StudyMaterial VALUES('cmo4m9lf500b2p5i2ylu3r2cx',1776533650098,1776533650098,'Pigments Study Material','Carotenoids, chlorophylls, anthocyanins, tannins, myoglobin. Food flavours: Terpenes, esters, aldehydes, ketones and quinines',NULL,NULL,12,1,1776533650098,'cmo4m9lf500b1p5i2w8zdchc4');
INSERT INTO StudyMaterial VALUES('cmo4m9lf600b6p5i24l10f0ow',1776533650098,1776533650098,'Mass Transfer Study Material','Molecular diffusion and Fick''s law, conduction and convective mass transfer, permeability through single and multilayer films',NULL,NULL,10,1,1776533650098,'cmo4m9lf600b5p5i24vbnz2fx');
INSERT INTO StudyMaterial VALUES('cmo4m9lf600bap5i2enhjj68u',1776533650099,1776533650099,'Plantation Crops Processing Study Material','Coffee',NULL,NULL,12,1,1776533650099,'cmo4m9lf600b9p5i2t6qqbsr8');
INSERT INTO StudyMaterial VALUES('cmo4m9lf700bep5i2jm8kgqzn',1776533650099,1776533650099,'Cereal Processing Study Material','Bread, biscuits, extruded products, ready to eat breakfast cereals',NULL,NULL,10,1,1776533650099,'cmo4m9lf700bdp5i2lfphci2q');
INSERT INTO StudyMaterial VALUES('cmo4m9lf700bip5i2mykgbb1p',1776533650100,1776533650100,'Food Standards Study Material','Food plant sanitation and cleaning in place (CIP)',NULL,NULL,12,1,1776533650100,'cmo4m9lf700bhp5i21mrggv98');
INSERT INTO StudyMaterial VALUES('cmo4m9lf800bmp5i27hp7s4vm',1776533650101,1776533650101,'Processing Principles Study Material','Chilling, freezing, crystallization',NULL,NULL,10,1,1776533650101,'cmo4m9lf800blp5i2xizmz7dn');
INSERT INTO StudyMaterial VALUES('cmo4m9lf900bqp5i207wlvwtu',1776533650101,1776533650101,'Mass Transfer Operations Study Material','Psychometric, humidification and dehumidification operations',NULL,NULL,12,1,1776533650101,'cmo4m9lf900bpp5i2pxxm0ynn');
INSERT INTO StudyMaterial VALUES('cmo4m9lfa00bup5i2bodqph16',1776533650102,1776533650102,'Plantation Crops Processing Study Material','Spice, extraction of essential oils and oleoresins from spice',NULL,NULL,10,1,1776533650102,'cmo4m9lf900btp5i2z7l87jql');
INSERT INTO StudyMaterial VALUES('cmo4m9lfa00byp5i2jd4osfme',1776533650103,1776533650103,'Thermal Operations Study Material','Evaporation of liquid foods',NULL,NULL,12,1,1776533650103,'cmo4m9lfa00bxp5i2u8p9ovfy');
INSERT INTO StudyMaterial VALUES('cmo4m9lfb00c2p5i20lezc3o8',1776533650103,1776533650103,'Thermal Operations Study Material','Hot air drying of solids; Spray drying, Freeze drying, Dehydration',NULL,NULL,10,1,1776533650103,'cmo4m9lfb00c1p5i28gsejw41');
INSERT INTO StudyMaterial VALUES('cmo4m9lfb00c6p5i26rs5rykq',1776533650104,1776533650104,'Plantation Crops Processing Study Material','Cocoa',NULL,NULL,12,1,1776533650104,'cmo4m9lfb00c5p5i2udotqm1i');
INSERT INTO StudyMaterial VALUES('cmo4m9lfc00cap5i2c7n0spyw',1776533650104,1776533650104,'Processing of Animal Products Study Material','Drying, canning, and freezing of fish and meat',NULL,NULL,10,1,1776533650104,'cmo4m9lfc00c9p5i27nln5kfe');
INSERT INTO StudyMaterial VALUES('cmo4m9lfd00cep5i2aaon7ws7',1776533650106,1776533650106,'Processing of Animal Products Study Material','Production of egg powder',NULL,NULL,12,1,1776533650106,'cmo4m9lfd00cdp5i2mun3mw4l');
INSERT INTO StudyMaterial VALUES('cmo4m9lfe00cip5i2chrq38va',1776533650107,1776533650107,'Food Standards Study Material','HACCP',NULL,NULL,10,1,1776533650107,'cmo4m9lfe00chp5i2jkpe9dmq');
INSERT INTO StudyMaterial VALUES('cmo4m9lff00cmp5i2o6cutw4u',1776533650107,1776533650107,'Food Standards Study Material','FPO, PFA, A-Mark, ISI',NULL,NULL,12,1,1776533650107,'cmo4m9lff00clp5i20eep8wxn');
INSERT INTO StudyMaterial VALUES('cmo4m9lff00cqp5i20c1i301z',1776533650108,1776533650108,'Waste Utilization Study Material','Pectin from fruit wastes',NULL,NULL,14,1,1776533650108,'cmo4m9lff00cpp5i2khr7rhko');
INSERT INTO StudyMaterial VALUES('cmo4m9lfg00cup5i2e0rtpe8z',1776533650108,1776533650108,'Mechanical Operation Study Material','Settling, sieving, mixing & agitation of liquid',NULL,NULL,10,1,1776533650108,'cmo4m9lfg00ctp5i2xlmswh64');
INSERT INTO StudyMaterial VALUES('cmo4m9lfg00cyp5i2v1z2bexd',1776533650109,1776533650109,'Processing Principle Study Material','Hurdle technology',NULL,NULL,12,1,1776533650109,'cmo4m9lfg00cxp5i2esk45xfk');
INSERT INTO StudyMaterial VALUES('cmo4m9lfh00d2p5i2jzglk7sl',1776533650109,1776533650109,'Mechanical Operation Study Material','Size reduction of solids',NULL,NULL,10,1,1776533650109,'cmo4m9lfh00d1p5i2w04llk4f');
INSERT INTO StudyMaterial VALUES('cmo4m9lfi00d6p5i2ltzs7fvd',1776533650110,1776533650110,'Processing Principle Study Material','Addition of preservatives and food additives',NULL,NULL,12,1,1776533650110,'cmo4m9lfi00d5p5i2fq97adtj');
INSERT INTO StudyMaterial VALUES('cmo4m9lfi00dap5i2bzd9kzpi',1776533650111,1776533650111,'Fruit and Vegetable Processing Study Material','Extraction, clarification, concentration and packaging of fruit juice, jam, jelly, marmalade, squash, candies, tomato sauce, ketchup, and puree, potato chips, pickles',NULL,NULL,10,1,1776533650111,'cmo4m9lfi00d9p5i2td1qx682');
INSERT INTO StudyMaterial VALUES('cmo4m9lfj00dep5i2oebbu0g8',1776533650111,1776533650111,'Food Packaging and Storage Study Material','Packaging materials, aseptic packaging, controlled and modified atmosphere storage',NULL,NULL,12,1,1776533650111,'cmo4m9lfj00ddp5i2nmvn96qq');
INSERT INTO StudyMaterial VALUES('cmo4m9lfj00dip5i24e6rffi6',1776533650112,1776533650112,'Toxins from Microbes Study Material','Pathogens and non-pathogens, Staphylococcus, Salmonella, Shebelle, Shigella, Escherichia, Bacillus, Clostridium Aspergillus genera',NULL,NULL,10,1,1776533650112,'cmo4m9lfj00dhp5i2l4tnq3d0');
INSERT INTO StudyMaterial VALUES('cmo4m9lfk00dmp5i2o99c97fn',1776533650113,1776533650113,'Chemical and Biochemical Changes Study Material','Changes occurring in foods during different processing',NULL,NULL,12,1,1776533650113,'cmo4m9lfk00dlp5i2siakb62z');
INSERT INTO StudyMaterial VALUES('cmo4m9lfl00dqp5i26ew7039p',1776533650113,1776533650113,'Processing Principle Study Material','Fermentation',NULL,NULL,14,1,1776533650113,'cmo4m9lfl00dpp5i2abghgxjs');
INSERT INTO StudyMaterial VALUES('cmo4m9lfl00dup5i2rrag3d3k',1776533650114,1776533650114,'Primitive atomic models (briefly), wave particle duality of electromagnetic radiation, Black body radiation and Planck''s quantum theory Study Material',NULL,NULL,'https://drive.google.com/file/d/1XuiyOQs4dS497LvUrLHS254qJy4qITZy/preview',10,1,1776533650114,'cmo4m9lfl00dtp5i2qlzh8d89');
INSERT INTO StudyMaterial VALUES('cmo4m9lfm00dyp5i21u0aywkh',1776533650115,1776533650115,'Comparison between Bohr''s model and quantum mechanical model, uncertainty principle, electronic configuration of atoms and ions, Hund''s rule and Pauli''s exclusion principle Study Material',NULL,NULL,NULL,10,1,1776533650115,'cmo4m9lfm00dxp5i2tnr0kzng');
INSERT INTO StudyMaterial VALUES('cmo4m9lfn00e2p5i296e72dpl',1776533650115,1776533650115,'Periodic table & periodic properties: ionisation energy, electronegativity, electron affinity and atomic size Study Material',NULL,NULL,NULL,10,1,1776533650115,'cmo4m9lfn00e1p5i21n1upoop');
INSERT INTO StudyMaterial VALUES('cmo4m9lfo00e6p5i27sxmvtj9',1776533650116,1776533650116,'Structure and bonding: ionic and covalent bonding, MO & VB approaches for diatomic molecules Study Material',NULL,NULL,NULL,10,1,1776533650116,'cmo4m9lfo00e5p5i2r4s00xu3');
INSERT INTO StudyMaterial VALUES('cmo4m9lfo00eap5i2svghc02u',1776533650117,1776533650117,'VSEPR theory and shape of molecules, hybridization, resonance, dipole moment, structural parameters, hydrogen bonding and van der Waals interaction, ionic solids and ionic radii, lattice energy (Born‐Haber cycle), HSAB principle Study Material',NULL,NULL,NULL,10,1,1776533650117,'cmo4m9lfo00e9p5i2gsodzqg5');
INSERT INTO StudyMaterial VALUES('cmo4m9lfp00eep5i2r20rjfo3',1776533650117,1776533650117,'s block elements Study Material',NULL,NULL,NULL,10,1,1776533650117,'cmo4m9lfp00edp5i25esbymu0');
INSERT INTO StudyMaterial VALUES('cmo4m9lfp00eip5i2p7m19e1e',1776533650118,1776533650118,'p block elements Study Material',NULL,NULL,NULL,10,1,1776533650118,'cmo4m9lfp00ehp5i2auy47bks');
INSERT INTO StudyMaterial VALUES('cmo4m9lfq00emp5i2wzxngedl',1776533650119,1776533650119,'d block elements Study Material',NULL,NULL,NULL,10,1,1776533650119,'cmo4m9lfq00elp5i2g6x5vw59');
INSERT INTO StudyMaterial VALUES('cmo4m9lfr00eqp5i2nlpcbzbz',1776533650119,1776533650119,'Coordination Compounds: nomenclature, isomerism, geometry, valence bond theory Study Material',NULL,NULL,NULL,10,1,1776533650119,'cmo4m9lfr00epp5i2nis3s2l9');
INSERT INTO StudyMaterial VALUES('cmo4m9lfr00eup5i2ybsntpfp',1776533650120,1776533650120,'Coordination Compounds: Valence bond theory, crystal field theory, color, magnetic properties Study Material',NULL,NULL,NULL,10,1,1776533650120,'cmo4m9lfr00etp5i2lw32r5si');
INSERT INTO StudyMaterial VALUES('cmo4m9lfs00eyp5i2b5i0x2xw',1776533650121,1776533650121,'Chemical equilibria: Osmotic pressure, elevation of boiling point and depression of freezing point, ionic equilibria in solution, solubility product. Study Material',NULL,NULL,NULL,10,1,1776533650121,'cmo4m9lfs00exp5i2s8ov7pk7');
INSERT INTO StudyMaterial VALUES('cmo4m9lft00f2p5i2p5jd8ipv',1776533650121,1776533650121,'Chemical equilibria: common ion effect, hydrolysis of salts, pH, buffer and their applications. Equilibrium constants (Kc, Kp and Kx) for homogeneous reactions Study Material',NULL,NULL,NULL,10,1,1776533650121,'cmo4m9lft00f1p5i218fnbgt2');
INSERT INTO StudyMaterial VALUES('cmo4m9lft00f6p5i2k35i0kdl',1776533650122,1776533650122,'Reaction Kinetics: Rate constant, order of reaction, molecularity, activation energy, zero, first and second order kinetics, catalysis and elementary enzyme reactions. Reversible and irreversible inhibition of enzymes Study Material',NULL,NULL,NULL,10,1,1776533650122,'cmo4m9lft00f5p5i2phanurmo');
INSERT INTO StudyMaterial VALUES('cmo4m9lfu00fap5i2q92rh1vb',1776533650122,1776533650122,'Reaction Kinetics: catalysis and elementary enzyme reactions. Reversible and irreversible inhibition of enzymes Study Material',NULL,NULL,NULL,10,1,1776533650122,'cmo4m9lfu00f9p5i27c946n8b');
INSERT INTO StudyMaterial VALUES('cmo4m9lfv00fep5i22xw1o5y3',1776533650123,1776533650123,'Electrochemistry: Conductance, Kohlrausch law, cell potentials, EMF, Nernst equation, thermodynamic aspects and their applications Study Material',NULL,NULL,NULL,10,1,1776533650123,'cmo4m9lfv00fdp5i239ou5amz');
INSERT INTO StudyMaterial VALUES('cmo4m9lfw00fip5i2xntvigtt',1776533650124,1776533650124,'Thermodynamics: Qualitative treatment of state and path functions, First law, reversible and irreversible processes, internal energy, enthalpy, Kirchoff equation, heat of reaction, Hess’s law, heat of formation. Study Material',NULL,NULL,NULL,10,1,1776533650124,'cmo4m9lfw00fhp5i2nj0rn5sh');
INSERT INTO StudyMaterial VALUES('cmo4m9lfw00fmp5i2njtx0s83',1776533650125,1776533650125,'Thermodynamics: Second law, entropy and free energy. Gibbs‐Helmholtz equation, free energy change and spontaneity, Free energy changes from equilibrium constant. Study Material',NULL,NULL,NULL,10,1,1776533650125,'cmo4m9lfw00flp5i2x4cqp6es');
INSERT INTO StudyMaterial VALUES('cmo4m9lfx00fqp5i26sv878lr',1776533650126,1776533650126,'Organic Reaction Mechanisms and Hydrocarbon: Acids and bases, electronic and steric effects, Stereochemistry, optical and geometrical isomerism, tautomerism, conformers and concept of aromaticity. Study Material',NULL,NULL,NULL,10,1,1776533650126,'cmo4m9lfx00fpp5i2m3alj94h');
INSERT INTO StudyMaterial VALUES('cmo4m9lfy00fup5i28zk41nzd',1776533650126,1776533650126,'Organic Reaction Mechanisms and Hydrocarbon: Elementary treatment of SN1, SN2, E1, E2 and radical reactions Study Material',NULL,NULL,NULL,10,1,1776533650126,'cmo4m9lfy00ftp5i2xlwpeuqp');
INSERT INTO StudyMaterial VALUES('cmo4m9lfy00fyp5i2mmaqr5sf',1776533650127,1776533650127,'Hoffmann/Saytzeff rules, addition reactions, Markownikoff rule and Kharasch effect. Elementary hydroboration reactions. Grignard’s reagents and their uses Study Material',NULL,NULL,NULL,10,1,1776533650127,'cmo4m9lfy00fxp5i2wwcn5og3');
INSERT INTO StudyMaterial VALUES('cmo4m9lfz00g2p5i26w11gri3',1776533650127,1776533650127,'Alcohol: Aromatic electrophilic substitutions, orientation effect as exemplified by various functional groups. Identification of common functional groups by chemical tests Study Material',NULL,NULL,NULL,10,1,1776533650127,'cmo4m9lfz00g1p5i2gv649neq');
INSERT INTO StudyMaterial VALUES('cmo4m9lg000g6p5i233yfwqfp',1776533650128,1776533650128,'Aldehydes and Ketones: Aromatic electrophilic substitutions, orientation effect as exemplified by various functional groups. Identification of common functional groups by chemical tests. Study Material',NULL,NULL,NULL,10,1,1776533650128,'cmo4m9lg000g5p5i2lzc9z8f3');
INSERT INTO StudyMaterial VALUES('cmo4m9lg000gap5i2oxl0qtjs',1776533650129,1776533650129,'Carboxylic acids and amines: Aromatic electrophilic substitutions, orientation effect as exemplified by various functional groups. Identification of common functional groups by chemical tests. Study Material',NULL,NULL,NULL,10,1,1776533650129,'cmo4m9lg000g9p5i2lncbt39m');
INSERT INTO StudyMaterial VALUES('cmo4m9lg100gep5i2vjs52pl2',1776533650129,1776533650129,'Chemistry of Biomolecules: Amino acids, proteins, nucleic acids and nucleotides. Peptide sequencing. DNA sequencing, Carbohydrates (upto hexoses only). Lipids (triglycerides only). Study Material',NULL,NULL,NULL,10,1,1776533650129,'cmo4m9lg100gdp5i2yst72ye8');
INSERT INTO StudyMaterial VALUES('cmo4m9lg200gip5i2fur63vqo',1776533650130,1776533650130,'Chemistry of Biomolecules: Principles of biomolecule purification - Ion exchange and gel filtration chromatography. Identification of these biomolecules and Beer-Lambert’s law. Study Material',NULL,NULL,NULL,10,1,1776533650130,'cmo4m9lg200ghp5i2iace28g7');
INSERT INTO StudyMaterial VALUES('cmo4m9lg300gmp5i26l993z35',1776533650131,1776533650131,'Importance of water; Structure and function of biomolecules: Lipids Study Material',NULL,NULL,NULL,10,1,1776533650131,'cmo4m9lg300glp5i2nm8az2ey');
INSERT INTO StudyMaterial VALUES('cmo4m9lg300gqp5i2cfw1gdzn',1776533650132,1776533650132,'Structure and function of biomolecules: Carbohydrates Study Material',NULL,NULL,NULL,10,1,1776533650132,'cmo4m9lg300gpp5i2i1wymh0s');
INSERT INTO StudyMaterial VALUES('cmo4m9lg400gup5i2y4hub1ja',1776533650132,1776533650132,'Structure and function of biomolecules: Amino acids and Nucleic acids Study Material',NULL,NULL,NULL,10,1,1776533650132,'cmo4m9lg400gtp5i2dbys76e8');
INSERT INTO StudyMaterial VALUES('cmo4m9lg400gyp5i2f26grlnl',1776533650133,1776533650133,'Protein structure, folding and function Study Material',NULL,NULL,NULL,10,1,1776533650133,'cmo4m9lg400gxp5i2r8pgfdft');
INSERT INTO StudyMaterial VALUES('cmo4m9lg500h2p5i2qlvj0hlf',1776533650133,1776533650133,'Protein structure, folding and function: II; Myoglobin and Hemoglobin Study Material',NULL,NULL,NULL,10,1,1776533650133,'cmo4m9lg500h1p5i21ruswwok');
INSERT INTO StudyMaterial VALUES('cmo4m9lg500h6p5i24giw307u',1776533650134,1776533650134,'Enzymes: Kinetics, regulation and inhibition; Lysozyme, Ribonuclease A, Carboxypeptidase and Chymotrypsin; Vitamins and Coenzymes Study Material',NULL,NULL,NULL,10,1,1776533650134,'cmo4m9lg500h5p5i2f9n29ou5');
INSERT INTO StudyMaterial VALUES('cmo4m9lg600hap5i2jpybahrg',1776533650134,1776533650134,'Metabolism and bioenergetics, Generation and utilization of ATP Study Material',NULL,NULL,NULL,10,1,1776533650134,'cmo4m9lg600h9p5i2m49lgd4n');
INSERT INTO StudyMaterial VALUES('cmo4m9lg700hep5i2llmb1rr4',1776533650135,1776533650135,'Metabolic pathways and their regulation: glycolysis Study Material',NULL,NULL,NULL,10,1,1776533650135,'cmo4m9lg700hdp5i2vctmjidp');
INSERT INTO StudyMaterial VALUES('cmo4m9lg700hip5i239zs3wxh',1776533650136,1776533650136,'Metabolic pathways and their regulation: gluconeogenesis, pentose phosphate pathway Study Material',NULL,NULL,NULL,10,1,1776533650136,'cmo4m9lg700hhp5i2s8ga1jwn');
INSERT INTO StudyMaterial VALUES('cmo4m9lg800hmp5i25n2n64un',1776533650136,1776533650136,'Metabolic pathways and their regulation: TCA cycle (Kreb Cycle), oxidative phosphorylation Study Material',NULL,NULL,NULL,10,1,1776533650136,'cmo4m9lg800hlp5i2sapxs5or');
INSERT INTO StudyMaterial VALUES('cmo4m9lg900hqp5i2lr65g2bb',1776533650137,1776533650137,'Metabolic pathways and their regulation: glycogen and fatty acid metabolism Study Material',NULL,NULL,NULL,10,1,1776533650137,'cmo4m9lg900hpp5i26jz1htoj');
INSERT INTO StudyMaterial VALUES('cmo4m9lga00hup5i2cf7efl3v',1776533650138,1776533650138,'Metabolism of Nitrogen containing compounds: nitrogen fixation, amino acids, nucleotides Study Material',NULL,NULL,NULL,10,1,1776533650138,'cmo4m9lga00htp5i20uwd8gjk');
INSERT INTO StudyMaterial VALUES('cmo4m9lgb00hyp5i2c6yoj8g5',1776533650139,1776533650139,'Photosynthesis: Calvin cycle. Study Material',NULL,NULL,NULL,10,1,1776533650139,'cmo4m9lgb00hxp5i20nlt2x9y');
INSERT INTO StudyMaterial VALUES('cmo4m9lgb00i2p5i2o7ifcqxo',1776533650140,1776533650140,'Biochemical separation techniques: ion exchange, size exclusion and affinity chromatography Study Material',NULL,NULL,NULL,10,1,1776533650140,'cmo4m9lgb00i1p5i2submrnde');
INSERT INTO StudyMaterial VALUES('cmo4m9lgc00i6p5i2yldvzwi8',1776533650140,1776533650140,'Biochemical separation techniques: centrifugation; Characterisation of biomolecules by electrophoresis Study Material',NULL,NULL,NULL,10,1,1776533650140,'cmo4m9lgc00i5p5i2d4wvot56');
INSERT INTO StudyMaterial VALUES('cmo4m9lgc00iap5i2wrclqh77',1776533650141,1776533650141,'Biochemical separation techniques: UV-visible and fluorescence spectroscopy, Mass spectrometry Study Material',NULL,NULL,NULL,10,1,1776533650141,'cmo4m9lgc00i9p5i2ma3mfnpz');
INSERT INTO StudyMaterial VALUES('cmo4m9lgd00iep5i206hj2uei',1776533650141,1776533650141,'Organisation of life; Cell structure and organelles; Biological membranes (plasma membrane) Study Material',NULL,NULL,NULL,10,1,1776533650141,'cmo4m9lgd00idp5i2fyuhwz68');
INSERT INTO StudyMaterial VALUES('cmo4m9lge00iip5i2hyg3suay',1776533650142,1776533650142,'Membrane Action potential; Transport across membranes; Membrane assembly and Protein targeting Study Material',NULL,NULL,NULL,10,1,1776533650142,'cmo4m9lge00ihp5i2otnz9tz8');
INSERT INTO StudyMaterial VALUES('cmo4m9lge00imp5i2nr1vmxfo',1776533650143,1776533650143,'DNA-protein and protein–protein interactions Study Material',NULL,NULL,NULL,10,1,1776533650143,'cmo4m9lge00ilp5i28gok29ig');
INSERT INTO StudyMaterial VALUES('cmo4m9lgf00iqp5i2fgn83pn5',1776533650143,1776533650143,'Cell Signaling: Signal transduction; Receptor-ligand interaction; Hormones and neurotransmitters Study Material',NULL,NULL,NULL,10,1,1776533650143,'cmo4m9lgf00ipp5i2kpw2hq91');
INSERT INTO StudyMaterial VALUES('cmo4m9lgf00iup5i2m3lne5ol',1776533650144,1776533650144,'DNA replication, transcription and translation; DNA damage and repair; Biochemical regulation of gene expression Study Material',NULL,NULL,NULL,10,1,1776533650144,'cmo4m9lgf00itp5i2luapx0bn');
INSERT INTO StudyMaterial VALUES('cmo4m9lgg00iyp5i2syqsfquv',1776533650145,1776533650145,'Immune system: Innate and adaptive; Cell of the immune system; Active and passive immunity; Complement system Study Material',NULL,NULL,NULL,10,1,1776533650145,'cmo4m9lgg00ixp5i2rkaxnhvu');
INSERT INTO StudyMaterial VALUES('cmo4m9lgh00j2p5i2b6m3vnfi',1776533650145,1776533650145,'Antibody structure, function and diversity; B cell and T Cell receptors; B cell and T cell activation Study Material',NULL,NULL,NULL,10,1,1776533650145,'cmo4m9lgh00j1p5i2s63abi2i');
INSERT INTO StudyMaterial VALUES('cmo4m9lgh00j6p5i278ycdbju',1776533650146,1776533650146,'Immunological techniques: Immunodiffusion, immune-electrophoresis, RIA and ELISA, flow cytometry; monoclonal antibodies and their applications. Study Material',NULL,NULL,NULL,10,1,1776533650146,'cmo4m9lgh00j5p5i2rn9w7wzn');
INSERT INTO StudyMaterial VALUES('cmo4m9lgi00jap5i2nixcpazd',1776533650147,1776533650147,'Recombinant DNA technology and applications: PCR Study Material',NULL,NULL,NULL,10,1,1776533650147,'cmo4m9lgi00j9p5i21dea5v6m');
INSERT INTO StudyMaterial VALUES('cmo4m9lgj00jep5i2o07m5vds',1776533650147,1776533650147,'Site directed mutagenesis, DNA-microarray; Next generation sequencing; Gene silencing and editing. Study Material',NULL,NULL,NULL,10,1,1776533650147,'cmo4m9lgj00jdp5i233auxd83');
INSERT INTO StudyMaterial VALUES('cmo4m9lgk00jip5i2cmly2kz7',1776533650148,1776533650148,'Historical Perspective (1) Study Material',NULL,NULL,NULL,10,1,1776533650148,'cmo4m9lgk00jhp5i2l86wg9lv');
INSERT INTO StudyMaterial VALUES('cmo4m9lgk00jmp5i2jmsw3y12',1776533650149,1776533650149,'Historical Perspective (2): Role of microorganisms in transformation of organic matter and in the causation of diseases Study Material',NULL,NULL,NULL,10,1,1776533650149,'cmo4m9lgk00jlp5i25n4fr865');
INSERT INTO StudyMaterial VALUES('cmo4m9lgl00jqp5i2wdccl978',1776533650149,1776533650149,'Methods in Microbiology 1: Pure culture techniques; Theory and practice of sterilization; Principles of microbial nutrition; Enrichment culture techniques for isolation of microorganisms Study Material',NULL,NULL,NULL,10,1,1776533650149,'cmo4m9lgl00jpp5i2v1gaym99');
INSERT INTO StudyMaterial VALUES('cmo4m9lgl00jup5i24q23ijnl',1776533650150,1776533650150,'Methods in Microbiology 2: Light-, phase contrast- and electron-microscopy Study Material',NULL,NULL,NULL,10,1,1776533650150,'cmo4m9lgl00jtp5i2az5eyonw');
INSERT INTO StudyMaterial VALUES('cmo4m9lgm00jyp5i295c2aen4',1776533650150,1776533650150,'Methods in Microbiology 3: antigen and antibody detection methods for microbial diagnosis Study Material',NULL,NULL,NULL,10,1,1776533650150,'cmo4m9lgm00jxp5i29hmn318u');
INSERT INTO StudyMaterial VALUES('cmo4m9lgm00k2p5i24e13wwu2',1776533650151,1776533650151,'Methods in Microbiology 4: PCR, real-time PCR for quantitation of microbes Next generation sequencing technologies in microbiology. Study Material',NULL,NULL,NULL,10,1,1776533650151,'cmo4m9lgm00k1p5i2qwx5kklu');
INSERT INTO StudyMaterial VALUES('cmo4m9lgn00k6p5i2ippnewpu',1776533650151,1776533650151,'Microbial Taxonomy and Diversity 1: Bacteria, Archea and their broad classification Eukaryotic microbes: Yeasts, molds and protozoa Study Material',NULL,NULL,NULL,10,1,1776533650151,'cmo4m9lgn00k5p5i2372vbgdn');
INSERT INTO StudyMaterial VALUES('cmo4m9lgn00kap5i20k80m7ch',1776533650152,1776533650152,'Microbial Taxonomy and Diversity 2: Viruses and their classification; Molecular approaches to microbial taxonomy and phylogeny Study Material',NULL,NULL,NULL,10,1,1776533650152,'cmo4m9lgn00k9p5i2blzaol2j');
INSERT INTO StudyMaterial VALUES('cmo4m9lgo00kep5i20370m4xa',1776533650153,1776533650153,'Prokaryotic Cells: cell walls, cell membranes and their biosynthesis, mechanisms of solute transport across membranes, Flagella and Pili, Capsules, Cell inclusions like endospores and gas vesicles; Bacterial locomotion, including positive and negative chemotaxis Study Material',NULL,NULL,NULL,10,1,1776533650153,'cmo4m9lgo00kdp5i210cnnwc9');
INSERT INTO StudyMaterial VALUES('cmo4m9lgp00kip5i2stecj1q8',1776533650153,1776533650153,'Microbial Growth 1: Definition of growth, Growth curve, Mathematical expression of exponential growth phase Study Material',NULL,NULL,NULL,10,1,1776533650153,'cmo4m9lgp00khp5i2gwrmg7pv');
INSERT INTO StudyMaterial VALUES('cmo4m9lgp00kmp5i23xhh8fqp',1776533650154,1776533650154,'Microbial Growth 2: Measurement of growth and growth yields; Synchronous growth; Continuous culture; Effect of environmental factors on growth. Bacterial biofilm and biofouling Study Material',NULL,NULL,NULL,10,1,1776533650154,'cmo4m9lgp00klp5i2znauy7oa');
INSERT INTO StudyMaterial VALUES('cmo4m9lgq00kqp5i2i9ztmzba',1776533650154,1776533650154,'Control of Micro-organisms: Disinfection and sterilization: principles, methods and assessment of efficacy Study Material',NULL,NULL,NULL,10,1,1776533650154,'cmo4m9lgq00kpp5i2nt1t94fa');
INSERT INTO StudyMaterial VALUES('cmo4m9lgq00kup5i2ho1m362j',1776533650155,1776533650155,'Microbial Metabolism 1: Energetics: redox reactions and electron carriers; Electron transport and oxidative phosphorylation; An overview of metabolism; Study Material',NULL,NULL,NULL,10,1,1776533650155,'cmo4m9lgq00ktp5i2r4facq08');
INSERT INTO StudyMaterial VALUES('cmo4m9lgr00kyp5i24phyz23j',1776533650155,1776533650155,'Microbial Metabolism 2: Glycolysis; Pentose-phosphate pathway; Entner-Doudoroff pathway; Glyoxalate pathway; The citric acid cycle Study Material',NULL,NULL,NULL,10,1,1776533650155,'cmo4m9lgr00kxp5i25xw8lnpw');
INSERT INTO StudyMaterial VALUES('cmo4m9lgs00l2p5i2y0ohyhy0',1776533650156,1776533650156,'Microbial Metabolism 3: Fermentation; Aerobic and anaerobic respiration; Chemolithotrophy; Photosynthesis; Calvin cycle; Biosynthetic pathway for fatty acids synthesis Study Material',NULL,NULL,NULL,10,1,1776533650156,'cmo4m9lgs00l1p5i2yresk7m3');
INSERT INTO StudyMaterial VALUES('cmo4m9lgt00l6p5i2c02b58aw',1776533650157,1776533650157,'Microbial Metabolism 4: Common regulatory mechanisms in synthesis of amino acids; Regulation of major metabolic pathways Study Material',NULL,NULL,NULL,10,1,1776533650157,'cmo4m9lgt00l5p5i2oveamb50');
INSERT INTO StudyMaterial VALUES('cmo4m9lgu00lap5i25ahrhdq8',1776533650159,1776533650159,'Microbial Diseases and Host Pathogen Interaction 1: Normal microbiota; Classification of infectious diseases; Reservoirs of infection; Nosocomial infection; Opportunistic infections; Emerging infectious diseases; Mechanism of microbial pathogenicity Study Material',NULL,NULL,NULL,10,1,1776533650159,'cmo4m9lgu00l9p5i2ro1lupvo');
INSERT INTO StudyMaterial VALUES('cmo4m9lgv00lep5i29cvmlqtr',1776533650159,1776533650159,'Microbial Diseases and Host Pathogen Interaction 2: Nonspecific defense of host; Antigens and antibodies; Humoral and cell mediated immunity; Vaccines; Passive immunization; Immune deficiency; Human diseases caused by viruses, bacteria, and pathogenic fungi Study Material',NULL,NULL,NULL,10,1,1776533650159,'cmo4m9lgv00ldp5i2fis9uuna');
INSERT INTO StudyMaterial VALUES('cmo4m9lgw00lip5i2t40uyqyk',1776533650160,1776533650160,'Chemotherapy/ Antibiotics: General characteristics of antimicrobial drugs; Antibiotics: Classification, mode of action and resistance; Antifungal and antiviral drugs Study Material',NULL,NULL,NULL,10,1,1776533650160,'cmo4m9lgw00lhp5i2u1wuml5t');
INSERT INTO StudyMaterial VALUES('cmo4m9lgw00lmp5i2zqmusbr2',1776533650161,1776533650161,'Microbial Genetics part 1: Types of mutation; UV and chemical mutagens; Selection of mutants; Ames test for mutagenesis Study Material',NULL,NULL,NULL,10,1,1776533650161,'cmo4m9lgw00llp5i2n4glf9qz');
INSERT INTO StudyMaterial VALUES('cmo4m9lgx00lqp5i25lrrf7yy',1776533650162,1776533650162,'Microbial Genetics part 2: Bacterial genetic system: transformation, conjugation, transduction, recombination, plasmids, transposons Study Material',NULL,NULL,NULL,10,1,1776533650162,'cmo4m9lgx00lpp5i2b1aen8vh');
INSERT INTO StudyMaterial VALUES('cmo4m9lgy00lup5i25xc49cp2',1776533650162,1776533650162,'Microbial Genetics part 3: DNA repair; Regulation of gene expression: repression and induction; Operon model; Bacterial genome with special reference to E.coli; Phage λ and its life cycle; RNA phages Study Material',NULL,NULL,NULL,10,1,1776533650162,'cmo4m9lgy00ltp5i2v1t7nynn');
INSERT INTO StudyMaterial VALUES('cmo4m9lgy00lyp5i2v1km23ef',1776533650163,1776533650163,'Microbial Genetics part 4: RNA viruses Retroviruses; mutation in virus genomes, virus recombination and reassortment; Basic concept of microbial genomics Study Material',NULL,NULL,NULL,10,1,1776533650163,'cmo4m9lgy00lxp5i2391s776h');
INSERT INTO StudyMaterial VALUES('cmo4m9lgz00m2p5i2boy9qt0n',1776533650164,1776533650164,'Microbial Ecology: Microbial interactions:Carbon, sulphur and nitrogen cycles Soil microorganisms associated with vascular plants. Bioremediation; Uncultivable microorganisms; basic concept of metagenomics and metatranscriptomics Study Material',NULL,NULL,NULL,10,1,1776533650164,'cmo4m9lgz00m1p5i2f3e6vigd');

INSERT INTO Module VALUES('cmo4m9lh100m7p5i2lcro404q',1776533650166,1776533650166,'Module 1','Release bundle for XE Thermodynamics Module 1.',1,'cmo4m9lh000m5p5i2y81dh8vk');
INSERT INTO Module VALUES('cmo4m9lh200m9p5i2w4p36o60',1776533650167,1776533650167,'Module 2','Release bundle for XE Thermodynamics Module 2.',2,'cmo4m9lh000m5p5i2y81dh8vk');
INSERT INTO Module VALUES('cmo4m9lh300mbp5i29bswv0q2',1776533650168,1776533650168,'Module 3','Release bundle for XE Thermodynamics Module 3.',3,'cmo4m9lh000m5p5i2y81dh8vk');
INSERT INTO Module VALUES('cmo4m9lh400mdp5i2yuh69ai2',1776533650168,1776533650168,'Module 4','Release bundle for XE Thermodynamics Module 4.',4,'cmo4m9lh000m5p5i2y81dh8vk');
INSERT INTO Module VALUES('cmo4m9lh500mfp5i2v8w44b2g',1776533650169,1776533650169,'Module 5','Release bundle for XE Thermodynamics Module 5.',5,'cmo4m9lh000m5p5i2y81dh8vk');
INSERT INTO Module VALUES('cmo4m9lh500mhp5i292nv8qhq',1776533650170,1776533650170,'Module 6','Release bundle for XE Thermodynamics Module 6.',6,'cmo4m9lh000m5p5i2y81dh8vk');
INSERT INTO Module VALUES('cmo4m9lh600mjp5i25hvhjroz',1776533650171,1776533650171,'Module 7','Release bundle for XE Thermodynamics Module 7.',7,'cmo4m9lh000m5p5i2y81dh8vk');
INSERT INTO Module VALUES('cmo4m9lh700mlp5i2d4lnmai1',1776533650172,1776533650172,'Module 8','Release bundle for XE Thermodynamics Module 8.',8,'cmo4m9lh000m5p5i2y81dh8vk');
INSERT INTO Module VALUES('cmo4m9lh800mnp5i2ji7ahd4y',1776533650172,1776533650172,'Module 9','Release bundle for XE Thermodynamics Module 9.',9,'cmo4m9lh000m5p5i2y81dh8vk');
INSERT INTO Module VALUES('cmo4m9lh900mpp5i2tgi42hog',1776533650173,1776533650173,'Module 10','Release bundle for XE Thermodynamics Module 10.',10,'cmo4m9lh000m5p5i2y81dh8vk');
INSERT INTO Module VALUES('cmo4m9lha00mrp5i2gha7fr1l',1776533650174,1776533650174,'Module 11','Release bundle for XE Thermodynamics Module 11.',11,'cmo4m9lh000m5p5i2y81dh8vk');
INSERT INTO Module VALUES('cmo4m9lha00mtp5i2fhqye70g',1776533650175,1776533650175,'Module 12','Release bundle for XE Thermodynamics Module 12.',12,'cmo4m9lh000m5p5i2y81dh8vk');
INSERT INTO Module VALUES('cmo4m9lhb00mvp5i2rqth7xfa',1776533650175,1776533650175,'Module 13','Release bundle for XE Thermodynamics Module 13.',13,'cmo4m9lh000m5p5i2y81dh8vk');
INSERT INTO Module VALUES('cmo4m9lhc00mxp5i24g9y9on8',1776533650176,1776533650176,'Module 14','Release bundle for XE Thermodynamics Module 14.',14,'cmo4m9lh000m5p5i2y81dh8vk');
INSERT INTO Module VALUES('cmo4m9lhd00mzp5i2uwb91wrn',1776533650177,1776533650177,'Module 15','Release bundle for XE Thermodynamics Module 15.',15,'cmo4m9lh000m5p5i2y81dh8vk');
INSERT INTO Module VALUES('cmo4m9lhe00n1p5i2t7lwubcf',1776533650178,1776533650178,'Module 16','Release bundle for XE Thermodynamics Module 16.',16,'cmo4m9lh000m5p5i2y81dh8vk');
INSERT INTO Module VALUES('cmo4m9lhe00n3p5i2fkdxwue6',1776533650179,1776533650179,'Module 17','Release bundle for XE Thermodynamics Module 17.',17,'cmo4m9lh000m5p5i2y81dh8vk');
INSERT INTO Module VALUES('cmo4m9lhf00n5p5i2std5mnw0',1776533650179,1776533650179,'Module 18','Release bundle for XE Thermodynamics Module 18.',18,'cmo4m9lh000m5p5i2y81dh8vk');
INSERT INTO Module VALUES('cmo4m9lhg00n7p5i2t7gvm8xh',1776533650180,1776533650180,'Module 19','Release bundle for XE Thermodynamics Module 19.',19,'cmo4m9lh000m5p5i2y81dh8vk');
INSERT INTO Module VALUES('cmo4m9lhh00n9p5i2enu5iraq',1776533650181,1776533650181,'Module 20','Release bundle for XE Thermodynamics Module 20.',20,'cmo4m9lh000m5p5i2y81dh8vk');
INSERT INTO Module VALUES('cmo4m9lhh00nbp5i201q6emd1',1776533650182,1776533650182,'Module 21','Release bundle for XE Thermodynamics Module 21.',21,'cmo4m9lh000m5p5i2y81dh8vk');
INSERT INTO Module VALUES('cmo4m9lhi00ndp5i2xkbvptjh',1776533650183,1776533650183,'Module 22','Release bundle for XE Thermodynamics Module 22.',22,'cmo4m9lh000m5p5i2y81dh8vk');
INSERT INTO Module VALUES('cmo4m9lhj00nfp5i2j2on3bpt',1776533650183,1776533650183,'Module 23','Release bundle for XE Thermodynamics Module 23.',23,'cmo4m9lh000m5p5i2y81dh8vk');
INSERT INTO Module VALUES('cmo4m9lhj00nhp5i2tjp2d53s',1776533650184,1776533650184,'Module 24','Release bundle for XE Thermodynamics Module 24.',24,'cmo4m9lh000m5p5i2y81dh8vk');
INSERT INTO Module VALUES('cmo4m9lhk00njp5i23btg5pyv',1776533650185,1776533650185,'Module 25','Release bundle for XE Thermodynamics Module 25.',25,'cmo4m9lh000m5p5i2y81dh8vk');
INSERT INTO Module VALUES('cmo4m9lhl00nlp5i2ecmx91ho',1776533650185,1776533650185,'Module 26','Release bundle for XE Thermodynamics Module 26.',26,'cmo4m9lh000m5p5i2y81dh8vk');
INSERT INTO Module VALUES('cmo4m9lhm00nnp5i2ihjd5jrz',1776533650186,1776533650186,'Module 27','Release bundle for XE Thermodynamics Module 27.',27,'cmo4m9lh000m5p5i2y81dh8vk');
INSERT INTO Module VALUES('cmo4m9llz00shp5i2n9t0ct16',1776533650344,1776533650344,'Module 1','Release bundle for XL Biochemistry Module 1.',1,'cmo4m9lly00sfp5i2u4alokmb');
INSERT INTO Module VALUES('cmo4m9lm000sjp5i2okua57t9',1776533650345,1776533650345,'Module 2','Release bundle for XL Biochemistry Module 2.',2,'cmo4m9lly00sfp5i2u4alokmb');
INSERT INTO Module VALUES('cmo4m9lm100slp5i2lmw2fdz6',1776533650346,1776533650346,'Module 3','Release bundle for XL Biochemistry Module 3.',3,'cmo4m9lly00sfp5i2u4alokmb');
INSERT INTO Module VALUES('cmo4m9lm200snp5i2bvo6ld72',1776533650347,1776533650347,'Module 4','Release bundle for XL Biochemistry Module 4.',4,'cmo4m9lly00sfp5i2u4alokmb');
INSERT INTO Module VALUES('cmo4m9lm400spp5i2zl2o3rl9',1776533650348,1776533650348,'Module 5','Release bundle for XL Biochemistry Module 5.',5,'cmo4m9lly00sfp5i2u4alokmb');
INSERT INTO Module VALUES('cmo4m9lm500srp5i2j57qgdeg',1776533650350,1776533650350,'Module 6','Release bundle for XL Biochemistry Module 6.',6,'cmo4m9lly00sfp5i2u4alokmb');
INSERT INTO Module VALUES('cmo4m9lm600stp5i2fxhcn4xr',1776533650350,1776533650350,'Module 7','Release bundle for XL Biochemistry Module 7.',7,'cmo4m9lly00sfp5i2u4alokmb');
INSERT INTO Module VALUES('cmo4m9lm700svp5i23ekzr9gw',1776533650351,1776533650351,'Module 8','Release bundle for XL Biochemistry Module 8.',8,'cmo4m9lly00sfp5i2u4alokmb');
INSERT INTO Module VALUES('cmo4m9lm800sxp5i208on6vb5',1776533650352,1776533650352,'Module 9','Release bundle for XL Biochemistry Module 9.',9,'cmo4m9lly00sfp5i2u4alokmb');
INSERT INTO Module VALUES('cmo4m9lm800szp5i2r3bx7jau',1776533650353,1776533650353,'Module 10','Release bundle for XL Biochemistry Module 10.',10,'cmo4m9lly00sfp5i2u4alokmb');
INSERT INTO Module VALUES('cmo4m9lm900t1p5i2n55bl037',1776533650354,1776533650354,'Module 11','Release bundle for XL Biochemistry Module 11.',11,'cmo4m9lly00sfp5i2u4alokmb');
INSERT INTO Module VALUES('cmo4m9lmb00t3p5i2grpmyfst',1776533650355,1776533650355,'Module 12','Release bundle for XL Biochemistry Module 12.',12,'cmo4m9lly00sfp5i2u4alokmb');
INSERT INTO Module VALUES('cmo4m9lmc00t5p5i2x4kdnavz',1776533650357,1776533650357,'Module 13','Release bundle for XL Biochemistry Module 13.',13,'cmo4m9lly00sfp5i2u4alokmb');
INSERT INTO Module VALUES('cmo4m9lmd00t7p5i2lq0u6d81',1776533650358,1776533650358,'Module 14','Release bundle for XL Biochemistry Module 14.',14,'cmo4m9lly00sfp5i2u4alokmb');
INSERT INTO Module VALUES('cmo4m9lme00t9p5i2ptuqq170',1776533650358,1776533650358,'Module 15','Release bundle for XL Biochemistry Module 15.',15,'cmo4m9lly00sfp5i2u4alokmb');
INSERT INTO Module VALUES('cmo4m9lmf00tbp5i2u4dvrcj0',1776533650359,1776533650359,'Module 16','Release bundle for XL Biochemistry Module 16.',16,'cmo4m9lly00sfp5i2u4alokmb');
INSERT INTO Module VALUES('cmo4m9lmg00tdp5i2sh8b5jyc',1776533650360,1776533650360,'Module 17','Release bundle for XL Biochemistry Module 17.',17,'cmo4m9lly00sfp5i2u4alokmb');
INSERT INTO Module VALUES('cmo4m9lmh00tfp5i2rk1d7mbw',1776533650361,1776533650361,'Module 18','Release bundle for XL Biochemistry Module 18.',18,'cmo4m9lly00sfp5i2u4alokmb');
INSERT INTO Module VALUES('cmo4m9lmi00thp5i2xpnwwl71',1776533650362,1776533650362,'Module 19','Release bundle for XL Biochemistry Module 19.',19,'cmo4m9lly00sfp5i2u4alokmb');
INSERT INTO Module VALUES('cmo4m9lmj00tjp5i2c5r2xz21',1776533650364,1776533650364,'Module 20','Release bundle for XL Biochemistry Module 20.',20,'cmo4m9lly00sfp5i2u4alokmb');
INSERT INTO Module VALUES('cmo4m9lmk00tlp5i2evupki9x',1776533650364,1776533650364,'Module 21','Release bundle for XL Biochemistry Module 21.',21,'cmo4m9lly00sfp5i2u4alokmb');
INSERT INTO Module VALUES('cmo4m9lml00tnp5i2go9k2ber',1776533650365,1776533650365,'Module 22','Release bundle for XL Biochemistry Module 22.',22,'cmo4m9lly00sfp5i2u4alokmb');
INSERT INTO Module VALUES('cmo4m9lml00tpp5i2g41nfoex',1776533650366,1776533650366,'Module 23','Release bundle for XL Biochemistry Module 23.',23,'cmo4m9lly00sfp5i2u4alokmb');
INSERT INTO Module VALUES('cmo4m9lmm00trp5i2nr3zcq05',1776533650367,1776533650367,'Module 24','Release bundle for XL Biochemistry Module 24.',24,'cmo4m9lly00sfp5i2u4alokmb');
INSERT INTO Module VALUES('cmo4m9lmn00ttp5i2j9mjt9f1',1776533650367,1776533650367,'Module 25','Release bundle for XL Biochemistry Module 25.',25,'cmo4m9lly00sfp5i2u4alokmb');
INSERT INTO Module VALUES('cmo4m9lmn00tvp5i2387ocacn',1776533650368,1776533650368,'Module 26','Release bundle for XL Biochemistry Module 26.',26,'cmo4m9lly00sfp5i2u4alokmb');
INSERT INTO Module VALUES('cmo4m9lmo00txp5i2e4ks7y9i',1776533650369,1776533650369,'Module 27','Release bundle for XL Biochemistry Module 27.',27,'cmo4m9lly00sfp5i2u4alokmb');
INSERT INTO Module VALUES('cmo4m9lvs00yrp5i2g6ibmefs',1776533650696,1776533650696,'Module 1','Release bundle for XL Microbiology Module 1.',1,'cmo4m9lvr00ypp5i2937cd8i1');
INSERT INTO Module VALUES('cmo4m9lvv00ytp5i25n9rqry5',1776533650699,1776533650699,'Module 2','Release bundle for XL Microbiology Module 2.',2,'cmo4m9lvr00ypp5i2937cd8i1');
INSERT INTO Module VALUES('cmo4m9lw400yvp5i2re5lh9nu',1776533650708,1776533650708,'Module 3','Release bundle for XL Microbiology Module 3.',3,'cmo4m9lvr00ypp5i2937cd8i1');
INSERT INTO Module VALUES('cmo4m9lw500yxp5i21b74tsgs',1776533650710,1776533650710,'Module 4','Release bundle for XL Microbiology Module 4.',4,'cmo4m9lvr00ypp5i2937cd8i1');
INSERT INTO Module VALUES('cmo4m9lw600yzp5i2yjpn8qww',1776533650711,1776533650711,'Module 5','Release bundle for XL Microbiology Module 5.',5,'cmo4m9lvr00ypp5i2937cd8i1');
INSERT INTO Module VALUES('cmo4m9lw700z1p5i2475utv2s',1776533650712,1776533650712,'Module 6','Release bundle for XL Microbiology Module 6.',6,'cmo4m9lvr00ypp5i2937cd8i1');
INSERT INTO Module VALUES('cmo4m9lw800z3p5i264uobqoa',1776533650713,1776533650713,'Module 7','Release bundle for XL Microbiology Module 7.',7,'cmo4m9lvr00ypp5i2937cd8i1');
INSERT INTO Module VALUES('cmo4m9lw900z5p5i2qprjja7p',1776533650713,1776533650713,'Module 8','Release bundle for XL Microbiology Module 8.',8,'cmo4m9lvr00ypp5i2937cd8i1');
INSERT INTO Module VALUES('cmo4m9lwa00z7p5i28hq16f9l',1776533650714,1776533650714,'Module 9','Release bundle for XL Microbiology Module 9.',9,'cmo4m9lvr00ypp5i2937cd8i1');
INSERT INTO Module VALUES('cmo4m9lwa00z9p5i2x78jkirf',1776533650715,1776533650715,'Module 10','Release bundle for XL Microbiology Module 10.',10,'cmo4m9lvr00ypp5i2937cd8i1');
INSERT INTO Module VALUES('cmo4m9lwb00zbp5i201w3j2aj',1776533650716,1776533650716,'Module 11','Release bundle for XL Microbiology Module 11.',11,'cmo4m9lvr00ypp5i2937cd8i1');
INSERT INTO Module VALUES('cmo4m9lwc00zdp5i25cyyr9mh',1776533650716,1776533650716,'Module 12','Release bundle for XL Microbiology Module 12.',12,'cmo4m9lvr00ypp5i2937cd8i1');
INSERT INTO Module VALUES('cmo4m9lwd00zfp5i2t1am2qlr',1776533650717,1776533650717,'Module 13','Release bundle for XL Microbiology Module 13.',13,'cmo4m9lvr00ypp5i2937cd8i1');
INSERT INTO Module VALUES('cmo4m9lwe00zhp5i25xxijmfr',1776533650718,1776533650718,'Module 14','Release bundle for XL Microbiology Module 14.',14,'cmo4m9lvr00ypp5i2937cd8i1');
INSERT INTO Module VALUES('cmo4m9lwe00zjp5i2xu9tigze',1776533650719,1776533650719,'Module 15','Release bundle for XL Microbiology Module 15.',15,'cmo4m9lvr00ypp5i2937cd8i1');
INSERT INTO Module VALUES('cmo4m9lwf00zlp5i2ry515nyk',1776533650720,1776533650720,'Module 16','Release bundle for XL Microbiology Module 16.',16,'cmo4m9lvr00ypp5i2937cd8i1');
INSERT INTO Module VALUES('cmo4m9lwg00znp5i2meahrdwm',1776533650721,1776533650721,'Module 17','Release bundle for XL Microbiology Module 17.',17,'cmo4m9lvr00ypp5i2937cd8i1');
INSERT INTO Module VALUES('cmo4m9lwh00zpp5i20cdewl5h',1776533650722,1776533650722,'Module 18','Release bundle for XL Microbiology Module 18.',18,'cmo4m9lvr00ypp5i2937cd8i1');
INSERT INTO Module VALUES('cmo4m9lwi00zrp5i2ag225sl2',1776533650723,1776533650723,'Module 19','Release bundle for XL Microbiology Module 19.',19,'cmo4m9lvr00ypp5i2937cd8i1');
INSERT INTO Module VALUES('cmo4m9lwj00ztp5i2be5qxagh',1776533650723,1776533650723,'Module 20','Release bundle for XL Microbiology Module 20.',20,'cmo4m9lvr00ypp5i2937cd8i1');
INSERT INTO Module VALUES('cmo4m9lwk00zvp5i2wxcr9e1d',1776533650724,1776533650724,'Module 21','Release bundle for XL Microbiology Module 21.',21,'cmo4m9lvr00ypp5i2937cd8i1');
INSERT INTO Module VALUES('cmo4m9lwk00zxp5i2j1diytbh',1776533650725,1776533650725,'Module 22','Release bundle for XL Microbiology Module 22.',22,'cmo4m9lvr00ypp5i2937cd8i1');
INSERT INTO Module VALUES('cmo4m9lwl00zzp5i29kmfymdf',1776533650726,1776533650726,'Module 23','Release bundle for XL Microbiology Module 23.',23,'cmo4m9lvr00ypp5i2937cd8i1');
INSERT INTO Module VALUES('cmo4m9lwm0101p5i22lt0wyk1',1776533650726,1776533650726,'Module 24','Release bundle for XL Microbiology Module 24.',24,'cmo4m9lvr00ypp5i2937cd8i1');
INSERT INTO Module VALUES('cmo4m9lwn0103p5i2rxmkcmgt',1776533650727,1776533650727,'Module 25','Release bundle for XL Microbiology Module 25.',25,'cmo4m9lvr00ypp5i2937cd8i1');
INSERT INTO Module VALUES('cmo4m9lwn0105p5i2t3j985hn',1776533650728,1776533650728,'Module 26','Release bundle for XL Microbiology Module 26.',26,'cmo4m9lvr00ypp5i2937cd8i1');
INSERT INTO Module VALUES('cmo4m9lwo0107p5i252bvjlti',1776533650729,1776533650729,'Module 27','Release bundle for XL Microbiology Module 27.',27,'cmo4m9lvr00ypp5i2937cd8i1');
INSERT INTO Module VALUES('cmo4m9m1q0151p5i2qyn962pb',1776533650911,1776533650911,'Module 1','Release bundle for XL Food Technology Module 1.',1,'cmo4m9m1p014zp5i2b1mk5lp3');
INSERT INTO Module VALUES('cmo4m9m1r0153p5i2ytp77dxq',1776533650912,1776533650912,'Module 2','Release bundle for XL Food Technology Module 2.',2,'cmo4m9m1p014zp5i2b1mk5lp3');
INSERT INTO Module VALUES('cmo4m9m1t0155p5i27a7fu03b',1776533650913,1776533650913,'Module 3','Release bundle for XL Food Technology Module 3.',3,'cmo4m9m1p014zp5i2b1mk5lp3');
INSERT INTO Module VALUES('cmo4m9m1u0157p5i2ngc7p1rk',1776533650914,1776533650914,'Module 4','Release bundle for XL Food Technology Module 4.',4,'cmo4m9m1p014zp5i2b1mk5lp3');
INSERT INTO Module VALUES('cmo4m9m1v0159p5i2pbd5ylk1',1776533650915,1776533650915,'Module 5','Release bundle for XL Food Technology Module 5.',5,'cmo4m9m1p014zp5i2b1mk5lp3');
INSERT INTO Module VALUES('cmo4m9m1w015bp5i2vos624ya',1776533650916,1776533650916,'Module 6','Release bundle for XL Food Technology Module 6.',6,'cmo4m9m1p014zp5i2b1mk5lp3');
INSERT INTO Module VALUES('cmo4m9m1x015dp5i2wbpzarcz',1776533650917,1776533650917,'Module 7','Release bundle for XL Food Technology Module 7.',7,'cmo4m9m1p014zp5i2b1mk5lp3');
INSERT INTO Module VALUES('cmo4m9m1y015fp5i2q36r3t76',1776533650918,1776533650918,'Module 8','Release bundle for XL Food Technology Module 8.',8,'cmo4m9m1p014zp5i2b1mk5lp3');
INSERT INTO Module VALUES('cmo4m9m1z015hp5i2ztxchh6c',1776533650919,1776533650919,'Module 9','Release bundle for XL Food Technology Module 9.',9,'cmo4m9m1p014zp5i2b1mk5lp3');
INSERT INTO Module VALUES('cmo4m9m20015jp5i2g3i7gz0b',1776533650920,1776533650920,'Module 10','Release bundle for XL Food Technology Module 10.',10,'cmo4m9m1p014zp5i2b1mk5lp3');
INSERT INTO Module VALUES('cmo4m9m21015lp5i2pfvx1on5',1776533650921,1776533650921,'Module 11','Release bundle for XL Food Technology Module 11.',11,'cmo4m9m1p014zp5i2b1mk5lp3');
INSERT INTO Module VALUES('cmo4m9m22015np5i2wajp4kjt',1776533650923,1776533650923,'Module 12','Release bundle for XL Food Technology Module 12.',12,'cmo4m9m1p014zp5i2b1mk5lp3');
INSERT INTO Module VALUES('cmo4m9m23015pp5i2gnl7dg2b',1776533650923,1776533650923,'Module 13','Release bundle for XL Food Technology Module 13.',13,'cmo4m9m1p014zp5i2b1mk5lp3');
INSERT INTO Module VALUES('cmo4m9m24015rp5i2634j2lcs',1776533650924,1776533650924,'Module 14','Release bundle for XL Food Technology Module 14.',14,'cmo4m9m1p014zp5i2b1mk5lp3');
INSERT INTO Module VALUES('cmo4m9m25015tp5i2s4739ci2',1776533650925,1776533650925,'Module 15','Release bundle for XL Food Technology Module 15.',15,'cmo4m9m1p014zp5i2b1mk5lp3');
INSERT INTO Module VALUES('cmo4m9m26015vp5i2eqcfbe3t',1776533650926,1776533650926,'Module 16','Release bundle for XL Food Technology Module 16.',16,'cmo4m9m1p014zp5i2b1mk5lp3');
INSERT INTO Module VALUES('cmo4m9m27015xp5i23c9t1q32',1776533650927,1776533650927,'Module 17','Release bundle for XL Food Technology Module 17.',17,'cmo4m9m1p014zp5i2b1mk5lp3');
INSERT INTO Module VALUES('cmo4m9m27015zp5i2e17b4b0r',1776533650928,1776533650928,'Module 18','Release bundle for XL Food Technology Module 18.',18,'cmo4m9m1p014zp5i2b1mk5lp3');
INSERT INTO Module VALUES('cmo4m9m280161p5i2vhsc5zf0',1776533650929,1776533650929,'Module 19','Release bundle for XL Food Technology Module 19.',19,'cmo4m9m1p014zp5i2b1mk5lp3');
INSERT INTO Module VALUES('cmo4m9m290163p5i21cqdcygw',1776533650930,1776533650930,'Module 20','Release bundle for XL Food Technology Module 20.',20,'cmo4m9m1p014zp5i2b1mk5lp3');
INSERT INTO Module VALUES('cmo4m9m2a0165p5i2xvba44s4',1776533650931,1776533650931,'Module 21','Release bundle for XL Food Technology Module 21.',21,'cmo4m9m1p014zp5i2b1mk5lp3');
INSERT INTO Module VALUES('cmo4m9m2b0167p5i2zu922t2x',1776533650932,1776533650932,'Module 22','Release bundle for XL Food Technology Module 22.',22,'cmo4m9m1p014zp5i2b1mk5lp3');
INSERT INTO Module VALUES('cmo4m9m2c0169p5i2sv1v8eag',1776533650932,1776533650932,'Module 23','Release bundle for XL Food Technology Module 23.',23,'cmo4m9m1p014zp5i2b1mk5lp3');
INSERT INTO Module VALUES('cmo4m9m2d016bp5i274uilbjn',1776533650933,1776533650933,'Module 24','Release bundle for XL Food Technology Module 24.',24,'cmo4m9m1p014zp5i2b1mk5lp3');
INSERT INTO Module VALUES('cmo4m9m2d016dp5i2nd3558qj',1776533650934,1776533650934,'Module 25','Release bundle for XL Food Technology Module 25.',25,'cmo4m9m1p014zp5i2b1mk5lp3');
INSERT INTO Module VALUES('cmo4m9m2e016fp5i2qqtzxwyg',1776533650935,1776533650935,'Module 26','Release bundle for XL Food Technology Module 26.',26,'cmo4m9m1p014zp5i2b1mk5lp3');
INSERT INTO Module VALUES('cmo4m9m2f016hp5i23s4a4oho',1776533650935,1776533650935,'Module 27','Release bundle for XL Food Technology Module 27.',27,'cmo4m9m1p014zp5i2b1mk5lp3');
INSERT INTO Module VALUES('cmo4m9m6p01bbp5i22waex71a',1776533651089,1776533651089,'Module 1','Release bundle for XE Food Technology Module 1.',1,'cmo4m9m6n01b9p5i2qj5s0u10');
INSERT INTO Module VALUES('cmo4m9m6q01bdp5i2iyk4i9az',1776533651090,1776533651090,'Module 2','Release bundle for XE Food Technology Module 2.',2,'cmo4m9m6n01b9p5i2qj5s0u10');
INSERT INTO Module VALUES('cmo4m9m6r01bfp5i2mf0kkw3q',1776533651091,1776533651091,'Module 3','Release bundle for XE Food Technology Module 3.',3,'cmo4m9m6n01b9p5i2qj5s0u10');
INSERT INTO Module VALUES('cmo4m9m6s01bhp5i2je8hgcnp',1776533651093,1776533651093,'Module 4','Release bundle for XE Food Technology Module 4.',4,'cmo4m9m6n01b9p5i2qj5s0u10');
INSERT INTO Module VALUES('cmo4m9m6t01bjp5i2l6mj5g5p',1776533651094,1776533651094,'Module 5','Release bundle for XE Food Technology Module 5.',5,'cmo4m9m6n01b9p5i2qj5s0u10');
INSERT INTO Module VALUES('cmo4m9m6u01blp5i2brqkczj3',1776533651095,1776533651095,'Module 6','Release bundle for XE Food Technology Module 6.',6,'cmo4m9m6n01b9p5i2qj5s0u10');
INSERT INTO Module VALUES('cmo4m9m6v01bnp5i2pi8yc7dw',1776533651096,1776533651096,'Module 7','Release bundle for XE Food Technology Module 7.',7,'cmo4m9m6n01b9p5i2qj5s0u10');
INSERT INTO Module VALUES('cmo4m9m6w01bpp5i2pjrkc6ap',1776533651097,1776533651097,'Module 8','Release bundle for XE Food Technology Module 8.',8,'cmo4m9m6n01b9p5i2qj5s0u10');
INSERT INTO Module VALUES('cmo4m9m6x01brp5i2ma7be50t',1776533651097,1776533651097,'Module 9','Release bundle for XE Food Technology Module 9.',9,'cmo4m9m6n01b9p5i2qj5s0u10');
INSERT INTO Module VALUES('cmo4m9m6y01btp5i2u5aevyx0',1776533651098,1776533651098,'Module 10','Release bundle for XE Food Technology Module 10.',10,'cmo4m9m6n01b9p5i2qj5s0u10');
INSERT INTO Module VALUES('cmo4m9m6z01bvp5i2yq1qlvlb',1776533651099,1776533651099,'Module 11','Release bundle for XE Food Technology Module 11.',11,'cmo4m9m6n01b9p5i2qj5s0u10');
INSERT INTO Module VALUES('cmo4m9m7001bxp5i2i5o50ukq',1776533651100,1776533651100,'Module 12','Release bundle for XE Food Technology Module 12.',12,'cmo4m9m6n01b9p5i2qj5s0u10');
INSERT INTO Module VALUES('cmo4m9m7101bzp5i28vznbks7',1776533651101,1776533651101,'Module 13','Release bundle for XE Food Technology Module 13.',13,'cmo4m9m6n01b9p5i2qj5s0u10');
INSERT INTO Module VALUES('cmo4m9m7101c1p5i2fqb9fsck',1776533651102,1776533651102,'Module 14','Release bundle for XE Food Technology Module 14.',14,'cmo4m9m6n01b9p5i2qj5s0u10');
INSERT INTO Module VALUES('cmo4m9m7201c3p5i2w3efnn94',1776533651103,1776533651103,'Module 15','Release bundle for XE Food Technology Module 15.',15,'cmo4m9m6n01b9p5i2qj5s0u10');
INSERT INTO Module VALUES('cmo4m9m7301c5p5i2dppper18',1776533651103,1776533651103,'Module 16','Release bundle for XE Food Technology Module 16.',16,'cmo4m9m6n01b9p5i2qj5s0u10');
INSERT INTO Module VALUES('cmo4m9m7401c7p5i2v2ge8ss3',1776533651104,1776533651104,'Module 17','Release bundle for XE Food Technology Module 17.',17,'cmo4m9m6n01b9p5i2qj5s0u10');
INSERT INTO Module VALUES('cmo4m9m7501c9p5i2aurll4rt',1776533651106,1776533651106,'Module 18','Release bundle for XE Food Technology Module 18.',18,'cmo4m9m6n01b9p5i2qj5s0u10');
INSERT INTO Module VALUES('cmo4m9m7601cbp5i23uca552g',1776533651106,1776533651106,'Module 19','Release bundle for XE Food Technology Module 19.',19,'cmo4m9m6n01b9p5i2qj5s0u10');
INSERT INTO Module VALUES('cmo4m9m7701cdp5i2r7lt3v11',1776533651107,1776533651107,'Module 20','Release bundle for XE Food Technology Module 20.',20,'cmo4m9m6n01b9p5i2qj5s0u10');
INSERT INTO Module VALUES('cmo4m9m7701cfp5i2ys4ddmhk',1776533651108,1776533651108,'Module 21','Release bundle for XE Food Technology Module 21.',21,'cmo4m9m6n01b9p5i2qj5s0u10');
INSERT INTO Module VALUES('cmo4m9m7801chp5i267u89ae4',1776533651109,1776533651109,'Module 22','Release bundle for XE Food Technology Module 22.',22,'cmo4m9m6n01b9p5i2qj5s0u10');
INSERT INTO Module VALUES('cmo4m9m7901cjp5i2iquhr1qi',1776533651109,1776533651109,'Module 23','Release bundle for XE Food Technology Module 23.',23,'cmo4m9m6n01b9p5i2qj5s0u10');
INSERT INTO Module VALUES('cmo4m9m7a01clp5i2al2gti2t',1776533651110,1776533651110,'Module 24','Release bundle for XE Food Technology Module 24.',24,'cmo4m9m6n01b9p5i2qj5s0u10');
INSERT INTO Module VALUES('cmo4m9m7a01cnp5i2bq6qayjg',1776533651111,1776533651111,'Module 25','Release bundle for XE Food Technology Module 25.',25,'cmo4m9m6n01b9p5i2qj5s0u10');
INSERT INTO Module VALUES('cmo4m9m7b01cpp5i2jtvbiqep',1776533651111,1776533651111,'Module 26','Release bundle for XE Food Technology Module 26.',26,'cmo4m9m6n01b9p5i2qj5s0u10');
INSERT INTO Module VALUES('cmo4m9m7c01crp5i27ga9dmw5',1776533651112,1776533651112,'Module 27','Release bundle for XE Food Technology Module 27.',27,'cmo4m9m6n01b9p5i2qj5s0u10');

INSERT INTO YearlyProduct VALUES('cmo4m9lhn00npp5i2mh9u9riu',1776533650188,1776533650188,2026,'XE Thermodynamics | GATE 2026',1999900,1499900,1801958399999,1,'cmo4m9lh000m5p5i2y81dh8vk');
INSERT INTO YearlyProduct VALUES('cmo4m9lmp00tzp5i2bfywi2xm',1776533650370,1776533650370,2026,'XL Biochemistry | GATE 2026',1999900,1499900,1801958399999,1,'cmo4m9lly00sfp5i2u4alokmb');
INSERT INTO YearlyProduct VALUES('cmo4m9lwp0109p5i2chso7y6d',1776533650730,1776533650730,2026,'XL Microbiology | GATE 2026',1999900,1499900,1801958399999,1,'cmo4m9lvr00ypp5i2937cd8i1');
INSERT INTO YearlyProduct VALUES('cmo4m9m2f016jp5i2290yaxhd',1776533650936,1776533650936,2026,'XL Food Technology | GATE 2026',1699900,1275000,1801958399999,1,'cmo4m9m1p014zp5i2b1mk5lp3');
INSERT INTO YearlyProduct VALUES('cmo4m9m7d01ctp5i2zqk9juel',1776533651113,1776533651113,2026,'XE Food Technology | GATE 2026',1699900,1275000,1801958399999,1,'cmo4m9m6n01b9p5i2qj5s0u10');

INSERT INTO Batch VALUES('cmo4m9lhp00nrp5i2khatqhl1',1776533650189,1776533650189,'26B1',1781395200000,1801958399999,1,'cmo4m9lhn00npp5i2mh9u9riu');
INSERT INTO Batch VALUES('cmo4m9liw00pbp5i2w8a3x23k',1776533650233,1776533650233,'26B2',1785628800000,1801958399999,1,'cmo4m9lhn00npp5i2mh9u9riu');
INSERT INTO Batch VALUES('cmo4m9lks00qvp5i2ugf0b5ai',1776533650301,1776533650301,'26B3',1791072000000,1801958399999,1,'cmo4m9lhn00npp5i2mh9u9riu');
INSERT INTO Batch VALUES('cmo4m9lmq00u1p5i2cei02gym',1776533650370,1776533650370,'26B1',1781395200000,1801958399999,1,'cmo4m9lmp00tzp5i2bfywi2xm');
INSERT INTO Batch VALUES('cmo4m9lpd00vlp5i2e84snwn7',1776533650466,1776533650466,'26B2',1785628800000,1801958399999,1,'cmo4m9lmp00tzp5i2bfywi2xm');
INSERT INTO Batch VALUES('cmo4m9lsy00x5p5i26lj0lslm',1776533650594,1776533650594,'26B3',1791072000000,1801958399999,1,'cmo4m9lmp00tzp5i2bfywi2xm');
INSERT INTO Batch VALUES('cmo4m9lwq010bp5i2a41ccczg',1776533650730,1776533650730,'26B1',1781395200000,1801958399999,1,'cmo4m9lwp0109p5i2chso7y6d');
INSERT INTO Batch VALUES('cmo4m9lyk011vp5i2uvfp7zzi',1776533650797,1776533650797,'26B2',1785628800000,1801958399999,1,'cmo4m9lwp0109p5i2chso7y6d');
INSERT INTO Batch VALUES('cmo4m9lzs013fp5i2rfhmws5j',1776533650841,1776533650841,'26B3',1791072000000,1801958399999,1,'cmo4m9lwp0109p5i2chso7y6d');
INSERT INTO Batch VALUES('cmo4m9m2g016lp5i2prc2f3d5',1776533650937,1776533650937,'26B1',1781395200000,1801958399999,1,'cmo4m9m2f016jp5i2290yaxhd');
INSERT INTO Batch VALUES('cmo4m9m480185p5i2xz8gxkjm',1776533651001,1776533651001,'26B2',1785628800000,1801958399999,1,'cmo4m9m2f016jp5i2290yaxhd');
INSERT INTO Batch VALUES('cmo4m9m5g019pp5i2je6r8oyv',1776533651044,1776533651044,'26B3',1791072000000,1801958399999,1,'cmo4m9m2f016jp5i2290yaxhd');
INSERT INTO Batch VALUES('cmo4m9m7d01cvp5i24gm3c53t',1776533651114,1776533651114,'26B1',1781395200000,1801958399999,1,'cmo4m9m7d01ctp5i2zqk9juel');
INSERT INTO Batch VALUES('cmo4m9m8i01efp5i2qq280vxi',1776533651155,1776533651155,'26B2',1785628800000,1801958399999,1,'cmo4m9m7d01ctp5i2zqk9juel');
INSERT INTO Batch VALUES('cmo4m9mb601fzp5i2ra41ls3v',1776533651251,1776533651251,'26B3',1791072000000,1801958399999,1,'cmo4m9m7d01ctp5i2zqk9juel');

INSERT INTO BatchModule VALUES('cmo4m9lhq00ntp5i27py1h0yu',1776533650190,1776533650190,1781395200000,'cmo4m9lhp00nrp5i2khatqhl1','cmo4m9lh100m7p5i2lcro404q');
INSERT INTO BatchModule VALUES('cmo4m9lhv00o9p5i2t7fyw9c7',1776533650196,1776533650196,1791676800000,'cmo4m9lhp00nrp5i2khatqhl1','cmo4m9lhf00n5p5i2std5mnw0');
INSERT INTO BatchModule VALUES('cmo4m9lhw00obp5i2sn8j4iz3',1776533650196,1776533650196,1792886400000,'cmo4m9lhp00nrp5i2khatqhl1','cmo4m9lhh00n9p5i2enu5iraq');
INSERT INTO BatchModule VALUES('cmo4m9lhw00odp5i2w4amhum4',1776533650197,1776533650197,1792281600000,'cmo4m9lhp00nrp5i2khatqhl1','cmo4m9lhg00n7p5i2t7gvm8xh');
INSERT INTO BatchModule VALUES('cmo4m9lhx00ofp5i2znjd9y0o',1776533650197,1776533650197,1793491200000,'cmo4m9lhp00nrp5i2khatqhl1','cmo4m9lhh00nbp5i201q6emd1');
INSERT INTO BatchModule VALUES('cmo4m9lhx00ohp5i2ij1kpb1m',1776533650197,1776533650197,1794096000000,'cmo4m9lhp00nrp5i2khatqhl1','cmo4m9lhi00ndp5i2xkbvptjh');
INSERT INTO BatchModule VALUES('cmo4m9lhy00ojp5i2g5tv8zsd',1776533650198,1776533650198,1794700800000,'cmo4m9lhp00nrp5i2khatqhl1','cmo4m9lhj00nfp5i2j2on3bpt');
INSERT INTO BatchModule VALUES('cmo4m9lhy00olp5i24fk7ptov',1776533650199,1776533650199,1795305600000,'cmo4m9lhp00nrp5i2khatqhl1','cmo4m9lhj00nhp5i2tjp2d53s');
INSERT INTO BatchModule VALUES('cmo4m9lhz00onp5i2sc9zys1h',1776533650199,1776533650199,1795910400000,'cmo4m9lhp00nrp5i2khatqhl1','cmo4m9lhk00njp5i23btg5pyv');
INSERT INTO BatchModule VALUES('cmo4m9li100opp5i2ojxkg0wu',1776533650201,1776533650201,1796515200000,'cmo4m9lhp00nrp5i2khatqhl1','cmo4m9lhl00nlp5i2ecmx91ho');
INSERT INTO BatchModule VALUES('cmo4m9li500orp5i2iwx4a5th',1776533650205,1776533650205,1797120000000,'cmo4m9lhp00nrp5i2khatqhl1','cmo4m9lhm00nnp5i2ihjd5jrz');
INSERT INTO BatchModule VALUES('cmo4m9li500otp5i21540459k',1776533650206,1776533650206,1788048000000,'cmo4m9lhp00nrp5i2khatqhl1','cmo4m9lha00mtp5i2fhqye70g');
INSERT INTO BatchModule VALUES('cmo4m9lhq00nyp5i2q0vkakkd',1776533650191,1776533650191,1787443200000,'cmo4m9lhp00nrp5i2khatqhl1','cmo4m9lha00mrp5i2gha7fr1l');
INSERT INTO BatchModule VALUES('cmo4m9lhr00o5p5i2xxrj6xh8',1776533650191,1776533650191,1789257600000,'cmo4m9lhp00nrp5i2khatqhl1','cmo4m9lhc00mxp5i24g9y9on8');
INSERT INTO BatchModule VALUES('cmo4m9li700ozp5i2q04r2var',1776533650207,1776533650207,1789862400000,'cmo4m9lhp00nrp5i2khatqhl1','cmo4m9lhd00mzp5i2uwb91wrn');
INSERT INTO BatchModule VALUES('cmo4m9li600ovp5i26jouf4kb',1776533650206,1776533650206,1783814400000,'cmo4m9lhp00nrp5i2khatqhl1','cmo4m9lh500mfp5i2v8w44b2g');
INSERT INTO BatchModule VALUES('cmo4m9li700p3p5i2jw4h9kd3',1776533650208,1776533650208,1782000000000,'cmo4m9lhp00nrp5i2khatqhl1','cmo4m9lh200m9p5i2w4p36o60');
INSERT INTO BatchModule VALUES('cmo4m9li800p5p5i2ckw5brcr',1776533650208,1776533650208,1785024000000,'cmo4m9lhp00nrp5i2khatqhl1','cmo4m9lh600mjp5i25hvhjroz');
INSERT INTO BatchModule VALUES('cmo4m9li700p1p5i2ssn3d0qp',1776533650208,1776533650208,1786838400000,'cmo4m9lhp00nrp5i2khatqhl1','cmo4m9lh900mpp5i2tgi42hog');
INSERT INTO BatchModule VALUES('cmo4m9li900p9p5i2p1vhmqwe',1776533650209,1776533650209,1785628800000,'cmo4m9lhp00nrp5i2khatqhl1','cmo4m9lh700mlp5i2d4lnmai1');
INSERT INTO BatchModule VALUES('cmo4m9li800p7p5i2lchgkbc3',1776533650209,1776533650209,1791072000000,'cmo4m9lhp00nrp5i2khatqhl1','cmo4m9lhe00n3p5i2fkdxwue6');
INSERT INTO BatchModule VALUES('cmo4m9li600oxp5i2jjf0imig',1776533650207,1776533650207,1788652800000,'cmo4m9lhp00nrp5i2khatqhl1','cmo4m9lhb00mvp5i2rqth7xfa');
INSERT INTO BatchModule VALUES('cmo4m9lhr00o3p5i2mhc6aauo',1776533650191,1776533650191,1783209600000,'cmo4m9lhp00nrp5i2khatqhl1','cmo4m9lh400mdp5i2yuh69ai2');
INSERT INTO BatchModule VALUES('cmo4m9lhq00nzp5i2rdkg8e75',1776533650191,1776533650191,1784419200000,'cmo4m9lhp00nrp5i2khatqhl1','cmo4m9lh500mhp5i292nv8qhq');
INSERT INTO BatchModule VALUES('cmo4m9lhq00nvp5i2jalcjkjm',1776533650190,1776533650190,1782604800000,'cmo4m9lhp00nrp5i2khatqhl1','cmo4m9lh300mbp5i29bswv0q2');
INSERT INTO BatchModule VALUES('cmo4m9lhr00o7p5i27bcp1a5y',1776533650191,1776533650191,1786233600000,'cmo4m9lhp00nrp5i2khatqhl1','cmo4m9lh800mnp5i2ji7ahd4y');
INSERT INTO BatchModule VALUES('cmo4m9lhq00o1p5i2lpl94sk2',1776533650191,1776533650191,1790467200000,'cmo4m9lhp00nrp5i2khatqhl1','cmo4m9lhe00n1p5i2t7lwubcf');
INSERT INTO BatchModule VALUES('cmo4m9liy00pdp5i2vnkkmhba',1776533650234,1776533650234,1785628800000,'cmo4m9liw00pbp5i2w8a3x23k','cmo4m9lh100m7p5i2lcro404q');
INSERT INTO BatchModule VALUES('cmo4m9liz00ptp5i2mr8jjxir',1776533650235,1776533650235,1794096000000,'cmo4m9liw00pbp5i2w8a3x23k','cmo4m9lhd00mzp5i2uwb91wrn');
INSERT INTO BatchModule VALUES('cmo4m9liz00pvp5i2teq9sp25',1776533650235,1776533650235,1794700800000,'cmo4m9liw00pbp5i2w8a3x23k','cmo4m9lhe00n1p5i2t7lwubcf');
INSERT INTO BatchModule VALUES('cmo4m9liz00pxp5i2ijmdkaoy',1776533650236,1776533650236,1795305600000,'cmo4m9liw00pbp5i2w8a3x23k','cmo4m9lhe00n3p5i2fkdxwue6');
INSERT INTO BatchModule VALUES('cmo4m9lj000pzp5i2gzvvaelv',1776533650236,1776533650236,1795910400000,'cmo4m9liw00pbp5i2w8a3x23k','cmo4m9lhf00n5p5i2std5mnw0');
INSERT INTO BatchModule VALUES('cmo4m9lj000q1p5i21e415l8b',1776533650237,1776533650237,1796515200000,'cmo4m9liw00pbp5i2w8a3x23k','cmo4m9lhg00n7p5i2t7gvm8xh');
INSERT INTO BatchModule VALUES('cmo4m9lj100q3p5i2lwopbfs4',1776533650237,1776533650237,1797120000000,'cmo4m9liw00pbp5i2w8a3x23k','cmo4m9lhh00n9p5i2enu5iraq');
INSERT INTO BatchModule VALUES('cmo4m9liy00pmp5i2g2q265kv',1776533650235,1776533650235,1789862400000,'cmo4m9liw00pbp5i2w8a3x23k','cmo4m9lh700mlp5i2d4lnmai1');
INSERT INTO BatchModule VALUES('cmo4m9lj200q7p5i2zlg4ezfx',1776533650238,1776533650238,1790467200000,'cmo4m9liw00pbp5i2w8a3x23k','cmo4m9lh800mnp5i2ji7ahd4y');
INSERT INTO BatchModule VALUES('cmo4m9lj100q5p5i27skgi76p',1776533650238,1776533650238,1797724800000,'cmo4m9liw00pbp5i2w8a3x23k','cmo4m9lhh00nbp5i201q6emd1');
INSERT INTO BatchModule VALUES('cmo4m9lj300qbp5i23ip19au0',1776533650240,1776533650240,1798329600000,'cmo4m9liw00pbp5i2w8a3x23k','cmo4m9lhi00ndp5i2xkbvptjh');
INSERT INTO BatchModule VALUES('cmo4m9lj400qdp5i23iy5euzg',1776533650240,1776533650240,1798934400000,'cmo4m9liw00pbp5i2w8a3x23k','cmo4m9lhj00nfp5i2j2on3bpt');
INSERT INTO BatchModule VALUES('cmo4m9lj400qfp5i2sd7b23ui',1776533650241,1776533650241,1799539200000,'cmo4m9liw00pbp5i2w8a3x23k','cmo4m9lhj00nhp5i2tjp2d53s');
INSERT INTO BatchModule VALUES('cmo4m9lj500qhp5i2u8pzotm0',1776533650242,1776533650242,1800144000000,'cmo4m9liw00pbp5i2w8a3x23k','cmo4m9lhk00njp5i23btg5pyv');
INSERT INTO BatchModule VALUES('cmo4m9lj600qjp5i2o1pkztk1',1776533650242,1776533650242,1800748800000,'cmo4m9liw00pbp5i2w8a3x23k','cmo4m9lhl00nlp5i2ecmx91ho');
INSERT INTO BatchModule VALUES('cmo4m9lj600qlp5i2z1g24yto',1776533650243,1776533650243,1801353600000,'cmo4m9liw00pbp5i2w8a3x23k','cmo4m9lhm00nnp5i2ihjd5jrz');
INSERT INTO BatchModule VALUES('cmo4m9lj700qnp5i2c3u81qak',1776533650243,1776533650243,1792886400000,'cmo4m9liw00pbp5i2w8a3x23k','cmo4m9lhb00mvp5i2rqth7xfa');
INSERT INTO BatchModule VALUES('cmo4m9liy00pgp5i23k5vfgvt',1776533650234,1776533650234,1786233600000,'cmo4m9liw00pbp5i2w8a3x23k','cmo4m9lh200m9p5i2w4p36o60');
INSERT INTO BatchModule VALUES('cmo4m9lj700qrp5i20ptqycat',1776533650244,1776533650244,1788652800000,'cmo4m9liw00pbp5i2w8a3x23k','cmo4m9lh500mhp5i292nv8qhq');
INSERT INTO BatchModule VALUES('cmo4m9lj800qtp5i22lprjnqd',1776533650244,1776533650244,1789257600000,'cmo4m9liw00pbp5i2w8a3x23k','cmo4m9lh600mjp5i25hvhjroz');
INSERT INTO BatchModule VALUES('cmo4m9lj700qpp5i2mc70z238',1776533650244,1776533650244,1787443200000,'cmo4m9liw00pbp5i2w8a3x23k','cmo4m9lh400mdp5i2yuh69ai2');
INSERT INTO BatchModule VALUES('cmo4m9lj300q9p5i2kfespsz5',1776533650239,1776533650239,1791072000000,'cmo4m9liw00pbp5i2w8a3x23k','cmo4m9lh900mpp5i2tgi42hog');
INSERT INTO BatchModule VALUES('cmo4m9liy00php5i2g5hauc04',1776533650234,1776533650234,1786838400000,'cmo4m9liw00pbp5i2w8a3x23k','cmo4m9lh300mbp5i29bswv0q2');
INSERT INTO BatchModule VALUES('cmo4m9liy00ppp5i2bykae008',1776533650235,1776533650235,1792281600000,'cmo4m9liw00pbp5i2w8a3x23k','cmo4m9lha00mtp5i2fhqye70g');
INSERT INTO BatchModule VALUES('cmo4m9liy00pnp5i2mg8eemlo',1776533650235,1776533650235,1791676800000,'cmo4m9liw00pbp5i2w8a3x23k','cmo4m9lha00mrp5i2gha7fr1l');
INSERT INTO BatchModule VALUES('cmo4m9liy00prp5i2ylfnj0af',1776533650235,1776533650235,1793491200000,'cmo4m9liw00pbp5i2w8a3x23k','cmo4m9lhc00mxp5i24g9y9on8');
INSERT INTO BatchModule VALUES('cmo4m9liy00pjp5i2wfmf2h7k',1776533650234,1776533650234,1788048000000,'cmo4m9liw00pbp5i2w8a3x23k','cmo4m9lh500mfp5i2v8w44b2g');
INSERT INTO BatchModule VALUES('cmo4m9lku00qzp5i23zz10eoz',1776533650303,1776533650303,1791072000000,'cmo4m9lks00qvp5i2ugf0b5ai','cmo4m9lh100m7p5i2lcro404q');
INSERT INTO BatchModule VALUES('cmo4m9lkw00rdp5i2tur81y6x',1776533650305,1776533650305,1798934400000,'cmo4m9lks00qvp5i2ugf0b5ai','cmo4m9lhc00mxp5i24g9y9on8');
INSERT INTO BatchModule VALUES('cmo4m9lkx00rfp5i2i639f167',1776533650306,1776533650306,1799539200000,'cmo4m9lks00qvp5i2ugf0b5ai','cmo4m9lhd00mzp5i2uwb91wrn');
INSERT INTO BatchModule VALUES('cmo4m9lku00rbp5i2dagc3rev',1776533650303,1776533650303,1797724800000,'cmo4m9lks00qvp5i2ugf0b5ai','cmo4m9lha00mtp5i2fhqye70g');
INSERT INTO BatchModule VALUES('cmo4m9ll000rjp5i2evnf21of',1776533650308,1776533650308,1798329600000,'cmo4m9lks00qvp5i2ugf0b5ai','cmo4m9lhb00mvp5i2rqth7xfa');
INSERT INTO BatchModule VALUES('cmo4m9ll000rlp5i2tg1ebl22',1776533650309,1776533650309,1801353600000,'cmo4m9lks00qvp5i2ugf0b5ai','cmo4m9lhf00n5p5i2std5mnw0');
INSERT INTO BatchModule VALUES('cmo4m9ll100rnp5i21hz1192e',1776533650309,1776533650309,1801958400000,'cmo4m9lks00qvp5i2ugf0b5ai','cmo4m9lhg00n7p5i2t7gvm8xh');
INSERT INTO BatchModule VALUES('cmo4m9lky00rhp5i2m6jws8ry',1776533650306,1776533650306,1800748800000,'cmo4m9lks00qvp5i2ugf0b5ai','cmo4m9lhe00n3p5i2fkdxwue6');
INSERT INTO BatchModule VALUES('cmo4m9ll200rrp5i2rhawtov6',1776533650310,1776533650310,1800144000000,'cmo4m9lks00qvp5i2ugf0b5ai','cmo4m9lhe00n1p5i2t7lwubcf');
INSERT INTO BatchModule VALUES('cmo4m9ll300rtp5i2031r716x',1776533650311,1776533650311,1803168000000,'cmo4m9lks00qvp5i2ugf0b5ai','cmo4m9lhh00nbp5i201q6emd1');
INSERT INTO BatchModule VALUES('cmo4m9ll300rvp5i2lcdgrltv',1776533650312,1776533650312,1803772800000,'cmo4m9lks00qvp5i2ugf0b5ai','cmo4m9lhi00ndp5i2xkbvptjh');
INSERT INTO BatchModule VALUES('cmo4m9lku00r0p5i2g59efom8',1776533650303,1776533650303,1791676800000,'cmo4m9lks00qvp5i2ugf0b5ai','cmo4m9lh200m9p5i2w4p36o60');
INSERT INTO BatchModule VALUES('cmo4m9ll600rzp5i2y4vrhhcq',1776533650315,1776533650315,1804982400000,'cmo4m9lks00qvp5i2ugf0b5ai','cmo4m9lhj00nhp5i2tjp2d53s');
INSERT INTO BatchModule VALUES('cmo4m9ll700s1p5i2ddhl2z9t',1776533650316,1776533650316,1805587200000,'cmo4m9lks00qvp5i2ugf0b5ai','cmo4m9lhk00njp5i23btg5pyv');
INSERT INTO BatchModule VALUES('cmo4m9ll800s3p5i2crlohfx4',1776533650316,1776533650316,1806192000000,'cmo4m9lks00qvp5i2ugf0b5ai','cmo4m9lhl00nlp5i2ecmx91ho');
INSERT INTO BatchModule VALUES('cmo4m9ll800s5p5i2fdin3m4d',1776533650317,1776533650317,1806796800000,'cmo4m9lks00qvp5i2ugf0b5ai','cmo4m9lhm00nnp5i2ihjd5jrz');
INSERT INTO BatchModule VALUES('cmo4m9ll900s7p5i2us9x9iaa',1776533650317,1776533650317,1795305600000,'cmo4m9lks00qvp5i2ugf0b5ai','cmo4m9lh700mlp5i2d4lnmai1');
INSERT INTO BatchModule VALUES('cmo4m9lla00s9p5i2imodvlia',1776533650318,1776533650318,1794096000000,'cmo4m9lks00qvp5i2ugf0b5ai','cmo4m9lh500mhp5i292nv8qhq');
INSERT INTO BatchModule VALUES('cmo4m9lla00sbp5i2dawj38gd',1776533650319,1776533650319,1796515200000,'cmo4m9lks00qvp5i2ugf0b5ai','cmo4m9lh900mpp5i2tgi42hog');
INSERT INTO BatchModule VALUES('cmo4m9ll100rpp5i2oozszrdz',1776533650310,1776533650310,1802563200000,'cmo4m9lks00qvp5i2ugf0b5ai','cmo4m9lhh00n9p5i2enu5iraq');
INSERT INTO BatchModule VALUES('cmo4m9llb00sdp5i2ha8exmln',1776533650319,1776533650319,1797120000000,'cmo4m9lks00qvp5i2ugf0b5ai','cmo4m9lha00mrp5i2gha7fr1l');
INSERT INTO BatchModule VALUES('cmo4m9ll400rxp5i2wwlgfgh3',1776533650313,1776533650313,1804377600000,'cmo4m9lks00qvp5i2ugf0b5ai','cmo4m9lhj00nfp5i2j2on3bpt');
INSERT INTO BatchModule VALUES('cmo4m9lku00r6p5i20w9xdw4g',1776533650303,1776533650303,1795910400000,'cmo4m9lks00qvp5i2ugf0b5ai','cmo4m9lh800mnp5i2ji7ahd4y');
INSERT INTO BatchModule VALUES('cmo4m9lku00r1p5i2kotxrhey',1776533650303,1776533650303,1792281600000,'cmo4m9lks00qvp5i2ugf0b5ai','cmo4m9lh300mbp5i29bswv0q2');
INSERT INTO BatchModule VALUES('cmo4m9lku00r7p5i2w4in9msa',1776533650303,1776533650303,1794700800000,'cmo4m9lks00qvp5i2ugf0b5ai','cmo4m9lh600mjp5i25hvhjroz');
INSERT INTO BatchModule VALUES('cmo4m9lku00r8p5i2axboubrf',1776533650303,1776533650303,1792886400000,'cmo4m9lks00qvp5i2ugf0b5ai','cmo4m9lh400mdp5i2yuh69ai2');
INSERT INTO BatchModule VALUES('cmo4m9lku00rap5i2hgeqjrfm',1776533650303,1776533650303,1793491200000,'cmo4m9lks00qvp5i2ugf0b5ai','cmo4m9lh500mfp5i2v8w44b2g');
INSERT INTO BatchModule VALUES('cmo4m9lmr00u5p5i24aeyww7k',1776533650372,1776533650372,1782000000000,'cmo4m9lmq00u1p5i2cei02gym','cmo4m9lm000sjp5i2okua57t9');
INSERT INTO BatchModule VALUES('cmo4m9lmt00ujp5i22mqtun05',1776533650374,1776533650374,1791072000000,'cmo4m9lmq00u1p5i2cei02gym','cmo4m9lmg00tdp5i2sh8b5jyc');
INSERT INTO BatchModule VALUES('cmo4m9lmu00ulp5i2qd4ozxi5',1776533650374,1776533650374,1792281600000,'cmo4m9lmq00u1p5i2cei02gym','cmo4m9lmi00thp5i2xpnwwl71');
INSERT INTO BatchModule VALUES('cmo4m9lmu00unp5i2x93c2bee',1776533650374,1776533650374,1791676800000,'cmo4m9lmq00u1p5i2cei02gym','cmo4m9lmh00tfp5i2rk1d7mbw');
INSERT INTO BatchModule VALUES('cmo4m9lmu00upp5i2n54i4fwq',1776533650375,1776533650375,1792886400000,'cmo4m9lmq00u1p5i2cei02gym','cmo4m9lmj00tjp5i2c5r2xz21');
INSERT INTO BatchModule VALUES('cmo4m9lms00uep5i25cx71hh5',1776533650372,1776533650372,1786233600000,'cmo4m9lmq00u1p5i2cei02gym','cmo4m9lm800sxp5i208on6vb5');
INSERT INTO BatchModule VALUES('cmo4m9lmr00u7p5i29k942epg',1776533650372,1776533650372,1781395200000,'cmo4m9lmq00u1p5i2cei02gym','cmo4m9llz00shp5i2n9t0ct16');
INSERT INTO BatchModule VALUES('cmo4m9lmw00uvp5i2hmv0fr2g',1776533650376,1776533650376,1794096000000,'cmo4m9lmq00u1p5i2cei02gym','cmo4m9lml00tnp5i2go9k2ber');
INSERT INTO BatchModule VALUES('cmo4m9lmw00uxp5i28n1a665w',1776533650377,1776533650377,1794700800000,'cmo4m9lmq00u1p5i2cei02gym','cmo4m9lml00tpp5i2g41nfoex');
INSERT INTO BatchModule VALUES('cmo4m9lmv00utp5i2muwnjcn8',1776533650376,1776533650376,1786838400000,'cmo4m9lmq00u1p5i2cei02gym','cmo4m9lm800szp5i2r3bx7jau');
INSERT INTO BatchModule VALUES('cmo4m9lmx00v1p5i257prk17v',1776533650378,1776533650378,1787443200000,'cmo4m9lmq00u1p5i2cei02gym','cmo4m9lm900t1p5i2n55bl037');
INSERT INTO BatchModule VALUES('cmo4m9lmy00v3p5i27wdtfqr6',1776533650378,1776533650378,1795910400000,'cmo4m9lmq00u1p5i2cei02gym','cmo4m9lmn00ttp5i2j9mjt9f1');
INSERT INTO BatchModule VALUES('cmo4m9lmy00v5p5i2tljawu2l',1776533650379,1776533650379,1796515200000,'cmo4m9lmq00u1p5i2cei02gym','cmo4m9lmn00tvp5i2387ocacn');
INSERT INTO BatchModule VALUES('cmo4m9lmz00v7p5i2kcdmswu6',1776533650379,1776533650379,1797120000000,'cmo4m9lmq00u1p5i2cei02gym','cmo4m9lmo00txp5i2e4ks7y9i');
INSERT INTO BatchModule VALUES('cmo4m9lmz00v9p5i2v7tcmn8n',1776533650379,1776533650379,1785024000000,'cmo4m9lmq00u1p5i2cei02gym','cmo4m9lm600stp5i2fxhcn4xr');
INSERT INTO BatchModule VALUES('cmo4m9lmz00vbp5i2lomyki2y',1776533650380,1776533650380,1785628800000,'cmo4m9lmq00u1p5i2cei02gym','cmo4m9lm700svp5i23ekzr9gw');
INSERT INTO BatchModule VALUES('cmo4m9ln000vdp5i24nb818fo',1776533650380,1776533650380,1788652800000,'cmo4m9lmq00u1p5i2cei02gym','cmo4m9lmc00t5p5i2x4kdnavz');
INSERT INTO BatchModule VALUES('cmo4m9lms00ufp5i29ldkrbwj',1776533650372,1776533650372,1789862400000,'cmo4m9lmq00u1p5i2cei02gym','cmo4m9lme00t9p5i2ptuqq170');
INSERT INTO BatchModule VALUES('cmo4m9ln100vhp5i2rtuhqqr0',1776533650381,1776533650381,1790467200000,'cmo4m9lmq00u1p5i2cei02gym','cmo4m9lmf00tbp5i2u4dvrcj0');
INSERT INTO BatchModule VALUES('cmo4m9ln100vjp5i22ndsxku3',1776533650382,1776533650382,1789257600000,'cmo4m9lmq00u1p5i2cei02gym','cmo4m9lmd00t7p5i2lq0u6d81');
INSERT INTO BatchModule VALUES('cmo4m9ln000vfp5i2cixq6nyi',1776533650381,1776533650381,1783814400000,'cmo4m9lmq00u1p5i2cei02gym','cmo4m9lm400spp5i2zl2o3rl9');
INSERT INTO BatchModule VALUES('cmo4m9lmv00urp5i2ibfcx3ci',1776533650375,1776533650375,1793491200000,'cmo4m9lmq00u1p5i2cei02gym','cmo4m9lmk00tlp5i2evupki9x');
INSERT INTO BatchModule VALUES('cmo4m9lmx00uzp5i2st2tuwby',1776533650377,1776533650377,1795305600000,'cmo4m9lmq00u1p5i2cei02gym','cmo4m9lmm00trp5i2nr3zcq05');
INSERT INTO BatchModule VALUES('cmo4m9lmr00u9p5i277kj4i9r',1776533650372,1776533650372,1784419200000,'cmo4m9lmq00u1p5i2cei02gym','cmo4m9lm500srp5i2j57qgdeg');
INSERT INTO BatchModule VALUES('cmo4m9lms00ubp5i27mqz60tc',1776533650372,1776533650372,1783209600000,'cmo4m9lmq00u1p5i2cei02gym','cmo4m9lm200snp5i2bvo6ld72');
INSERT INTO BatchModule VALUES('cmo4m9lms00uhp5i2dho6hu8o',1776533650372,1776533650372,1788048000000,'cmo4m9lmq00u1p5i2cei02gym','cmo4m9lmb00t3p5i2grpmyfst');
INSERT INTO BatchModule VALUES('cmo4m9lmr00u6p5i2e8y08mqz',1776533650372,1776533650372,1782604800000,'cmo4m9lmq00u1p5i2cei02gym','cmo4m9lm100slp5i2lmw2fdz6');
INSERT INTO BatchModule VALUES('cmo4m9lpf00vpp5i25b1ss3df',1776533650467,1776533650467,1785628800000,'cmo4m9lpd00vlp5i2e84snwn7','cmo4m9llz00shp5i2n9t0ct16');
INSERT INTO BatchModule VALUES('cmo4m9lpg00w3p5i2hc1916rs',1776533650468,1776533650468,1793491200000,'cmo4m9lpd00vlp5i2e84snwn7','cmo4m9lmd00t7p5i2lq0u6d81');
INSERT INTO BatchModule VALUES('cmo4m9lpf00vrp5i2jzzkhn6x',1776533650467,1776533650467,1786838400000,'cmo4m9lpd00vlp5i2e84snwn7','cmo4m9lm100slp5i2lmw2fdz6');
INSERT INTO BatchModule VALUES('cmo4m9lph00w7p5i2t2s7vdih',1776533650469,1776533650469,1795305600000,'cmo4m9lpd00vlp5i2e84snwn7','cmo4m9lmg00tdp5i2sh8b5jyc');
INSERT INTO BatchModule VALUES('cmo4m9lph00w9p5i2ien5i9xr',1776533650470,1776533650470,1795910400000,'cmo4m9lpd00vlp5i2e84snwn7','cmo4m9lmh00tfp5i2rk1d7mbw');
INSERT INTO BatchModule VALUES('cmo4m9lpi00wbp5i2cxnajp33',1776533650470,1776533650470,1797120000000,'cmo4m9lpd00vlp5i2e84snwn7','cmo4m9lmj00tjp5i2c5r2xz21');
INSERT INTO BatchModule VALUES('cmo4m9lpi00wdp5i2vhz55gc6',1776533650471,1776533650471,1796515200000,'cmo4m9lpd00vlp5i2e84snwn7','cmo4m9lmi00thp5i2xpnwwl71');
INSERT INTO BatchModule VALUES('cmo4m9lpf00vqp5i2opwyouyz',1776533650467,1776533650467,1786233600000,'cmo4m9lpd00vlp5i2e84snwn7','cmo4m9lm000sjp5i2okua57t9');
INSERT INTO BatchModule VALUES('cmo4m9lpj00whp5i2hbi2gtg1',1776533650472,1776533650472,1798329600000,'cmo4m9lpd00vlp5i2e84snwn7','cmo4m9lml00tnp5i2go9k2ber');
INSERT INTO BatchModule VALUES('cmo4m9lpj00wfp5i2p4ed94hm',1776533650471,1776533650471,1797724800000,'cmo4m9lpd00vlp5i2e84snwn7','cmo4m9lmk00tlp5i2evupki9x');
INSERT INTO BatchModule VALUES('cmo4m9lpl00wlp5i20v7n325k',1776533650473,1776533650473,1799539200000,'cmo4m9lpd00vlp5i2e84snwn7','cmo4m9lmm00trp5i2nr3zcq05');
INSERT INTO BatchModule VALUES('cmo4m9lpl00wnp5i242evcbwu',1776533650474,1776533650474,1800144000000,'cmo4m9lpd00vlp5i2e84snwn7','cmo4m9lmn00ttp5i2j9mjt9f1');
INSERT INTO BatchModule VALUES('cmo4m9lpm00wpp5i2pwq22aie',1776533650474,1776533650474,1800748800000,'cmo4m9lpd00vlp5i2e84snwn7','cmo4m9lmn00tvp5i2387ocacn');
INSERT INTO BatchModule VALUES('cmo4m9lpm00wrp5i2mu7gepvf',1776533650475,1776533650475,1801353600000,'cmo4m9lpd00vlp5i2e84snwn7','cmo4m9lmo00txp5i2e4ks7y9i');
INSERT INTO BatchModule VALUES('cmo4m9lpn00wtp5i29lbvsh5a',1776533650475,1776533650475,1791072000000,'cmo4m9lpd00vlp5i2e84snwn7','cmo4m9lm800szp5i2r3bx7jau');
INSERT INTO BatchModule VALUES('cmo4m9lpn00wvp5i2cdq6o8vi',1776533650476,1776533650476,1788652800000,'cmo4m9lpd00vlp5i2e84snwn7','cmo4m9lm500srp5i2j57qgdeg');
INSERT INTO BatchModule VALUES('cmo4m9lpk00wjp5i2kc5yspw0',1776533650473,1776533650473,1798934400000,'cmo4m9lpd00vlp5i2e84snwn7','cmo4m9lml00tpp5i2g41nfoex');
INSERT INTO BatchModule VALUES('cmo4m9lpo00wzp5i2rkn5byqa',1776533650477,1776533650477,1794700800000,'cmo4m9lpd00vlp5i2e84snwn7','cmo4m9lmf00tbp5i2u4dvrcj0');
INSERT INTO BatchModule VALUES('cmo4m9lpp00x1p5i29lnpy9zb',1776533650477,1776533650477,1791676800000,'cmo4m9lpd00vlp5i2e84snwn7','cmo4m9lm900t1p5i2n55bl037');
INSERT INTO BatchModule VALUES('cmo4m9lpp00x3p5i2wkffw6tv',1776533650478,1776533650478,1789257600000,'cmo4m9lpd00vlp5i2e84snwn7','cmo4m9lm600stp5i2fxhcn4xr');
INSERT INTO BatchModule VALUES('cmo4m9lpo00wxp5i2njs545ib',1776533650476,1776533650476,1792886400000,'cmo4m9lpd00vlp5i2e84snwn7','cmo4m9lmc00t5p5i2x4kdnavz');
INSERT INTO BatchModule VALUES('cmo4m9lpf00vxp5i2dqb3ry08',1776533650467,1776533650467,1788048000000,'cmo4m9lpd00vlp5i2e84snwn7','cmo4m9lm400spp5i2zl2o3rl9');
INSERT INTO BatchModule VALUES('cmo4m9lpf00vvp5i2ow0gygap',1776533650467,1776533650467,1792281600000,'cmo4m9lpd00vlp5i2e84snwn7','cmo4m9lmb00t3p5i2grpmyfst');
INSERT INTO BatchModule VALUES('cmo4m9lpg00w5p5i2cibpdtkw',1776533650469,1776533650469,1794096000000,'cmo4m9lpd00vlp5i2e84snwn7','cmo4m9lme00t9p5i2ptuqq170');
INSERT INTO BatchModule VALUES('cmo4m9lpf00w1p5i2812rt5yi',1776533650468,1776533650468,1787443200000,'cmo4m9lpd00vlp5i2e84snwn7','cmo4m9lm200snp5i2bvo6ld72');
INSERT INTO BatchModule VALUES('cmo4m9lpf00w0p5i254eiau5n',1776533650467,1776533650467,1790467200000,'cmo4m9lpd00vlp5i2e84snwn7','cmo4m9lm800sxp5i208on6vb5');
INSERT INTO BatchModule VALUES('cmo4m9lpf00vzp5i26rpbhfqj',1776533650467,1776533650467,1789862400000,'cmo4m9lpd00vlp5i2e84snwn7','cmo4m9lm700svp5i23ekzr9gw');
INSERT INTO BatchModule VALUES('cmo4m9lsz00x9p5i2afvg69dz',1776533650596,1776533650596,1791072000000,'cmo4m9lsy00x5p5i26lj0lslm','cmo4m9llz00shp5i2n9t0ct16');
INSERT INTO BatchModule VALUES('cmo4m9lt000xnp5i259iv30sq',1776533650597,1776533650597,1799539200000,'cmo4m9lsy00x5p5i26lj0lslm','cmo4m9lme00t9p5i2ptuqq170');
INSERT INTO BatchModule VALUES('cmo4m9lt000xip5i25podht7l',1776533650596,1776533650596,1795910400000,'cmo4m9lsy00x5p5i26lj0lslm','cmo4m9lm800sxp5i208on6vb5');
INSERT INTO BatchModule VALUES('cmo4m9lt100xrp5i2msgdt09o',1776533650598,1776533650598,1801353600000,'cmo4m9lsy00x5p5i26lj0lslm','cmo4m9lmh00tfp5i2rk1d7mbw');
INSERT INTO BatchModule VALUES('cmo4m9lt200xtp5i22jihycxk',1776533650598,1776533650598,1796515200000,'cmo4m9lsy00x5p5i26lj0lslm','cmo4m9lm800szp5i2r3bx7jau');
INSERT INTO BatchModule VALUES('cmo4m9lt200xvp5i2h38d53bn',1776533650599,1776533650599,1801958400000,'cmo4m9lsy00x5p5i26lj0lslm','cmo4m9lmi00thp5i2xpnwwl71');
INSERT INTO BatchModule VALUES('cmo4m9lt300xxp5i2kf349g9e',1776533650599,1776533650599,1797120000000,'cmo4m9lsy00x5p5i26lj0lslm','cmo4m9lm900t1p5i2n55bl037');
INSERT INTO BatchModule VALUES('cmo4m9lt000xkp5i27slr7a41',1776533650596,1776533650596,1792886400000,'cmo4m9lsy00x5p5i26lj0lslm','cmo4m9lm200snp5i2bvo6ld72');
INSERT INTO BatchModule VALUES('cmo4m9lt400y1p5i22mbso5np',1776533650600,1776533650600,1803168000000,'cmo4m9lsy00x5p5i26lj0lslm','cmo4m9lmk00tlp5i2evupki9x');
INSERT INTO BatchModule VALUES('cmo4m9lt400y3p5i2rxk0glc6',1776533650601,1776533650601,1803772800000,'cmo4m9lsy00x5p5i26lj0lslm','cmo4m9lml00tnp5i2go9k2ber');
INSERT INTO BatchModule VALUES('cmo4m9lt500y5p5i2xle6916z',1776533650601,1776533650601,1804982400000,'cmo4m9lsy00x5p5i26lj0lslm','cmo4m9lmm00trp5i2nr3zcq05');
INSERT INTO BatchModule VALUES('cmo4m9lt500y7p5i2y6b89wzd',1776533650602,1776533650602,1804377600000,'cmo4m9lsy00x5p5i26lj0lslm','cmo4m9lml00tpp5i2g41nfoex');
INSERT INTO BatchModule VALUES('cmo4m9lt600y9p5i26psciccy',1776533650602,1776533650602,1805587200000,'cmo4m9lsy00x5p5i26lj0lslm','cmo4m9lmn00ttp5i2j9mjt9f1');
INSERT INTO BatchModule VALUES('cmo4m9lt600ybp5i2zd9irei0',1776533650603,1776533650603,1806192000000,'cmo4m9lsy00x5p5i26lj0lslm','cmo4m9lmn00tvp5i2387ocacn');
INSERT INTO BatchModule VALUES('cmo4m9lt700ydp5i2rktwhfsk',1776533650603,1776533650603,1806796800000,'cmo4m9lsy00x5p5i26lj0lslm','cmo4m9lmo00txp5i2e4ks7y9i');
INSERT INTO BatchModule VALUES('cmo4m9lt300xzp5i2cuf4dri4',1776533650600,1776533650600,1802563200000,'cmo4m9lsy00x5p5i26lj0lslm','cmo4m9lmj00tjp5i2c5r2xz21');
INSERT INTO BatchModule VALUES('cmo4m9lt800yhp5i2x6z25u5f',1776533650604,1776533650604,1794700800000,'cmo4m9lsy00x5p5i26lj0lslm','cmo4m9lm600stp5i2fxhcn4xr');
INSERT INTO BatchModule VALUES('cmo4m9lt800yjp5i2mvxl24j1',1776533650605,1776533650605,1795305600000,'cmo4m9lsy00x5p5i26lj0lslm','cmo4m9lm700svp5i23ekzr9gw');
INSERT INTO BatchModule VALUES('cmo4m9lt900ylp5i2uyhm9jwi',1776533650605,1776533650605,1798329600000,'cmo4m9lsy00x5p5i26lj0lslm','cmo4m9lmc00t5p5i2x4kdnavz');
INSERT INTO BatchModule VALUES('cmo4m9lt000xjp5i2arakghle',1776533650596,1776533650596,1797724800000,'cmo4m9lsy00x5p5i26lj0lslm','cmo4m9lmb00t3p5i2grpmyfst');
INSERT INTO BatchModule VALUES('cmo4m9lta00ynp5i2p3ngn20u',1776533650606,1776533650606,1798934400000,'cmo4m9lsy00x5p5i26lj0lslm','cmo4m9lmd00t7p5i2lq0u6d81');
INSERT INTO BatchModule VALUES('cmo4m9lt700yfp5i233jy6wfl',1776533650604,1776533650604,1800144000000,'cmo4m9lsy00x5p5i26lj0lslm','cmo4m9lmf00tbp5i2u4dvrcj0');
INSERT INTO BatchModule VALUES('cmo4m9lsz00xap5i2oftu66lr',1776533650596,1776533650596,1791676800000,'cmo4m9lsy00x5p5i26lj0lslm','cmo4m9lm000sjp5i2okua57t9');
INSERT INTO BatchModule VALUES('cmo4m9lsz00xbp5i28bcq5k5w',1776533650596,1776533650596,1792281600000,'cmo4m9lsy00x5p5i26lj0lslm','cmo4m9lm100slp5i2lmw2fdz6');
INSERT INTO BatchModule VALUES('cmo4m9lt000xdp5i2h5bkapzq',1776533650596,1776533650596,1794096000000,'cmo4m9lsy00x5p5i26lj0lslm','cmo4m9lm500srp5i2j57qgdeg');
INSERT INTO BatchModule VALUES('cmo4m9lt100xpp5i2d2gprny9',1776533650597,1776533650597,1800748800000,'cmo4m9lsy00x5p5i26lj0lslm','cmo4m9lmg00tdp5i2sh8b5jyc');
INSERT INTO BatchModule VALUES('cmo4m9lt000xlp5i2ijnlrsjy',1776533650596,1776533650596,1793491200000,'cmo4m9lsy00x5p5i26lj0lslm','cmo4m9lm400spp5i2zl2o3rl9');
INSERT INTO BatchModule VALUES('cmo4m9lwr010dp5i2zda9py0q',1776533650732,1776533650732,1783814400000,'cmo4m9lwq010bp5i2a41ccczg','cmo4m9lw600yzp5i2yjpn8qww');
INSERT INTO BatchModule VALUES('cmo4m9lws010tp5i24qzr1arh',1776533650732,1776533650732,1792281600000,'cmo4m9lwq010bp5i2a41ccczg','cmo4m9lwi00zrp5i2ag225sl2');
INSERT INTO BatchModule VALUES('cmo4m9lws010vp5i28vwqhobm',1776533650733,1776533650733,1793491200000,'cmo4m9lwq010bp5i2a41ccczg','cmo4m9lwk00zvp5i2wxcr9e1d');
INSERT INTO BatchModule VALUES('cmo4m9lwr010rp5i2dqqzgdc0',1776533650732,1776533650732,1788048000000,'cmo4m9lwq010bp5i2a41ccczg','cmo4m9lwc00zdp5i25cyyr9mh');
INSERT INTO BatchModule VALUES('cmo4m9lwt010zp5i2cxa5zund',1776533650733,1776533650733,1794096000000,'cmo4m9lwq010bp5i2a41ccczg','cmo4m9lwk00zxp5i2j1diytbh');
INSERT INTO BatchModule VALUES('cmo4m9lwt0111p5i28d5imgjv',1776533650734,1776533650734,1788652800000,'cmo4m9lwq010bp5i2a41ccczg','cmo4m9lwd00zfp5i2t1am2qlr');
INSERT INTO BatchModule VALUES('cmo4m9lwu0113p5i2epfcir2d',1776533650734,1776533650734,1794700800000,'cmo4m9lwq010bp5i2a41ccczg','cmo4m9lwl00zzp5i29kmfymdf');
INSERT INTO BatchModule VALUES('cmo4m9lwu0115p5i213kcaqq3',1776533650735,1776533650735,1789257600000,'cmo4m9lwq010bp5i2a41ccczg','cmo4m9lwe00zhp5i25xxijmfr');
INSERT INTO BatchModule VALUES('cmo4m9lwv0117p5i27snan4tf',1776533650735,1776533650735,1795305600000,'cmo4m9lwq010bp5i2a41ccczg','cmo4m9lwm0101p5i22lt0wyk1');
INSERT INTO BatchModule VALUES('cmo4m9lwv0119p5i26u6ows1z',1776533650736,1776533650736,1795910400000,'cmo4m9lwq010bp5i2a41ccczg','cmo4m9lwn0103p5i2rxmkcmgt');
INSERT INTO BatchModule VALUES('cmo4m9lww011bp5i20bm38ulz',1776533650736,1776533650736,1796515200000,'cmo4m9lwq010bp5i2a41ccczg','cmo4m9lwn0105p5i2t3j985hn');
INSERT INTO BatchModule VALUES('cmo4m9lws010xp5i23xp01i5n',1776533650733,1776533650733,1792886400000,'cmo4m9lwq010bp5i2a41ccczg','cmo4m9lwj00ztp5i2be5qxagh');
INSERT INTO BatchModule VALUES('cmo4m9lww011fp5i2gt9eyuf5',1776533650737,1776533650737,1785024000000,'cmo4m9lwq010bp5i2a41ccczg','cmo4m9lw800z3p5i264uobqoa');
INSERT INTO BatchModule VALUES('cmo4m9lwx011hp5i2o7abaaya',1776533650737,1776533650737,1786233600000,'cmo4m9lwq010bp5i2a41ccczg','cmo4m9lwa00z7p5i28hq16f9l');
INSERT INTO BatchModule VALUES('cmo4m9lwx011jp5i20zfu57at',1776533650738,1776533650738,1786838400000,'cmo4m9lwq010bp5i2a41ccczg','cmo4m9lwa00z9p5i2x78jkirf');
INSERT INTO BatchModule VALUES('cmo4m9lwy011lp5i2d2uxf3i2',1776533650738,1776533650738,1785628800000,'cmo4m9lwq010bp5i2a41ccczg','cmo4m9lw900z5p5i2qprjja7p');
INSERT INTO BatchModule VALUES('cmo4m9lwy011np5i26qcy8zu5',1776533650739,1776533650739,1791676800000,'cmo4m9lwq010bp5i2a41ccczg','cmo4m9lwh00zpp5i20cdewl5h');
INSERT INTO BatchModule VALUES('cmo4m9lwz011pp5i2kqg11lqk',1776533650739,1776533650739,1783209600000,'cmo4m9lwq010bp5i2a41ccczg','cmo4m9lw500yxp5i21b74tsgs');
INSERT INTO BatchModule VALUES('cmo4m9lwz011rp5i2zcmo2xah',1776533650740,1776533650740,1782000000000,'cmo4m9lwq010bp5i2a41ccczg','cmo4m9lvv00ytp5i25n9rqry5');
INSERT INTO BatchModule VALUES('cmo4m9lww011dp5i24bpa4aww',1776533650736,1776533650736,1797120000000,'cmo4m9lwq010bp5i2a41ccczg','cmo4m9lwo0107p5i252bvjlti');
INSERT INTO BatchModule VALUES('cmo4m9lx0011tp5i2u0b38ioc',1776533650740,1776533650740,1790467200000,'cmo4m9lwq010bp5i2a41ccczg','cmo4m9lwf00zlp5i2ry515nyk');
INSERT INTO BatchModule VALUES('cmo4m9lwr010pp5i27fl48lse',1776533650732,1776533650732,1791072000000,'cmo4m9lwq010bp5i2a41ccczg','cmo4m9lwg00znp5i2meahrdwm');
INSERT INTO BatchModule VALUES('cmo4m9lwr010hp5i23yfyrkjv',1776533650732,1776533650732,1787443200000,'cmo4m9lwq010bp5i2a41ccczg','cmo4m9lwb00zbp5i201w3j2aj');
INSERT INTO BatchModule VALUES('cmo4m9lwr010gp5i2e29zgt4l',1776533650732,1776533650732,1784419200000,'cmo4m9lwq010bp5i2a41ccczg','cmo4m9lw700z1p5i2475utv2s');
INSERT INTO BatchModule VALUES('cmo4m9lwr010qp5i2p3irmznh',1776533650732,1776533650732,1789862400000,'cmo4m9lwq010bp5i2a41ccczg','cmo4m9lwe00zjp5i2xu9tigze');
INSERT INTO BatchModule VALUES('cmo4m9lwr010np5i28hb5rtos',1776533650732,1776533650732,1782604800000,'cmo4m9lwq010bp5i2a41ccczg','cmo4m9lw400yvp5i2re5lh9nu');
INSERT INTO BatchModule VALUES('cmo4m9lwr010mp5i2vrb4ekwt',1776533650732,1776533650732,1781395200000,'cmo4m9lwq010bp5i2a41ccczg','cmo4m9lvs00yrp5i2g6ibmefs');
INSERT INTO BatchModule VALUES('cmo4m9lym011yp5i20yqtaj96',1776533650798,1776533650798,1785628800000,'cmo4m9lyk011vp5i2uvfp7zzi','cmo4m9lvs00yrp5i2g6ibmefs');
INSERT INTO BatchModule VALUES('cmo4m9lyn012dp5i28pc4dtkg',1776533650799,1776533650799,1795305600000,'cmo4m9lyk011vp5i2uvfp7zzi','cmo4m9lwg00znp5i2meahrdwm');
INSERT INTO BatchModule VALUES('cmo4m9lym0120p5i29ys22i4t',1776533650798,1776533650798,1786233600000,'cmo4m9lyk011vp5i2uvfp7zzi','cmo4m9lvv00ytp5i25n9rqry5');
INSERT INTO BatchModule VALUES('cmo4m9lyo012hp5i2cbk9qqdo',1776533650800,1776533650800,1797120000000,'cmo4m9lyk011vp5i2uvfp7zzi','cmo4m9lwj00ztp5i2be5qxagh');
INSERT INTO BatchModule VALUES('cmo4m9lyo012jp5i2ypxxia6j',1776533650801,1776533650801,1797724800000,'cmo4m9lyk011vp5i2uvfp7zzi','cmo4m9lwk00zvp5i2wxcr9e1d');
INSERT INTO BatchModule VALUES('cmo4m9lyp012lp5i2kqx2c80m',1776533650801,1776533650801,1798329600000,'cmo4m9lyk011vp5i2uvfp7zzi','cmo4m9lwk00zxp5i2j1diytbh');
INSERT INTO BatchModule VALUES('cmo4m9lyp012np5i2yfkk7ujx',1776533650802,1776533650802,1798934400000,'cmo4m9lyk011vp5i2uvfp7zzi','cmo4m9lwl00zzp5i29kmfymdf');
INSERT INTO BatchModule VALUES('cmo4m9lym012bp5i2acbc903l',1776533650799,1776533650799,1789862400000,'cmo4m9lyk011vp5i2uvfp7zzi','cmo4m9lw900z5p5i2qprjja7p');
INSERT INTO BatchModule VALUES('cmo4m9lyq012rp5i2v133ns1l',1776533650798,1776533650798,1789257600000,'cmo4m9lyk011vp5i2uvfp7zzi','cmo4m9lw800z3p5i264uobqoa');
INSERT INTO BatchModule VALUES('cmo4m9lyn012fp5i2b579yaif',1776533650800,1776533650800,1796515200000,'cmo4m9lyk011vp5i2uvfp7zzi','cmo4m9lwi00zrp5i2ag225sl2');
INSERT INTO BatchModule VALUES('cmo4m9lyr012vp5i2m440v0vk',1776533650804,1776533650804,1795910400000,'cmo4m9lyk011vp5i2uvfp7zzi','cmo4m9lwh00zpp5i20cdewl5h');
INSERT INTO BatchModule VALUES('cmo4m9lys012xp5i2umwtjfdx',1776533650805,1776533650805,1800748800000,'cmo4m9lyk011vp5i2uvfp7zzi','cmo4m9lwn0105p5i2t3j985hn');
INSERT INTO BatchModule VALUES('cmo4m9lyt012zp5i2tneqmo8b',1776533650805,1776533650805,1801353600000,'cmo4m9lyk011vp5i2uvfp7zzi','cmo4m9lwo0107p5i252bvjlti');
INSERT INTO BatchModule VALUES('cmo4m9lyt0131p5i2pl0em25p',1776533650806,1776533650806,1791072000000,'cmo4m9lyk011vp5i2uvfp7zzi','cmo4m9lwa00z9p5i2x78jkirf');
INSERT INTO BatchModule VALUES('cmo4m9lyu0133p5i261una35n',1776533650806,1776533650806,1788048000000,'cmo4m9lyk011vp5i2uvfp7zzi','cmo4m9lw600yzp5i2yjpn8qww');
INSERT INTO BatchModule VALUES('cmo4m9lyu0135p5i26b3h69mb',1776533650807,1776533650807,1788652800000,'cmo4m9lyk011vp5i2uvfp7zzi','cmo4m9lw700z1p5i2475utv2s');
INSERT INTO BatchModule VALUES('cmo4m9lym012ap5i27kue6ipt',1776533650798,1776533650798,1793491200000,'cmo4m9lyk011vp5i2uvfp7zzi','cmo4m9lwe00zhp5i25xxijmfr');
INSERT INTO BatchModule VALUES('cmo4m9lyv0139p5i2kw2cedai',1776533650808,1776533650808,1792281600000,'cmo4m9lyk011vp5i2uvfp7zzi','cmo4m9lwc00zdp5i25cyyr9mh');
INSERT INTO BatchModule VALUES('cmo4m9lym0121p5i25jggccpy',1776533650798,1776533650798,1786838400000,'cmo4m9lyk011vp5i2uvfp7zzi','cmo4m9lw400yvp5i2re5lh9nu');
INSERT INTO BatchModule VALUES('cmo4m9lyw013dp5i2gazcy072',1776533650809,1776533650809,1791676800000,'cmo4m9lyk011vp5i2uvfp7zzi','cmo4m9lwb00zbp5i201w3j2aj');
INSERT INTO BatchModule VALUES('cmo4m9lyw013bp5i26s1amxuf',1776533650808,1776533650808,1792886400000,'cmo4m9lyk011vp5i2uvfp7zzi','cmo4m9lwd00zfp5i2t1am2qlr');
INSERT INTO BatchModule VALUES('cmo4m9lyv0137p5i2wgz7c9hb',1776533650807,1776533650807,1794700800000,'cmo4m9lyk011vp5i2uvfp7zzi','cmo4m9lwf00zlp5i2ry515nyk');
INSERT INTO BatchModule VALUES('cmo4m9lyr012tp5i2r40avibs',1776533650803,1776533650803,1800144000000,'cmo4m9lyk011vp5i2uvfp7zzi','cmo4m9lwn0103p5i2rxmkcmgt');
INSERT INTO BatchModule VALUES('cmo4m9lym0123p5i2cpboiu9m',1776533650798,1776533650798,1790467200000,'cmo4m9lyk011vp5i2uvfp7zzi','cmo4m9lwa00z7p5i28hq16f9l');
INSERT INTO BatchModule VALUES('cmo4m9lyq012pp5i2izas4hxt',1776533650802,1776533650802,1799539200000,'cmo4m9lyk011vp5i2uvfp7zzi','cmo4m9lwm0101p5i22lt0wyk1');
INSERT INTO BatchModule VALUES('cmo4m9lym0129p5i2yaonc5s8',1776533650799,1776533650799,1794096000000,'cmo4m9lyk011vp5i2uvfp7zzi','cmo4m9lwe00zjp5i2xu9tigze');
INSERT INTO BatchModule VALUES('cmo4m9lym0126p5i20l9jmxad',1776533650798,1776533650798,1787443200000,'cmo4m9lyk011vp5i2uvfp7zzi','cmo4m9lw500yxp5i21b74tsgs');
INSERT INTO BatchModule VALUES('cmo4m9lzu013ip5i2icf24iez',1776533650843,1776533650843,1794096000000,'cmo4m9lzs013fp5i2rfhmws5j','cmo4m9lw700z1p5i2475utv2s');
INSERT INTO BatchModule VALUES('cmo4m9lzv013xp5i2wm6phyb1',1776533650843,1776533650843,1799539200000,'cmo4m9lzs013fp5i2rfhmws5j','cmo4m9lwe00zjp5i2xu9tigze');
INSERT INTO BatchModule VALUES('cmo4m9lzu013rp5i2wynpms4g',1776533650843,1776533650843,1793491200000,'cmo4m9lzs013fp5i2rfhmws5j','cmo4m9lw600yzp5i2yjpn8qww');
INSERT INTO BatchModule VALUES('cmo4m9lzw0141p5i2ydb0ktwn',1776533650844,1776533650844,1792886400000,'cmo4m9lzs013fp5i2rfhmws5j','cmo4m9lw500yxp5i21b74tsgs');
INSERT INTO BatchModule VALUES('cmo4m9lzw0143p5i292cma4w2',1776533650845,1776533650845,1800144000000,'cmo4m9lzs013fp5i2rfhmws5j','cmo4m9lwf00zlp5i2ry515nyk');
INSERT INTO BatchModule VALUES('cmo4m9lzy0145p5i2nshobw8v',1776533650847,1776533650847,1800748800000,'cmo4m9lzs013fp5i2rfhmws5j','cmo4m9lwg00znp5i2meahrdwm');
INSERT INTO BatchModule VALUES('cmo4m9lzv013zp5i26u8vv4tt',1776533650844,1776533650844,1794700800000,'cmo4m9lzs013fp5i2rfhmws5j','cmo4m9lw800z3p5i264uobqoa');
INSERT INTO BatchModule VALUES('cmo4m9lzz0149p5i2umy5sxau',1776533650848,1776533650848,1802563200000,'cmo4m9lzs013fp5i2rfhmws5j','cmo4m9lwj00ztp5i2be5qxagh');
INSERT INTO BatchModule VALUES('cmo4m9m00014bp5i2wrictobi',1776533650848,1776533650848,1803168000000,'cmo4m9lzs013fp5i2rfhmws5j','cmo4m9lwk00zvp5i2wxcr9e1d');
INSERT INTO BatchModule VALUES('cmo4m9m00014dp5i2bnypvmkb',1776533650849,1776533650849,1803772800000,'cmo4m9lzs013fp5i2rfhmws5j','cmo4m9lwk00zxp5i2j1diytbh');
INSERT INTO BatchModule VALUES('cmo4m9m01014fp5i2ohntbuk4',1776533650849,1776533650849,1804377600000,'cmo4m9lzs013fp5i2rfhmws5j','cmo4m9lwl00zzp5i29kmfymdf');
INSERT INTO BatchModule VALUES('cmo4m9m01014hp5i23sd95u47',1776533650850,1776533650850,1804982400000,'cmo4m9lzs013fp5i2rfhmws5j','cmo4m9lwm0101p5i22lt0wyk1');
INSERT INTO BatchModule VALUES('cmo4m9m02014jp5i2m5lih875',1776533650850,1776533650850,1805587200000,'cmo4m9lzs013fp5i2rfhmws5j','cmo4m9lwn0103p5i2rxmkcmgt');
INSERT INTO BatchModule VALUES('cmo4m9m02014lp5i2ia7na2ta',1776533650851,1776533650851,1806192000000,'cmo4m9lzs013fp5i2rfhmws5j','cmo4m9lwn0105p5i2t3j985hn');
INSERT INTO BatchModule VALUES('cmo4m9m03014np5i2u2ffmupb',1776533650851,1776533650851,1806796800000,'cmo4m9lzs013fp5i2rfhmws5j','cmo4m9lwo0107p5i252bvjlti');
INSERT INTO BatchModule VALUES('cmo4m9lzu013tp5i2yl0f9d8s',1776533650843,1776533650843,1791676800000,'cmo4m9lzs013fp5i2rfhmws5j','cmo4m9lvv00ytp5i25n9rqry5');
INSERT INTO BatchModule VALUES('cmo4m9lzu013op5i2egq8z2sx',1776533650843,1776533650843,1795305600000,'cmo4m9lzs013fp5i2rfhmws5j','cmo4m9lw900z5p5i2qprjja7p');
INSERT INTO BatchModule VALUES('cmo4m9m04014tp5i2epjx2rcc',1776533650852,1776533650852,1795910400000,'cmo4m9lzs013fp5i2rfhmws5j','cmo4m9lwa00z7p5i28hq16f9l');
INSERT INTO BatchModule VALUES('cmo4m9m04014vp5i2s22il5a7',1776533650853,1776533650853,1796515200000,'cmo4m9lzs013fp5i2rfhmws5j','cmo4m9lwa00z9p5i2x78jkirf');
INSERT INTO BatchModule VALUES('cmo4m9m05014xp5i2wym0j17j',1776533650853,1776533650853,1798934400000,'cmo4m9lzs013fp5i2rfhmws5j','cmo4m9lwe00zhp5i25xxijmfr');
INSERT INTO BatchModule VALUES('cmo4m9m03014pp5i2o5vxve45',1776533650851,1776533650851,1801353600000,'cmo4m9lzs013fp5i2rfhmws5j','cmo4m9lwh00zpp5i20cdewl5h');
INSERT INTO BatchModule VALUES('cmo4m9lzz0147p5i2fg52iwep',1776533650847,1776533650847,1801958400000,'cmo4m9lzs013fp5i2rfhmws5j','cmo4m9lwi00zrp5i2ag225sl2');
INSERT INTO BatchModule VALUES('cmo4m9m03014rp5i2ulxahcc5',1776533650852,1776533650852,1798329600000,'cmo4m9lzs013fp5i2rfhmws5j','cmo4m9lwd00zfp5i2t1am2qlr');
INSERT INTO BatchModule VALUES('cmo4m9lzu013qp5i2neuzbprr',1776533650843,1776533650843,1792281600000,'cmo4m9lzs013fp5i2rfhmws5j','cmo4m9lw400yvp5i2re5lh9nu');
INSERT INTO BatchModule VALUES('cmo4m9lzu013pp5i26nutvfhu',1776533650843,1776533650843,1797120000000,'cmo4m9lzs013fp5i2rfhmws5j','cmo4m9lwb00zbp5i201w3j2aj');
INSERT INTO BatchModule VALUES('cmo4m9lzu013sp5i2rf30z580',1776533650843,1776533650843,1791072000000,'cmo4m9lzs013fp5i2rfhmws5j','cmo4m9lvs00yrp5i2g6ibmefs');
INSERT INTO BatchModule VALUES('cmo4m9lzu013vp5i2hf5k4dhl',1776533650843,1776533650843,1797724800000,'cmo4m9lzs013fp5i2rfhmws5j','cmo4m9lwc00zdp5i25cyyr9mh');
INSERT INTO BatchModule VALUES('cmo4m9m2h016op5i2z2wjv8s6',1776533650938,1776533650938,1781395200000,'cmo4m9m2g016lp5i2prc2f3d5','cmo4m9m1q0151p5i2qyn962pb');
INSERT INTO BatchModule VALUES('cmo4m9m2j0173p5i2k2kq73jp',1776533650940,1776533650940,1791676800000,'cmo4m9m2g016lp5i2prc2f3d5','cmo4m9m27015zp5i2e17b4b0r');
INSERT INTO BatchModule VALUES('cmo4m9m2k0175p5i2bdy3x8q3',1776533650940,1776533650940,1792886400000,'cmo4m9m2g016lp5i2prc2f3d5','cmo4m9m290163p5i21cqdcygw');
INSERT INTO BatchModule VALUES('cmo4m9m2k0177p5i2yep5vkoa',1776533650941,1776533650941,1792281600000,'cmo4m9m2g016lp5i2prc2f3d5','cmo4m9m280161p5i2vhsc5zf0');
INSERT INTO BatchModule VALUES('cmo4m9m2k0179p5i2y9682no3',1776533650941,1776533650941,1793491200000,'cmo4m9m2g016lp5i2prc2f3d5','cmo4m9m2a0165p5i2xvba44s4');
INSERT INTO BatchModule VALUES('cmo4m9m2h016pp5i2bxrito0o',1776533650938,1776533650938,1782000000000,'cmo4m9m2g016lp5i2prc2f3d5','cmo4m9m1r0153p5i2ytp77dxq');
INSERT INTO BatchModule VALUES('cmo4m9m2h0170p5i2rfi2glrs',1776533650938,1776533650938,1786838400000,'cmo4m9m2g016lp5i2prc2f3d5','cmo4m9m20015jp5i2g3i7gz0b');
INSERT INTO BatchModule VALUES('cmo4m9m2m017fp5i22qfc0lj8',1776533650942,1776533650942,1795305600000,'cmo4m9m2g016lp5i2prc2f3d5','cmo4m9m2d016bp5i274uilbjn');
INSERT INTO BatchModule VALUES('cmo4m9m2m017hp5i2btdqyjv7',1776533650943,1776533650943,1787443200000,'cmo4m9m2g016lp5i2prc2f3d5','cmo4m9m21015lp5i2pfvx1on5');
INSERT INTO BatchModule VALUES('cmo4m9m2l017dp5i26euc4vcb',1776533650942,1776533650942,1794700800000,'cmo4m9m2g016lp5i2prc2f3d5','cmo4m9m2c0169p5i2sv1v8eag');
INSERT INTO BatchModule VALUES('cmo4m9m2n017lp5i2gdffxjyp',1776533650944,1776533650944,1796515200000,'cmo4m9m2g016lp5i2prc2f3d5','cmo4m9m2e016fp5i2qqtzxwyg');
INSERT INTO BatchModule VALUES('cmo4m9m2o017np5i2b6j53ao1',1776533650944,1776533650944,1797120000000,'cmo4m9m2g016lp5i2prc2f3d5','cmo4m9m2f016hp5i23s4a4oho');
INSERT INTO BatchModule VALUES('cmo4m9m2o017pp5i2xvepozjf',1776533650945,1776533650945,1788048000000,'cmo4m9m2g016lp5i2prc2f3d5','cmo4m9m22015np5i2wajp4kjt');
INSERT INTO BatchModule VALUES('cmo4m9m2l017bp5i2jgd6o79z',1776533650941,1776533650941,1794096000000,'cmo4m9m2g016lp5i2prc2f3d5','cmo4m9m2b0167p5i2zu922t2x');
INSERT INTO BatchModule VALUES('cmo4m9m2p017tp5i2yrecy1em',1776533650945,1776533650945,1791072000000,'cmo4m9m2g016lp5i2prc2f3d5','cmo4m9m27015xp5i23c9t1q32');
INSERT INTO BatchModule VALUES('cmo4m9m2p017vp5i2cwioh27y',1776533650946,1776533650946,1785628800000,'cmo4m9m2g016lp5i2prc2f3d5','cmo4m9m1y015fp5i2q36r3t76');
INSERT INTO BatchModule VALUES('cmo4m9m2p017rp5i2y7xn6xdt',1776533650945,1776533650945,1789257600000,'cmo4m9m2g016lp5i2prc2f3d5','cmo4m9m24015rp5i2634j2lcs');
INSERT INTO BatchModule VALUES('cmo4m9m2n017jp5i2548q2sfl',1776533650943,1776533650943,1795910400000,'cmo4m9m2g016lp5i2prc2f3d5','cmo4m9m2d016dp5i2nd3558qj');
INSERT INTO BatchModule VALUES('cmo4m9m2h016vp5i2639gct8i',1776533650938,1776533650938,1785024000000,'cmo4m9m2g016lp5i2prc2f3d5','cmo4m9m1x015dp5i2wbpzarcz');
INSERT INTO BatchModule VALUES('cmo4m9m2r0183p5i2asu8226a',1776533650948,1776533650948,1784419200000,'cmo4m9m2g016lp5i2prc2f3d5','cmo4m9m1w015bp5i2vos624ya');
INSERT INTO BatchModule VALUES('cmo4m9m2r0181p5i2t7jqf3om',1776533650947,1776533650947,1783814400000,'cmo4m9m2g016lp5i2prc2f3d5','cmo4m9m1v0159p5i2pbd5ylk1');
INSERT INTO BatchModule VALUES('cmo4m9m2q017xp5i2qulxx3eb',1776533650946,1776533650946,1786233600000,'cmo4m9m2g016lp5i2prc2f3d5','cmo4m9m1z015hp5i2ztxchh6c');
INSERT INTO BatchModule VALUES('cmo4m9m2q017zp5i2tw049yxd',1776533650947,1776533650947,1783209600000,'cmo4m9m2g016lp5i2prc2f3d5','cmo4m9m1u0157p5i2ngc7p1rk');
INSERT INTO BatchModule VALUES('cmo4m9m2h016rp5i2xcl671eu',1776533650938,1776533650938,1782604800000,'cmo4m9m2g016lp5i2prc2f3d5','cmo4m9m1t0155p5i27a7fu03b');
INSERT INTO BatchModule VALUES('cmo4m9m2h016zp5i2n8nahhi9',1776533650938,1776533650938,1790467200000,'cmo4m9m2g016lp5i2prc2f3d5','cmo4m9m26015vp5i2eqcfbe3t');
INSERT INTO BatchModule VALUES('cmo4m9m2h0171p5i2tu7irnpz',1776533650938,1776533650938,1789862400000,'cmo4m9m2g016lp5i2prc2f3d5','cmo4m9m25015tp5i2s4739ci2');
INSERT INTO BatchModule VALUES('cmo4m9m2h016tp5i2kirvork4',1776533650938,1776533650938,1788652800000,'cmo4m9m2g016lp5i2prc2f3d5','cmo4m9m23015pp5i2gnl7dg2b');
INSERT INTO BatchModule VALUES('cmo4m9m4a018bp5i2136zd34v',1776533651002,1776533651002,1786838400000,'cmo4m9m480185p5i2xz8gxkjm','cmo4m9m1t0155p5i27a7fu03b');
INSERT INTO BatchModule VALUES('cmo4m9m4a018np5i2xud62z5s',1776533651003,1776533651003,1794096000000,'cmo4m9m480185p5i2xz8gxkjm','cmo4m9m25015tp5i2s4739ci2');
INSERT INTO BatchModule VALUES('cmo4m9m4a018dp5i20u66yus9',1776533651002,1776533651002,1787443200000,'cmo4m9m480185p5i2xz8gxkjm','cmo4m9m1u0157p5i2ngc7p1rk');
INSERT INTO BatchModule VALUES('cmo4m9m4b018rp5i2fw6hay7n',1776533651004,1776533651004,1795910400000,'cmo4m9m480185p5i2xz8gxkjm','cmo4m9m27015zp5i2e17b4b0r');
INSERT INTO BatchModule VALUES('cmo4m9m4b018pp5i240lr57fk',1776533651003,1776533651003,1794700800000,'cmo4m9m480185p5i2xz8gxkjm','cmo4m9m26015vp5i2eqcfbe3t');
INSERT INTO BatchModule VALUES('cmo4m9m4c018vp5i2f87vyzln',1776533651005,1776533651005,1796515200000,'cmo4m9m480185p5i2xz8gxkjm','cmo4m9m280161p5i2vhsc5zf0');
INSERT INTO BatchModule VALUES('cmo4m9m4d018xp5i2buil76jg',1776533651005,1776533651005,1795305600000,'cmo4m9m480185p5i2xz8gxkjm','cmo4m9m27015xp5i23c9t1q32');
INSERT INTO BatchModule VALUES('cmo4m9m4a018hp5i2wqq26zub',1776533651002,1776533651002,1789257600000,'cmo4m9m480185p5i2xz8gxkjm','cmo4m9m1x015dp5i2wbpzarcz');
INSERT INTO BatchModule VALUES('cmo4m9m4e0191p5i24t5q3hzb',1776533651007,1776533651007,1797724800000,'cmo4m9m480185p5i2xz8gxkjm','cmo4m9m2a0165p5i2xvba44s4');
INSERT INTO BatchModule VALUES('cmo4m9m4f0193p5i28oxigok1',1776533651007,1776533651007,1789862400000,'cmo4m9m480185p5i2xz8gxkjm','cmo4m9m1y015fp5i2q36r3t76');
INSERT INTO BatchModule VALUES('cmo4m9m4f0195p5i2lopfy843',1776533651008,1776533651008,1798329600000,'cmo4m9m480185p5i2xz8gxkjm','cmo4m9m2b0167p5i2zu922t2x');
INSERT INTO BatchModule VALUES('cmo4m9m4g0197p5i22dv8t82n',1776533651008,1776533651008,1790467200000,'cmo4m9m480185p5i2xz8gxkjm','cmo4m9m1z015hp5i2ztxchh6c');
INSERT INTO BatchModule VALUES('cmo4m9m4g0199p5i2agnbzgn2',1776533651008,1776533651008,1798934400000,'cmo4m9m480185p5i2xz8gxkjm','cmo4m9m2c0169p5i2sv1v8eag');
INSERT INTO BatchModule VALUES('cmo4m9m4g019bp5i2h0jm9y5y',1776533651009,1776533651009,1799539200000,'cmo4m9m480185p5i2xz8gxkjm','cmo4m9m2d016bp5i274uilbjn');
INSERT INTO BatchModule VALUES('cmo4m9m4h019dp5i21vsawica',1776533651009,1776533651009,1800144000000,'cmo4m9m480185p5i2xz8gxkjm','cmo4m9m2d016dp5i2nd3558qj');
INSERT INTO BatchModule VALUES('cmo4m9m4i019fp5i2j78w2ku3',1776533651010,1776533651010,1800748800000,'cmo4m9m480185p5i2xz8gxkjm','cmo4m9m2e016fp5i2qqtzxwyg');
INSERT INTO BatchModule VALUES('cmo4m9m4i019hp5i2z8u5wh55',1776533651011,1776533651011,1801353600000,'cmo4m9m480185p5i2xz8gxkjm','cmo4m9m2f016hp5i23s4a4oho');
INSERT INTO BatchModule VALUES('cmo4m9m4j019jp5i2w8exm6fw',1776533651011,1776533651011,1793491200000,'cmo4m9m480185p5i2xz8gxkjm','cmo4m9m24015rp5i2634j2lcs');
INSERT INTO BatchModule VALUES('cmo4m9m4a0188p5i2cjbvtud3',1776533651002,1776533651002,1785628800000,'cmo4m9m480185p5i2xz8gxkjm','cmo4m9m1q0151p5i2qyn962pb');
INSERT INTO BatchModule VALUES('cmo4m9m4a018jp5i2madcu8ed',1776533651002,1776533651002,1791072000000,'cmo4m9m480185p5i2xz8gxkjm','cmo4m9m20015jp5i2g3i7gz0b');
INSERT INTO BatchModule VALUES('cmo4m9m4j019lp5i2mhiccktd',1776533651011,1776533651011,1791676800000,'cmo4m9m480185p5i2xz8gxkjm','cmo4m9m21015lp5i2pfvx1on5');
INSERT INTO BatchModule VALUES('cmo4m9m4j019np5i2on9itvgm',1776533651012,1776533651012,1792281600000,'cmo4m9m480185p5i2xz8gxkjm','cmo4m9m22015np5i2wajp4kjt');
INSERT INTO BatchModule VALUES('cmo4m9m4c018tp5i25nbyiv4x',1776533651004,1776533651004,1788048000000,'cmo4m9m480185p5i2xz8gxkjm','cmo4m9m1v0159p5i2pbd5ylk1');
INSERT INTO BatchModule VALUES('cmo4m9m4e018zp5i2q5lv7mi9',1776533651006,1776533651006,1797120000000,'cmo4m9m480185p5i2xz8gxkjm','cmo4m9m290163p5i21cqdcygw');
INSERT INTO BatchModule VALUES('cmo4m9m4a018kp5i2fjikcoej',1776533651002,1776533651002,1788652800000,'cmo4m9m480185p5i2xz8gxkjm','cmo4m9m1w015bp5i2vos624ya');
INSERT INTO BatchModule VALUES('cmo4m9m4a018ap5i2tkz9rvpd',1776533651002,1776533651002,1786233600000,'cmo4m9m480185p5i2xz8gxkjm','cmo4m9m1r0153p5i2ytp77dxq');
INSERT INTO BatchModule VALUES('cmo4m9m4a018lp5i28ojubaov',1776533651002,1776533651002,1792886400000,'cmo4m9m480185p5i2xz8gxkjm','cmo4m9m23015pp5i2gnl7dg2b');
INSERT INTO BatchModule VALUES('cmo4m9m5h019sp5i2socdsd19',1776533651046,1776533651046,1791072000000,'cmo4m9m5g019pp5i2je6r8oyv','cmo4m9m1q0151p5i2qyn962pb');
INSERT INTO BatchModule VALUES('cmo4m9m5i01a7p5i2141j5s0m',1776533651046,1776533651046,1800144000000,'cmo4m9m5g019pp5i2je6r8oyv','cmo4m9m26015vp5i2eqcfbe3t');
INSERT INTO BatchModule VALUES('cmo4m9m5i01a9p5i2uxqwtgu0',1776533651047,1776533651047,1801353600000,'cmo4m9m5g019pp5i2je6r8oyv','cmo4m9m27015zp5i2e17b4b0r');
INSERT INTO BatchModule VALUES('cmo4m9m5j01abp5i2rkftyike',1776533651047,1776533651047,1800748800000,'cmo4m9m5g019pp5i2je6r8oyv','cmo4m9m27015xp5i23c9t1q32');
INSERT INTO BatchModule VALUES('cmo4m9m5j01adp5i298i25iad',1776533651048,1776533651048,1801958400000,'cmo4m9m5g019pp5i2je6r8oyv','cmo4m9m280161p5i2vhsc5zf0');
INSERT INTO BatchModule VALUES('cmo4m9m5k01afp5i27b0ylkrz',1776533651048,1776533651048,1803168000000,'cmo4m9m5g019pp5i2je6r8oyv','cmo4m9m2a0165p5i2xvba44s4');
INSERT INTO BatchModule VALUES('cmo4m9m5k01ahp5i23k5norhg',1776533651049,1776533651049,1802563200000,'cmo4m9m5g019pp5i2je6r8oyv','cmo4m9m290163p5i21cqdcygw');
INSERT INTO BatchModule VALUES('cmo4m9m5h019up5i20slswdv8',1776533651046,1776533651046,1791676800000,'cmo4m9m5g019pp5i2je6r8oyv','cmo4m9m1r0153p5i2ytp77dxq');
INSERT INTO BatchModule VALUES('cmo4m9m5h019xp5i25k81l68i',1776533651046,1776533651046,1796515200000,'cmo4m9m5g019pp5i2je6r8oyv','cmo4m9m20015jp5i2g3i7gz0b');
INSERT INTO BatchModule VALUES('cmo4m9m5m01anp5i21zhp99q5',1776533651050,1776533651050,1804982400000,'cmo4m9m5g019pp5i2je6r8oyv','cmo4m9m2d016bp5i274uilbjn');
INSERT INTO BatchModule VALUES('cmo4m9m5m01app5i2cnq700dm',1776533651051,1776533651051,1797120000000,'cmo4m9m5g019pp5i2je6r8oyv','cmo4m9m21015lp5i2pfvx1on5');
INSERT INTO BatchModule VALUES('cmo4m9m5l01alp5i29nz40o0s',1776533651050,1776533651050,1804377600000,'cmo4m9m5g019pp5i2je6r8oyv','cmo4m9m2c0169p5i2sv1v8eag');
INSERT INTO BatchModule VALUES('cmo4m9m5n01atp5i2x4tev8py',1776533651051,1776533651051,1806192000000,'cmo4m9m5g019pp5i2je6r8oyv','cmo4m9m2e016fp5i2qqtzxwyg');
INSERT INTO BatchModule VALUES('cmo4m9m5n01avp5i2upx6m06n',1776533651052,1776533651052,1806796800000,'cmo4m9m5g019pp5i2je6r8oyv','cmo4m9m2f016hp5i23s4a4oho');
INSERT INTO BatchModule VALUES('cmo4m9m5o01axp5i2ydekbrxw',1776533651052,1776533651052,1795910400000,'cmo4m9m5g019pp5i2je6r8oyv','cmo4m9m1z015hp5i2ztxchh6c');
INSERT INTO BatchModule VALUES('cmo4m9m5o01azp5i2mbgkn4ja',1776533651053,1776533651053,1795305600000,'cmo4m9m5g019pp5i2je6r8oyv','cmo4m9m1y015fp5i2q36r3t76');
INSERT INTO BatchModule VALUES('cmo4m9m5p01b1p5i2nvsgfd57',1776533651053,1776533651053,1798934400000,'cmo4m9m5g019pp5i2je6r8oyv','cmo4m9m24015rp5i2634j2lcs');
INSERT INTO BatchModule VALUES('cmo4m9m5p01b3p5i28v50r44o',1776533651054,1776533651054,1793491200000,'cmo4m9m5g019pp5i2je6r8oyv','cmo4m9m1v0159p5i2pbd5ylk1');
INSERT INTO BatchModule VALUES('cmo4m9m5q01b5p5i21df826zy',1776533651046,1776533651046,1794700800000,'cmo4m9m5g019pp5i2je6r8oyv','cmo4m9m1x015dp5i2wbpzarcz');
INSERT INTO BatchModule VALUES('cmo4m9m5r01b7p5i2v3kfpio0',1776533651055,1776533651055,1797724800000,'cmo4m9m5g019pp5i2je6r8oyv','cmo4m9m22015np5i2wajp4kjt');
INSERT INTO BatchModule VALUES('cmo4m9m5h01a2p5i2p9rzd9rl',1776533651046,1776533651046,1798329600000,'cmo4m9m5g019pp5i2je6r8oyv','cmo4m9m23015pp5i2gnl7dg2b');
INSERT INTO BatchModule VALUES('cmo4m9m5l01ajp5i226vyz3ct',1776533651049,1776533651049,1803772800000,'cmo4m9m5g019pp5i2je6r8oyv','cmo4m9m2b0167p5i2zu922t2x');
INSERT INTO BatchModule VALUES('cmo4m9m5m01arp5i2u6ay9xw9',1776533651051,1776533651051,1805587200000,'cmo4m9m5g019pp5i2je6r8oyv','cmo4m9m2d016dp5i2nd3558qj');
INSERT INTO BatchModule VALUES('cmo4m9m5h019vp5i26v9677pv',1776533651046,1776533651046,1792281600000,'cmo4m9m5g019pp5i2je6r8oyv','cmo4m9m1t0155p5i27a7fu03b');
INSERT INTO BatchModule VALUES('cmo4m9m5h01a1p5i25yjwz3p4',1776533651046,1776533651046,1792886400000,'cmo4m9m5g019pp5i2je6r8oyv','cmo4m9m1u0157p5i2ngc7p1rk');
INSERT INTO BatchModule VALUES('cmo4m9m5h01a4p5i2sz2di5y3',1776533651046,1776533651046,1794096000000,'cmo4m9m5g019pp5i2je6r8oyv','cmo4m9m1w015bp5i2vos624ya');
INSERT INTO BatchModule VALUES('cmo4m9m5h01a5p5i2ncu1kdsb',1776533651046,1776533651046,1799539200000,'cmo4m9m5g019pp5i2je6r8oyv','cmo4m9m25015tp5i2s4739ci2');
INSERT INTO BatchModule VALUES('cmo4m9m7f01cxp5i2vww4ytxz',1776533651115,1776533651115,1781395200000,'cmo4m9m7d01cvp5i24gm3c53t','cmo4m9m6p01bbp5i22waex71a');
INSERT INTO BatchModule VALUES('cmo4m9m7f01ddp5i29qalel03',1776533651116,1776533651116,1791676800000,'cmo4m9m7d01cvp5i24gm3c53t','cmo4m9m7501c9p5i2aurll4rt');
INSERT INTO BatchModule VALUES('cmo4m9m7g01dfp5i2905hpkxd',1776533651116,1776533651116,1792886400000,'cmo4m9m7d01cvp5i24gm3c53t','cmo4m9m7701cdp5i2r7lt3v11');
INSERT INTO BatchModule VALUES('cmo4m9m7f01czp5i2ahcnjfpk',1776533651115,1776533651115,1783814400000,'cmo4m9m7d01cvp5i24gm3c53t','cmo4m9m6t01bjp5i2l6mj5g5p');
INSERT INTO BatchModule VALUES('cmo4m9m7g01djp5i2083ypido',1776533651117,1776533651117,1782000000000,'cmo4m9m7d01cvp5i24gm3c53t','cmo4m9m6q01bdp5i2iyk4i9az');
INSERT INTO BatchModule VALUES('cmo4m9m7h01dlp5i23nhnmhbr',1776533651117,1776533651117,1793491200000,'cmo4m9m7d01cvp5i24gm3c53t','cmo4m9m7701cfp5i2ys4ddmhk');
INSERT INTO BatchModule VALUES('cmo4m9m7h01dnp5i2ruj8rm36',1776533651118,1776533651118,1782604800000,'cmo4m9m7d01cvp5i24gm3c53t','cmo4m9m6r01bfp5i2mf0kkw3q');
INSERT INTO BatchModule VALUES('cmo4m9m7i01dpp5i2b7s41tqv',1776533651118,1776533651118,1794096000000,'cmo4m9m7d01cvp5i24gm3c53t','cmo4m9m7801chp5i267u89ae4');
INSERT INTO BatchModule VALUES('cmo4m9m7i01drp5i22rdg5vlj',1776533651118,1776533651118,1783209600000,'cmo4m9m7d01cvp5i24gm3c53t','cmo4m9m6s01bhp5i2je8hgcnp');
INSERT INTO BatchModule VALUES('cmo4m9m7f01d2p5i2zmus0yfw',1776533651115,1776533651115,1788048000000,'cmo4m9m7d01cvp5i24gm3c53t','cmo4m9m7001bxp5i2i5o50ukq');
INSERT INTO BatchModule VALUES('cmo4m9m7j01dvp5i2oltq06dw',1776533651119,1776533651119,1786838400000,'cmo4m9m7d01cvp5i24gm3c53t','cmo4m9m6y01btp5i2u5aevyx0');
INSERT INTO BatchModule VALUES('cmo4m9m7j01dxp5i2jrhnb7s2',1776533651120,1776533651120,1795305600000,'cmo4m9m7d01cvp5i24gm3c53t','cmo4m9m7a01clp5i2al2gti2t');
INSERT INTO BatchModule VALUES('cmo4m9m7k01dzp5i2t5856n98',1776533651120,1776533651120,1787443200000,'cmo4m9m7d01cvp5i24gm3c53t','cmo4m9m6z01bvp5i2yq1qlvlb');
INSERT INTO BatchModule VALUES('cmo4m9m7l01e1p5i201ljr5qx',1776533651121,1776533651121,1795910400000,'cmo4m9m7d01cvp5i24gm3c53t','cmo4m9m7a01cnp5i2bq6qayjg');
INSERT INTO BatchModule VALUES('cmo4m9m7l01e3p5i2sx0i52qo',1776533651122,1776533651122,1796515200000,'cmo4m9m7d01cvp5i24gm3c53t','cmo4m9m7b01cpp5i2jtvbiqep');
INSERT INTO BatchModule VALUES('cmo4m9m7m01e5p5i2i16da7c3',1776533651122,1776533651122,1797120000000,'cmo4m9m7d01cvp5i24gm3c53t','cmo4m9m7c01crp5i27ga9dmw5');
INSERT INTO BatchModule VALUES('cmo4m9m7m01e7p5i26sz2uzc1',1776533651122,1776533651122,1785024000000,'cmo4m9m7d01cvp5i24gm3c53t','cmo4m9m6v01bnp5i2pi8yc7dw');
INSERT INTO BatchModule VALUES('cmo4m9m7m01e9p5i2bp2e070g',1776533651123,1776533651123,1789257600000,'cmo4m9m7d01cvp5i24gm3c53t','cmo4m9m7101c1p5i2fqb9fsck');
INSERT INTO BatchModule VALUES('cmo4m9m7n01ebp5i2diy7ktrh',1776533651123,1776533651123,1790467200000,'cmo4m9m7d01cvp5i24gm3c53t','cmo4m9m7301c5p5i2dppper18');
INSERT INTO BatchModule VALUES('cmo4m9m7f01dap5i29fi9bk5x',1776533651115,1776533651115,1789862400000,'cmo4m9m7d01cvp5i24gm3c53t','cmo4m9m7201c3p5i2w3efnn94');
INSERT INTO BatchModule VALUES('cmo4m9m7f01d3p5i2ma9yvvs9',1776533651115,1776533651115,1788652800000,'cmo4m9m7d01cvp5i24gm3c53t','cmo4m9m7101bzp5i28vznbks7');
INSERT INTO BatchModule VALUES('cmo4m9m7n01edp5i2t2dhzkup',1776533651124,1776533651124,1785628800000,'cmo4m9m7d01cvp5i24gm3c53t','cmo4m9m6w01bpp5i2pjrkc6ap');
INSERT INTO BatchModule VALUES('cmo4m9m7g01dhp5i2jwgwpbop',1776533651116,1776533651116,1792281600000,'cmo4m9m7d01cvp5i24gm3c53t','cmo4m9m7601cbp5i23uca552g');
INSERT INTO BatchModule VALUES('cmo4m9m7i01dtp5i23of97fpb',1776533651119,1776533651119,1794700800000,'cmo4m9m7d01cvp5i24gm3c53t','cmo4m9m7901cjp5i2iquhr1qi');
INSERT INTO BatchModule VALUES('cmo4m9m7f01dbp5i2d6rjwt5s',1776533651115,1776533651115,1791072000000,'cmo4m9m7d01cvp5i24gm3c53t','cmo4m9m7401c7p5i2v2ge8ss3');
INSERT INTO BatchModule VALUES('cmo4m9m7f01d6p5i2d3rfjgj7',1776533651115,1776533651115,1784419200000,'cmo4m9m7d01cvp5i24gm3c53t','cmo4m9m6u01blp5i2brqkczj3');
INSERT INTO BatchModule VALUES('cmo4m9m7f01d7p5i2m0pb736t',1776533651115,1776533651115,1786233600000,'cmo4m9m7d01cvp5i24gm3c53t','cmo4m9m6x01brp5i2ma7be50t');
INSERT INTO BatchModule VALUES('cmo4m9m8k01elp5i2pbg02g53',1776533651156,1776533651156,1785628800000,'cmo4m9m8i01efp5i2qq280vxi','cmo4m9m6p01bbp5i22waex71a');
INSERT INTO BatchModule VALUES('cmo4m9m8l01exp5i2z6szmznr',1776533651157,1776533651157,1794096000000,'cmo4m9m8i01efp5i2qq280vxi','cmo4m9m7201c3p5i2w3efnn94');
INSERT INTO BatchModule VALUES('cmo4m9m8k01etp5i21s7b26p7',1776533651156,1776533651156,1790467200000,'cmo4m9m8i01efp5i2qq280vxi','cmo4m9m6x01brp5i2ma7be50t');
INSERT INTO BatchModule VALUES('cmo4m9m8n01f1p5i2wl2svm53',1776533651160,1776533651160,1795910400000,'cmo4m9m8i01efp5i2qq280vxi','cmo4m9m7501c9p5i2aurll4rt');
INSERT INTO BatchModule VALUES('cmo4m9m8k01esp5i293m5aecx',1776533651156,1776533651156,1787443200000,'cmo4m9m8i01efp5i2qq280vxi','cmo4m9m6s01bhp5i2je8hgcnp');
INSERT INTO BatchModule VALUES('cmo4m9m8o01f5p5i2fdufveh8',1776533651161,1776533651161,1797724800000,'cmo4m9m8i01efp5i2qq280vxi','cmo4m9m7701cfp5i2ys4ddmhk');
INSERT INTO BatchModule VALUES('cmo4m9m8p01f7p5i2mbluka9x',1776533651161,1776533651161,1788048000000,'cmo4m9m8i01efp5i2qq280vxi','cmo4m9m6t01bjp5i2l6mj5g5p');
INSERT INTO BatchModule VALUES('cmo4m9m8p01f9p5i2k9440ble',1776533651162,1776533651162,1798329600000,'cmo4m9m8i01efp5i2qq280vxi','cmo4m9m7801chp5i267u89ae4');
INSERT INTO BatchModule VALUES('cmo4m9m8q01fbp5i2duiipm8s',1776533651162,1776533651162,1798934400000,'cmo4m9m8i01efp5i2qq280vxi','cmo4m9m7901cjp5i2iquhr1qi');
INSERT INTO BatchModule VALUES('cmo4m9m8q01fdp5i2mrlz6nrn',1776533651163,1776533651163,1799539200000,'cmo4m9m8i01efp5i2qq280vxi','cmo4m9m7a01clp5i2al2gti2t');
INSERT INTO BatchModule VALUES('cmo4m9m8r01ffp5i2z2exzcr0',1776533651163,1776533651163,1800144000000,'cmo4m9m8i01efp5i2qq280vxi','cmo4m9m7a01cnp5i2bq6qayjg');
INSERT INTO BatchModule VALUES('cmo4m9m8o01f3p5i26ve5q422',1776533651160,1776533651160,1797120000000,'cmo4m9m8i01efp5i2qq280vxi','cmo4m9m7701cdp5i2r7lt3v11');
INSERT INTO BatchModule VALUES('cmo4m9m8s01fjp5i2c0g0kgf7',1776533651164,1776533651164,1796515200000,'cmo4m9m8i01efp5i2qq280vxi','cmo4m9m7601cbp5i23uca552g');
INSERT INTO BatchModule VALUES('cmo4m9m8s01flp5i29d9o9cei',1776533651165,1776533651165,1801353600000,'cmo4m9m8i01efp5i2qq280vxi','cmo4m9m7c01crp5i27ga9dmw5');
INSERT INTO BatchModule VALUES('cmo4m9m8k01evp5i21zf5pjh0',1776533651156,1776533651156,1791072000000,'cmo4m9m8i01efp5i2qq280vxi','cmo4m9m6y01btp5i2u5aevyx0');
INSERT INTO BatchModule VALUES('cmo4m9m8t01fpp5i2t6ui8ukb',1776533651166,1776533651166,1791676800000,'cmo4m9m8i01efp5i2qq280vxi','cmo4m9m6z01bvp5i2yq1qlvlb');
INSERT INTO BatchModule VALUES('cmo4m9m8u01frp5i2yrehcewy',1776533651166,1776533651166,1792281600000,'cmo4m9m8i01efp5i2qq280vxi','cmo4m9m7001bxp5i2i5o50ukq');
INSERT INTO BatchModule VALUES('cmo4m9m8u01ftp5i248ssmmnp',1776533651167,1776533651167,1789862400000,'cmo4m9m8i01efp5i2qq280vxi','cmo4m9m6w01bpp5i2pjrkc6ap');
INSERT INTO BatchModule VALUES('cmo4m9m8v01fvp5i2fca6qe9j',1776533651167,1776533651167,1795305600000,'cmo4m9m8i01efp5i2qq280vxi','cmo4m9m7401c7p5i2v2ge8ss3');
INSERT INTO BatchModule VALUES('cmo4m9m8v01fxp5i2fdhy5znd',1776533651168,1776533651168,1793491200000,'cmo4m9m8i01efp5i2qq280vxi','cmo4m9m7101c1p5i2fqb9fsck');
INSERT INTO BatchModule VALUES('cmo4m9m8t01fnp5i22555oi5c',1776533651165,1776533651165,1789257600000,'cmo4m9m8i01efp5i2qq280vxi','cmo4m9m6v01bnp5i2pi8yc7dw');
INSERT INTO BatchModule VALUES('cmo4m9m8r01fhp5i2lpx1sra0',1776533651164,1776533651164,1800748800000,'cmo4m9m8i01efp5i2qq280vxi','cmo4m9m7b01cpp5i2jtvbiqep');
INSERT INTO BatchModule VALUES('cmo4m9m8k01eup5i26i21sv9s',1776533651156,1776533651156,1792886400000,'cmo4m9m8i01efp5i2qq280vxi','cmo4m9m7101bzp5i28vznbks7');
INSERT INTO BatchModule VALUES('cmo4m9m8k01ekp5i2l6v60g2w',1776533651156,1776533651156,1786233600000,'cmo4m9m8i01efp5i2qq280vxi','cmo4m9m6q01bdp5i2iyk4i9az');
INSERT INTO BatchModule VALUES('cmo4m9m8l01ezp5i21gr30eem',1776533651158,1776533651158,1794700800000,'cmo4m9m8i01efp5i2qq280vxi','cmo4m9m7301c5p5i2dppper18');
INSERT INTO BatchModule VALUES('cmo4m9m8k01eop5i27geouh3o',1776533651156,1776533651156,1788652800000,'cmo4m9m8i01efp5i2qq280vxi','cmo4m9m6u01blp5i2brqkczj3');
INSERT INTO BatchModule VALUES('cmo4m9m8k01ejp5i2iad97pmf',1776533651156,1776533651156,1786838400000,'cmo4m9m8i01efp5i2qq280vxi','cmo4m9m6r01bfp5i2mf0kkw3q');
INSERT INTO BatchModule VALUES('cmo4m9mb801g1p5i2mpi7wpg5',1776533651252,1776533651252,1791072000000,'cmo4m9mb601fzp5i2ra41ls3v','cmo4m9m6p01bbp5i22waex71a');
INSERT INTO BatchModule VALUES('cmo4m9mb901ghp5i2sdkx0b3f',1776533651253,1776533651253,1800748800000,'cmo4m9mb601fzp5i2ra41ls3v','cmo4m9m7401c7p5i2v2ge8ss3');
INSERT INTO BatchModule VALUES('cmo4m9mb801g3p5i20k8yxdwa',1776533651253,1776533651253,1795305600000,'cmo4m9mb601fzp5i2ra41ls3v','cmo4m9m6w01bpp5i2pjrkc6ap');
INSERT INTO BatchModule VALUES('cmo4m9mba01glp5i20n757ve3',1776533651254,1776533651254,1802563200000,'cmo4m9mb601fzp5i2ra41ls3v','cmo4m9m7701cdp5i2r7lt3v11');
INSERT INTO BatchModule VALUES('cmo4m9mb901gjp5i20u2hv3nl',1776533651254,1776533651254,1801958400000,'cmo4m9mb601fzp5i2ra41ls3v','cmo4m9m7601cbp5i23uca552g');
INSERT INTO BatchModule VALUES('cmo4m9mbb01gpp5i23q9je9za',1776533651256,1776533651256,1801353600000,'cmo4m9mb601fzp5i2ra41ls3v','cmo4m9m7501c9p5i2aurll4rt');
INSERT INTO BatchModule VALUES('cmo4m9mb801g7p5i21o6wm8s0',1776533651253,1776533651253,1791676800000,'cmo4m9mb601fzp5i2ra41ls3v','cmo4m9m6q01bdp5i2iyk4i9az');
INSERT INTO BatchModule VALUES('cmo4m9mbc01gtp5i220jysuyu',1776533651257,1776533651257,1803772800000,'cmo4m9mb601fzp5i2ra41ls3v','cmo4m9m7801chp5i267u89ae4');
INSERT INTO BatchModule VALUES('cmo4m9mbd01gvp5i2qc9o3szu',1776533651257,1776533651257,1792281600000,'cmo4m9mb601fzp5i2ra41ls3v','cmo4m9m6r01bfp5i2mf0kkw3q');
INSERT INTO BatchModule VALUES('cmo4m9mbd01gxp5i2zffwi3kz',1776533651258,1776533651258,1804377600000,'cmo4m9mb601fzp5i2ra41ls3v','cmo4m9m7901cjp5i2iquhr1qi');
INSERT INTO BatchModule VALUES('cmo4m9mbe01gzp5i2o5sg564q',1776533651258,1776533651258,1804982400000,'cmo4m9mb601fzp5i2ra41ls3v','cmo4m9m7a01clp5i2al2gti2t');
INSERT INTO BatchModule VALUES('cmo4m9mbb01gnp5i2kpaturrq',1776533651255,1776533651255,1795910400000,'cmo4m9mb601fzp5i2ra41ls3v','cmo4m9m6x01brp5i2ma7be50t');
INSERT INTO BatchModule VALUES('cmo4m9mbf01h3p5i2kslvi3l5',1776533651259,1776533651259,1806192000000,'cmo4m9mb601fzp5i2ra41ls3v','cmo4m9m7b01cpp5i2jtvbiqep');
INSERT INTO BatchModule VALUES('cmo4m9mbf01h5p5i2cb6xktd4',1776533651260,1776533651260,1796515200000,'cmo4m9mb601fzp5i2ra41ls3v','cmo4m9m6y01btp5i2u5aevyx0');
INSERT INTO BatchModule VALUES('cmo4m9mbg01h7p5i27ik9xwbe',1776533651260,1776533651260,1806796800000,'cmo4m9mb601fzp5i2ra41ls3v','cmo4m9m7c01crp5i27ga9dmw5');
INSERT INTO BatchModule VALUES('cmo4m9mbg01h9p5i2vsoyacxd',1776533651261,1776533651261,1794096000000,'cmo4m9mb601fzp5i2ra41ls3v','cmo4m9m6u01blp5i2brqkczj3');
INSERT INTO BatchModule VALUES('cmo4m9mbh01hbp5i2cx0cc2io',1776533651261,1776533651261,1797724800000,'cmo4m9mb601fzp5i2ra41ls3v','cmo4m9m7001bxp5i2i5o50ukq');
INSERT INTO BatchModule VALUES('cmo4m9mb801gfp5i2uqcc9g22',1776533651253,1776533651253,1800144000000,'cmo4m9mb601fzp5i2ra41ls3v','cmo4m9m7301c5p5i2dppper18');
INSERT INTO BatchModule VALUES('cmo4m9mb801g8p5i2nhazv79r',1776533651253,1776533651253,1793491200000,'cmo4m9mb601fzp5i2ra41ls3v','cmo4m9m6t01bjp5i2l6mj5g5p');
INSERT INTO BatchModule VALUES('cmo4m9mbi01hhp5i26nd1woo3',1776533651263,1776533651263,1794700800000,'cmo4m9mb601fzp5i2ra41ls3v','cmo4m9m6v01bnp5i2pi8yc7dw');
INSERT INTO BatchModule VALUES('cmo4m9mbi01hfp5i2znzsc1xu',1776533651262,1776533651262,1798329600000,'cmo4m9mb601fzp5i2ra41ls3v','cmo4m9m7101bzp5i28vznbks7');
INSERT INTO BatchModule VALUES('cmo4m9mbh01hdp5i28tc8uab5',1776533651262,1776533651262,1799539200000,'cmo4m9mb601fzp5i2ra41ls3v','cmo4m9m7201c3p5i2w3efnn94');
INSERT INTO BatchModule VALUES('cmo4m9mbc01grp5i2vd6v1ql4',1776533651256,1776533651256,1803168000000,'cmo4m9mb601fzp5i2ra41ls3v','cmo4m9m7701cfp5i2ys4ddmhk');
INSERT INTO BatchModule VALUES('cmo4m9mbe01h1p5i25f8x3uzy',1776533651259,1776533651259,1805587200000,'cmo4m9mb601fzp5i2ra41ls3v','cmo4m9m7a01cnp5i2bq6qayjg');
INSERT INTO BatchModule VALUES('cmo4m9mb801gdp5i2a2gnv9f4',1776533651253,1776533651253,1798934400000,'cmo4m9mb601fzp5i2ra41ls3v','cmo4m9m7101c1p5i2fqb9fsck');
INSERT INTO BatchModule VALUES('cmo4m9mb801gbp5i26xz3avce',1776533651253,1776533651253,1792886400000,'cmo4m9mb601fzp5i2ra41ls3v','cmo4m9m6s01bhp5i2je8hgcnp');
INSERT INTO BatchModule VALUES('cmo4m9mb801gap5i2khowngn1',1776533651253,1776533651253,1797120000000,'cmo4m9mb601fzp5i2ra41ls3v','cmo4m9m6z01bvp5i2yq1qlvlb');

INSERT INTO _CourseCategoryToWhatYouWillGet VALUES('cmo4m9lcv0000p5i2r01c3zp5','cmo4m9lcw0001p5i21o9vg10e');
INSERT INTO _CourseCategoryToWhatYouWillGet VALUES('cmo4m9lcv0000p5i2r01c3zp5','cmo4m9lcw0002p5i2c1v3kuig');
INSERT INTO _CourseCategoryToWhatYouWillGet VALUES('cmo4m9lcv0000p5i2r01c3zp5','cmo4m9lcw0003p5i2vlrheg9n');
INSERT INTO _CourseCategoryToWhatYouWillGet VALUES('cmo4m9lcv0000p5i2r01c3zp5','cmo4m9lcw0004p5i23go84ev8');
INSERT INTO _CourseCategoryToWhatYouWillGet VALUES('cmo4m9lcv0000p5i2r01c3zp5','cmo4m9lcw0005p5i202jte1zq');
INSERT INTO _CourseCategoryToWhatYouWillGet VALUES('cmo4m9lcv0000p5i2r01c3zp5','cmo4m9lcw0006p5i2h7mxkm50');
INSERT INTO _CourseCategoryToWhatYouWillGet VALUES('cmo4m9lcv0000p5i2r01c3zp5','cmo4m9lcw0007p5i2pw75y5lz');
INSERT INTO _CourseCategoryToWhatYouWillGet VALUES('cmo4m9lcv0000p5i2r01c3zp5','cmo4m9lcw0008p5i2b7tgpnvi');

INSERT INTO _CoursePackageToSubject VALUES('cmo4m9lh000m5p5i2y81dh8vk','cmo4m9ld00009p5i2tn6ehitm');
INSERT INTO _CoursePackageToSubject VALUES('cmo4m9lh000m5p5i2y81dh8vk','cmo4m9ld0000ap5i26derw8ov');
INSERT INTO _CoursePackageToSubject VALUES('cmo4m9lh000m5p5i2y81dh8vk','cmo4m9ld0000bp5i2adbbrfma');
INSERT INTO _CoursePackageToSubject VALUES('cmo4m9lh000m5p5i2y81dh8vk','cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO _CoursePackageToSubject VALUES('cmo4m9lly00sfp5i2u4alokmb','cmo4m9ld00009p5i2tn6ehitm');
INSERT INTO _CoursePackageToSubject VALUES('cmo4m9lly00sfp5i2u4alokmb','cmo4m9ld0000dp5i2hzwakjmo');
INSERT INTO _CoursePackageToSubject VALUES('cmo4m9lly00sfp5i2u4alokmb','cmo4m9ld0000ep5i2wk1rv3yh');
INSERT INTO _CoursePackageToSubject VALUES('cmo4m9lly00sfp5i2u4alokmb','cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO _CoursePackageToSubject VALUES('cmo4m9lvr00ypp5i2937cd8i1','cmo4m9ld00009p5i2tn6ehitm');
INSERT INTO _CoursePackageToSubject VALUES('cmo4m9lvr00ypp5i2937cd8i1','cmo4m9ld0000dp5i2hzwakjmo');
INSERT INTO _CoursePackageToSubject VALUES('cmo4m9lvr00ypp5i2937cd8i1','cmo4m9ld0000fp5i2agm4gapx');
INSERT INTO _CoursePackageToSubject VALUES('cmo4m9lvr00ypp5i2937cd8i1','cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO _CoursePackageToSubject VALUES('cmo4m9m1p014zp5i2b1mk5lp3','cmo4m9ld00009p5i2tn6ehitm');
INSERT INTO _CoursePackageToSubject VALUES('cmo4m9m1p014zp5i2b1mk5lp3','cmo4m9ld0000dp5i2hzwakjmo');
INSERT INTO _CoursePackageToSubject VALUES('cmo4m9m1p014zp5i2b1mk5lp3','cmo4m9ld0000cp5i2ht9c3aij');
INSERT INTO _CoursePackageToSubject VALUES('cmo4m9m6n01b9p5i2qj5s0u10','cmo4m9ld00009p5i2tn6ehitm');
INSERT INTO _CoursePackageToSubject VALUES('cmo4m9m6n01b9p5i2qj5s0u10','cmo4m9ld0000ap5i26derw8ov');
INSERT INTO _CoursePackageToSubject VALUES('cmo4m9m6n01b9p5i2qj5s0u10','cmo4m9ld0000cp5i2ht9c3aij');

INSERT INTO _ModuleToTopic VALUES('cmo4m9lh100m7p5i2lcro404q','cmo4m9ld1000hp5i214ny4m5q');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh100m7p5i2lcro404q','cmo4m9ldl0035p5i2v5h8na33');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh100m7p5i2lcro404q','cmo4m9le10055p5i2x6a458th');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh100m7p5i2lcro404q','cmo4m9le20059p5i2b3wn7dwh');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh100m7p5i2lcro404q','cmo4m9lei007hp5i2irc09skw');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh100m7p5i2lcro404q','cmo4m9lej007lp5i2xzulwign');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh200m9p5i2w4p36o60','cmo4m9ld2000lp5i2uxzbtaak');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh200m9p5i2w4p36o60','cmo4m9ldm0039p5i27vfvpttc');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh200m9p5i2w4p36o60','cmo4m9le3005dp5i2cckf7qh7');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh200m9p5i2w4p36o60','cmo4m9lek007pp5i29jpfozoz');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh200m9p5i2w4p36o60','cmo4m9lel007tp5i29mpetr7j');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh300mbp5i29bswv0q2','cmo4m9ld3000pp5i26f1gi7xq');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh300mbp5i29bswv0q2','cmo4m9ldn003dp5i21filmr8x');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh300mbp5i29bswv0q2','cmo4m9lel007xp5i26f7jrvn0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh300mbp5i29bswv0q2','cmo4m9lem0081p5i20dm6zcol');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh400mdp5i2yuh69ai2','cmo4m9ld4000tp5i2r4um49wi');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh400mdp5i2yuh69ai2','cmo4m9le4005hp5i27vtvbccc');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh400mdp5i2yuh69ai2','cmo4m9len0085p5i2ccihnqtq');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh400mdp5i2yuh69ai2','cmo4m9leo0089p5i277f709pl');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh500mfp5i2v8w44b2g','cmo4m9ld5000xp5i2t0hyav7p');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh500mfp5i2v8w44b2g','cmo4m9ldo003hp5i2srfxg9n7');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh500mfp5i2v8w44b2g','cmo4m9le5005lp5i2ikpzlvg3');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh500mfp5i2v8w44b2g','cmo4m9lep008dp5i2jt87ex5x');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh500mfp5i2v8w44b2g','cmo4m9lep008hp5i2n6e5vng0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh500mhp5i292nv8qhq','cmo4m9ld60011p5i2s2cg6x92');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh500mhp5i292nv8qhq','cmo4m9ldo003lp5i29at6v7np');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh500mhp5i292nv8qhq','cmo4m9leq008lp5i2sri7qi7l');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh500mhp5i292nv8qhq','cmo4m9ler008pp5i2z5fqjieq');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh600mjp5i25hvhjroz','cmo4m9ld70015p5i2qfsm110d');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh600mjp5i25hvhjroz','cmo4m9le5005pp5i24c3aqr6g');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh600mjp5i25hvhjroz','cmo4m9les008tp5i2zbmymzak');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh600mjp5i25hvhjroz','cmo4m9les008xp5i2xdn6gmys');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh700mlp5i2d4lnmai1','cmo4m9ld70019p5i2vg87o8cb');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh700mlp5i2d4lnmai1','cmo4m9ldp003pp5i2ixziw7b4');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh700mlp5i2d4lnmai1','cmo4m9le6005tp5i2y44fmlia');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh700mlp5i2d4lnmai1','cmo4m9let0091p5i2iap1mo3s');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh700mlp5i2d4lnmai1','cmo4m9leu0095p5i2g80v7363');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh800mnp5i2ji7ahd4y','cmo4m9ld8001dp5i2rllm1y5c');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh800mnp5i2ji7ahd4y','cmo4m9leu0099p5i2ptbjyknr');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh800mnp5i2ji7ahd4y','cmo4m9lev009dp5i26axk6ttx');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh900mpp5i2tgi42hog','cmo4m9ld9001hp5i2rm3tykv9');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh900mpp5i2tgi42hog','cmo4m9ldr003tp5i27gzl0rkh');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh900mpp5i2tgi42hog','cmo4m9le7005xp5i2pflcit1j');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh900mpp5i2tgi42hog','cmo4m9lew009hp5i2ji6a80dr');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lh900mpp5i2tgi42hog','cmo4m9lex009lp5i28ntgwqr0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lha00mrp5i2gha7fr1l','cmo4m9ld9001lp5i21mj2m2xr');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lha00mrp5i2gha7fr1l','cmo4m9le80061p5i2026gwhum');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lha00mrp5i2gha7fr1l','cmo4m9ley009pp5i2842m09yv');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lha00mrp5i2gha7fr1l','cmo4m9ley009tp5i27vibnzlw');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lha00mtp5i2fhqye70g','cmo4m9lda001pp5i2r4ul1weo');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lha00mtp5i2fhqye70g','cmo4m9ldr003xp5i2f949fumm');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lha00mtp5i2fhqye70g','cmo4m9le90065p5i2lij2nqg9');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lha00mtp5i2fhqye70g','cmo4m9lez009xp5i2k972huw0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lha00mtp5i2fhqye70g','cmo4m9lf000a1p5i2o0be7834');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhb00mvp5i2rqth7xfa','cmo4m9ldb001tp5i279sgop2p');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhb00mvp5i2rqth7xfa','cmo4m9lds0041p5i2lnj8nd6o');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhb00mvp5i2rqth7xfa','cmo4m9lf000a5p5i2m9l2tmdw');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhb00mvp5i2rqth7xfa','cmo4m9lf100a9p5i2hmmkdjr6');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhb00mvp5i2rqth7xfa','cmo4m9lf200adp5i2ghr3q6hd');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhc00mxp5i24g9y9on8','cmo4m9ldc001xp5i2qd02ka8i');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhc00mxp5i24g9y9on8','cmo4m9lea0069p5i283dkbayb');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhc00mxp5i24g9y9on8','cmo4m9lf200ahp5i2wch90b7y');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhc00mxp5i24g9y9on8','cmo4m9lf300alp5i2z0km0m41');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhd00mzp5i2uwb91wrn','cmo4m9ldt0045p5i2if43o0fn');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhd00mzp5i2uwb91wrn','cmo4m9lea006dp5i2erfqvaly');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhd00mzp5i2uwb91wrn','cmo4m9lf300app5i2wd42rtmm');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhd00mzp5i2uwb91wrn','cmo4m9lf400atp5i2pcct8an4');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhe00n1p5i2t7lwubcf','cmo4m9ldd0021p5i2vqwh2lxd');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhe00n1p5i2t7lwubcf','cmo4m9ldu0049p5i2wojng6zc');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhe00n1p5i2t7lwubcf','cmo4m9lf400axp5i2p0i0lzdn');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhe00n1p5i2t7lwubcf','cmo4m9lf500b1p5i2w8zdchc4');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhe00n3p5i2fkdxwue6','cmo4m9ldd0025p5i218vweddo');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhe00n3p5i2fkdxwue6','cmo4m9leb006hp5i20duhq60u');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhe00n3p5i2fkdxwue6','cmo4m9lf600b5p5i24vbnz2fx');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhe00n3p5i2fkdxwue6','cmo4m9lf600b9p5i2t6qqbsr8');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhf00n5p5i2std5mnw0','cmo4m9lde0029p5i2owr35tan');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhf00n5p5i2std5mnw0','cmo4m9ldv004dp5i2cmf046l2');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhf00n5p5i2std5mnw0','cmo4m9lec006lp5i2x752qv8v');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhf00n5p5i2std5mnw0','cmo4m9lf700bdp5i2lfphci2q');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhf00n5p5i2std5mnw0','cmo4m9lf700bhp5i21mrggv98');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhg00n7p5i2t7gvm8xh','cmo4m9ldf002dp5i2fjldb0ul');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhg00n7p5i2t7gvm8xh','cmo4m9ldw004hp5i2bd9grdwh');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhg00n7p5i2t7gvm8xh','cmo4m9led006pp5i2ukymg4en');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhg00n7p5i2t7gvm8xh','cmo4m9lf800blp5i2xizmz7dn');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhg00n7p5i2t7gvm8xh','cmo4m9lf900bpp5i2pxxm0ynn');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhh00n9p5i2enu5iraq','cmo4m9ldg002hp5i2kqikj3fj');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhh00n9p5i2enu5iraq','cmo4m9lee006tp5i2laii3l8d');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhh00n9p5i2enu5iraq','cmo4m9lf900btp5i2z7l87jql');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhh00n9p5i2enu5iraq','cmo4m9lfa00bxp5i2u8p9ovfy');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhh00nbp5i201q6emd1','cmo4m9ldx004lp5i2ljx6mnf3');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhh00nbp5i201q6emd1','cmo4m9lee006xp5i2vuvqlpi8');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhh00nbp5i201q6emd1','cmo4m9lfb00c1p5i28gsejw41');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhh00nbp5i201q6emd1','cmo4m9lfb00c5p5i2udotqm1i');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhi00ndp5i2xkbvptjh','cmo4m9ldg002lp5i2bpemzue0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhi00ndp5i2xkbvptjh','cmo4m9ldy004pp5i2hv9twp31');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhi00ndp5i2xkbvptjh','cmo4m9lfc00c9p5i27nln5kfe');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhi00ndp5i2xkbvptjh','cmo4m9lfd00cdp5i2mun3mw4l');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhj00nfp5i2j2on3bpt','cmo4m9ldh002pp5i2it83x5yy');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhj00nfp5i2j2on3bpt','cmo4m9lef0071p5i2zwao1jeo');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhj00nfp5i2j2on3bpt','cmo4m9lfe00chp5i2jkpe9dmq');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhj00nfp5i2j2on3bpt','cmo4m9lff00clp5i20eep8wxn');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhj00nfp5i2j2on3bpt','cmo4m9lff00cpp5i2khr7rhko');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhj00nhp5i2tjp2d53s','cmo4m9ldi002tp5i2nxkn7hze');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhj00nhp5i2tjp2d53s','cmo4m9ldy004tp5i2tftt5v5r');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhj00nhp5i2tjp2d53s','cmo4m9leg0075p5i2actbg3hz');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhj00nhp5i2tjp2d53s','cmo4m9lfg00ctp5i2xlmswh64');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhj00nhp5i2tjp2d53s','cmo4m9lfg00cxp5i2esk45xfk');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhk00njp5i23btg5pyv','cmo4m9lfh00d1p5i2w04llk4f');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhk00njp5i23btg5pyv','cmo4m9lfi00d5p5i2fq97adtj');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhl00nlp5i2ecmx91ho','cmo4m9ldj002xp5i2qrlurp0l');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhl00nlp5i2ecmx91ho','cmo4m9ldz004xp5i22c5h0lz1');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhl00nlp5i2ecmx91ho','cmo4m9leh0079p5i2rhvwuumb');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhl00nlp5i2ecmx91ho','cmo4m9lfi00d9p5i2td1qx682');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhl00nlp5i2ecmx91ho','cmo4m9lfj00ddp5i2nmvn96qq');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhm00nnp5i2ihjd5jrz','cmo4m9ldk0031p5i2j5x7oo2j');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhm00nnp5i2ihjd5jrz','cmo4m9le00051p5i2d5uqw8dc');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhm00nnp5i2ihjd5jrz','cmo4m9lei007dp5i2fkjunymj');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhm00nnp5i2ihjd5jrz','cmo4m9lfj00dhp5i2l4tnq3d0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhm00nnp5i2ihjd5jrz','cmo4m9lfk00dlp5i2siakb62z');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lhm00nnp5i2ihjd5jrz','cmo4m9lfl00dpp5i2abghgxjs');
INSERT INTO _ModuleToTopic VALUES('cmo4m9llz00shp5i2n9t0ct16','cmo4m9ld1000hp5i214ny4m5q');
INSERT INTO _ModuleToTopic VALUES('cmo4m9llz00shp5i2n9t0ct16','cmo4m9lfl00dtp5i2qlzh8d89');
INSERT INTO _ModuleToTopic VALUES('cmo4m9llz00shp5i2n9t0ct16','cmo4m9lg300glp5i2nm8az2ey');
INSERT INTO _ModuleToTopic VALUES('cmo4m9llz00shp5i2n9t0ct16','cmo4m9lei007hp5i2irc09skw');
INSERT INTO _ModuleToTopic VALUES('cmo4m9llz00shp5i2n9t0ct16','cmo4m9lej007lp5i2xzulwign');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm000sjp5i2okua57t9','cmo4m9ld2000lp5i2uxzbtaak');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm000sjp5i2okua57t9','cmo4m9lfm00dxp5i2tnr0kzng');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm000sjp5i2okua57t9','cmo4m9lg300gpp5i2i1wymh0s');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm000sjp5i2okua57t9','cmo4m9lek007pp5i29jpfozoz');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm000sjp5i2okua57t9','cmo4m9lel007tp5i29mpetr7j');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm100slp5i2lmw2fdz6','cmo4m9ld3000pp5i26f1gi7xq');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm100slp5i2lmw2fdz6','cmo4m9lfn00e1p5i21n1upoop');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm100slp5i2lmw2fdz6','cmo4m9lg400gtp5i2dbys76e8');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm100slp5i2lmw2fdz6','cmo4m9lel007xp5i26f7jrvn0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm100slp5i2lmw2fdz6','cmo4m9lem0081p5i20dm6zcol');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm200snp5i2bvo6ld72','cmo4m9ld4000tp5i2r4um49wi');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm200snp5i2bvo6ld72','cmo4m9lfo00e5p5i2r4s00xu3');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm200snp5i2bvo6ld72','cmo4m9lg400gxp5i2r8pgfdft');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm200snp5i2bvo6ld72','cmo4m9len0085p5i2ccihnqtq');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm200snp5i2bvo6ld72','cmo4m9leo0089p5i277f709pl');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm400spp5i2zl2o3rl9','cmo4m9ld5000xp5i2t0hyav7p');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm400spp5i2zl2o3rl9','cmo4m9lfo00e9p5i2gsodzqg5');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm400spp5i2zl2o3rl9','cmo4m9lg500h1p5i21ruswwok');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm400spp5i2zl2o3rl9','cmo4m9lep008dp5i2jt87ex5x');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm400spp5i2zl2o3rl9','cmo4m9lep008hp5i2n6e5vng0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm500srp5i2j57qgdeg','cmo4m9ld60011p5i2s2cg6x92');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm500srp5i2j57qgdeg','cmo4m9lg500h5p5i2f9n29ou5');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm500srp5i2j57qgdeg','cmo4m9leq008lp5i2sri7qi7l');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm500srp5i2j57qgdeg','cmo4m9ler008pp5i2z5fqjieq');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm600stp5i2fxhcn4xr','cmo4m9ld70015p5i2qfsm110d');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm600stp5i2fxhcn4xr','cmo4m9lfp00edp5i25esbymu0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm600stp5i2fxhcn4xr','cmo4m9lg600h9p5i2m49lgd4n');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm600stp5i2fxhcn4xr','cmo4m9les008tp5i2zbmymzak');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm600stp5i2fxhcn4xr','cmo4m9les008xp5i2xdn6gmys');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm700svp5i23ekzr9gw','cmo4m9ld70019p5i2vg87o8cb');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm700svp5i23ekzr9gw','cmo4m9lfp00ehp5i2auy47bks');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm700svp5i23ekzr9gw','cmo4m9lg700hdp5i2vctmjidp');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm700svp5i23ekzr9gw','cmo4m9let0091p5i2iap1mo3s');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm700svp5i23ekzr9gw','cmo4m9leu0095p5i2g80v7363');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm800sxp5i208on6vb5','cmo4m9ld8001dp5i2rllm1y5c');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm800sxp5i208on6vb5','cmo4m9lfq00elp5i2g6x5vw59');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm800sxp5i208on6vb5','cmo4m9lg700hhp5i2s8ga1jwn');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm800sxp5i208on6vb5','cmo4m9leu0099p5i2ptbjyknr');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm800sxp5i208on6vb5','cmo4m9lev009dp5i26axk6ttx');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm800szp5i2r3bx7jau','cmo4m9ld9001hp5i2rm3tykv9');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm800szp5i2r3bx7jau','cmo4m9lg800hlp5i2sapxs5or');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm800szp5i2r3bx7jau','cmo4m9lew009hp5i2ji6a80dr');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm800szp5i2r3bx7jau','cmo4m9lex009lp5i28ntgwqr0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm900t1p5i2n55bl037','cmo4m9ld9001lp5i21mj2m2xr');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm900t1p5i2n55bl037','cmo4m9lfr00epp5i2nis3s2l9');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm900t1p5i2n55bl037','cmo4m9lg900hpp5i26jz1htoj');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm900t1p5i2n55bl037','cmo4m9ley009pp5i2842m09yv');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lm900t1p5i2n55bl037','cmo4m9ley009tp5i27vibnzlw');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmb00t3p5i2grpmyfst','cmo4m9lda001pp5i2r4ul1weo');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmb00t3p5i2grpmyfst','cmo4m9lfr00etp5i2lw32r5si');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmb00t3p5i2grpmyfst','cmo4m9lga00htp5i20uwd8gjk');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmb00t3p5i2grpmyfst','cmo4m9lez009xp5i2k972huw0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmb00t3p5i2grpmyfst','cmo4m9lf000a1p5i2o0be7834');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmc00t5p5i2x4kdnavz','cmo4m9ldb001tp5i279sgop2p');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmc00t5p5i2x4kdnavz','cmo4m9lfs00exp5i2s8ov7pk7');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmc00t5p5i2x4kdnavz','cmo4m9lgb00hxp5i20nlt2x9y');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmc00t5p5i2x4kdnavz','cmo4m9lf000a5p5i2m9l2tmdw');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmc00t5p5i2x4kdnavz','cmo4m9lf100a9p5i2hmmkdjr6');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmc00t5p5i2x4kdnavz','cmo4m9lf200adp5i2ghr3q6hd');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmd00t7p5i2lq0u6d81','cmo4m9ldc001xp5i2qd02ka8i');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmd00t7p5i2lq0u6d81','cmo4m9lft00f1p5i218fnbgt2');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmd00t7p5i2lq0u6d81','cmo4m9lgb00i1p5i2submrnde');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmd00t7p5i2lq0u6d81','cmo4m9lf200ahp5i2wch90b7y');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmd00t7p5i2lq0u6d81','cmo4m9lf300alp5i2z0km0m41');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lme00t9p5i2ptuqq170','cmo4m9lft00f5p5i2phanurmo');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lme00t9p5i2ptuqq170','cmo4m9lgc00i5p5i2d4wvot56');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lme00t9p5i2ptuqq170','cmo4m9lf300app5i2wd42rtmm');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lme00t9p5i2ptuqq170','cmo4m9lf400atp5i2pcct8an4');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmf00tbp5i2u4dvrcj0','cmo4m9ldd0021p5i2vqwh2lxd');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmf00tbp5i2u4dvrcj0','cmo4m9lfu00f9p5i27c946n8b');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmf00tbp5i2u4dvrcj0','cmo4m9lgc00i9p5i2ma3mfnpz');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmf00tbp5i2u4dvrcj0','cmo4m9lf400axp5i2p0i0lzdn');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmf00tbp5i2u4dvrcj0','cmo4m9lf500b1p5i2w8zdchc4');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmg00tdp5i2sh8b5jyc','cmo4m9ldd0025p5i218vweddo');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmg00tdp5i2sh8b5jyc','cmo4m9lfv00fdp5i239ou5amz');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmg00tdp5i2sh8b5jyc','cmo4m9lgd00idp5i2fyuhwz68');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmg00tdp5i2sh8b5jyc','cmo4m9lf600b5p5i24vbnz2fx');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmg00tdp5i2sh8b5jyc','cmo4m9lf600b9p5i2t6qqbsr8');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmh00tfp5i2rk1d7mbw','cmo4m9lde0029p5i2owr35tan');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmh00tfp5i2rk1d7mbw','cmo4m9lfw00fhp5i2nj0rn5sh');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmh00tfp5i2rk1d7mbw','cmo4m9lge00ihp5i2otnz9tz8');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmh00tfp5i2rk1d7mbw','cmo4m9lf700bdp5i2lfphci2q');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmh00tfp5i2rk1d7mbw','cmo4m9lf700bhp5i21mrggv98');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmi00thp5i2xpnwwl71','cmo4m9ldf002dp5i2fjldb0ul');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmi00thp5i2xpnwwl71','cmo4m9lfw00flp5i2x4cqp6es');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmi00thp5i2xpnwwl71','cmo4m9lge00ilp5i28gok29ig');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmi00thp5i2xpnwwl71','cmo4m9lf800blp5i2xizmz7dn');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmi00thp5i2xpnwwl71','cmo4m9lf900bpp5i2pxxm0ynn');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmj00tjp5i2c5r2xz21','cmo4m9ldg002hp5i2kqikj3fj');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmj00tjp5i2c5r2xz21','cmo4m9lfx00fpp5i2m3alj94h');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmj00tjp5i2c5r2xz21','cmo4m9lgf00ipp5i2kpw2hq91');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmj00tjp5i2c5r2xz21','cmo4m9lf900btp5i2z7l87jql');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmj00tjp5i2c5r2xz21','cmo4m9lfa00bxp5i2u8p9ovfy');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmk00tlp5i2evupki9x','cmo4m9lfy00ftp5i2xlwpeuqp');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmk00tlp5i2evupki9x','cmo4m9lgf00itp5i2luapx0bn');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmk00tlp5i2evupki9x','cmo4m9lfb00c1p5i28gsejw41');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmk00tlp5i2evupki9x','cmo4m9lfb00c5p5i2udotqm1i');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lml00tnp5i2go9k2ber','cmo4m9ldg002lp5i2bpemzue0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lml00tnp5i2go9k2ber','cmo4m9lfy00fxp5i2wwcn5og3');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lml00tnp5i2go9k2ber','cmo4m9lfc00c9p5i27nln5kfe');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lml00tnp5i2go9k2ber','cmo4m9lfd00cdp5i2mun3mw4l');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lml00tpp5i2g41nfoex','cmo4m9ldh002pp5i2it83x5yy');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lml00tpp5i2g41nfoex','cmo4m9lfz00g1p5i2gv649neq');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lml00tpp5i2g41nfoex','cmo4m9lgg00ixp5i2rkaxnhvu');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lml00tpp5i2g41nfoex','cmo4m9lfe00chp5i2jkpe9dmq');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lml00tpp5i2g41nfoex','cmo4m9lff00clp5i20eep8wxn');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lml00tpp5i2g41nfoex','cmo4m9lff00cpp5i2khr7rhko');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmm00trp5i2nr3zcq05','cmo4m9ldi002tp5i2nxkn7hze');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmm00trp5i2nr3zcq05','cmo4m9lg000g5p5i2lzc9z8f3');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmm00trp5i2nr3zcq05','cmo4m9lgh00j1p5i2s63abi2i');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmm00trp5i2nr3zcq05','cmo4m9lfg00ctp5i2xlmswh64');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmm00trp5i2nr3zcq05','cmo4m9lfg00cxp5i2esk45xfk');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmn00ttp5i2j9mjt9f1','cmo4m9lg000g9p5i2lncbt39m');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmn00ttp5i2j9mjt9f1','cmo4m9lgh00j5p5i2rn9w7wzn');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmn00ttp5i2j9mjt9f1','cmo4m9lfh00d1p5i2w04llk4f');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmn00ttp5i2j9mjt9f1','cmo4m9lfi00d5p5i2fq97adtj');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmn00tvp5i2387ocacn','cmo4m9ldj002xp5i2qrlurp0l');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmn00tvp5i2387ocacn','cmo4m9lg100gdp5i2yst72ye8');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmn00tvp5i2387ocacn','cmo4m9lgi00j9p5i21dea5v6m');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmn00tvp5i2387ocacn','cmo4m9lfi00d9p5i2td1qx682');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmn00tvp5i2387ocacn','cmo4m9lfj00ddp5i2nmvn96qq');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmo00txp5i2e4ks7y9i','cmo4m9ldk0031p5i2j5x7oo2j');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmo00txp5i2e4ks7y9i','cmo4m9lg200ghp5i2iace28g7');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmo00txp5i2e4ks7y9i','cmo4m9lgj00jdp5i233auxd83');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmo00txp5i2e4ks7y9i','cmo4m9lfj00dhp5i2l4tnq3d0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmo00txp5i2e4ks7y9i','cmo4m9lfk00dlp5i2siakb62z');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lmo00txp5i2e4ks7y9i','cmo4m9lfl00dpp5i2abghgxjs');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lvs00yrp5i2g6ibmefs','cmo4m9ld1000hp5i214ny4m5q');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lvs00yrp5i2g6ibmefs','cmo4m9lfl00dtp5i2qlzh8d89');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lvs00yrp5i2g6ibmefs','cmo4m9lgk00jhp5i2l86wg9lv');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lvs00yrp5i2g6ibmefs','cmo4m9lei007hp5i2irc09skw');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lvs00yrp5i2g6ibmefs','cmo4m9lej007lp5i2xzulwign');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lvv00ytp5i25n9rqry5','cmo4m9ld2000lp5i2uxzbtaak');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lvv00ytp5i25n9rqry5','cmo4m9lfm00dxp5i2tnr0kzng');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lvv00ytp5i25n9rqry5','cmo4m9lgk00jlp5i25n4fr865');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lvv00ytp5i25n9rqry5','cmo4m9lek007pp5i29jpfozoz');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lvv00ytp5i25n9rqry5','cmo4m9lel007tp5i29mpetr7j');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lw400yvp5i2re5lh9nu','cmo4m9ld3000pp5i26f1gi7xq');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lw400yvp5i2re5lh9nu','cmo4m9lfn00e1p5i21n1upoop');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lw400yvp5i2re5lh9nu','cmo4m9lel007xp5i26f7jrvn0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lw400yvp5i2re5lh9nu','cmo4m9lem0081p5i20dm6zcol');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lw500yxp5i21b74tsgs','cmo4m9ld4000tp5i2r4um49wi');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lw500yxp5i21b74tsgs','cmo4m9lfo00e5p5i2r4s00xu3');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lw500yxp5i21b74tsgs','cmo4m9lgl00jpp5i2v1gaym99');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lw500yxp5i21b74tsgs','cmo4m9len0085p5i2ccihnqtq');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lw500yxp5i21b74tsgs','cmo4m9leo0089p5i277f709pl');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lw600yzp5i2yjpn8qww','cmo4m9ld5000xp5i2t0hyav7p');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lw600yzp5i2yjpn8qww','cmo4m9lfo00e9p5i2gsodzqg5');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lw600yzp5i2yjpn8qww','cmo4m9lgl00jtp5i2az5eyonw');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lw600yzp5i2yjpn8qww','cmo4m9lep008dp5i2jt87ex5x');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lw600yzp5i2yjpn8qww','cmo4m9lep008hp5i2n6e5vng0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lw700z1p5i2475utv2s','cmo4m9ld60011p5i2s2cg6x92');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lw700z1p5i2475utv2s','cmo4m9leq008lp5i2sri7qi7l');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lw700z1p5i2475utv2s','cmo4m9ler008pp5i2z5fqjieq');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lw800z3p5i264uobqoa','cmo4m9ld70015p5i2qfsm110d');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lw800z3p5i264uobqoa','cmo4m9lfp00edp5i25esbymu0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lw800z3p5i264uobqoa','cmo4m9lgm00jxp5i29hmn318u');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lw800z3p5i264uobqoa','cmo4m9les008tp5i2zbmymzak');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lw800z3p5i264uobqoa','cmo4m9les008xp5i2xdn6gmys');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lw900z5p5i2qprjja7p','cmo4m9ld70019p5i2vg87o8cb');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lw900z5p5i2qprjja7p','cmo4m9lfp00ehp5i2auy47bks');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lw900z5p5i2qprjja7p','cmo4m9lgm00k1p5i2qwx5kklu');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lw900z5p5i2qprjja7p','cmo4m9let0091p5i2iap1mo3s');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lw900z5p5i2qprjja7p','cmo4m9leu0095p5i2g80v7363');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwa00z7p5i28hq16f9l','cmo4m9ld8001dp5i2rllm1y5c');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwa00z7p5i28hq16f9l','cmo4m9lfq00elp5i2g6x5vw59');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwa00z7p5i28hq16f9l','cmo4m9leu0099p5i2ptbjyknr');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwa00z7p5i28hq16f9l','cmo4m9lev009dp5i26axk6ttx');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwa00z9p5i2x78jkirf','cmo4m9ld9001hp5i2rm3tykv9');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwa00z9p5i2x78jkirf','cmo4m9lgn00k5p5i2372vbgdn');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwa00z9p5i2x78jkirf','cmo4m9lew009hp5i2ji6a80dr');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwa00z9p5i2x78jkirf','cmo4m9lex009lp5i28ntgwqr0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwb00zbp5i201w3j2aj','cmo4m9ld9001lp5i21mj2m2xr');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwb00zbp5i201w3j2aj','cmo4m9lfr00epp5i2nis3s2l9');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwb00zbp5i201w3j2aj','cmo4m9lgn00k9p5i2blzaol2j');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwb00zbp5i201w3j2aj','cmo4m9ley009pp5i2842m09yv');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwb00zbp5i201w3j2aj','cmo4m9ley009tp5i27vibnzlw');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwc00zdp5i25cyyr9mh','cmo4m9lda001pp5i2r4ul1weo');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwc00zdp5i25cyyr9mh','cmo4m9lfr00etp5i2lw32r5si');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwc00zdp5i25cyyr9mh','cmo4m9lgo00kdp5i210cnnwc9');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwc00zdp5i25cyyr9mh','cmo4m9lez009xp5i2k972huw0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwc00zdp5i25cyyr9mh','cmo4m9lf000a1p5i2o0be7834');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwd00zfp5i2t1am2qlr','cmo4m9ldb001tp5i279sgop2p');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwd00zfp5i2t1am2qlr','cmo4m9lfs00exp5i2s8ov7pk7');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwd00zfp5i2t1am2qlr','cmo4m9lgp00khp5i2gwrmg7pv');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwd00zfp5i2t1am2qlr','cmo4m9lf000a5p5i2m9l2tmdw');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwd00zfp5i2t1am2qlr','cmo4m9lf100a9p5i2hmmkdjr6');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwd00zfp5i2t1am2qlr','cmo4m9lf200adp5i2ghr3q6hd');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwe00zhp5i25xxijmfr','cmo4m9ldc001xp5i2qd02ka8i');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwe00zhp5i25xxijmfr','cmo4m9lft00f1p5i218fnbgt2');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwe00zhp5i25xxijmfr','cmo4m9lgp00klp5i2znauy7oa');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwe00zhp5i25xxijmfr','cmo4m9lf200ahp5i2wch90b7y');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwe00zhp5i25xxijmfr','cmo4m9lf300alp5i2z0km0m41');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwe00zjp5i2xu9tigze','cmo4m9lft00f5p5i2phanurmo');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwe00zjp5i2xu9tigze','cmo4m9lgq00kpp5i2nt1t94fa');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwe00zjp5i2xu9tigze','cmo4m9lf300app5i2wd42rtmm');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwe00zjp5i2xu9tigze','cmo4m9lf400atp5i2pcct8an4');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwf00zlp5i2ry515nyk','cmo4m9ldd0021p5i2vqwh2lxd');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwf00zlp5i2ry515nyk','cmo4m9lfu00f9p5i27c946n8b');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwf00zlp5i2ry515nyk','cmo4m9lgq00ktp5i2r4facq08');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwf00zlp5i2ry515nyk','cmo4m9lf400axp5i2p0i0lzdn');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwf00zlp5i2ry515nyk','cmo4m9lf500b1p5i2w8zdchc4');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwg00znp5i2meahrdwm','cmo4m9ldd0025p5i218vweddo');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwg00znp5i2meahrdwm','cmo4m9lfv00fdp5i239ou5amz');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwg00znp5i2meahrdwm','cmo4m9lgr00kxp5i25xw8lnpw');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwg00znp5i2meahrdwm','cmo4m9lf600b5p5i24vbnz2fx');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwg00znp5i2meahrdwm','cmo4m9lf600b9p5i2t6qqbsr8');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwh00zpp5i20cdewl5h','cmo4m9lde0029p5i2owr35tan');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwh00zpp5i20cdewl5h','cmo4m9lfw00fhp5i2nj0rn5sh');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwh00zpp5i20cdewl5h','cmo4m9lgs00l1p5i2yresk7m3');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwh00zpp5i20cdewl5h','cmo4m9lf700bdp5i2lfphci2q');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwh00zpp5i20cdewl5h','cmo4m9lf700bhp5i21mrggv98');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwi00zrp5i2ag225sl2','cmo4m9ldf002dp5i2fjldb0ul');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwi00zrp5i2ag225sl2','cmo4m9lfw00flp5i2x4cqp6es');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwi00zrp5i2ag225sl2','cmo4m9lgt00l5p5i2oveamb50');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwi00zrp5i2ag225sl2','cmo4m9lf800blp5i2xizmz7dn');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwi00zrp5i2ag225sl2','cmo4m9lf900bpp5i2pxxm0ynn');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwj00ztp5i2be5qxagh','cmo4m9ldg002hp5i2kqikj3fj');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwj00ztp5i2be5qxagh','cmo4m9lfx00fpp5i2m3alj94h');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwj00ztp5i2be5qxagh','cmo4m9lgu00l9p5i2ro1lupvo');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwj00ztp5i2be5qxagh','cmo4m9lf900btp5i2z7l87jql');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwj00ztp5i2be5qxagh','cmo4m9lfa00bxp5i2u8p9ovfy');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwk00zvp5i2wxcr9e1d','cmo4m9lfy00ftp5i2xlwpeuqp');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwk00zvp5i2wxcr9e1d','cmo4m9lgv00ldp5i2fis9uuna');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwk00zvp5i2wxcr9e1d','cmo4m9lfb00c1p5i28gsejw41');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwk00zvp5i2wxcr9e1d','cmo4m9lfb00c5p5i2udotqm1i');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwk00zxp5i2j1diytbh','cmo4m9ldg002lp5i2bpemzue0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwk00zxp5i2j1diytbh','cmo4m9lfy00fxp5i2wwcn5og3');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwk00zxp5i2j1diytbh','cmo4m9lgw00lhp5i2u1wuml5t');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwk00zxp5i2j1diytbh','cmo4m9lfc00c9p5i27nln5kfe');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwk00zxp5i2j1diytbh','cmo4m9lfd00cdp5i2mun3mw4l');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwl00zzp5i29kmfymdf','cmo4m9ldh002pp5i2it83x5yy');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwl00zzp5i29kmfymdf','cmo4m9lfz00g1p5i2gv649neq');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwl00zzp5i29kmfymdf','cmo4m9lgw00llp5i2n4glf9qz');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwl00zzp5i29kmfymdf','cmo4m9lfe00chp5i2jkpe9dmq');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwl00zzp5i29kmfymdf','cmo4m9lff00clp5i20eep8wxn');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwl00zzp5i29kmfymdf','cmo4m9lff00cpp5i2khr7rhko');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwm0101p5i22lt0wyk1','cmo4m9ldi002tp5i2nxkn7hze');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwm0101p5i22lt0wyk1','cmo4m9lg000g5p5i2lzc9z8f3');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwm0101p5i22lt0wyk1','cmo4m9lgx00lpp5i2b1aen8vh');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwm0101p5i22lt0wyk1','cmo4m9lfg00ctp5i2xlmswh64');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwm0101p5i22lt0wyk1','cmo4m9lfg00cxp5i2esk45xfk');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwn0103p5i2rxmkcmgt','cmo4m9lg000g9p5i2lncbt39m');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwn0103p5i2rxmkcmgt','cmo4m9lgy00ltp5i2v1t7nynn');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwn0103p5i2rxmkcmgt','cmo4m9lfh00d1p5i2w04llk4f');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwn0103p5i2rxmkcmgt','cmo4m9lfi00d5p5i2fq97adtj');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwn0105p5i2t3j985hn','cmo4m9ldj002xp5i2qrlurp0l');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwn0105p5i2t3j985hn','cmo4m9lg100gdp5i2yst72ye8');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwn0105p5i2t3j985hn','cmo4m9lgy00lxp5i2391s776h');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwn0105p5i2t3j985hn','cmo4m9lfi00d9p5i2td1qx682');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwn0105p5i2t3j985hn','cmo4m9lfj00ddp5i2nmvn96qq');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwo0107p5i252bvjlti','cmo4m9ldk0031p5i2j5x7oo2j');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwo0107p5i252bvjlti','cmo4m9lg200ghp5i2iace28g7');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwo0107p5i252bvjlti','cmo4m9lgz00m1p5i2f3e6vigd');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwo0107p5i252bvjlti','cmo4m9lfj00dhp5i2l4tnq3d0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwo0107p5i252bvjlti','cmo4m9lfk00dlp5i2siakb62z');
INSERT INTO _ModuleToTopic VALUES('cmo4m9lwo0107p5i252bvjlti','cmo4m9lfl00dpp5i2abghgxjs');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1q0151p5i2qyn962pb','cmo4m9ld1000hp5i214ny4m5q');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1q0151p5i2qyn962pb','cmo4m9lfl00dtp5i2qlzh8d89');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1q0151p5i2qyn962pb','cmo4m9lei007hp5i2irc09skw');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1q0151p5i2qyn962pb','cmo4m9lej007lp5i2xzulwign');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1r0153p5i2ytp77dxq','cmo4m9ld2000lp5i2uxzbtaak');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1r0153p5i2ytp77dxq','cmo4m9lfm00dxp5i2tnr0kzng');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1r0153p5i2ytp77dxq','cmo4m9lek007pp5i29jpfozoz');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1r0153p5i2ytp77dxq','cmo4m9lel007tp5i29mpetr7j');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1t0155p5i27a7fu03b','cmo4m9ld3000pp5i26f1gi7xq');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1t0155p5i27a7fu03b','cmo4m9lfn00e1p5i21n1upoop');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1t0155p5i27a7fu03b','cmo4m9lel007xp5i26f7jrvn0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1t0155p5i27a7fu03b','cmo4m9lem0081p5i20dm6zcol');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1u0157p5i2ngc7p1rk','cmo4m9ld4000tp5i2r4um49wi');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1u0157p5i2ngc7p1rk','cmo4m9lfo00e5p5i2r4s00xu3');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1u0157p5i2ngc7p1rk','cmo4m9len0085p5i2ccihnqtq');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1u0157p5i2ngc7p1rk','cmo4m9leo0089p5i277f709pl');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1v0159p5i2pbd5ylk1','cmo4m9ld5000xp5i2t0hyav7p');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1v0159p5i2pbd5ylk1','cmo4m9lfo00e9p5i2gsodzqg5');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1v0159p5i2pbd5ylk1','cmo4m9lep008dp5i2jt87ex5x');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1v0159p5i2pbd5ylk1','cmo4m9lep008hp5i2n6e5vng0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1w015bp5i2vos624ya','cmo4m9ld60011p5i2s2cg6x92');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1w015bp5i2vos624ya','cmo4m9leq008lp5i2sri7qi7l');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1w015bp5i2vos624ya','cmo4m9ler008pp5i2z5fqjieq');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1x015dp5i2wbpzarcz','cmo4m9ld70015p5i2qfsm110d');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1x015dp5i2wbpzarcz','cmo4m9lfp00edp5i25esbymu0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1x015dp5i2wbpzarcz','cmo4m9les008tp5i2zbmymzak');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1x015dp5i2wbpzarcz','cmo4m9les008xp5i2xdn6gmys');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1y015fp5i2q36r3t76','cmo4m9ld70019p5i2vg87o8cb');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1y015fp5i2q36r3t76','cmo4m9lfp00ehp5i2auy47bks');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1y015fp5i2q36r3t76','cmo4m9let0091p5i2iap1mo3s');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1y015fp5i2q36r3t76','cmo4m9leu0095p5i2g80v7363');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1z015hp5i2ztxchh6c','cmo4m9ld8001dp5i2rllm1y5c');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1z015hp5i2ztxchh6c','cmo4m9lfq00elp5i2g6x5vw59');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1z015hp5i2ztxchh6c','cmo4m9leu0099p5i2ptbjyknr');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m1z015hp5i2ztxchh6c','cmo4m9lev009dp5i26axk6ttx');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m20015jp5i2g3i7gz0b','cmo4m9ld9001hp5i2rm3tykv9');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m20015jp5i2g3i7gz0b','cmo4m9lew009hp5i2ji6a80dr');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m20015jp5i2g3i7gz0b','cmo4m9lex009lp5i28ntgwqr0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m21015lp5i2pfvx1on5','cmo4m9ld9001lp5i21mj2m2xr');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m21015lp5i2pfvx1on5','cmo4m9lfr00epp5i2nis3s2l9');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m21015lp5i2pfvx1on5','cmo4m9ley009pp5i2842m09yv');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m21015lp5i2pfvx1on5','cmo4m9ley009tp5i27vibnzlw');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m22015np5i2wajp4kjt','cmo4m9lda001pp5i2r4ul1weo');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m22015np5i2wajp4kjt','cmo4m9lfr00etp5i2lw32r5si');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m22015np5i2wajp4kjt','cmo4m9lez009xp5i2k972huw0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m22015np5i2wajp4kjt','cmo4m9lf000a1p5i2o0be7834');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m23015pp5i2gnl7dg2b','cmo4m9ldb001tp5i279sgop2p');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m23015pp5i2gnl7dg2b','cmo4m9lfs00exp5i2s8ov7pk7');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m23015pp5i2gnl7dg2b','cmo4m9lf000a5p5i2m9l2tmdw');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m23015pp5i2gnl7dg2b','cmo4m9lf100a9p5i2hmmkdjr6');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m23015pp5i2gnl7dg2b','cmo4m9lf200adp5i2ghr3q6hd');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m24015rp5i2634j2lcs','cmo4m9ldc001xp5i2qd02ka8i');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m24015rp5i2634j2lcs','cmo4m9lft00f1p5i218fnbgt2');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m24015rp5i2634j2lcs','cmo4m9lf200ahp5i2wch90b7y');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m24015rp5i2634j2lcs','cmo4m9lf300alp5i2z0km0m41');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m25015tp5i2s4739ci2','cmo4m9lft00f5p5i2phanurmo');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m25015tp5i2s4739ci2','cmo4m9lf300app5i2wd42rtmm');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m25015tp5i2s4739ci2','cmo4m9lf400atp5i2pcct8an4');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m26015vp5i2eqcfbe3t','cmo4m9ldd0021p5i2vqwh2lxd');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m26015vp5i2eqcfbe3t','cmo4m9lfu00f9p5i27c946n8b');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m26015vp5i2eqcfbe3t','cmo4m9lf400axp5i2p0i0lzdn');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m26015vp5i2eqcfbe3t','cmo4m9lf500b1p5i2w8zdchc4');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m27015xp5i23c9t1q32','cmo4m9ldd0025p5i218vweddo');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m27015xp5i23c9t1q32','cmo4m9lfv00fdp5i239ou5amz');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m27015xp5i23c9t1q32','cmo4m9lf600b5p5i24vbnz2fx');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m27015xp5i23c9t1q32','cmo4m9lf600b9p5i2t6qqbsr8');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m27015zp5i2e17b4b0r','cmo4m9lde0029p5i2owr35tan');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m27015zp5i2e17b4b0r','cmo4m9lfw00fhp5i2nj0rn5sh');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m27015zp5i2e17b4b0r','cmo4m9lf700bdp5i2lfphci2q');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m27015zp5i2e17b4b0r','cmo4m9lf700bhp5i21mrggv98');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m280161p5i2vhsc5zf0','cmo4m9ldf002dp5i2fjldb0ul');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m280161p5i2vhsc5zf0','cmo4m9lfw00flp5i2x4cqp6es');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m280161p5i2vhsc5zf0','cmo4m9lf800blp5i2xizmz7dn');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m280161p5i2vhsc5zf0','cmo4m9lf900bpp5i2pxxm0ynn');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m290163p5i21cqdcygw','cmo4m9ldg002hp5i2kqikj3fj');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m290163p5i21cqdcygw','cmo4m9lfx00fpp5i2m3alj94h');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m290163p5i21cqdcygw','cmo4m9lf900btp5i2z7l87jql');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m290163p5i21cqdcygw','cmo4m9lfa00bxp5i2u8p9ovfy');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m2a0165p5i2xvba44s4','cmo4m9lfy00ftp5i2xlwpeuqp');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m2a0165p5i2xvba44s4','cmo4m9lfb00c1p5i28gsejw41');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m2a0165p5i2xvba44s4','cmo4m9lfb00c5p5i2udotqm1i');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m2b0167p5i2zu922t2x','cmo4m9ldg002lp5i2bpemzue0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m2b0167p5i2zu922t2x','cmo4m9lfy00fxp5i2wwcn5og3');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m2b0167p5i2zu922t2x','cmo4m9lfc00c9p5i27nln5kfe');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m2b0167p5i2zu922t2x','cmo4m9lfd00cdp5i2mun3mw4l');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m2c0169p5i2sv1v8eag','cmo4m9ldh002pp5i2it83x5yy');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m2c0169p5i2sv1v8eag','cmo4m9lfz00g1p5i2gv649neq');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m2c0169p5i2sv1v8eag','cmo4m9lfe00chp5i2jkpe9dmq');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m2c0169p5i2sv1v8eag','cmo4m9lff00clp5i20eep8wxn');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m2c0169p5i2sv1v8eag','cmo4m9lff00cpp5i2khr7rhko');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m2d016bp5i274uilbjn','cmo4m9ldi002tp5i2nxkn7hze');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m2d016bp5i274uilbjn','cmo4m9lg000g5p5i2lzc9z8f3');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m2d016bp5i274uilbjn','cmo4m9lfg00ctp5i2xlmswh64');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m2d016bp5i274uilbjn','cmo4m9lfg00cxp5i2esk45xfk');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m2d016dp5i2nd3558qj','cmo4m9lg000g9p5i2lncbt39m');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m2d016dp5i2nd3558qj','cmo4m9lfh00d1p5i2w04llk4f');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m2d016dp5i2nd3558qj','cmo4m9lfi00d5p5i2fq97adtj');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m2e016fp5i2qqtzxwyg','cmo4m9ldj002xp5i2qrlurp0l');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m2e016fp5i2qqtzxwyg','cmo4m9lg100gdp5i2yst72ye8');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m2e016fp5i2qqtzxwyg','cmo4m9lfi00d9p5i2td1qx682');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m2e016fp5i2qqtzxwyg','cmo4m9lfj00ddp5i2nmvn96qq');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m2f016hp5i23s4a4oho','cmo4m9ldk0031p5i2j5x7oo2j');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m2f016hp5i23s4a4oho','cmo4m9lg200ghp5i2iace28g7');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m2f016hp5i23s4a4oho','cmo4m9lfj00dhp5i2l4tnq3d0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m2f016hp5i23s4a4oho','cmo4m9lfk00dlp5i2siakb62z');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m2f016hp5i23s4a4oho','cmo4m9lfl00dpp5i2abghgxjs');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6p01bbp5i22waex71a','cmo4m9ld1000hp5i214ny4m5q');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6p01bbp5i22waex71a','cmo4m9ldl0035p5i2v5h8na33');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6p01bbp5i22waex71a','cmo4m9lei007hp5i2irc09skw');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6p01bbp5i22waex71a','cmo4m9lej007lp5i2xzulwign');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6q01bdp5i2iyk4i9az','cmo4m9ld2000lp5i2uxzbtaak');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6q01bdp5i2iyk4i9az','cmo4m9ldm0039p5i27vfvpttc');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6q01bdp5i2iyk4i9az','cmo4m9lek007pp5i29jpfozoz');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6q01bdp5i2iyk4i9az','cmo4m9lel007tp5i29mpetr7j');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6r01bfp5i2mf0kkw3q','cmo4m9ld3000pp5i26f1gi7xq');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6r01bfp5i2mf0kkw3q','cmo4m9ldn003dp5i21filmr8x');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6r01bfp5i2mf0kkw3q','cmo4m9lel007xp5i26f7jrvn0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6r01bfp5i2mf0kkw3q','cmo4m9lem0081p5i20dm6zcol');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6s01bhp5i2je8hgcnp','cmo4m9ld4000tp5i2r4um49wi');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6s01bhp5i2je8hgcnp','cmo4m9len0085p5i2ccihnqtq');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6s01bhp5i2je8hgcnp','cmo4m9leo0089p5i277f709pl');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6t01bjp5i2l6mj5g5p','cmo4m9ld5000xp5i2t0hyav7p');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6t01bjp5i2l6mj5g5p','cmo4m9ldo003hp5i2srfxg9n7');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6t01bjp5i2l6mj5g5p','cmo4m9lep008dp5i2jt87ex5x');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6t01bjp5i2l6mj5g5p','cmo4m9lep008hp5i2n6e5vng0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6u01blp5i2brqkczj3','cmo4m9ld60011p5i2s2cg6x92');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6u01blp5i2brqkczj3','cmo4m9ldo003lp5i29at6v7np');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6u01blp5i2brqkczj3','cmo4m9leq008lp5i2sri7qi7l');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6u01blp5i2brqkczj3','cmo4m9ler008pp5i2z5fqjieq');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6v01bnp5i2pi8yc7dw','cmo4m9ld70015p5i2qfsm110d');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6v01bnp5i2pi8yc7dw','cmo4m9les008tp5i2zbmymzak');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6v01bnp5i2pi8yc7dw','cmo4m9les008xp5i2xdn6gmys');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6w01bpp5i2pjrkc6ap','cmo4m9ld70019p5i2vg87o8cb');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6w01bpp5i2pjrkc6ap','cmo4m9ldp003pp5i2ixziw7b4');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6w01bpp5i2pjrkc6ap','cmo4m9let0091p5i2iap1mo3s');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6w01bpp5i2pjrkc6ap','cmo4m9leu0095p5i2g80v7363');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6x01brp5i2ma7be50t','cmo4m9ld8001dp5i2rllm1y5c');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6x01brp5i2ma7be50t','cmo4m9leu0099p5i2ptbjyknr');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6x01brp5i2ma7be50t','cmo4m9lev009dp5i26axk6ttx');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6y01btp5i2u5aevyx0','cmo4m9ld9001hp5i2rm3tykv9');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6y01btp5i2u5aevyx0','cmo4m9ldr003tp5i27gzl0rkh');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6y01btp5i2u5aevyx0','cmo4m9lew009hp5i2ji6a80dr');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6y01btp5i2u5aevyx0','cmo4m9lex009lp5i28ntgwqr0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6z01bvp5i2yq1qlvlb','cmo4m9ld9001lp5i21mj2m2xr');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6z01bvp5i2yq1qlvlb','cmo4m9ley009pp5i2842m09yv');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m6z01bvp5i2yq1qlvlb','cmo4m9ley009tp5i27vibnzlw');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7001bxp5i2i5o50ukq','cmo4m9lda001pp5i2r4ul1weo');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7001bxp5i2i5o50ukq','cmo4m9ldr003xp5i2f949fumm');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7001bxp5i2i5o50ukq','cmo4m9lez009xp5i2k972huw0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7001bxp5i2i5o50ukq','cmo4m9lf000a1p5i2o0be7834');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7101bzp5i28vznbks7','cmo4m9ldb001tp5i279sgop2p');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7101bzp5i28vznbks7','cmo4m9lds0041p5i2lnj8nd6o');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7101bzp5i28vznbks7','cmo4m9lf000a5p5i2m9l2tmdw');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7101bzp5i28vznbks7','cmo4m9lf100a9p5i2hmmkdjr6');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7101bzp5i28vznbks7','cmo4m9lf200adp5i2ghr3q6hd');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7101c1p5i2fqb9fsck','cmo4m9ldc001xp5i2qd02ka8i');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7101c1p5i2fqb9fsck','cmo4m9lf200ahp5i2wch90b7y');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7101c1p5i2fqb9fsck','cmo4m9lf300alp5i2z0km0m41');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7201c3p5i2w3efnn94','cmo4m9ldt0045p5i2if43o0fn');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7201c3p5i2w3efnn94','cmo4m9lf300app5i2wd42rtmm');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7201c3p5i2w3efnn94','cmo4m9lf400atp5i2pcct8an4');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7301c5p5i2dppper18','cmo4m9ldd0021p5i2vqwh2lxd');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7301c5p5i2dppper18','cmo4m9ldu0049p5i2wojng6zc');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7301c5p5i2dppper18','cmo4m9lf400axp5i2p0i0lzdn');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7301c5p5i2dppper18','cmo4m9lf500b1p5i2w8zdchc4');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7401c7p5i2v2ge8ss3','cmo4m9ldd0025p5i218vweddo');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7401c7p5i2v2ge8ss3','cmo4m9lf600b5p5i24vbnz2fx');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7401c7p5i2v2ge8ss3','cmo4m9lf600b9p5i2t6qqbsr8');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7501c9p5i2aurll4rt','cmo4m9lde0029p5i2owr35tan');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7501c9p5i2aurll4rt','cmo4m9ldv004dp5i2cmf046l2');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7501c9p5i2aurll4rt','cmo4m9lf700bdp5i2lfphci2q');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7501c9p5i2aurll4rt','cmo4m9lf700bhp5i21mrggv98');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7601cbp5i23uca552g','cmo4m9ldf002dp5i2fjldb0ul');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7601cbp5i23uca552g','cmo4m9ldw004hp5i2bd9grdwh');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7601cbp5i23uca552g','cmo4m9lf800blp5i2xizmz7dn');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7601cbp5i23uca552g','cmo4m9lf900bpp5i2pxxm0ynn');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7701cdp5i2r7lt3v11','cmo4m9ldg002hp5i2kqikj3fj');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7701cdp5i2r7lt3v11','cmo4m9lf900btp5i2z7l87jql');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7701cdp5i2r7lt3v11','cmo4m9lfa00bxp5i2u8p9ovfy');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7701cfp5i2ys4ddmhk','cmo4m9ldx004lp5i2ljx6mnf3');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7701cfp5i2ys4ddmhk','cmo4m9lfb00c1p5i28gsejw41');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7701cfp5i2ys4ddmhk','cmo4m9lfb00c5p5i2udotqm1i');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7801chp5i267u89ae4','cmo4m9ldg002lp5i2bpemzue0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7801chp5i267u89ae4','cmo4m9ldy004pp5i2hv9twp31');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7801chp5i267u89ae4','cmo4m9lfc00c9p5i27nln5kfe');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7801chp5i267u89ae4','cmo4m9lfd00cdp5i2mun3mw4l');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7901cjp5i2iquhr1qi','cmo4m9ldh002pp5i2it83x5yy');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7901cjp5i2iquhr1qi','cmo4m9lfe00chp5i2jkpe9dmq');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7901cjp5i2iquhr1qi','cmo4m9lff00clp5i20eep8wxn');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7901cjp5i2iquhr1qi','cmo4m9lff00cpp5i2khr7rhko');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7a01clp5i2al2gti2t','cmo4m9ldi002tp5i2nxkn7hze');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7a01clp5i2al2gti2t','cmo4m9ldy004tp5i2tftt5v5r');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7a01clp5i2al2gti2t','cmo4m9lfg00ctp5i2xlmswh64');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7a01clp5i2al2gti2t','cmo4m9lfg00cxp5i2esk45xfk');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7a01cnp5i2bq6qayjg','cmo4m9lfh00d1p5i2w04llk4f');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7a01cnp5i2bq6qayjg','cmo4m9lfi00d5p5i2fq97adtj');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7b01cpp5i2jtvbiqep','cmo4m9ldj002xp5i2qrlurp0l');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7b01cpp5i2jtvbiqep','cmo4m9ldz004xp5i22c5h0lz1');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7b01cpp5i2jtvbiqep','cmo4m9lfi00d9p5i2td1qx682');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7b01cpp5i2jtvbiqep','cmo4m9lfj00ddp5i2nmvn96qq');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7c01crp5i27ga9dmw5','cmo4m9ldk0031p5i2j5x7oo2j');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7c01crp5i27ga9dmw5','cmo4m9le00051p5i2d5uqw8dc');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7c01crp5i27ga9dmw5','cmo4m9lfj00dhp5i2l4tnq3d0');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7c01crp5i27ga9dmw5','cmo4m9lfk00dlp5i2siakb62z');
INSERT INTO _ModuleToTopic VALUES('cmo4m9m7c01crp5i27ga9dmw5','cmo4m9lfl00dpp5i2abghgxjs');

INSERT INTO CoursePackage VALUES('cmo4m9lh000m5p5i2y81dh8vk',1776533650164,1776533650164,'XE Thermodynamics','xe-thermodynamics','Complete GATE XE package focused on thermodynamics with shared aptitude and food technology coverage.','Includes General Aptitude, Engineering Mathematics, Thermodynamics, and Food Technology.',1,'cmo4m9lcv0000p5i2r01c3zp5',3);
INSERT INTO CoursePackage VALUES('cmo4m9lly00sfp5i2u4alokmb',1776533650343,1776533650343,'XL Biochemistry','xl-biochemistry','Complete GATE XL package for the biochemistry stream with chemistry and food technology support.','Includes General Aptitude, Chemistry, Biochemistry, and Food Technology.',1,'cmo4m9lcv0000p5i2r01c3zp5',2);
INSERT INTO CoursePackage VALUES('cmo4m9lvr00ypp5i2937cd8i1',1776533650695,1776533650695,'XL Microbiology','xl-microbiology','Complete GATE XL package for microbiology with chemistry and food technology support.','Includes General Aptitude, Chemistry, Microbiology, and Food Technology.',1,'cmo4m9lcv0000p5i2r01c3zp5',1);
INSERT INTO CoursePackage VALUES('cmo4m9m1p014zp5i2b1mk5lp3',1776533650909,1776533650909,'XL Food Technology','xl-food-technology','Focused GATE XL package for food technology with chemistry support.','Includes General Aptitude, Chemistry, and Food Technology.',1,'cmo4m9lcv0000p5i2r01c3zp5',4);
INSERT INTO CoursePackage VALUES('cmo4m9m6n01b9p5i2qj5s0u10',1776533651088,1776533651088,'XE Food Technology','xe-food-technology','Focused GATE XE package for food technology with engineering mathematics support.','Includes General Aptitude, Engineering Mathematics, and Food Technology.',1,'cmo4m9lcv0000p5i2r01c3zp5',5);
