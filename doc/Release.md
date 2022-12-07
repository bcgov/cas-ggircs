
# GGIRCS Release process

Before releasing our application to our `test` and `prod` environments, an essential step is to add a tag to our sqitch plan, to identify which database mutations are released to prod and should be immutable.

Additionally, to facilitate identification of the changes that are released and communication around them, we want to:

- bump the version number, following [semantic versioning](https://semver.org/)
- generate a change log, based on the commit messages using the [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/) format

To make this process easy, we use [`release-it`](https://github.com/release-it/release-it).

When you're ready to make a release, apply the following steps:

1. create a `chore/release` branch
1. run `yarn && yarn release-it` and follow the prompts
1. create a pull request
1. once the pull request is approved and merged, and all required checks on the merge commit have passed, fast-forward the `main` branch

If you want to override the version number, which is automatically determined based on the conventional commit messages being relased, you can do so by passing a parameter to the `release-it` command, e.g.

```
yarn release-it 1.0.0-rc.1
```