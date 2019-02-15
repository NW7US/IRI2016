FROM debian:buster-slim AS build
RUN apt-get update && apt-get install -y gfortran cmake build-essential python3-setuptools meson ca-certificates
COPY . /src
WORKDIR /src
RUN python3 setup.py build

FROM debian:buster-slim AS iri2016
RUN apt-get update && apt-get install -y gfortran python3 python3-dateutil python3-xarray
COPY --from=build /src /src
ENTRYPOINT ["/src/build/iri2016_driver"]
