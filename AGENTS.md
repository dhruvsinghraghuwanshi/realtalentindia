# RealTalent architecture

React/TanStack Start frontend in `src/marketplace.tsx`, route entry points in `src/routes`, shared responsive styling in `src/styles.css`. Root metadata lives in `src/routes/__root.tsx`. The same marketplace shell renders each route and restores page state from the browser pathname.

`netlify/functions/api.mts` is the private server API. Authenticate using `@netlify/identity`; never trust browser role claims. The persisted users row fixes employer/applicant role at first profile creation. Administrator access comes only from Identity server-managed roles. Mutations require same-origin requests. Keep all sensitive data server-side and avoid logging credentials or environment values.

`db/schema.ts` defines Postgres tables; `db/index.ts` exports Drizzle. Migrations belong in `netlify/database/migrations` and must accompany schema changes. Use Drizzle beta packages for the Netlify adapter. Application creation and job quotas use native database transactions with row locks. Keep application/conversation uniqueness and introduction-message atomicity intact.

PDF resumes use private Netlify Blobs. Never expose public storage URLs. Chat polling is four seconds; jobs refresh every fifteen seconds. All displayed jobs are genuine database listings; retain empty states instead of fake seed jobs or counts.

Plans are persisted and configurable by admins. Checkout is an explicit sandbox, never a real payment. Live payment activation requires verified backend confirmation. Do not grant live subscriptions based on browser success claims.

Use accessible labelled forms, disabled pending submission states, responsive layout, and server-side ownership checks. Do not edit generated route trees. Follow run-specific platform restrictions on validation commands; deployment performs build validation.
