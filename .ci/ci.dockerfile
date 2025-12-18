FROM golang:trixie AS builder

ARG asdf_version="v0.18.0"
RUN go install github.com/asdf-vm/asdf/cmd/asdf@$asdf_version

FROM asdfvm/asdf:debian

USER root
RUN <<SETUP
apt-get update --quiet --yes

RUBY_DEPS="ruby-build libffi-dev libyaml-dev"
JRUBY_DEPS="default-jre"
MRUBY_DEPS="build-essential"

apt-get install --quiet --yes \
  ${RUBY_DEPS} \
  ${JRUBY_DEPS} \
  ${MRUBY_DEPS}
SETUP

COPY --from=builder /go/bin/asdf /usr/local/bin/asdf

RUN apt-get install wget

USER asdf
