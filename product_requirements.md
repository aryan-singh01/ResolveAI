# ResolveAI — Product Requirements (Starter)

## Product goal
Help customer-support teams triage incoming tickets, draft replies for agent review, and understand support trends through reliable analytics.

## Primary users
- Support agent: reviews, assigns, replies to, and resolves tickets.
- Support manager: monitors backlog, escalations, service performance, and recurring issues.
- Administrator: manages users, roles, and configuration.

## MVP features
1. Ticket inbox with search, filters, sorting, and pagination.
2. Ticket details with conversation history and status changes.
3. Assignment to an agent and escalation tracking.
4. AI-assisted category, intent, sentiment, and priority suggestions.
5. AI-generated draft reply; an agent must approve/edit it before sending.
6. Feedback capture: accepted unchanged, edited, or rejected.
7. Analytics for resolution time, escalation rate, suggestion adoption, and volume by category.
8. Robust loading, error, retry, and empty states.

## Initial allowed labels
- Category: Billing, Account Access, Shipping, Technical Issue, Subscription, Product Feedback, Security, Other
- Sentiment: Positive, Neutral, Concerned, Negative
- Priority: Low, Medium, High, Critical
- Status: Open, In Progress, Waiting on Customer, Resolved, Closed

## Non-functional requirements
- Keep LLM API keys on the server; never expose secrets in frontend code.
- Validate model output before storing it.
- Enforce role-based access to ticket data.
- Store timestamps in UTC.
- Log status transitions and escalation events.
- Provide a way to use the ticket workflow if the AI provider is unavailable.
- Use synthetic/demo data only; do not upload real customer personal data.

## MVP acceptance criteria
- A user can create and view a ticket.
- An authorized agent can assign and update a ticket.
- AI analysis is saved and can be retried after a failure.
- An agent can edit/reject a draft and that feedback is recorded.
- Dashboard KPIs are computed from database records and have documented definitions.
- README explains setup, environment variables, test instructions, and limitations.
