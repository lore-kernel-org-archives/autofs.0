From: Ian Kent <raven@themaw.net>
Subject: Re: "Too many levels of symbolic links"
Date: Sun, 02 Mar 2014 17:41:24 +0800
Message-ID: <1393753284.9725.31.camel@perseus.fritz.box>
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
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=q0PcGIB1M4hJwa3PiyjuFN4CPeg=; b=H1XPs/ty+wnvaBe9n+ybs/7XCAk1
	Cz2R3ukkS73lTAkOojKmEFfDR1br+E5GFZqSeAxpgDVLhM1rtRzrfEtuZF8+iJTd
	hx4wbhnlojaFqO3sl11W9wYG0arb0kadLwmp/NOVlHgkAJf7Cw9WtuekJsmNKiPz
	+uEKudtvb5OECts=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=q0PcGIB1M4hJwa3PiyjuFN
	4CPeg=; b=HLwCCzde6lclsjXd8doYZ7y1VYLQun1VG0/V7f5CefuzpPkGvyb/UL
	hTFdzwZz4gk319tHdkkeN+D41cu6RPAuzzM8ZHhBbYt67I/BFckDwaZy+zI3coW3
	RYiwR/TbYyAAJAnRcq4+Bl82ZEanXm0zgPko9gb1FXNDA1OgDseSk=
In-Reply-To: <5312EBAC.2070200@molgen.mpg.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Donald Buczek <buczek@molgen.mpg.de>
Cc: Alexander Viro <aviro@redhat.com>, autofs <autofs@vger.kernel.org>

On Sun, 2014-03-02 at 09:28 +0100, Donald Buczek wrote:
> Am 02.03.2014 03:17, schrieb Ian Kent:
> > mnt_hash->next == mnt_hash->prev, mount has been unlinked from the mount
> > tree so is not "visible". As far as we are concerned this mount has
> > gone.
> 
> No, prev and next both point to the list_head in the mount_hashtable.

Fair call, ->mnt_mp != NULL too which implies the mount hasn't been
unlinked.

