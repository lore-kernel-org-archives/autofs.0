From: Ian Kent <raven@themaw.net>
Subject: Re: "Too many levels of symbolic links"
Date: Sun, 02 Mar 2014 19:35:02 +0800
Message-ID: <1393760102.9725.72.camel@perseus.fritz.box>
References: <1391145206.2486.25.camel@perseus.fritz.box>
	 <52EB7694.20707@molgen.mpg.de> <52EB7B07.2070707@molgen.mpg.de>
	 <530484B7.6030305@molgen.mpg.de>
	 <1392896501.2508.16.camel@perseus.fritz.box>
	 <1392898704.2508.26.camel@perseus.fritz.box>
	 <530625D0.7020808@molgen.mpg.de>
	 <1392946952.2495.3.camel@perseus.fritz.box>
	 <53076D91.7050703@molgen.mpg.de> <53107D4A.90904@molgen.mpg.de>
	 <20140228132906.GM15017@sh-el6.eng.rdu2.redhat.com>
	 <5310F30D.9040407@molgen.mpg.de> <53125771.4030000@molgen.mpg.de>
	 <531280C5.1050906@molgen.mpg.de>
	 <1393726632.9725.3.camel@perseus.fritz.box>
	 <5312EBAC.2070200@molgen.mpg.de>
	 <1393753284.9725.31.camel@perseus.fritz.box>
	 <5313066F.6040302@molgen.mpg.de>
	 <1393758213.9725.60.camel@perseus.fritz.box>
	 <531312DE.1010300@molgen.mpg.de>
	 <1393759812.9725.69.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=4LmoS6KvwJ5NaAsNFnhsshjZVt8=; b=s2fmXMT6vzcegtLgFPsto3y0uBAi
	7FFOJsX98VOfzJnlrQ23GKYvaAIptXQGNOYav1agTfaL1Wk5+q+n3v0tpjs8jkT3
	fK2JHMILPjO/pnvkB0DJSTPM3qDvHTLH7p7c9ovvoqiUPpQVIe5W4BgvAIY2djhh
	gV3C1SHYEkymJW0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=4LmoS6KvwJ5NaAsNFnhssh
	jZVt8=; b=OdOScAfoccRna5H4iOW9LsCs2KQpNWjfvcbi/eqrfA54qyUIiIPBYK
	rEJSn1voPDgWJI8d05v6QziBZR6/aNQ/FGyUNfcJicIlTUh6+8zanrDDCmlQVp3h
	ILMEtBZ92UKkqoIwhG2TfyKhSoMSLb0XiF/ZUl5f7+q9mZ5CObVGU=
In-Reply-To: <1393759812.9725.69.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Donald Buczek <buczek@molgen.mpg.de>
Cc: Alexander Viro <aviro@redhat.com>, autofs <autofs@vger.kernel.org>

On Sun, 2014-03-02 at 19:30 +0800, Ian Kent wrote:
> On Sun, 2014-03-02 at 12:15 +0100, Donald Buczek wrote:
> > I've follow the mysterious "root" up:
> > 
> > > (gdb) print ((struct dentry *)0xffff88007ca407d0)->d_name->name
> > > $10 = (const unsigned char *) 0xffff88007ca40808 "old-root-D0k5jB"
> > > (gdb) print ((struct dentry *)0xffff88007ca407d0)->d_parent->d_name->name
> > > $11 = (const unsigned char *) 0xffff88007ca6c748 "private"
> > > (gdb) print ((struct dentry 
> > > *)0xffff88007ca407d0)->d_parent->d_parent->d_name->name
> > > $12 = (const unsigned char *) 0xffff88007ca58b48 
> > > "systemd-namespace-os99ZC"
> > > (gdb) print ((struct dentry 
> > > *)0xffff88007ca407d0)->d_parent->d_parent->d_parent->d_name->name
> > > $13 = (const unsigned char *) 0xffff8800c890ce48 "tmp"
> > > (gdb) print ((struct dentry 
> > > *)0xffff88007ca407d0)->d_parent->d_parent->d_parent->d_parent->d_name->name
> > > $14 = (const unsigned char *) 0xffff88012900f2c8 "/"
> > > root:kasslerbraten:/home/buczek/autofs/# ls -lR 
> > > /tmp/systemd-namespace-os99ZC/
> > > /tmp/systemd-namespace-os99ZC/:
> > > total 0
> > > drwxrwxr-t 2 root system 48 Feb 28 12:33 private
> > > drwxrwxr-x 2 root system 48 Feb 28 12:33 root
> > >
> > > /tmp/systemd-namespace-os99ZC/private:
> > > total 0
> > >
> > > /tmp/systemd-namespace-os99ZC/root:
> > > total 0
> > 
> > 
> > So its systemd which is doing some strange namespace stuff in /tmp.
> > This probably collides in some way with the autofs model of autofs 
> > having global pathnames.
> > 
> > Still not clear and not solved, but we're really coming closer...
> 
> LOL, forgive me for thinking that systemd just sets "/" shared in a
> simple way.
> 
> That little pain in the a*** might be what it's doing there.
> 

Mind you making "/" shared should be done way before autofs is started.
Container implementations do similar things with like pivot mount on a
new root and may change the propagation type as well.

Ian
 

