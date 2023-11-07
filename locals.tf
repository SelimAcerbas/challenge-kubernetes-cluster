locals {
  NAME_PREFIX_DEV = "${var.COMMON_NAMING_PREFIX}-dev"
  COMMON_TAGS = {
      TAG = "${var.COMPANY}-${var.PROJECT}"
  }
}