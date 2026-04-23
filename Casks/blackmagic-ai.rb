cask "blackmagic-ai" do
  version "0.4.87"

  on_arm do
    sha256 "257812dbf8381582dc0e842f78adf8d443a23da101724ff62f0071331d8b891c"
    url "https://pub-d259d1d2737843cb8bcb2b1ff98fc9c6.r2.dev/blackmagic-desktop/BlackMagic%20AI-#{version}-arm64.dmg",
        verified: "pub-d259d1d2737843cb8bcb2b1ff98fc9c6.r2.dev/blackmagic-desktop/"
  end

  on_intel do
    sha256 "b7d84806fb9851f74fdc9568eb91d1a74326be39696bbd05151923d31a8e30a5"
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
