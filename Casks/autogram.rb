cask "autogram" do
  version "1.99.16"
  sha256 "ef334505de223aa4a1ae12889015f433713b20ab9d3e2e08afa3f52e60bf62ce"

  url "https://github.com/slovensko-digital/autogram/releases/download/v#{version}/Autogram-#{version}.pkg"
  name "autogram"
  desc "Application for electronic signing of signatures"
  homepage "https://github.com/slovensko-digital/autogram"

  livecheck do
    url :url
    strategy :github_latest
  end

  pkg "Autogram-#{version}.pkg"

  preflight do
    FileUtils.mkdir_p "#{Dir.home}/Library/Application Support/Autogram/tls/"
    FileUtils.touch "#{Dir.home}/Library/Application Support/Autogram/tls/skip"
  end

  uninstall pkgutil: "digital.slovensko.autogram",
            quit:    "digital.slovensko.autogram"

  zap trash: [
    "~/Library/Preferences/digital.slovensko.autogram.plist",
    "~/Library/Saved Application State/digital.slovensko.autogram.savedState",
    "~/Library/Saved Application State/digital.slovensko.autogram.savedState",
    "~/Library/Application Support/Autogram",
  ]

  caveats do
    license "https://github.com/slovensko-digital/autogram/blob/main/LICENSE"
  end
end
