cask "blackmagic-ai" do
  version "0.4.4"

  on_arm do
    sha256 "8abc691f8c83c772028b441928e749aa336220f42c11e1aeed693c91caa3eff3"
    url "https://pub-d259d1d2737843cb8bcb2b1ff98fc9c6.r2.dev/blackmagic-desktop/BlackMagic%20AI-#{version}-arm64.dmg",
        verified: "pub-d259d1d2737843cb8bcb2b1ff98fc9c6.r2.dev/blackmagic-desktop/"
  end

  on_intel do
    sha256 "db7fdc8c961eea9077c4a9f0bc59377bd3d7d6b054c83bca16b96bc71ef429f8"
    url "https://pub-d259d1d2737843cb8bcb2b1ff98fc9c6.r2.dev/blackmagic-desktop/BlackMagic%20AI-#{version}.dmg",
        verified: "pub-d259d1d2737843cb8bcb2b1ff98fc9c6.r2.dev/blackmagic-desktop/"
  end

  name "BlackMagic AI"
  desc "Agent-first AI desktop app"
  homepage "https://github.com/furudo-erika/blackmagic-desktop"

  app "BlackMagic AI.app"

  # Belt-and-suspenders: strip quarantine + any lingering xattrs on the
  # installed app. Our build re-signs ad-hoc in afterPack, which resolves
  # the "app is damaged" Gatekeeper error caused by Electron's default
  # linker-signed stub having a mismatched identifier.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/BlackMagic AI.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/BlackMagic AI",
    "~/Library/Logs/BlackMagic AI",
    "~/Library/Preferences/run.blackmagic.desktop.plist",
    "~/Library/Saved Application State/run.blackmagic.desktop.savedState",
  ]
end
