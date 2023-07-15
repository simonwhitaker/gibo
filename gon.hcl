# gon.hcl
#
# The path follows a pattern
# ./dist/BUILD-ID_TARGET/BINARY-NAME
source = [
  "./dist/gibo-macos_darwin_arm64/gibo"
  "./dist/gibo-macos_darwin_amd64_v1/gibo"
]
bundle_id = "org.netcetera.gibo"

apple_id {
  username = "sw@netcetera.org"
  password = "@env:AC_PASSWORD"
}

sign {
  application_identity = "Developer ID Application: Simon Whitaker"
}
