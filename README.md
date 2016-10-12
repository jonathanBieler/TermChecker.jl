## Term Checker
```julia
using TermChecker

t = @term Domain.Optimization "Absolute tolerance" :abstol [:atol,:abs_tol]

checkpkg("Optim", t)
    abstol: 0
    atol: 0
    abs_tol: 13

checkpkg("Roots", t)
    abstol: 0
    atol: 5
    abs_tol: 0

checkpkg("NLsolve", t)
    abstol: 0
    atol: 0
    abs_tol: 0
```
