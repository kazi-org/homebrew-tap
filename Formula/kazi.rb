# kazi Homebrew formula. Installs the prebuilt Burrito single-file binary
# (ERTS + the exqlite NIF bundled, so the full SQLite read-model is present --
# no Erlang prerequisite). See https://github.com/kazi-org/kazi (ADR-0014).
#
# NOTE: kazi DRIVES a coding agent at runtime (ADR-0001), so a harness binary
# (`claude` or `opencode`) must be on PATH to actually run a goal.
class Kazi < Formula
  desc "Reconciliation controller that drives a coding agent until goal predicates are true"
  homepage "https://github.com/kazi-org/kazi"
  version "0.1.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/kazi-org/kazi/releases/download/v0.1.1/kazi_macos_aarch64"
      sha256 "73a551c6e329b35d77be4b15acfd0f8b9c8b8c66b02ad828aac6363069708407"
    end
    # Intel macOS (x86_64) is not yet published (CI Intel-runner scarcity).
  end

  on_linux do
    on_intel do
      url "https://github.com/kazi-org/kazi/releases/download/v0.1.1/kazi_linux_x86_64"
      sha256 "c161b5921b78b7cfe25b66b27e2bb6d760a28a953206956513cbc4afd555cace"
    end
    on_arm do
      url "https://github.com/kazi-org/kazi/releases/download/v0.1.1/kazi_linux_aarch64"
      sha256 "7a043514bb4a3dbd503a1de7c18213f26b3318a16de839030d60624ef9d2f07f"
    end
  end

  def install
    bin.install Dir["kazi_*"].first => "kazi"
  end

  test do
    assert_match "kazi", shell_output("#{bin}/kazi --version")
  end
end
