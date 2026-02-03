/*
  Warnings:

  - The `status` column on the `Recipe` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - Changed the type of `status` on the `Recipe` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- AlterTable
ALTER TABLE "Recipe" DROP COLUMN "status",
ADD COLUMN     "status" TEXT NOT NULL DEFAULT 'PUBLISHED';

-- DropEnum
DROP TYPE "RecipeStatus";

-- AddCheckConstraints
ALTER TABLE "User" ADD CONSTRAINT "User_role_check" CHECK (role IN ('user', 'admin'));
ALTER TABLE "Recipe" ADD CONSTRAINT "Recipe_status_check" CHECK (status IN ('DRAFT', 'PUBLISHED'));
