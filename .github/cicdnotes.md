Why tests are important

single branch
devs merge small  frequent updates directly to the core trunk branch
if u are ceveloping a particular feature
trunk = main branch
main branch releaseable state
triggers cicd 
fully streamlined, no manual steps, 
trunk based development

build - test - package - tests - deploy to DEV - tests - deploy to STAGING - tests - deploy to PROD

ideally ur coy might want to automatically and continously deploy all the way to PROD iff u have lots of TESTS that can be deployed and released to end users.

Unit Tests
-validate individual parts of the app function


Integration tests
validate individual parts of code work together e.g frontend and backend communication

functional tests are the unit tests and the integration tezt

security test
-validates application security
-scan libraries for vulnerabitliyt
-scan code for vulnerabilities
-types are sast, dast, secret scanning

code quality trst
-code duplications
-code smells like using deprecated API
-Possinle bugs
-low test coverage

merge request triggers ci pipeline to test code changes
ci server is like the gatekeeper to decide whether to allow merge or not

why run tests on merge request
reduces the feedback look, you can fix issue right away
you can learn lotsof things

practice in where develops frequenely integrate their code changes into a shared repository
the pipeline is called ci pipeline

its best practice to build your pipeline in feature branch - all these is 


