# gon.hcl
#
# The path follows a pattern
# ./dist/BUILD-ID_TARGET/BINARY-NAME
source = ["./dist/gibo-macos_darwin_arm64/gibo"]
bundle_id = "com.mitchellh.example.terraform"

apple_id {
  username = "sw@netcetera.org"
  password = "@env:AC_PASSWORD"
}

sign {
  application_identity = "Developer ID Application: Simon Whitaker"
}
