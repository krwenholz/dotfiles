# Doc — a glossary section

Internal doc register. Definitional writing, where precision matters and the temptation is to
get stiff. Kyle doesn't.

---

## Glossary

- **environment:** the sum of running containers, processes, and external (AWS) resources
  required to e2e test the monolith or other service.
- **local environment:** the classical Mac environment that, in the monolith, uses `yarn infra`
  to create some AWS resources used for running the local stack.
- **Cursor Cloud Agent:** these, not to be confused with folks' local Cursor IDE usage. Note that
  an "agent" is equivalent to a "session" in a standard LLM chat window and may imply something
  you return to multiple times.

  > 💡 Agents assume a role to access AWS, similar to OIDC in GitHub. Docs here. We already
  > provide a shared role with access to dev resources.

- **Cloud Agent environment**: an agent environment capable of running the monolith and similarly
  complex systems with just a prompt and minimal developer _account_ setup.
- **Cursor Cloud Agents GA:** AI Builder Tools has a working POC of the monolith in Cursor Cloud
  Agents, but we feel it needs various infrastructure and security guardrails in place before
  making it generally available. Similarly, we're limiting enablement work to a subset of
  non-monorepo repos while we build confidence in the implementation.
- **AIBT:** AI Builder Tools when I'm lazy.

---

## What to copy

- **Bold term, colon, plain definition.** No "refers to", no "is defined as". The definition
  starts immediately.
- **Definitions say what a thing IS, not what it does.** "the sum of running containers,
  processes, and external resources required to…"
- **Disambiguation is explicit.** "not to be confused with folks' local Cursor IDE usage."
  Kyle names the wrong reading and kills it.
- **Analogies to something the reader already knows.** "similar to OIDC in GitHub."
- **Callouts carry the aside**, so the definition line stays one thought long.
- **Italics on the one qualifying word.** "minimal developer _account_ setup" — the italic is
  doing real work, narrowing the claim.
- **The honest status, in the definition itself.** "we feel it needs various infrastructure and
  security guardrails in place before making it generally available." A glossary entry that
  admits the thing isn't ready.
- **End on a joke.** "**AIBT:** AI Builder Tools when I'm lazy." A dry, self-deprecating last
  entry after a page of precision. This is very on-brand — earn it by being rigorous first.
