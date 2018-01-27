#! /bin/sh
set -e

if ! [ -x "$(command -v go)" ]; then
    echo "go is not installed"
    exit
fi
if ! [ -x "$(command -v git)" ]; then
    echo "git is not installed"
    exit
fi
if [ -z "$GOPATH" ]; then
    echo "set GOPATH"
    exit
fi

COMMIT=`git rev-parse --short HEAD`
TAG=$(git describe --exact-match --abbrev=0 --tags ${COMMIT} 2> /dev/null || true)

if [ -z "$TAG" ]; then
    VERSION=$COMMIT
else
    VERSION=$TAG
fi

if [ -n "$(git diff --shortstat 2> /dev/null | tail -n1)" ]; then
    VERSION="${VERSION}-dirty"
fi

PATH="$PATH:$GOPATH/bin"

if ! [ -x "$GOPATH/bin/dep" ]; then
    echo "Installing dep ..."
    go get -u github.com/golang/dep/cmd/dep
fi

dep ensure -v -vendor-only
go install -v -ldflags="-X github.com/msyrus/twtfetcher/version.Version=${VERSION}" .
