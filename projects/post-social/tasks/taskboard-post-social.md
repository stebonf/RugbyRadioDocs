---
type: task-board
status: open
created: 2026-08-02T21:54:17+02:00
topic: "Post Social"
project: "post-social"
slug: "post-social"
tasklist: "projects/post-social/tasks/tasklist-post-social.md"
---

# Taskboard: Post Social

## Tracking Rules

- Allowed states: Todo, In Progress, Blocked, Review, Done, Dropped.
- Update this file when a task starts, blocks, enters review, or finishes.
- Keep the tasklist as the plan and the taskboard as the status view.

## Summary Status

Project planned. Atomic runnable task files have been created under `projects/post-social/tasks`. Idea `20260803070301-web-page` integrated as Social Workbench backlog.

## Board

| Task | Title | Milestone | Priority | Owner | Status | Started | Done | Blocker | Last Update |
|---|---|---|---|---|---|---|---|---|---|
| POST-T001 | Create Social Config Structure | M1 | P0 | AI | Done | 2026-08-03 | 2026-08-03 |  | 2026-08-03 |
| POST-T002 | Define Draft Storage Format | M1 | P0 | AI | Todo |  |  | POST-T001 | 2026-08-02 |
| POST-T011 | Define Social Workbench File Contract | M1b | P0 | AI | Todo |  |  | POST-T001, POST-T002 | 2026-08-03 |
| POST-T012 | Build Social Workbench File Server | M1b | P0 | AI | Todo |  |  | POST-T011 | 2026-08-03 |
| POST-T013 | Build Social Workbench UI | M1b | P1 | AI | Todo |  |  | POST-T011, POST-T012 | 2026-08-03 |
| POST-T014 | Wire Social Workbench Save Flows | M1b | P1 | AI | Todo |  |  | POST-T012, POST-T013 | 2026-08-03 |
| POST-T003 | Create Social Post Generator Skill | M2 | P0 | AI | Todo |  |  | POST-T001, POST-T002 | 2026-08-02 |
| POST-T004 | Create Agent Social Post | M2 | P1 | AI | Todo |  |  | POST-T003 | 2026-08-02 |
| POST-T005 | Generate First Manual Drafts | M2 | P1 | Mixed | Todo |  |  | POST-T004 | 2026-08-02 |
| POST-T006 | Add Anti-Repetition Check | M3 | P1 | AI | Todo |  |  | POST-T005 | 2026-08-02 |
| POST-T007 | Validate API Feasibility For Initial Socials | M4 | P1 | Mixed | Todo |  |  | POST-T005 | 2026-08-02 |
| POST-T008 | Evaluate Google Flow Automation | M4 | P2 | Mixed | Todo |  |  |  | 2026-08-02 |
| POST-T009 | Design Publishing Adapter | M5 | P2 | AI | Todo |  |  | POST-T007 | 2026-08-02 |
| POST-T010 | Plan Scheduling | M6 | P3 | Mixed | Todo |  |  | POST-T005 | 2026-08-02 |

## Progress Log

| Date | Task | Status | Note |
|---|---|---|---|
| 2026-08-02 | all | Todo | Initial taskboard created from idea-to-plan flow. |
| 2026-08-02 | all | Todo | Atomic runnable task files created for dashboard execution. |
| 2026-08-03 | POST-T011..POST-T014 | Todo | Integrated Social Workbench idea `20260803070301-web-page` into analysis, architecture and runnable task backlog. |
| 2026-08-03 | POST-T001 | Done | Created initial Instagram and LinkedIn social channel configuration files under `src/RugbyRadioSocial/config/socials`. |
