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
      sha256 "63a093399d0d2c2807dd6c68bc66407a699d148faa3fb90154ec2314cd9cac26"
    end
    # Intel macOS (x86_64) is not yet published (CI Intel-runner scarcity).
  end

  on_linux do
    on_intel do
      url "https://github.com/kazi-org/kazi/releases/download/v0.1.0/kazi_linux_x86_64"
      sha256 "9a27e81bf33e006c507edd02d2a7d4488e3b53739ad5ea9bb4d73d0423bbe703"
    end
    on_arm do
      url "https://github.com/kazi-org/kazi/releases/download/v0.1.0/kazi_linux_aarch64"
      sha256 "23b9596b0286a119d9061728df22d4cc55fe15cc74567a12aafc4b35dcad39c2"
    end
  end

  def install
    # The release asset is a bare binary named kazi_<target>; install it as `kazi`.
    bin.install Dir["kazi_*"].first => "kazi"
  end

  test do
    assert_match "kazi", shell_output("#{bin}/kazi --help")
  end
end
