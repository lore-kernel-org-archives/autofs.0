From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 2/2, 2nd attempt] samples/auto.smb: add logic to obtain
 credentials
Date: Fri, 06 Sep 2013 15:59:18 +0800
Message-ID: <1378454358.2311.1.camel@perseus.fritz.box>
References: <51081EF4.20105@ts.fujitsu.com>
	 <1359549686-7246-1-git-send-email-martin.wilck@ts.fujitsu.com>
	 <1359549686-7246-3-git-send-email-martin.wilck@ts.fujitsu.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=oC+9PuHrSI6O4OyS5LmE/OY3EK0=; b=NFSpEKGqpo7tRRzkEDX77Bm/K+Sn
	tzA3aYNh1TosMzUF1LEMy6ELd2aVIXPXR+1JwZjz/AsG90tXEhZO2R1g50avXU47
	WLhoqFLpj1Qq4ipCoJsgcNzgWgfjqMH3V5Jl4JGG4HhlSFzIHnARDLzVzp8iX8dV
	OxlQ1D3Gz3gTzTw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=oC+9PuHrSI6O4OyS5LmE/O
	Y3EK0=; b=DWCiN24kqUFVEpBo2j6YznCpFz+YJWUCK6B+zzDDwWkS1U/4UjkiqT
	ex636R6UZyYzcpfna+91nLzxSOwaCDT2M1gJnekVbvqcPgcsObzGBG+FXFiuUXxl
	px99OGNeW/TC26y2mmwk6aBrJoC6ts/9d0HvzNonPBiu2Y+YUY88s=
In-Reply-To: <1359549686-7246-3-git-send-email-martin.wilck@ts.fujitsu.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Martin Wilck <martin.wilck@ts.fujitsu.com>
Cc: autofs@vger.kernel.org

On Wed, 2013-01-30 at 13:41 +0100, Martin Wilck wrote:
> In some environments, hosts will require credentials for a share
> listing.
> 
> This patch introduces 2 methods to obtain credentials:
>  1) if a credentials file is present
>     under /etc/creds/$key, use it.
>  2) Otherwise, try to find a usable kerberos credentials cache
>     for the calling user (using the UID the script is running as)
>     and use that.
> If both methods fail, the script will try to obtain the list
> of shares anonymously, falling back to the previous behavior.
> ---
>  samples/auto.smb | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/samples/auto.smb b/samples/auto.smb
> index 2dfb8f8..977b29b 100755
> --- a/samples/auto.smb
> +++ b/samples/auto.smb
> @@ -2,6 +2,40 @@
>  
>  # This file must be executable to work! chmod 755!
>  
> +# Automagically mount CIFS shares in the network, similar to
> +# what autofs -hosts does for NFS. 
> +
> +# Put a line like the following in /etc/auto.master:
> +# /cifs  /etc/auto.smb --timeout=300
> +# You'll be able to access Windows and Samba shares in your network
> +# under /cifs/host.domain/share
> +
> +# "smbclient -L" is used to obtain a list of shares from the given host. 
> +# In some environments, this requires valid credentials.
> +
> +# This script knows 2 methods to obtain credentials:
> +# 1) if a credentials file (see mount.cifs(8)) is present
> +#    under /etc/creds/$key, use it.
> +# 2) Otherwise, try to find a usable kerberos credentials cache
> +#    for the calling user and use that.
> +# If both methods fail, the script will try to obtain the list
> +# of shares anonymously.
> +
> +get_krb5_cache() {
> +    cache=
> +    uid=$(id -u)
> +    for x in $(ls -d /run/user/$uid/krb5cc_* 2>/dev/null); do
> +        if [ -d "$x" ] && klist -s DIR:"$x"; then
> +	    cache=DIR:$x
> +            return
> +        fi
> +    done
> +    if [ -f /tmp/krb5cc_$uid ] && klist -s /tmp/krb5cc_$uid; then
> +	    cache=/tmp/krb5cc_$uid
> +	    return
> +    fi
> +}
> +
>  key="$1"
>  opts="-fstype=cifs"
>  
> @@ -16,7 +50,23 @@ done
>  
>  [ -x $SMBCLIENT ] || exit 1
>  
> -$SMBCLIENT -gNL $key 2>/dev/null| awk -v key="$key" -v opts="$opts" -F'|' -- '
> +creds=/etc/creds/$key
> +if [ -f "$creds" ]; then
> +    opts="$opts"',uid=$UID,gid=$GID,credentials='"$creds"
> +    smbopts="-A $creds"
> +else
> +    get_krb5_cache
> +    if [ -n "$cache" ]; then
> +        opts="$opts"',multiuser,cruid=$UID,sec=krb5i'
> +        smbopts="-k"
> +        export KRB5CCNAME=$cache 
> +    else
> +        opts="$opts"',guest'

Why add guest?
Is that going to change the behavior of the existing script.

> +        smbopts="-N"
> +    fi
> +fi
> +
> +$SMBCLIENT $smbopts -gL "$key" 2>/dev/null| awk -v "key=$key" -v "opts=$opts" -F '|' -- '
>  	BEGIN	{ ORS=""; first=1 }
>  	/Disk/	{
>  		  if (first)


