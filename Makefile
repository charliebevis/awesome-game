CC = elm make
PACKAGE = elm package
INSTALL = install
SRC = src
TEST = test
OPEN = open
NODE = node
BASH = bash
CF_CLI = cf
PUSH = push

PACKAGE_FLAGS = -y

BUILD_DIR = build
RESOURCES_DIR = resources

all: package/install clean compile

Index.html = index.html
open: all $(Index.html)
	$(OPEN) $(Index.html)

compile: awesome

Awesome = Awesome
Awesome.js = $(BUILD_DIR)/$(Awesome).js
Awesome.elm = $(SRC)/$(Awesome).elm
awesome: $(Awesome.js)
$(Awesome.js): $(Awesome.elm)
	$(CC) --output $(Awesome.js) $(Awesome.elm)

clean:
	rm -rf $(BUILD_DIR)

package/install:
	$(PACKAGE) $(INSTALL) $(PACKAGE_FLAGS)

deploy: all
	$(CF_CLI) $(PUSH)