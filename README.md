# SurgeNeue

**SurgeNeue** is an experimental blank-slate re-implementation of the lowest-level building blocks of the **Surge** project.

☣️ CAUTION: You absolutely do NOT want to depend on this project under ANY circumstances! ☢️

## Packages

The idea behind this project is to split Surge up into smaller Swift Packages, with **SurgeCore** providing a common base dependency.

### Low-Level

- **SurgeCore**: Low-level functional core providing essential building blocks.

### Mid-/High-Level

- **SurgeArithmetic**: High-level parallel computation APIs for arithmetic applications.
- **SurgeDSP**: High-level parallel computation APIs for digital signal processing applications (FFT, …).
- **SurgeLinearAlgebra**:  High-level parallel computation APIs for Scalar/Vector/Matrix applications.
- **SurgeStochastics**: High-level parallel computation APIs for stochastic applications (random numbers, sampling, …).
- **SurgeStatistics**: High-level parallel computation APIs for statistic applications (mean, variance, …).
- **SurgeTrigonometry**: High-level parallel computation APIs for trigonometry applications (sin, cos, atan, …).  

## Architecture

**SurgeNeue** makes heavy use of the [**Protocol Witness**](https://www.youtube.com/watch?v=3BVkbWXcFS4) pattern.

## Goals

### Functional Requirements

- Added support for specifying a custom destination buffer for **externalMutating functions**, where applicable.
- Added support for specifying a custom output type for **external functions**, where applicable.
- Added support for allocation-efficient copy-on-write semantics for **merging functions**, where applicable.

### Non-Functional Requirements

- Most – if not all – of the APIs should be fully documented.
- Most – if not all – of the APIs should be fully tested.
- Most – if not all – of the derivable APIs should get auto-generated \*.
- Most – if not all – of the documentation should get auto-generated \*.
- Most – if not all – of the unit tests should get auto-generated \*.
- Most – if not all – of the benchmarks should get auto-generated \*.

\* via [Sourcery](https://github.com/krzysztofzablocki/Sourcery)
