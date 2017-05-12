From: Colin Walters <walters@verbum.org>
Subject: Re: [PATCH 3/3] autofs - fix AT_NO_AUTOMOUNT not being honored
Date: Fri, 12 May 2017 08:49:20 -0400
Message-ID: <1494593360.2027710.974439704.4D9A14FD@webmail.messagingengine.com>
References: <149438991819.26550.11290804420751932707.stgit@pluto.themaw.net>
 <149438992850.26550.14370272866390445786.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=O6sk3u
        INLNB8zeL6djHvUmzHzziCKwyBY3QfofrB3J4=; b=BHmoDId4TcPFAgvd6uWZZA
        WJEmjft2FDgENGUTOqZ8S+kyDleVXMGoXEGoZM/0O5RMkDVojrrMPBvB/pk+zAby
        UsBf3C/0aGz1NmuksXkKI93c52TssH8SPbiivpnUWfFHXIbIierNzdcaJoNL0UD/
        m9MFVfb/+p40AmUC4ChnC8Z/wQx764ycLE2Z7xwOXt2R3W3cjqXBbQ6YfgjNV5X5
        2hamTfMIIWp9xVwCc/DrGtGpnFGD3RT0CDQid5yCN60yFmwrUEUM2HQTHmT7dg6f
        l3dj+Tau7enqhEI66izn17Adzcvf2A0WewfUNY70vc4j61F+ZWA0RjEP3u2VjxCg
        ==
In-Reply-To: <149438992850.26550.14370272866390445786.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>, Al Viro <viro@ZenIV.linux.org.uk>
Cc: Colin Walters <walters@redhat.com>, Ondrej Holy <oholy@redhat.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On Wed, May 10, 2017, at 12:18 AM, Ian Kent wrote:
> The fstatat(2) and statx() calls can pass the flag AT_NO_AUTOMOUNT
> which is meant to clear the LOOKUP_AUTOMOUNT flag and prevent triggering
> of an automount by the call. But this flag is unconditionally cleared
> for all stat family system calls except statx().
> 

Here's the GLib patch to make use of this:
https://bugzilla.gnome.org/show_bug.cgi?id=782554

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
