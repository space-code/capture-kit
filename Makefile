all: bootstrap

bootstrap: hook brew

brew:
	brew bundle check || brew bundle

hook:
	ln -sf ../../hooks/pre-commit .git/hooks/pre-commit
	chmod +x .git/hooks/pre-commit

lint:
	# mint run swiftlint

fmt:
	find CaptureKit -iname '*.h' -o -iname '*.m' | xargs clang-format -i
	find CaptureKitTests -iname '*.h' -o -iname '*.m' | xargs clang-format -i

.PHONY: all bootstrap hook brew mint lint fmt