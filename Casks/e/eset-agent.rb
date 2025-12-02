cask "eset-agent" do
  version "12.5.2104.0"
  sha256 "09faa39659a0a91567646d9c0613047ef64d348efcab85a104b0aa2a40f5b77a"

  url "https://download.eset.com/com/eset/apps/business/era/agent/v#{version.major}/#{version}/agent_macosx_x86_64.dmg"
  name "ESET Agent"
  desc "Centralized agent for remote endpoint management and security policy enforcement"
  homepage "https://www.eset.com/"

  livecheck do
    url "https://gwc.eset.com/v1/product/40"
    strategy :json do |json|
      json.dig("files", "installer")&.map { |_, item| item["full_version"] }
    end
  end

  depends_on macos: ">= :catalina"

  pkg "Agent-MacOSX-x86_64_arm64.pkg"

  uninstall script:  {
              executable: "/Applications/ESET Cyber Security.app/Contents/Helpers/Uninstaller.app/Contents/Scripts/uninstall.sh",
              sudo:       true,
            },
            pkgutil: "com.eset.protection"

  zap trash: "~/Library/Preferences/com.eset.ecs.*.plist"
end
