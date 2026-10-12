# ResolveAI starter files

This pack contains synthetic starter material for the ResolveAI project.

## Files
- `sample_support_tickets.csv` — 20 fictional tickets for UI demos, SQL practice, and analytics prototyping.
- `product_requirements.md` — MVP scope and acceptance criteria.
- `schema.sql` — initial PostgreSQL schema.
- `ai_prompt_template.md` — draft LLM instruction and output contract.

## Suggested use
1. Inspect the CSV and import it into a staging table or write a small seed script.
2. Review `schema.sql` and adapt it to your EF Core entities and migrations.
3. Implement the ticket workflow before connecting the LLM.
4. Use the prompt template as a starting point, then enforce a strict structured-output schema in the backend.
5. Use synthetic data only. These tickets are illustrative and are not real customer records.

## Important
The CSV includes example labels and some illustrative resolution durations. Treat them as demo data, not measured product outcomes or a validated AI evaluation dataset.
