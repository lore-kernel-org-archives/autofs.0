From: Ian Kent <raven@themaw.net>
Subject: Re: Using wildcards in multi-mount maps
Date: Mon, 01 Jun 2015 11:58:33 +0800
Message-ID: <1433131113.2703.43.camel@pluto.fritz.box>
References: <556B4D79.6030006@embl-heidelberg.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=oxk3bx4hMi8iZlCuq9yj85xGLOU=; b=w5Oz17
	8g2dCK7Esr4EPbik+aIEqBaVguUH/VBaFI8aKDlz3j3jOH01V7dtyqVub3qPx9MN
	ykhir/gMVvf0J8ABTbeZdLTaoRdVCJI7qXFjBZuQ4yZBkZiN01SG1YAMAxIlwXq1
	M6vf8ucxLtMvH/Dg9CWQtLumqHFr4yovqD5GM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=oxk3bx4hMi8iZlC
	uq9yj85xGLOU=; b=OLPOrhcxTKBxZGluvtjSUaufjpvc+UIwzHzbVRU+6fk4q2v
	0kR47+imTByqyHVoSP+Hqlmqsu8vd7Ua2fF6f5G9BSzUf/R/ATB883j5hOqeppig
	ByPJEajQjsAwhpNDxpmNWAuMR0fBcrUx77pe8WKNTaa7FTmc6D5lMXPLuHZE=
In-Reply-To: <556B4D79.6030006@embl-heidelberg.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Frank Thommen <frank.thommen@embl-heidelberg.de>
Cc: autofs@vger.kernel.org

On Sun, 2015-05-31 at 20:05 +0200, Frank Thommen wrote:
> Hi,
> 
> are wildcards within multi-mount maps supposed to work?

Good question.

> 
> I have the following entry in our maps:
> 
> /etc/auto.master (local):
>     /mymount yp:mymap --ghost
> 
> 
> Indirect NIS map for /mymount:
>     $ ypmatch webapps mymap
>     /*         -timeo=30                   server:/local/exports/&

Yeah, that can't work.

The wildcard must be a single character at the start of the key, no
other characters can be used.

So, no that can't be used in multi-mount map entries.

Keep in mind that for multi-mount map entries to work the offset paths
must be known when the containing mount is performed so adding
functionality like this isn't actually doable.

The substitution is based on replacing the whole key, autofs can't take
part of a key and use it for substitution either.

What's more doing so would introduce the the need to handle multiple
occurrences of the wildcard with matching of where to substitute each
one and that isn't covered by the Sun map format AFAIK.

If this type of extended key pattern matching is really needed you could
have a look at the amd map format. I haven't implemented the regex key
matching functionality of am-utils in autofs but the variable length key
matching combined with wildcard entries might be sufficient.

Note that I also haven't implemented the am-utils multi-mount like map
type either and the way they are specified in amd map format maps
doesn't lend itself to this sort of wildcard handling either.

>     $
> 
> 
> On the NIS server the map looks like this:
>     webapps \
>        /*         -timeo=30                   server:/local/exports/&
> 
> 
> However on the client it looks like:
> 
>     $ ls /mymount/webapps
>     *
>     $ ls /mymount/webapps/user
>     ls: /mymount/webapps/user: No such file or directory
>     $
> 
> (/local/exports/user /is/ exported to this client from server)
> 
> This is on CentOS 5 with autofs 5.0.1.
> 
> Should that work or do I have to solve this mount config in an other way?
> 
> Frank
> 
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


