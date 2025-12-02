

## [1.20.1](https://github.com/bcgov/cas-ggircs/compare/v1.20.0...v1.20.1) (2025-12-02)


### Bug Fixes

* standard providers moved to new pacakge in Airflow 3 ([ca6f6c2](https://github.com/bcgov/cas-ggircs/commit/ca6f6c22e73d0915f95854b80c5983cdd5ed5d2a))

# [1.20.0](https://github.com/bcgov/cas-ggircs/compare/v1.19.3...v1.20.0) (2025-08-20)

## [1.19.3](https://github.com/bcgov/cas-ggircs/compare/v1.19.1...v1.19.3) (2025-08-19)

## [1.19.2](https://github.com/bcgov/cas-ggircs/compare/v1.19.1...v1.19.2) (2025-08-19)

## [1.19.1](https://github.com/bcgov/cas-ggircs/compare/v1.19.0...v1.19.1) (2025-08-15)

# [1.19.0](https://github.com/bcgov/cas-ggircs/compare/v1.18.3...v1.19.0) (2025-08-13)


### Bug Fixes

* revert sqitch plan history rewrite ([0f02007](https://github.com/bcgov/cas-ggircs/commit/0f020072c2f293845f80c2bb8e86c57aa6449a7b))

## [1.18.3](https://github.com/bcgov/cas-ggircs/compare/v1.18.2...v1.18.3) (2025-03-11)

## [1.18.2](https://github.com/bcgov/cas-ggircs/compare/v1.18.1...v1.18.2) (2025-01-09)

## [1.18.1](https://github.com/bcgov/cas-ggircs/compare/v1.18.0...v1.18.1) (2024-05-31)


### Bug Fixes

* race condition when loading environment variables ([02a066b](https://github.com/bcgov/cas-ggircs/commit/02a066b4646ace257c2fd8ff785e27f863e59507))
* using the new pipeTo method instead ([9b15fdd](https://github.com/bcgov/cas-ggircs/commit/9b15fdd888946b9d92f7ab1d11c066331e8fb5aa))

# [1.18.0](https://github.com/bcgov/cas-ggircs/compare/v1.17.4...v1.18.0) (2024-05-30)


### Features

* adding 2023 carbon tax act fuel rates ([59c54ed](https://github.com/bcgov/cas-ggircs/commit/59c54ed78f8c3803063677ddd5933e0a83c50dbd))

## [1.17.4](https://github.com/bcgov/cas-ggircs/compare/v1.17.3...v1.17.4) (2024-02-27)

## [1.17.3](https://github.com/bcgov/cas-ggircs/compare/v1.17.2...v1.17.3) (2024-02-23)

## [1.17.2](https://github.com/bcgov/cas-ggircs/compare/v1.17.1...v1.17.2) (2023-11-22)

## [1.17.1](https://github.com/bcgov/cas-ggircs/compare/v1.17.0...v1.17.1) (2023-10-17)


### Bug Fixes

* update load_emission function to include EIO Emission data beyond 2022 ([2d450a9](https://github.com/bcgov/cas-ggircs/commit/2d450a9ca49e2d5bac891aa1e02a05d26985d951))

# [1.17.0](https://github.com/bcgov/cas-ggircs/compare/v1.16.3...v1.17.0) (2023-06-19)


### Features

* add calculated ar5 quantity to emission table in load ([067eaf4](https://github.com/bcgov/cas-ggircs/commit/067eaf4346e6af256757788b3f5f1cb463f7d9f1))

## [1.16.3](https://github.com/bcgov/cas-ggircs/compare/v1.16.2...v1.16.3) (2023-05-29)

## [1.16.2](https://github.com/bcgov/cas-ggircs/compare/v1.16.1...v1.16.2) (2023-05-17)


### Bug Fixes

* no relative path for wget-spider call ([3c239b5](https://github.com/bcgov/cas-ggircs/commit/3c239b577f0e67b0059cb989a23567bba8ce3fec))

## [1.16.1](https://github.com/bcgov/cas-ggircs/compare/v1.16.0...v1.16.1) (2023-05-15)

# [1.16.0](https://github.com/bcgov/cas-ggircs/compare/v1.15.0...v1.16.0) (2023-04-24)


### Bug Fixes

* create load_emission_factor to handle post-2017 records ([e6ea99e](https://github.com/bcgov/cas-ggircs/commit/e6ea99e20195ff01bf96ecdfcca98a8bdef9313d))

# [1.15.0](https://github.com/bcgov/cas-ggircs/compare/v1.14.1...v1.15.0) (2023-02-08)


### Features

* add materialized view to parse details on other venting sources ([0edb1ec](https://github.com/bcgov/cas-ggircs/commit/0edb1ec3965185b1fad90dc92549d1637a736f85))
* add table for other_venting details ([f818c4f](https://github.com/bcgov/cas-ggircs/commit/f818c4fe75736643b22d3dcdd9ae3db2e2b9ebc5))

## [1.14.1](https://github.com/bcgov/cas-ggircs/compare/v1.14.0...v1.14.1) (2023-01-19)

# [1.14.0](https://github.com/bcgov/cas-ggircs/compare/v1.13.4...v1.14.0) (2023-01-19)


### Bug Fixes

* fixing issue where a user entry wouldn't be created when a new user logs in ([bdd6f9e](https://github.com/bcgov/cas-ggircs/commit/bdd6f9e20970abea42fcd8c22ee5fa15447da463))


### Features

* add scripts to ensure sqitch changes are immutable ([1f9b5a6](https://github.com/bcgov/cas-ggircs/commit/1f9b5a663f0d25ef1315781e237ede3724c2c982))
* Keycloak Gold integration ([893b80d](https://github.com/bcgov/cas-ggircs/commit/893b80dd9ad689ffe3503ae274a21682854a08f4))

## [1.13.4](https://github.com/bcgov/cas-ggircs/compare/v1.13.0...v1.13.4) (2022-12-07)


### Bug Fixes

* add offending report to quarantine list ([acfa490](https://github.com/bcgov/cas-ggircs/commit/acfa490920d1a60fa818c55fe9dbfe663066e54b))
