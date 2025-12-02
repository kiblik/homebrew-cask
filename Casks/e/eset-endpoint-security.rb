cask "eset-endpoint-security" do
  version "9.1.2000.0"
  sha256 "3b37ce2d7fcd0397c7caaa041a93244ceb83599854cf48b1549683455617351a"

  url "https://download.eset.com/com/eset/apps/business/ees/mac/g2/v#{version.major}/#{version}/ees_osx.pkg"
  name "ESET Endpoint Security"
  desc "Enterprise security with firewall, antispam, and AI-powered threat protection"
  homepage "https://www.eset.com/"

  livecheck do
    url "https://gwc.eset.com/v1/product/17"
    strategy :json do |json|
      json.dig("files", "installer")&.map { |_, item| item["full_version"] }
    end
  end

  depends_on macos: ">= :big_sur"

  uninstall script:  {
              executable: "/Applications/ESET Endpoint Security.app/Contents/Helpers/Uninstaller.app/Contents/Scripts/uninstall.sh",
              sudo:       true,
            },
            pkgutil: "com.eset.protection"

  zap trash: "~/Library/Preferences/com.eset.ees.*.plist"
end
