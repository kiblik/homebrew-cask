cask "eset-inspect-agent" do
  arch arm: "_arm64", intel: ""
  version "2.8.5555.0"
    sha256 arm:   "925830a92e82606f240011ac7435c978828d51255c76dcf7016e9f9dbd4ccbbf",
         intel: "bb59766a3fa4ccde252bb5e56671a41d810a8549a08881d7febb5926ac9a9a5b"

  url "https://download.eset.com/com/eset/apps/business/eei/agent/v#{version.major}/#{version}/ei_connector_macos#{arch}.pkg"
  name "ESET Inspect Agent"
  desc "On-prem threat detection, real-time monitoring, and incident response tool."
  homepage "https://www.eset.com/"

  livecheck do
    url "https://gwc.eset.com/v1/product/21"
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
