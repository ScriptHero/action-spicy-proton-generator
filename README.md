# spicy-proton generator

Deterministically generates a string in the form of "spicy-proton"
that can be used to name deployments from a branch.

## Action

Given a `name`, this action action returns a `result` output containing the spicy-proton name.

Example:
```yml
  steps:
    - name: Generate deployment name
      id: deployment_name
      uses: ScriptHero/action-spicy-proton-generator@v1
      with:
        name: ${{ github.head_ref }}
    # ... later
    - name: Create deployment
      with:
        environment: ${{ steps.deployment_name.outputs.result }}
```

## What release of this Action should I use?

In your GitHub Actions workflow,
this action is used in the form `ScriptHero/action-spicy-proton-generator@RELEASE`.

If you want to be safest, point to a specific git commit hash.
This will never allow potentially breaking/nefarious changes to leak into your workflow, but it will
also prevent any fixes from being adopted by your workflow.

Never use `main` except as a convenience to test this action while actively developing it.

The middle ground is to use a major/minor release name.
Since this Action follows semantic versioning, any release will be tagged with `major.minor.patch`
version number.

In addition to that tag, major and minor tags are maintained that track the latest with each.
So for example, when `v1.0.3` is released, `v1` and `v1.0` will both point to the same commit as `v1.0.3`.

Following that, when `v1.1.0` is released, `v1` will be updated and `v1.1` will be created,
both pointing to the same commit as `v1.1.0`.

Meanwhile, `v1.0` will continue to point at the same commit as `v1.0.3`.

## Developing

This is a GitHub Action that uses Docker.

1. Have Docker
1. Make changes
1. `docker build --tag action-spicy-proton-generator .`
1. `docker run action-spicy-proton-generator input` (you can replace `input` with a different string)
1. The output uses [actions/toolkit functions](https://docs.github.com/en/actions/reference/workflow-commands-for-github-actions#setting-an-output-parameter) to set the output variable

## Releasing

This project follows semantic versioning releases,
which are automatically built from pull requests that are merged.

Running release tags for major and minor versions are updated,
following [GitHub recommendations](https://docs.github.com/en/actions/creating-actions/about-actions#using-release-management-for-actions).

1. Name your branch with one of the following prefixes:
    - `fix/` when you're making a non-feature, non-breaking fix
    - `chore/` when your change is not code-related at all
    - `feature/` for everything else
1. Create a pull request, with the title containing the work "breaking" if it contains a breaking change
1. Your pull request will be labeled automatically based on the above:
    - `feature`: a feature change
    - `patch fix`: a very minor patch
    - `chore`: non-code-related change
    - `breaking change`: contains a breaking change
1. When you merge your pull request, a GitHub Release is drafted/updated containing the not-yet-released changed
1. Open Releases, find the draft release (at the top) and hit Edit
1. Verify that it has the semantic version you want (v`major.minor.release`)
1. Click Publish Release
1. The running major and minor release tags will be automatically updated
