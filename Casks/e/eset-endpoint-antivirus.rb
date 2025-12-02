cask "eset-endpoint-antivirus" do
  version "7.5.50.0"
  sha256 "730f56d5fbdbea584faa1338cef2195283348805f41444170c34dfe6d57639ea"

  url "https://download.eset.com/com/eset/apps/business/eea/mac/g2/v#{version.major}/#{version}/eea_osx.dmg"
  name "ESET Endpoint Antivirus"
  desc "Lightweight business antivirus with AI threat detection & cloud management"
  homepage "https://www.eset.com/"

  livecheck do
    url "https://gwc.eset.com/v1/product/15"
    strategy :json do |json|
      json.dig("files", "installer")&.map { |_, item| item["full_version"] }
    end
  end

  depends_on macos: [:big_sur, :monterey, :ventura, :sonoma]

  pkg "Resources/Installer.pkg"
end
