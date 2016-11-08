#!/bin/bash

set -e

# Use supplied assets tarball or compile assets, if it doesn't exist
if [ -f "assets.tar.gz" ] ; then
    tar vxfz assets.tar.gz
else
    # Set dummy database connection string
    export DATABASE_URL="mysql2://user:pass@127.0.0.1/dummy"

    # Set these to correct values
    # FIXME OS defaults
    export font_proximanovasoft_url=https://assets-sharetribecom.sharetribe.com/webfonts/proximanovasoft/
    export ss_pika_location=//assets-sharetribecom.sharetribe.com/webfonts/ss-pika/ss-pika.css
    export ss_social_location=//assets-sharetribecom.sharetribe.com/webfonts/ss-pika/ss-social.css
    export icon_pack=ss-pika

    secret_key_base=$(ruby -r securerandom -e "puts SecureRandom.hex(64)")
    export secret_key_base

    bundle exec rake assets:precompile
fi
