-- AlterTable
ALTER TABLE "Recipe" DROP COLUMN "status",
ADD COLUMN     "status" TEXT NOT NULL DEFAULT 'PUBLISHED';

-- DropEnum
DROP TYPE "RecipeStatus";

-- AddCheckConstraints
ALTER TABLE "User" ADD CONSTRAINT "User_role_check" CHECK (role IN ('user', 'admin'));
ALTER TABLE "Recipe" ADD CONSTRAINT "Recipe_status_check" CHECK (status IN ('DRAFT', 'PUBLISHED'));
