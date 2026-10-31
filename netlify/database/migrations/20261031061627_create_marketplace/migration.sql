CREATE TABLE "applications" (
	"id" text PRIMARY KEY,
	"job_id" text NOT NULL,
	"applicant_id" text NOT NULL,
	"employer_id" text NOT NULL,
	"status" text DEFAULT 'submitted' NOT NULL,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "content" (
	"id" text PRIMARY KEY,
	"data" jsonb NOT NULL
);
--> statement-breakpoint
CREATE TABLE "conversations" (
	"id" text PRIMARY KEY,
	"application_id" text NOT NULL UNIQUE,
	"applicant_id" text NOT NULL,
	"employer_id" text NOT NULL
);
--> statement-breakpoint
CREATE TABLE "jobs" (
	"id" text PRIMARY KEY,
	"employer_id" text NOT NULL,
	"company" text NOT NULL,
	"title" text NOT NULL,
	"salary" integer NOT NULL,
	"work_type" text NOT NULL,
	"openings" integer NOT NULL,
	"status" text DEFAULT 'published' NOT NULL,
	"request_key" text NOT NULL UNIQUE,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "messages" (
	"id" text PRIMARY KEY,
	"conversation_id" text NOT NULL,
	"sender_id" text NOT NULL,
	"body" text NOT NULL,
	"read" boolean DEFAULT false,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "notifications" (
	"id" text PRIMARY KEY,
	"user_id" text NOT NULL,
	"body" text NOT NULL,
	"read" boolean DEFAULT false,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "payments" (
	"id" text PRIMARY KEY,
	"user_id" text NOT NULL,
	"plan_id" text NOT NULL,
	"amount" integer NOT NULL,
	"status" text NOT NULL,
	"sandbox" boolean DEFAULT true,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "plans" (
	"id" text PRIMARY KEY,
	"role" text NOT NULL,
	"name" text NOT NULL,
	"price" integer NOT NULL,
	"limit" integer NOT NULL,
	"features" text NOT NULL
);
--> statement-breakpoint
CREATE TABLE "reports" (
	"id" text PRIMARY KEY,
	"user_id" text NOT NULL,
	"body" text NOT NULL,
	"status" text DEFAULT 'open',
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "saved_jobs" (
	"id" text PRIMARY KEY,
	"user_id" text NOT NULL,
	"job_id" text NOT NULL
);
--> statement-breakpoint
CREATE TABLE "subscriptions" (
	"id" text PRIMARY KEY,
	"user_id" text NOT NULL,
	"plan_id" text NOT NULL,
	"expires_at" timestamp NOT NULL,
	"cancelled" boolean DEFAULT false,
	"sandbox" boolean DEFAULT true
);
--> statement-breakpoint
CREATE TABLE "users" (
	"id" text PRIMARY KEY,
	"email" text NOT NULL,
	"role" text NOT NULL,
	"name" text NOT NULL,
	"phone" text NOT NULL,
	"gst" text,
	"experience" text DEFAULT '',
	"skills" text DEFAULT '',
	"preference" text DEFAULT '',
	"work_type" text DEFAULT 'Any',
	"resume" text,
	"disabled" boolean DEFAULT false,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE UNIQUE INDEX "one_application" ON "applications" ("job_id","applicant_id");--> statement-breakpoint
CREATE UNIQUE INDEX "one_save" ON "saved_jobs" ("user_id","job_id");--> statement-breakpoint
ALTER TABLE "applications" ADD CONSTRAINT "applications_job_id_jobs_id_fkey" FOREIGN KEY ("job_id") REFERENCES "jobs"("id");--> statement-breakpoint
ALTER TABLE "applications" ADD CONSTRAINT "applications_applicant_id_users_id_fkey" FOREIGN KEY ("applicant_id") REFERENCES "users"("id");--> statement-breakpoint
ALTER TABLE "applications" ADD CONSTRAINT "applications_employer_id_users_id_fkey" FOREIGN KEY ("employer_id") REFERENCES "users"("id");--> statement-breakpoint
ALTER TABLE "conversations" ADD CONSTRAINT "conversations_application_id_applications_id_fkey" FOREIGN KEY ("application_id") REFERENCES "applications"("id");--> statement-breakpoint
ALTER TABLE "conversations" ADD CONSTRAINT "conversations_applicant_id_users_id_fkey" FOREIGN KEY ("applicant_id") REFERENCES "users"("id");--> statement-breakpoint
ALTER TABLE "conversations" ADD CONSTRAINT "conversations_employer_id_users_id_fkey" FOREIGN KEY ("employer_id") REFERENCES "users"("id");--> statement-breakpoint
ALTER TABLE "jobs" ADD CONSTRAINT "jobs_employer_id_users_id_fkey" FOREIGN KEY ("employer_id") REFERENCES "users"("id");--> statement-breakpoint
ALTER TABLE "messages" ADD CONSTRAINT "messages_conversation_id_conversations_id_fkey" FOREIGN KEY ("conversation_id") REFERENCES "conversations"("id");--> statement-breakpoint
ALTER TABLE "messages" ADD CONSTRAINT "messages_sender_id_users_id_fkey" FOREIGN KEY ("sender_id") REFERENCES "users"("id");--> statement-breakpoint
ALTER TABLE "notifications" ADD CONSTRAINT "notifications_user_id_users_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id");--> statement-breakpoint
ALTER TABLE "payments" ADD CONSTRAINT "payments_user_id_users_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id");--> statement-breakpoint
ALTER TABLE "payments" ADD CONSTRAINT "payments_plan_id_plans_id_fkey" FOREIGN KEY ("plan_id") REFERENCES "plans"("id");--> statement-breakpoint
ALTER TABLE "reports" ADD CONSTRAINT "reports_user_id_users_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id");--> statement-breakpoint
ALTER TABLE "saved_jobs" ADD CONSTRAINT "saved_jobs_user_id_users_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id");--> statement-breakpoint
ALTER TABLE "saved_jobs" ADD CONSTRAINT "saved_jobs_job_id_jobs_id_fkey" FOREIGN KEY ("job_id") REFERENCES "jobs"("id");--> statement-breakpoint
ALTER TABLE "subscriptions" ADD CONSTRAINT "subscriptions_user_id_users_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id");--> statement-breakpoint
ALTER TABLE "subscriptions" ADD CONSTRAINT "subscriptions_plan_id_plans_id_fkey" FOREIGN KEY ("plan_id") REFERENCES "plans"("id");