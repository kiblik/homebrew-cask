cask "eset-endpoint-encryption" do
  version "5.2.0.22"
  sha256 "e13c0adfee6ce574d2aecddb90898c3276861e9e96568ded534f3736028d8024"

  url "https://download.eset.com/com/eset/apps/business/eee/mac/v#{version.major}/#{version}/eee_macos.pkg"
  name "ESET Endpoint Encryption"
  desc "Secure file/disk encryption"
  homepage "https://www.eset.com/"

  livecheck do
    url "https://gwc.eset.com/v1/product/32"
    strategy :json do |json|
      json.dig("files", "installer")&.map { |_, item| item["full_version"] }
    end
  end

  depends_on macos: ">= :catalina"

  uninstall script:  {
              executable: "/Applications/ESET Cyber Security.app/Contents/Helpers/Uninstaller.app/Contents/Scripts/uninstall.sh",
              sudo:       true,
            },
            pkgutil: "com.eset.protection"

  zap trash: "~/Library/Preferences/com.eset.ecs.*.plist"
end
