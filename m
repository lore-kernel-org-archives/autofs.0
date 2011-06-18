From: Ian Kent <raven@themaw.net>
Subject: Re: Bug in autofs4_d_automount()?
Date: Sat, 18 Jun 2011 17:49:57 +0800
Message-ID: <1308390597.12881.5.camel@perseus.themaw.net>
References: <32229.1308353388@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=Fyu27iExJwOXghg81bv99OdpNsU=;
	b=jyKRX7Mkv3erlqQHGDZKz03Mk+2gVyi+QSU+3x7xTMulGTPLRhoq3p4uf1VbFLIHTxheb9A3E8s0U8w/CLE1iqXQPWwLemxtqgCxQRiLW0x2wfowe7s1+KkyxXrqAwazYekzf0HnheIeMiQsyobKJU3StfraKiJyNQ+DNlrbY94=
In-Reply-To: <32229.1308353388@redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: autofs@linux.kernel.org, viro@ZenIV.linux.org.uk

On Sat, 2011-06-18 at 00:29 +0100, David Howells wrote:
> Hi Ian,
> 
> At the top of autofs4_d_automount() you have:
> 
> 	/* The daemon never triggers a mount. */
> 	if (autofs4_oz_mode(sbi))
> 		return NULL;
> 
> I think this should be returning -EISDIR.  If by some chance we do get here in
> Oz mode, this will cause the kernel to just loop forever.  A return of NULL is
> meant to indicate that you got a collision and that it should recheck the
> mountpoint - but it does not advance path in follow_managed().

I think your mistaken this time.

That was done to work around the fact that -EISDIR can't be returned in
the case where the dentry doesn't and (and won't have) a explicit mount
on it without entering an ELOOP situation. IIRC I needed to return NULL
here and handle it in ->d_manage() to make this work.

> 
> -EISDIR is the return to indicate this is to be treated as a normal directory.

That would be the better way to do it but the logic doesn't allow it
ATM.

> 
> David
