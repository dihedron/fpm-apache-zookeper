VERSION?=3.9.4
DOWNLOAD_URL=https://dlcdn.apache.org/zookeeper/zookeeper-${VERSION}/apache-zookeeper-${VERSION}-bin.tar.gz

apache-zookeeper-${VERSION}-bin.tar.gz:
	@wget $(DOWNLOAD_URL)

.phony: version
version:
	@echo "Latest Apache Zookeeper version is $(VERSION)"

.phony: setup-tools
setup-tools:
	@go install github.com/goreleaser/nfpm/v2/cmd/nfpm@latest

.phony: deb
deb: apache-zookeeper-${VERSION}-bin.tar.gz
ifeq ($(GITLAB_CI),)
ifeq ($(shell which nfpm),)
	@echo "Need to install nFPM first..."
	@go install github.com/goreleaser/nfpm/v2/cmd/nfpm@latest
endif
endif
	@rm -rf apache-zookeeper-${VERSION}-bin/
	@tar xzvf apache-zookeeper-${VERSION}-bin.tar.gz 2>&1 > /dev/null
	@mv apache-zookeeper-${VERSION}-bin/ apache-zookeeper-bin/
	@echo -n "Create Apache Zookeeper $(VERSION) "
	@VERSION=$(VERSION) nfpm package --packager deb --target .
	@rm -rf apache-zookeeper-bin/

.phony: rpm
rpm: apache-zookeeper-${VERSION}-bin.tar.gz
ifeq ($(GITLAB_CI),)
ifeq ($(shell which nfpm),)
	@echo "Need to install nFPM first..."
	@go install github.com/goreleaser/nfpm/v2/cmd/nfpm@latest
endif
endif
	@rm -rf apache-zookeeper-${VERSION}-bin/
	@tar xzvf apache-zookeeper-${VERSION}-bin.tar.gz 2>&1 > /dev/null
	@mv apache-zookeeper-${VERSION}-bin/ apache-zookeeper-bin/
	@echo -n "Create Apache Zookeeper $(VERSION) "
	@VERSION=$(VERSION) nfpm package --packager rpm --target .
	@rm -rf apache-zookeeper-bin/

# TODO: run a cleanup task removing go/ only once:
# see https://gist.github.com/APTy/9a9eb218f68bc0b4beb133b89c9def14

.phony: apk
apk: apache-zookeeper-${VERSION}-bin.tar.gz
ifeq ($(GITLAB_CI),)
ifeq ($(shell which nfpm),)
	@echo "Need to install nFPM first..."
	@go install github.com/goreleaser/nfpm/v2/cmd/nfpm@latest
endif
endif
	@rm -rf apache-zookeeper-${VERSION}-bin/
	@tar xzvf apache-zookeeper-${VERSION}-bin.tar.gz 2>&1 > /dev/null
	@mv apache-zookeeper-${VERSION}-bin/ apache-zookeeper-bin/
	@echo -n "Create Apache Zookeeper $(VERSION) "
	@VERSION=$(VERSION) nfpm package --packager apk --target .
	@rm -rf apache-zookeeper-bin/

.phony: clean
clean:
	@rm -rf *.deb *.rpm *.apk *.tar.gz apache-zookeeper-bin/ apache-zookeeper-*-bin/
