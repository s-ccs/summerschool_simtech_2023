---
type: slide
slideOptions:
  transition: slide
  width: 1400
  height: 900
  margin: 0.1
---

<style>
  .reveal strong {
    font-weight: bold;
    color: orange;
  }
  .reveal p {
    text-align: left;
  }
  .reveal section h1 {
    color: orange;
  }
  .reveal section h2 {
    color: orange;
  }
  .reveal code {
    font-family: 'Ubuntu Mono';
    color: orange;
  }
  .reveal section img {
    background:none;
    border:none;
    box-shadow:none;
  }
</style>

# Learning Goals

- Get to know a few common terms of testing
- Work with the Julia unit testing package `Test.jl`

Material is taken and modified from the [SSE lecture](https://github.com/Simulation-Software-Engineering/Lecture-Material), which builds partly on the [py-rse book](https://merely-useful.tech/py-rse), and from the [Test.jl docs](https://docs.julialang.org/en/v1/stdlib/Test/).


---

# 1. General Introduction to Testing

---

## What is Testing?

- Smelling old milk before using it
- A way to determine if a software is not producing reliable results and if so, what is the reason
- Manual testing vs. automated testing

---

## Why Should you Test your Software?

- Improve software reliability and reproducibility
- Make sure that changes (bugfixes, new features) do not affect other parts of software
- Generally all software is better off being tested regularly. Possible exceptions are very small codes with single users.
- Ensure that a released version of a software actually works.

---

## Some Ways to Test Software

- Assertions
- Unit testing
- Integration testing
- Regression testing

---

## Assertions

```julia
@assert condition "message"
```

- Principle of *defensive programming*
- Nothing happens when an assertion is true; throws error when false.
- Types of assertion statements:
    - Precondition
    - Postcondition
    - Invariant
- A basic but powerful tool to test a software on-the-go

---

## Unit Testing

- Catching errors with assertions is good but preventing them is better.
- A *unit* is a single function in one situation.
    - A situation is one amongst many possible variations of input parameters.
- User creates the **expected result** manually.
- **Actual result** is compared to the expected result by `@test`.

---

## Integration Testing

- Test whether several units work in conjunction.
- *Integrate* units and test them together in an *integration* test.
- Often more complicated than a unit test and gives higher test coverage.

---

## Regression Testing

- Generating an expected result is not possible in some situations.
- Compare the *current* actual result with a *previous* actual result.
- No guarantee that the current actual result is correct.
- Risk of a bug being carried over indefinitely.
- Main purpose is to identify changes in the current state of the code with respect to a past state.

---

# 2. Unit Testing in Julia with Test.jl

---

## Setup of Test.jl

- Standardized folder structure:

  ```
  ├── Manifest.toml
  ├── Project.toml
  ├── src/
  └── test
      ├── Manifest.toml
      ├── Project.toml
      ├── runtests.jl
      └── setup.jl
  ```

- Singular `test` vs plural `runtests.jl`
- `setup.jl` for all `using XYZ` statements, included in `runtests.jl`
- Additional packages in `[extra] section` of `./Project.toml` or in new `./test/Project.toml`
  - In case of the latter: Do not add the package itself to the `./test/Project.toml`
- Run: `]test` when root project is activated

---

## Implement and Structure Tests

- `@test expr`: Test whether expression `expr` is true
- `@test expr broken=true`: Explicitly mark test as broken
- `@test_throws exception expr`: Test whether expression `expr` throws `exception` (test unhappy path)

    ```julia
    julia> @test_throws DimensionMismatch [1, 2, 3] + [1, 2]
    Test Passed
          Thrown: DimensionMismatch
    ```

- `@testset`: Structure tests

   ```julia
   @testset "trigonometric identities" begin
       θ = 2/3*π
       @test sin(-θ) ≈ -sin(θ)
       @test cos(-θ) ≈ cos(θ)
   end;
   ```

- `@testset for ... end`: Test in loop

---

## Further Reading and Watching

- [Research Software Engineering with Python - Chapter 11: Testing Software](https://merely-useful.tech/py-rse/testing.html)
- [HiRSE-Summer of Testing Part 2b: "Testing with Julia" by Nils Niggemann](https://www.youtube.com/watch?v=gSMKNbZOpZU)
- [Official documentation of Test.jl](https://docs.julialang.org/en/v1/stdlib/Test/)

---

# 3. Test.jl Demo

We use [`MyTestPackage`](https://github.com/s-ccs/summerschool_simtech_2023/tree/main/material/2_tue/testing/MyTestPackage), which looks as follows:


```
├── Manifest.toml
├── Project.toml
├── src
│   ├── find.jl
│   └── MyTestPackage.jl
└── test
    ├── find.jl
    ├── Manifest.toml
    ├── Project.toml
    ├── runtests.jl
    └── setup.jl
```


- Look at `MyTestPackage.jl` and `find.jl`: We have two functions `find_max` and `find_mean`, which calculate the maximum and mean of all elements of a `::AbstractVector`.
  - Assertions were added to check for `NaN` values
- Look at `runtests.jl`:
  - Why do we need `using MyTestPackage`?
  - We include dependencies via `setup.jl`: `Test` and `StableRNG`.
  - Testset "find"
- Look at `find.jl`
  - Unit tests for `find_max` and `find_mean`
  - `test_throws` to test unhappy path
  - Test with absolute tolerance
  - Integration test, which tests combination of both methods
- Run tests:

    ```
    ]activate .
    ]test
    ```

---

# 4. Exercise

Write tests for your own statistics package 😊

