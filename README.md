# Two-Trace Cost Reconstruction for One-Time Roadmap Validation Decisions

**Meshaal Mouawad** · Mississippi State University  
**Journal:** Journal of Combinatorial Optimization (Springer Nature)  
**Manuscript:** JOCO-D-26-01323 · Submitted 21 November 2026  
**Manuscript release:** V22.8 (19 pages)

## Research question

For a sequence of start–goal queries on a fixed candidate roadmap, can all one-time persistent-edge completion decisions be evaluated exactly using only the permanently lazy and upfront-completed executions?

The manuscript proves an exact two-trace reconstruction of every completion cost under durable edge checks and history-independent completed-query service. A running prefix minimum identifies the lowest modeled cost retrospectively in linear time in the number of requests.

## Evidence

- 216 workloads × 40 start–goal queries.
- Two engines: restarted A* and query-local LPA*.
- 17,280 directly executed completion schedules.
- 2,833,920 service-field comparisons and 1,062,720 coefficient comparisons.
- Experimental code and input evidence retained with frozen releases.

## Current manuscript

- [JOCO V22.8 manuscript (PDF)](Manuscript/JOCO_Manuscript_v22_8.pdf)
- [JOCO V22.8 LaTeX source, figures, and build instructions](Manuscript/JOCO_LaTeX_Source_v22_8.zip)

## Research data and reproducibility

**Harvard Dataverse:** [Replication Data for Two-Trace Cost Reconstruction for One-Time Roadmap Validation Decisions](https://doi.org/10.7910/DVN/TICP0N)

- [ESM_1.zip](Evidence/ESM_1.zip) — original ROBOTICA-PQV-v10 study.
- [ESM_2.zip](Evidence/ESM_2.zip) — JIRS-TWO-TRACE-v1.1 extension and verification.
- [Historical ESM_2 archive](Evidence/ESM_2_v1_original_provenance.zip) — preserved for provenance.

For detailed reproduction procedures and archived verification, see the materials inside the ESM archives and [historical verification reports](Archive/JIRS/Verification/).

## Project history

The original visibility-graph project started in 2021. The [historical MATLAB code](Code/) and [original project document](Archive/Original_2021/) remain available. Older JIRS submission versions are preserved in [Archive/JIRS/Manuscript/](Archive/JIRS/Manuscript/); GitHub commit history also remains intact.

## License and attribution

See [LICENSE](LICENSE) and source-file attribution. Historical third-party contributions retain their original notices.
