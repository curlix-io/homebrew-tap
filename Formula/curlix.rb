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
  version "1.2.0"
  license :cannot_represent # Proprietary

  on_macos do
    on_arm do
      url "https://github.com/curlix-io/homebrew-tap/releases/download/cli-v#{version}/curlix-#{version}-darwin-arm64.tar.gz"
      sha256 "cc46847037b606567212503d15cb49ca654c30a9f1b6e60fdda8d9f45d1bf639"
    end
    on_intel do
      url "https://github.com/curlix-io/homebrew-tap/releases/download/cli-v#{version}/curlix-#{version}-darwin-x86_64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/curlix-io/homebrew-tap/releases/download/cli-v#{version}/curlix-#{version}-linux-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_intel do
      url "https://github.com/curlix-io/homebrew-tap/releases/download/cli-v#{version}/curlix-#{version}-linux-x86_64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
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
