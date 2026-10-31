# RealTalent

A responsive job and talent marketplace built with React 19, TanStack Start, TypeScript, Netlify Functions, Netlify Identity, Netlify Database (Postgres and Drizzle), and private Netlify Blobs resume storage.

## Local development

Install dependencies with `pnpm install`. Link this project to the Netlify site with `netlify link`, then run `netlify dev --port 8889`. Identity and storage require Netlify's runtime. Application data is never stored in local JSON or memory. Generate schema migrations with `pnpm exec drizzle-kit generate --name describe_change`. Netlify applies the checked-in migrations at deployment.

## Authentication and administration

Identity is enabled. Registration requires email confirmation by default. Confirm the email link to return to the original action. Identity handles password hashing, sessions, token refresh and password recovery. Applicant and employer roles are persisted on first authenticated profile creation and cannot be changed through profile updates. Admin roles are never assigned by registration.

Create your account, then open Netlify's Identity user details and assign the `admin` role to the designated administrator. Log in again and visit `/admin`. Configure production email delivery and email templates in Identity settings. Confirm registration and password-recovery redirect links use the production domain. Never put credentials into frontend environment variables.

## Features and operating rules

Employers publish and manage their jobs. Applicants save jobs, submit applications, upload PDF resumes up to 3 MB and exchange private messages. Applying atomically creates one application, one conversation and one introduction. Chats refresh every four seconds; public listings refresh every fifteen seconds. Application and job quotas are enforced under database row locks. Resume downloads require ownership, an application to the requesting employer, or admin privileges.

The five monthly plans per role are configurable in `/admin`. Free allowances are 2 employer posts and 10 applicant applications per calendar month. Paid tiers provide 10, 30, 75 and 200 actions monthly. Subscriptions last 30 days. Cancellation retains access until expiry; the sandbox never auto-renews or charges. Sandbox success activates access, failure preserves the current plan, and all payment records clearly indicate sandbox status. **No live payment provider is configured.** To accept money, replace sandbox checkout with a provider order endpoint and verified, idempotent backend webhook confirmation before granting live subscriptions. Provider credentials must remain in function-scoped environment variables.

Administrators can suspend users, close jobs, resolve reports, change plan pricing/limits/features, inspect payments/subscriptions and edit homepage/category content. For homepage content use key `homepage` with `{"description":"Your finished copy"}`. For categories use key `categories` with an array of up to six objects containing `title` and `description`.

## Deploy and custom domain

Push the project through the connected Netlify repository. `netlify.toml` configures the TanStack build and functions directory; the platform supplies database, Identity and Blobs integration. No application database URL or service secret needs to be exposed to the browser. Add `realtalent.site` and optionally `www.realtalent.site` in Netlify Domain management. Follow the displayed DNS instructions, wait for domain verification, provision HTTPS, and set the primary domain. Configure Identity URLs for that domain. DNS ownership changes must be completed by the domain owner.

## Verification status

Files were reviewed in this run. Local build, type-check, server and test commands were prohibited by the execution environment; deployment validation runs separately. Before production use, verify confirmation email, recovery email, applicant/employer registration, cross-role denials, job editing/closing, duplicate submissions, quota enforcement, saved jobs, applications, auto-introduction, two-account chat replies, private resume access, plan sandbox success/failure/cancellation/expiry, admin isolation and mobile navigation on the deployed preview. No employer listings or activity statistics are fabricated.
