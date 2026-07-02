# Homebrew formula for the curlix CLI.
#
# This lives in the curlix tap repo (curlix-io/homebrew-tap) as Formula/curlix.rb.
# A copy is kept here so the formula is versioned next to the build tooling; the
# release CI (.github/workflows/release-cli.yml) regenerates the version + sha256
# values and pushes the result to the tap on every CLI release.
#
#   brew tap curlix-io/tap
#   brew install curlix
#
# It installs a prebuilt, self-contained binary (PyInstaller one-folder bundle) —
# no Python toolchain required on the user's machine.
class Curlix < Formula
  desc "Curlix CLI — authenticate and connect to your databases through curlix"
  homepage "https://github.com/curlix-io/curlix"
  version "1.2.1"
  license :cannot_represent # Proprietary

  on_macos do
    on_arm do
      url "https://github.com/curlix-io/homebrew-tap/releases/download/cli-v#{version}/curlix-#{version}-darwin-arm64.tar.gz"
      sha256 "8b8647ccbb84e60c87e990886e332f480c79f40975b84122165d8093760ae387"
    end
    on_intel do
      url "https://github.com/curlix-io/homebrew-tap/releases/download/cli-v#{version}/curlix-#{version}-darwin-x86_64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/curlix-io/homebrew-tap/releases/download/cli-v#{version}/curlix-#{version}-linux-arm64.tar.gz"
      sha256 "67882ad357cd5c9c62cc8a83a29d5ec9b6b4e1b442b226d733c3026feca9fcbb"
    end
    on_intel do
      url "https://github.com/curlix-io/homebrew-tap/releases/download/cli-v#{version}/curlix-#{version}-linux-x86_64.tar.gz"
      sha256 "973bdf12c850035192437bfd5e79e3f23826a1c41292459a81143aa2a22f2256"
    end
  end

  def install
    # The tarball contains the PyInstaller one-folder bundle (launcher + _internal/).
    # Homebrew strips the single top-level "curlix/" dir, so install everything here
    # into libexec and expose only the launcher on PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"curlix"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/curlix --version")
  end
end
