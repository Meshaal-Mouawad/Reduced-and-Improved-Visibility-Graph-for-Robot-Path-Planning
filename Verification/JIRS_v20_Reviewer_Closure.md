# JIRS V20 — independent reviewer closure

**Manuscript:** *When Roadmap Completion Pays Off: A Two-Trace Analysis of Multi-Query Robot Path Planning*  
**Journal:** Journal of Intelligent & Robotic Systems  
**Baseline:** JIRS V19, 38 pages. **Working release:** JIRS V20, 38 pages.  
**Decision:** **PASS — the three identified V19 follow-up items are closed.** The paper has not been submitted.

## Finding-by-finding result

| Finding | Actual correction or execution | Decision |
| --- | --- | --- |
| **V19-R1, page 38: ESM_2 release mismatch** | Updated the `Supplementary information` paragraph from `JIRS-TWO-TRACE-v1` to `JIRS-TWO-TRACE-v1.1`. Data availability already read v1.1. Inspected page 38, checked both identifiers against `ESM_2.zip/new_study/RELEASE.json`. | **PASS — corrected in source and PDF** |
| **Direct verification of ESM_2** | Executed `new_study/reproduce.py --full` from the *actual* V19 v1.1 archive against the exact frozen ESM_1, regenerated direct experiments and all analysis. See machine-readable report below. | **PASS — independently executed in this task** |
| **V19 source and PDF identity** | Extracted the source ZIP and compiled cleanly. Compared 38 pages of the independent rebuild with the released PDF: no textual or rendered differences. The V20 source ZIP contains the same PDF bytes as the released file and passes 69 internal file checksums. | **PASS — independently rebuilt** |

## Full ESM_2 evidence

- **ESM_1 baseline SHA-256:** `6eeb0f605d4081b9a9e2acd157e88ecdfaf5eba09c73fdeb00df1c0a86ff962c`; 149 embedded file hashes verified.
- **ESM_2 v1.1 SHA-256:** `e52ca5fe4e73abfa9018649f6e2c3b11c4761cfbca85be7831b8a14911cf98d8`; 29 embedded file hashes verified.
- **Direct execution:** 432 engine–workload combinations; 17,280 completion branches; 354,240 suffix-query executions.
- **Scientific checks:** 2,833,920 service-field equalities; 1,062,720 horizon-coefficient equalities; 388,800 returned-length comparisons. Zero assertion failures.
- **Raw files:** `traces.csv` (34,560 rows), `all_switch_coefficients.csv` (354,240 rows), and `exhaustive_verification.csv` (17,280 rows) are **byte-identical** to the deposited files.
- **Analysis:** six tables are **byte-identical**. `grid_group_summary.csv` and `horizon_weight_results.csv` are **numeric-roundoff equivalent**, with maximum absolute differences of 5.6843418860808015e-14 and 5.6843418860808015e-14, respectively, within the archived absolute/relative `1e-12` tolerance. Counts and classifications match. The figures and LaTeX table were regenerated.
- **Current release identity:** `JIRS-TWO-TRACE-v1.1` in metadata and both manuscript statements. Historical `JIRS-TWO-TRACE-v1` remains separately preserved as `ESM_2_v1_original_provenance.zip`.

## Preservation and production

- The **only scientific-manuscript text change** from V19 is the release identifier on page 38. No new experiment, new theory, broad rewrite, or change of result was introduced.
- The source ZIP differs from V19 in four files: `main.tex`, its compiled `main.pdf`, `BUILD_README.md` and `MANIFEST_SHA256.json`. Its `references.bib`, 16 numbered figure PDFs/SVGs/PNGs, algorithms and other sources remain byte-identical.
- Comparing V19 and V20 PDFs: the only extracted-text change and only rendered-page change occur on **page 38**.
- The independent fresh ZIP extraction rebuilt a **38-page** PDF matching all pages of the released file in extracted text and raster pixels.
- The current ESM_2 source and data are unmodified. Frozen ESM_1 and the V18 original ESM_2 archive retain their byte identities.

## Files and reviewer reproduction

1. `JIRS_Manuscript_v20.pdf` — corrected manuscript.
2. `JIRS_LaTeX_Source_v20.zip` — buildable source, current PDF, source manifest.
3. `ESM_1.zip` — frozen original study, unmodified.
4. `ESM_2.zip` — current `JIRS-TWO-TRACE-v1.1` resource, unmodified.
5. `ESM_2_v1_original_provenance.zip` — historic release only.
6. `verification/ESM2_FULL_REPRODUCTION_REPORT.json` and `verification/ESM2_DIRECT_VERIFICATION.json` — actual current-run results.
7. `VERIFY_RELEASE_v20.py` — zero-dependency file identity check; `python VERIFY_RELEASE_v20.py`.

To repeat the direct computational experiment, extract ESM_2 alongside ESM_1 and execute `python new_study/reproduce.py --full --baseline-zip ESM_1.zip --out replay-full`, using a fresh output folder. The reproduction helper also supports `--verify` for manifest checks.

**Closure:** All material findings in the supplied V19 follow-up review have been corrected or directly verified. Existing novelty and theorem-layout findings remain closed. The article has not been submitted.
