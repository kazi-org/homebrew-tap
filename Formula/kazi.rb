# kazi Homebrew formula. Installs the prebuilt Burrito single-file binary
# (ERTS + the exqlite NIF bundled, so the full SQLite read-model is present --
# no Erlang prerequisite). See https://github.com/kazi-org/kazi (ADR-0014).
#
# NOTE: kazi DRIVES a coding agent at runtime (ADR-0001), so a harness binary
# (`claude` or `opencode`) must be on PATH to actually run a goal.
class Kazi < Formula
  desc "Reconciliation controller that drives a coding agent until goal predicates are true"
  homepage "https://github.com/kazi-org/kazi"
  version "0.1.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/kazi-org/kazi/releases/download/v0.1.0/kazi_macos_aarch64"
      sha256 "d2e01ecb3678882a1e1ab7824836aa4a6002b5425fda0d961523f9c513126b40"
    end
    # Intel macOS (x86_64) is not yet published; see the kazi release workflow.
  end

  on_linux do
    on_intel do
      url "https://github.com/kazi-org/kazi/releases/download/v0.1.0/kazi_linux_x86_64"
      sha256 "a7e50a827f216d7c7524887e790f0a555fe1ad9d7afcf64fe9006803f91049ed"
    end
    # ARM Linux (aarch64) is not yet published; see the kazi release workflow.
  end

  def install
    # The release asset is a bare binary named kazi_<target>; install it as `kazi`.
    bin.install Dir["kazi_*"].first => "kazi"
  end

  test do
    assert_match "kazi", shell_output("#{bin}/kazi --help")
  end
end
