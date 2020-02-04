NAME ?= MhDZmR

VERSION ?= 0.1

DEVICE ?= nicklaus

DATE := $(shell date +'%Y%m%d-%H%M')

ZIP := $(NAME)-$(VERSION)-$(DEVICE)-$(DATE).zip

EXCLUDE := Makefile README.md *.git* *zip *sha1 *placeholder

all: $(ZIP)

$(ZIP):
	@echo 
	@echo 
	@echo " M H D  Z U M A I R || D E V "
	@echo " ______________________________________"
	@echo "Script Created by Mohamed Zumair"
	@rm -rf *.zip *.sha1
	@echo 
	@echo " Date : $(shell date +"%b-%d-%Y")"
	@sleep 3.0;
	@echo " Creating ZIP: $(ZIP)"
	@echo "      =====>>> ... "
	@zip -r9 "$@" . -x $(EXCLUDE)
	@echo "Generating SHA1..."
	@sha1sum "$@" > "$@.sha1"
	@cat "$@.sha1"
	@echo
	@echo "Zip Size :"
	@du -h "$(NAME)-"*.zip*
	@echo ""
	@echo "Done."

clean:
	@rm -vf "$(NAME)-"*.zip*
	@echo "Done."
	@sleep 5.0;
