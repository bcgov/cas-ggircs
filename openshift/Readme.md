# Building and deploying to OpenShift

## `make` targets

**TODO**

## OpenShift configurations
### Metabase

We build an deploy a custom version of metabase ([bcgov/cas-ggircs-metabase](https://github.com/bcgov/cas-ggircs-metabase)), using the s2i ([source-to-image](https://docs.openshift.com/container-platform/3.11/architecture/core_concepts/builds_and_image_streams.html#source-build)) tool.

Building using s2i requires us to define three imagestreams and build configs:
    - a **builder** image, which will contain all the dependencies needed to build metabase and the s2i scripts
    - a **build** image where the *assemble* script will be executed, buiding metabase
    - a final image contaning the runtime dependency of metabase (java) and the `metabase.jar` file built in the *build* image

#### cas-ggircs-metabase-builder

This [build config](buildconfig/cas-ggircs-metabase-builder.yml) builds an image using the dockerfile located in [docker/metabase-builder](/docker/metabase-builder).
The `contextDir` option (see below) instructs OpenShift to run docker from that directory

```yaml
source:
  git:
    ref: ${GIT_BRANCH}
    uri: https://github.com/bcgov/cas-ggircs.git
  contextDir: docker/metabase-builder
strategy:
  type: Docker
```

The dockerfile installs the build dependencies for metabase (OpenJDK 8, NodeJS, Yarn, Leiningen), and git (which is needed to help with incremental builds, see below).

It also copies the s2i scripts (located in docker/metabase-builder/s2i/) into `$STI_SCRIPTS_PATH` (which is defined in the base docker image).

#### cas-ggircs-metabase-build

This [build config](buildconfig/cas-ggircs-metabase-build.yml) uses the s2i build strategy. The s2i strategy does the following:
  1. Pull the builder image and use it.
  1. Clone the metabase repository into the `/tmp/src/` directory of the builder image.
  1. Pull the previous build image (if any), and executes the `save-artifacts` script in it, and extract the saved artifact in the `/tmp/artifacts/` directory of the builder image. The `save-artifacts` scripts simply runs a `tar` command outputting to stdout, containg all the files that should be made available to the next build (dependencies, built sql drivers, etc).
  1. Execute the `assemble` script. The assemble script restores the previous build artifacts, if any, i.e. moves them to the metabase source repository, and runs the metabase build.
  1. Push the resulting image (builder + built sources, aka the *build* image).

#### cas-ggircs-metabase

The last [build config](buildconfig/cas-ggircs-metabase.yml) has two steps:
  1. Pull the *cas-ggircs-metabase-build* image and copies the `metabase.jar` file into the build environment.
  1. Build an image using the [docker/metabase](/docker/metabase) dockerfile. This dockerfile installs the runtime dependency (java), exposes the metabase port (`3000`), copies the `jar` file into the image, and sets `java -jar metabase.jar` as the entrypoint.
