From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] Test for ldap connectivity during lookup_ldap
 initialization
Date: Wed, 16 Aug 2017 13:02:40 +0800
Message-ID: <a1205319-aa1f-13c4-51c6-740ac6d15a4c@themaw.net>
References: <1502399721-2491-1-git-send-email-osalvador@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=rDNLe2/uthEwuH8VuQ
        C8ExcRtloNyFuD8BIOYtyMfKo=; b=ctDujBK31Zk241LAumKNW+ZlJOLR2W90Uy
        8Nd2CLME/AAliH8Iq/z2hrd9imcrfm0dNpNmmM+47MG0IUYicJOK6FDWQS9HCSJq
        Jgu13FDSl6zB/4x/CNK8oJ524CQWDQtdpbWMBStDpKVx2t9lAt5KfxGhTF0uVvIe
        wK/BOvMBSfjNPkA8hGqsNiEqm04grhgr4GJdWpYJONgc38bFwQmFJwEnE6RjxplK
        4C0/sqkalNwjaePmI4nZEpMnQYGaiBBLo7eo02MiSFjVlkh+1YR8mcLye/fosWZB
        W48I5w7XGpQ7iDNrOG3TOjF0GWXky1EeaclMDh0zqpDnvkFLN5pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=rDNLe2/uthEwuH8VuQC8ExcRtloNyFuD8BIOYtyMfKo=; b=irKcaLu1
        Bc79o+RBUJ8ib0K4syEDYsL+ECjwuInnqoJMXOCcZh2+y4dMw02x3PyAWc+bu+sq
        NF+Ski1ADPT70B9zH0SCUathrNCmoDj0mr8rwerY8REmA/ngkPWMJ8HDznhvVzIV
        bfx4T4aLXsf66EX01czwkmrMX/fWwbOnsaa+f/TXp4hqA3zEPh2jlW6jSuIYv0zx
        6CiaUTIqhRr2OVLnZmkIItp7oZGq3dPjTpS/OQ/bG+O4GoQij2HcrRiODAJYD89n
        XTsVHoYEZq6Ob0P9wimuk3iEP6zoI2E5kYJ+DwtGn0Dv469vlQG2EYMCSDcEr6bl
        TpIr2Cy1TP7Ugw==
In-Reply-To: <1502399721-2491-1-git-send-email-osalvador@suse.com>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Oscar Salvador <osalvador@suse.com>, autofs@vger.kernel.org
Cc: Jeff Mahoney <jeffm@suse.com>

On 11/08/17 05:15, Oscar Salvador wrote:
> Right now we are just checking and parsing the ldap's configuration
> in lookup_init() function, and if everything goes well we return a zero
> value indicating that everything worked fine.
> 
> This has a problem, because in the case we set ldap method in
> /etc/nsswitch.conf, configuration parsing goes fine but ldap is not working,
> we will return a zero value in lookup_init() function, so autofs will move on,
> but then we will return NSS_STATUS_UNAVAIL in lookup_read_master() function
> once do_reconnect() fails, and because of this autofs will not be able to
> reread the maps.

Umm ... I can't see a check in the current upstream NIS code?

> 
> NIS already handles this by testing for server connectivity during initialization.
> This patch does the same thing for LDAP.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.com>
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> ---
>  modules/lookup_ldap.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
> index 98701e5..29a67a5 100644
> --- a/modules/lookup_ldap.c
> +++ b/modules/lookup_ldap.c
> @@ -1681,6 +1681,7 @@ static int do_init(const char *mapfmt,
>  		   int argc, const char *const *argv,
>  		   struct lookup_context *ctxt, unsigned int reinit)
>  {
> +	struct ldap_conn conn;
>  	unsigned int is_amd_format;
>  	int ret;
>  
> @@ -1810,6 +1811,12 @@ static int do_init(const char *mapfmt,
>  		}
>  	}
>  
> +	memset(&conn, 0, sizeof(struct ldap_conn));
> +	ret = do_reconnect (LOGOPT_ANY, &conn, ctxt);
> +	if (ret != NSS_STATUS_SUCCESS)
> +		return 1;
> +
> +	unbind_ldap_connection(LOGOPT_ANY, &conn, ctxt);
>  	return ret;
>  }
>  
> 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
